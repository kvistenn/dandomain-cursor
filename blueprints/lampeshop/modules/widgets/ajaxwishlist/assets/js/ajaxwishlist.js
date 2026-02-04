;(function($, eksport) {
    'use strict';

    var selectors = {
        count: '[data-wishlist="count"]',
        wishlist: '[data-wishlist="wishlist"]',
        overlay: '[data-wishlist="overlay"]',
        close: '[data-wishlist="close"]',
        open: '[data-wishlist="open"]',
        scroll: '[data-wishlist="scroll"]',
        toggle: '[data-wishlist="toggle"]',
        transfer: '[data-wishlist="transfer"]'
    };

    var Wishlist = function() {
        this.$count = $(selectors.count);
        this.$total = $(selectors.total);
        this.$open = $(selectors.open);
        this.$scroll = $(selectors.scroll);
        this.template = $.templates('#render-wishlist');
    }

    Wishlist.prototype = {
        load: async function() {
            var self = this;

            return new Promise(function(resolve, reject) {
                $.get('/json/wishlist', function(res) {
                    
                    var newAmount = res.WishlistProduct.length;
                    if(newAmount > 0) {
                        self.$count.text(newAmount);
                    } else {
                        self.$count.text('');
                    }

                    var scrollPos = self.$scroll.scrollTop();

                    var htmlOutput = self.template.render(res, {
                        wishlistClass: function(wishlistClass) {
                            var wishlistClass = $('#ajaxwishlist').find(selectors.wishlist).hasClass('show') ? 'show' : '';
                            return wishlistClass;
                        },
                        platformcurrency: function(key) {
                            return window.platform.currency[key];
                        },
                        currency: platform.currency_format,
                        number: platform.number_format
                    });

                    $('#ajaxwishlist').html(htmlOutput);

                    if (scrollPos) {
                        self.$scroll.scrollTop(scrollPos);
                    }

                    self.$open.on('click', function() {
                        self.open();
                    }.bind(self));

                    $('#ajaxwishlist').find(selectors.close).on('click', function() {
                        self.close();
                    }.bind(self));

                    $('#ajaxwishlist').find(selectors.overlay).on('click', function() {
                        self.close();
                    }.bind(self));

                    $('#ajaxwishlist').find(selectors.transfer).on('click', function() {
                        
                        var productData = [];

                        res.WishlistProduct.forEach(function(product) {
                            productData.push(product.ProductId);
                        });

                        var ajax_request = function(data) {
                            var deferred = $.Deferred();
          
                            $.ajax({
                                type: 'POST',
                                url: '/actions/cart/add',
                                data: data,
                                success: function() {
                                    deferred.resolve();
                                    platform.ajaxCart.load();
                                    platform.Message.load(text.FAVORITES_TRANSFERRED, 0);
                                },
                                error: function() {
                                    deferred.reject();
                                }
                            })
          
                            return deferred.promise();
                        }
          
                        var looper = $.Deferred().resolve();
          
                        $.when.apply($, $.map(productData, function(productId) {
          
                            var data = encodeURIComponent("product[" + productId + "][amount]") + "=" + $('[data-controller="amount"]').val();
          
                            looper = looper.then(function() {
                                return ajax_request(data);
                            });
          
                            return looper;
          
                        }));

                    }.bind(self));

                    $(platform).on('loaded.productlist', function() {
                        setTimeout(function() {
                            var productlist = $(document).find(selectors.toggle);
                            productlist.each(function() {
                                var productItem = $(this);
                                var productId = productItem.data('id');
                                var inWishlist = res.WishlistProduct.find(function(product) {
                                    return product.ProductId === productId;
                                })

                                if(inWishlist) {
                                    productItem.find('> svg').addClass('stroke-red-500 fill-red-500');
                                }
                            });
                        }, 100);
                    });

                    $(document).on('click', '[data-wishlist="delete"]', function (e) {
                        e.preventDefault();
                        var $this = $(this);
        
                        $.get($this.attr('href'), function() {
                            self.load();
        
                            var productId = $this.data('id');
                            var productlist = $(document).find(selectors.toggle);
                            productlist.each(function() {
                                var productItem = $(this);
                                var productItemId = productItem.data('id');
        
                                if(productItemId == productId) {
                                    productItem.find('> svg').removeClass('stroke-red-500 fill-red-500');
                                    platform.Message.load(text.FAVORITES_REMOVED, 0);
                                }
                            });
                        })
                    });

                    resolve(res);

                });
            });
        },
        show: async function() {
            var self = this;
            const result = await self.load();
            if (result) {
                var newAmount = result.WishlistProduct.length;
                self.$count.text(newAmount);
                setTimeout(function () {
                    $('#ajaxwishlist').find(selectors.wishlist).add(selectors.overlay).addClass("show");
                }, 100);
            }
        },
        open: function() {
            $('#ajaxwishlist').find(selectors.wishlist).add(selectors.overlay).addClass('show');
        },
        close: function() {
            $('#ajaxwishlist').find(selectors.wishlist).add(selectors.overlay).removeClass('show');
        },
        toggle: function() {
            var self = this;

            $(document).on('click', selectors.toggle, async function (e) {
                e.preventDefault();
                var $this = $(this);
                var productId = $(this).data('id');
                var wishlistId = 0;
                var load = await self.load();

                if(load) {

                    var wishlistProduct = load.WishlistProduct.find(function(product) {
                        return product.ProductId === productId;
                    });

                    if(wishlistProduct) {
                        wishlistId = wishlistProduct.Id;
                    }
                }

                if(!$this.find('> svg').hasClass('stroke-red-500')) {
                    var requestData = "product[" + encodeURIComponent(productId) + "][amount]=1&wishlistadd=true";
                    $.post('/actions/cart/add', requestData, function(res) {
                        if(res.type == "cart_wishlist_add_success") {
                            $this.find('> svg').addClass('stroke-red-500 fill-red-500');
                            platform.Message.load(text.FAVORITES_ADDED, 0);
                            self.load();
                        }
                    });
                } else {
                    $.get('/actions/wishlist/delete?id=' + wishlistId, function() {
                        $this.find('> svg').removeClass('stroke-red-500 fill-red-500');
                        platform.Message.load(text.FAVORITES_REMOVED, 0);
                        self.load();
                    })
                }
            });
        },
    }

    $(async function() {
        

        if(platform.settings.module_shop_wishlist) {
            var wishlist = new Wishlist();
            var load = await wishlist.load();
    
            if (load) {
                wishlist.toggle();
            }
        }


    });


})(jQuery, window);