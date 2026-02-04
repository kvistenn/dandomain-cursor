;(function($, eksport) {
    'use strict';

    var selectors = {
        count: '[data-cart="count"]',
        total: '[data-cart="total"]',
        cart: '[data-cart="cart"]',
        overlay: '[data-cart="overlay"]',
        close: '[data-cart="close"]',
        open: '[data-cart="open"]',
        scroll: '[data-cart="scroll"]',
        delivery: '[data-cart="delivery"]',
        delivery_not_free: '[data-cart="delivery_not_free"]',
        delivery_free: '[data-cart="delivery_free"]'
    };

    var Cart = function() {
        this.$count = $(selectors.count);
        this.$total = $(selectors.total);
        this.$open = $(selectors.open);
        this.$scroll = $(selectors.scroll);
        this.$delivery = $(selectors.delivery);
        this.$delivery_not_free = $(selectors.delivery_not_free);
        this.$delivery_free = $(selectors.delivery_free);
        this.template = $.templates('#render-cart');
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

                    var newTotal = res.CartTotalLinePrice;
                    self.$total.text(platform.currency_format(newTotal));

                    var estimatedPrice = res.CartEstimatedPrice;
                    if (estimatedPrice) {
                        self.$delivery.text(estimatedPrice);
                    } else {
                        let oldHtml = self.$delivery_not_free.find('span[data-text]').attr('data-text');
                        self.$delivery_not_free.find('span[data-text]').html(oldHtml);
                        self.$delivery = $(document).find(selectors.delivery);
                    }

                    if (newAmount > 0 && !estimatedPrice) {
                        self.$delivery_not_free.hide();
                        self.$delivery_free.css('display', 'flex');
                    } else {
                        self.$delivery_not_free.css('display', 'flex');
                        self.$delivery_free.hide();
                    }

                    var scrollPos = self.$scroll.scrollTop();

                    var htmlOutput = self.template.render(res, {
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
                self.call(url, method, data, form);
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

            gtag('event', 'add_to_cart', { "items": items });

        }
    }

    $(function() {
        
        var cart = new Cart();
        cart.load();

        if (platform.page.isCart) {

            if(document.location.href.indexOf('?mobilepay') > -1) {
                setTimeout(function () {
                    $('[data-w-checkout-type="onpay-mobilepay"] > button').trigger('click');
                }, 100);
            }

        }
    
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