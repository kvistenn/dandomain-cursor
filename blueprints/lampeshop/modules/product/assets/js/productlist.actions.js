
; (function ($, eksport) {
    'use strict';

    if (platform.page.isProduct && platform.page.productId == null) {
        var productlistString = 'fetch.productlist';
    } else {
        var productlistString = 'loaded.productlist';
    }

    $(platform).on(productlistString, (e) => {
        setTimeout(function () {


            $('.product').each(function () {

                const dataIds = [];

                var variantContainer = $(this).find('[data-variant="variant"]:not(.slick-initialized)');
                var variants = variantContainer.find('span[data-value]');

                variants.on('click', function (e) {

                    var $this = $(e.target).closest('span[data-value]');

                    let parentLength = $this.closest('.product').find('div[data-index]').length;
                    let id = $this.closest('.product').data('id');
                    let product = $this.closest('.product');
                    let index = parseInt($this.closest('[data-index]').data('index'));
                    let hasMultipleVariants = $this.closest('[data-index]').data('hasmultiplevariants');
                    let input = $this;
                    let inputval = input.data('value');
                    dataIds[index] = inputval;

                    input.closest('[data-index]').find('span[data-value] > img').removeClass('border-black').addClass('border-gray-200');
                    input.find('> img').addClass('border-black').removeClass('border-gray-200');

                    if(id && parentLength && product && dataIds) {
                        console.log(id, parentLength, product, dataIds);
                        changeVariant(id, parentLength, product, dataIds, hasMultipleVariants);
                    }
                });

                /* variantContainer.slick({
                    infinite: false,
                    slidesToShow: 5,
                    dots: false,
                    arrows: true,
                    swipeToSlide: true,
                    prevArrow: null,
                    nextArrow: $(this).find('[data-variant="next"]'),
                    responsive: [
                        {
                            breakpoint: 1240,
                            settings: {
                                slidesToShow: 4,
                            }
                        }
                    ]
                }); */

                var amount = $(this).find('[data-product="amount"]');
                var inc = $(this).find('[data-product="inc"]');
                var dec = $(this).find('[data-product="dec"]');

                inc.on('click', function (e) {
                    let val = parseInt(amount.val());

                    setTimeout(function () {
                        amount.val(val + 1);
                        amount.trigger('change');
                    }, 10);
                });

                dec.on('click', function (e) {
                    let val = parseInt(amount.val());

                    setTimeout(function () {
                        if (val > 1) {
                            amount.val(val - 1);
                            amount.trigger('change');
                        }
                    }, 10);
                });

            });

            function changeVariant(id, length, product, dataIds, hasMultipleVariants) {

                if (dataIds.length == length && dataIds.indexOf(null) == -1) {
                    $.get('/json/productvariants/' + id + '?dataIds=' + dataIds.join(','), function (data) {
                        if (data.count > 0) {
                            let variant = data.data[0];
                            let buyable = variant.Buyable;
                            let variantId = variant.Id;
                            let stockCount = variant.Stock;
                            let remoteStock = variant.remoteStock;
                            if(data.data.length > 1) {
                                buyable = false;
                            }

                            // Set image to data[0].Picture if it exists
                            if (variant.Picture) {
                                product.find('[data-variant="image"]').attr('src', variant.Picture);
                            }

                            if(!product.hasClass('variant')) {
                                product.addClass('variant');
                            }

                            product.find('[data-variant="id"]').val(variantId);
                            product.data('buyable', buyable);

                            let variantBtnTxt = product.find(['data-basket"link"']).data('varianttext');

                            if (stockCount > 0) {
                                product.find('[data-stock="instock"]').show().removeClass('ng-hide');
                                product.find('[data-stock="outofstock"]').hide().addClass('ng-hide');
                                product.find('[data-stock="inremotestock"]').hide().addClass('ng-hide');
                            } else if (remoteStock > 0) {
                                product.find('[data-stock="inremotestock"]').show().removeClass('ng-hide');
                                product.find('[data-stock="instock"]').hide().addClass('ng-hide');
                                product.find('[data-stock="outofstock"]').hide().addClass('ng-hide');
                            }
                            else {
                                product.find('[data-stock="instock"]').hide().addClass('ng-hide');
                                product.find('[data-stock="outofstock"]').show().removeClass('ng-hide');
                                product.find('[data-stock="inremotestock"]').hide().addClass('ng-hide');
                            }
                            
                            if (buyable) {
                                product.find('[data-basket="link"]').text(variantBtnTxt);
                                product.find('[data-basket="add"]').removeClass('hidden');
                                product.find('[data-basket="link"]').addClass('hidden');
                                product.find('[data-variant="stock"]').text(variant.DeliveryTimeText);

                            } else {
                                product.find('[data-basket="link"]').text(text.PRODUCT_CATALOG_PRODUCT_SOLDOUT);
                                product.find('[data-basket="add"]').addClass('hidden');
                                product.find('[data-basket="link"]').removeClass('hidden');
                                if (variant.DeliveryTimeText) {
                                    product.find('[data-variant="stock"]').text(variant.DeliveryTimeText);
                                } else {
                                    product.find('[data-variant="stock"]').text(text.PRODUCT_CATALOG_PRODUCT_CHOOSE_VARIANT);
                                }
                            }
                        }
                    });
                }
            };


            if ($('[data-categories="show"]').length) {
                let categoryBtnText = $('[data-categories="show"]').text();
                let toggledText = text.SHOW_FEWER_CATEGORIES;
                $('[data-categories="show"]').on('click', function (e) {
                    $('[data-categories="hidden-category"]').toggleClass('hidden');
                    if ($('[data-categories="hidden-category"]').hasClass('hidden')) {
                        $(this).text(categoryBtnText);
                    } else {
                        $(this).text(toggledText);
                    }
                });
            }

            if ($('[data-productlist="categories"]').length) {
                let categories = $('[data-productlist="categories"]');
                categories.removeClass('grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6');
                categories.slick({
                    infinite: false,
                    slidesToShow: 6,
                    slidesToScroll: 6,
                    dots: false,
                    arrows: true,
                    swipeToSlide: true,
                    responsive: [
                        {
                            breakpoint: 1024,
                            settings: {
                                slidesToShow: 5,
                                slidesToScroll: 5,
                            }
                        },
                        {
                            breakpoint: 768,
                            settings: {
                                slidesToShow: 4,
                                slidesToScroll: 4,
                            }
                        },
                        {
                            breakpoint: 640,
                            settings: {
                                slidesToShow: 3,
                                swipeToSlide: true,
                            }
                        }
                    ]
                });
            }
            
        }, 300);

    });



})(jQuery, window);