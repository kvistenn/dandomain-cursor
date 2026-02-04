(function (platform, $) {

    extraBuyProducts();

    function extraBuyProducts() {
        var extraBuyProductCats = $('[data-controller="extraBuyProducts"]').children("[data-extrabuy='group']");
        if (extraBuyProductCats.length) {

            var basePrice = parseFloat($('[property="product:price:amount"]').attr("content"));
            var buyButton = $('[data-product="buyButton"]');

            extraBuyProductCats.find("[data-extrabuy='add']").on("click", function () {
                var amount = $(this).parent().prev('input');
                amount.val(parseInt(amount.val()) + 1);
                amount.trigger("change");
            });

            extraBuyProductCats.find("[data-extrabuy='subtract']").on("click", function () {
                var amount = $(this).parent().prev('input');
                if(amount.val() > 0) {
                    amount.val(parseInt(amount.val()) - 1);
                    amount.trigger("change");
                }
            });
            
            extraBuyProductCats.find("input[data-extrabuy='amount']").on("change", function () {

                if($(this).attr('type') === 'checkbox') {
                    if($(this).is(':checked')) {
                        $(this).val(1);
                    } else {
                        $(this).val(0);
                    }
                }
                updateInfo($(this).closest('li'), $(this).val());
            });

            var mobilepayBtn = $('[data-w-checkout-type="onpay-mobilepay"] button');

            if(mobilepayBtn.length) {

                $('[data-w-checkout="modal-open"]').attr('data-w-checkout', null);
                $('.w-checkout--onpay-mobilepay').hide();

                mobilepayBtn.on('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();


                    var form = $(this).closest('form[name="cartadd"]');
                    var extraProducts = [];
    
                    extraBuyProductCats.each(function (i, category) {
                        var children = $(category).find('ul').children("li");
                        children.each(function (ii, li) {
                            var amount = $(li).find("input").val();
                            if (amount > 0) {
    
                                var product = {
                                    id: $(li).data("id"),
                                    amount: parseInt(amount)
                                }
    
                                if($(li).data("variantid")) {
                                    product.variantid = $(li).data("variantid");
                                }
    
                                extraProducts.push(product);
                            }
                        });
                    });
    
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
                            var data = encodeURIComponent("product[" + product.id + "][amount]") + "=" + product.amount + '&' + encodeURIComponent("product[" + product.id + "][variant]") + "=" + product.variantid;
                        } else {
                            var data = encodeURIComponent("product[" + product.id + "][amount]") + "=" + product.amount;
                        }
    
                        looper = looper.then(function () {
                            return ajax_request(data);
                        });
    
                        return looper;
                    })).then(function () {
                        form.submit();
                    }).then(function() {
                        let mobilepayHref = $('#ajaxcart .bg-mobilepay').attr('href');
                        setTimeout(function() {
                            window.location.href = mobilepayHref;
                        }, 500);
                    });


                });


            }

            buyButton.on("click", function (e) {
                e.preventDefault();

                var form = $(this).closest('form[name="cartadd"]');
                var extraProducts = [];

                extraBuyProductCats.each(function (i, category) {
                    var children = $(category).find('ul').children("li");
                    children.each(function (ii, li) {

                        if ($(li).data("addon")) {
                            
                            var amount = $(li).find("input").prop('checked') ? 1 : 0;
                            if (amount > 0) {

                                var product = {
                                    id: $(li).data("id"),
                                    amount: parseInt(amount)
                                }

                                if($(li).data("variantid")) {
                                    product.variantid = $(li).data("variantid");
                                }

                                extraProducts.push(product);
                            }

                        } else {

                            var amount = $(li).find("input").val();
                            if (amount > 0) {

                                var product = {
                                    id: $(li).data("id"),
                                    amount: parseInt(amount)
                                }

                                if($(li).data("variantid")) {
                                    product.variantid = $(li).data("variantid");
                                }

                                extraProducts.push(product);
                            }

                        }
                    });
                });

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
                        var data = encodeURIComponent("product[" + product.id + "][amount]") + "=" + product.amount + '&' + encodeURIComponent("product[" + product.id + "][variant]") + "=" + product.variantid;
                    } else {
                        var data = encodeURIComponent("product[" + product.id + "][amount]") + "=" + product.amount;
                    }

                    looper = looper.then(function () {
                        return ajax_request(data);
                    });

                    return looper;
                })).then(function () {
                    form.submit();
                });
            });

            function updateInfo(li, amount) {

                var id = li.data("id");
                var variantid = li.data("variantid");
                var dataIds = li.data("dataids");

                if(variantid) {

                    $.get('/json/productvariants/' + id + '?dataIds=' + dataIds, function (data) {

                        if(data.data.length === 0) {
                            return;
                        }
                        
                        var product = data.data[0];
                        var prices = product.Prices;

                        prices.forEach(function(price, index) {

                            if (amount >= price.Amount) {
                                
                                var price = price.PriceMin;
                                var priceString = platform.currency_format(price);

                                li.find("[data-extrabuy='price']").text(priceString);
                                li.attr("data-price", price);
                            }

                            if(amount == 0) {

                                li.find("[data-extrabuy='price']").text(platform.currency_format(prices[0].PriceMin));
                                li.attr("data-price", prices[0].PriceMin);
                            }

                            if(prices.length === index + 1) {
                                calcPrice();
                            }
                        })
                    });

                } else {

                    $.get('/json/products/id/' + id, function (data) {

                        if(data.products.length === 0) {
                            return;
                        }
                        
                        var product = data.products[0];
                        var prices = product.Prices;

                        prices.forEach(function(price, index) {

                            if (amount >= price.Amount) {
                                
                                var price = price.PriceMin;
                                var priceString = platform.currency_format(price);

                                li.find("[data-extrabuy='price']").text(priceString);
                                li.attr("data-price", price);
                            }

                            if(amount == 0) {

                                li.find("[data-extrabuy='price']").text(platform.currency_format(prices[0].PriceMin));
                                li.attr("data-price", prices[0].PriceMin);
                            }

                            if(prices.length === index + 1) {
                                calcPrice();
                            }
                        })

                    });

                }

            }

            function calcPrice() {
                var newPrice = basePrice;
                var items = extraBuyProductCats.find("li");

                items.each(function(index, item) {
                    var price = parseFloat($(item).attr("data-price"));
                    newPrice += price * parseInt($(item).find("input").val());
                })

                $('[data-product="price"]').text(platform.currency_format(newPrice));
            }
        }
    }

})(window.platform, jQuery);

