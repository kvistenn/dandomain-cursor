;(function($, eksport) {
    'use strict';

    var selectors = {
        count: '[data-cart="count"]',
        total: '[data-cart="total"]',
        cart: '[data-cart="cart"]',
        overlay: '[data-cart="overlay"]',
        close: '[data-cart="close"]',
        open: '[data-cart="open"]',
        scroll: '[data-cart="scroll"]'
    };

    var Cart = function() {
        this.$count = $(selectors.count);
        this.$total = $(selectors.total);
        this.$open = $(selectors.open);
        this.$scroll = $(selectors.scroll);
        this.templates = {
            cart: $.templates('#render-cart'),
            delivery: $.templates('#render-delivery')
        }
        this.triggerTracking = false;
    }

    Cart.prototype = {
        load: async function() {
            var self = this;

            return new Promise(function(resolve, reject) {
                $.get('/json/cart', function(res) {
                    
                    var newAmount = res.CartProductCount;
                    if(newAmount !== 0) {
                        self.$count.text(newAmount);
                    }

                    var scrollPos = self.$scroll.scrollTop();

                    var htmlOutput = self.templates.cart.render(res, {
                        cartClass: function(cartClass) {
                            var cartClass = $('#ajaxcart').find(selectors.cart).hasClass('show') ? 'show' : '';
                            return cartClass;
                        },
                        platformcurrency: function(key) {
                            return window.platform.currency[key];
                        },
                        currency: platform.currency_format,
                        number: platform.number_format,
                        path: platform.template.path
                    });

                    $('#ajaxcart').html(htmlOutput);

                    var deliveryLimit = 1500;

                    if(platform.general.languageIso == "SE26" || platform.general.languageIso == "DE26") {
                        deliveryLimit = 2000;
                    }

                    var deliveryLimitUntil = deliveryLimit - res.CartSubTotalPrice;
                    var progress = deliveryLimit > 0 ? ((deliveryLimit - deliveryLimitUntil) / deliveryLimit) * 100 : 0;

                    // Progress should not exceed 100%
                    if (progress > 100) {
                        progress = 100;
                    }

                    var htmlOutput = self.templates.delivery.render(res, {
                        cartClass: function(cartClass) {
                            var cartClass = $('#ajaxcart').find(selectors.cart).hasClass('show') ? 'show' : '';
                            return cartClass;
                        },
                        platformcurrency: function(key) {
                            return window.platform.currency[key];
                        },
                        currency: platform.currency_format,
                        number: platform.number_format,
                        path: platform.template.path,
                        progress: progress,
                        deliveryLimit: deliveryLimit,
                        deliveryLimitUntil: deliveryLimitUntil < 0 ? 0 : deliveryLimitUntil,
                        deliveryLimitUntilText: text.CART_DELIVERY_LIMIT_NOT_REACHED.replace('#TOTAL#', platform.currency_format(deliveryLimitUntil)),
                        deliveryLimitText: text.CART_DELIVERY_LIMIT_NOT_REACHED.replace('#TOTAL#', platform.currency_format(deliveryLimit))
                    });

                    $('#ajaxdelivery').html(htmlOutput);

                    if (scrollPos) {
                        self.$scroll.scrollTop(scrollPos);
                    }

                    if (self.triggerTracking) {
                        self.track_add_to_cart(res);
                        self.triggerTracking = false;
                    }

                    self.$open.on('click', function() {
                        self.open();
                    }.bind(self));

                    $('#ajaxcart').find(selectors.close).on('click', function() {
                        self.close();
                    }.bind(self));

                    $('#ajaxcart').find(selectors.overlay).on('click', function() {
                        self.close();
                    }.bind(self));

                    resolve(res);

                });
            });
        },
        show: async function() {
            var self = this;
            const result = await self.load();
            if (result) {
                var newAmount = result.CartProductCount;
                if(newAmount !== 0) {
                    self.$count.text(newAmount);
                }
                setTimeout(function () {
                    $('#ajaxcart').find(selectors.cart).add(selectors.overlay).addClass("show");
                }, 100);
            }
        },
        open: function() {
            $('#ajaxcart').find(selectors.cart).add(selectors.overlay).addClass('show');
        },
        close: function() {
            $('#ajaxcart').find(selectors.cart).add(selectors.overlay).removeClass('show');
        },
        call: function(url, method, data, form) {
            var self = this;

            $.ajax({
                url: url,
                method: method,
                data: data,
                success: function (res) {
                    if (url.includes('/actions/cart/') && res.status == 0 && !platform.page.isCart) {
                        self.show();
                        self.triggerTracking = true;
                    } else {
                        var message = platform.Message;
                        message.load(res.text, res.status);
                    }
                }
            });
        },
        ajax: function() {
            var self = this;
            $(document).on('submit', 'form[data-form="ajax"]', function (e) {
                e.preventDefault();
                var form = $(this);
                var url = form.attr('action');
                var method = form.attr('method');
                var data = form.serialize();

                self.add_extrabuy(function () {
                    self.call(url, method, data, form);
                });
            });
        },
        track_add_to_cart: function (cart) {
            var self = this;

            var items = [],
                item = {},
                product = {};

            for(var i = 0, length1 = cart.CartProduct.length; i < length1; i++){
                product = cart.CartProduct[i],
                item = {
                    'id': String( product.VariantId ? product.VariantId+ "-" +product.ProductId : product.ProductId ),
                    'name': product.Title,
                    'category': product.CategoryTitle,
                    'quantity': product.Amount
                };

                if ( product.ItemNumber ) {
                    item.id = product.ItemNumber;
                }

                if ( product.VariantId ) {
                    item.variant = product.VariantTitle;
                }

                if ( product.ProducerTitle ) {
                    item.brand = product.ProducerTitle;
                }

                if ( product.CartBlocker ) {
                    item.price = '0';
                } else {
                    item.price = String(product.Price);
                }
                items.push(item);
            }

            if(typeof gtag === 'function') {
                gtag('event', 'add_to_cart', { "items": items });
            }

        },
        add_extrabuy: function (callback) {
            
            if(!platform.extrabuy) {
                if (typeof callback === 'function') {
                    callback();
                }
                return;
            }
            
            var extraProducts = platform.extrabuy.products;
            var ajax_request = function (data) {
                var deferred = $.Deferred();

                $.ajax({
                    type: "POST",
                    url: "/actions/cart/add",
                    data: data,
                    success: function () {
                        deferred.resolve();
                    },
                    error: function () {
                        deferred.reject();
                    }
                });

                return deferred.promise();
            };

            var looper = $.Deferred().resolve();

            $.when.apply($, $.map(extraProducts, function (product) {
                if(product.variantid) {
                    var data = encodeURIComponent("product[" + product.id + "][amount]") + "=1" + '&' + encodeURIComponent("product[" + product.id + "][variant]") + "=" + product.variantid;
                } else {
                    var data = encodeURIComponent("product[" + product.id + "][amount]") + "=1";
                }

                looper = looper.then(function () {
                    return ajax_request(data);
                });

                return looper;

            })).then(function () {
                if (typeof callback === 'function') {
                    callback();
                }
            });
        }
    }

    $(function() {
        
        var cart = new Cart();
        cart.load();
    
        if (!platform.page.isCheckout) {
            cart.ajax();
        }

        $(document).on("click", "[data-cart='delete'], [data-cart='increase'], [data-cart='decrease']", function (e) {
            e.preventDefault();
            var href = $(this).attr("href");
            var url = href.split("?")[0];
            var method = "GET";
            var data = "id=" + href.split("id=")[1].split("&")[0];
            var form = $(this).closest("form");
            cart.call(url, method, data, form);
        });

        eksport.platform.ajaxCart = cart;

    });


})(jQuery, window);