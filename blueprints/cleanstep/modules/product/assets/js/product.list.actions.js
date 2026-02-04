
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

                var variantContainer = $(this).find('[data-variant="variant"]');
                var variants = variantContainer.find('[data-value]');

                variants.on('click', function (e) {

                    let elements = {
                        'product': '.product',
                        'value': '[data-value]',
                        'index': '[data-index]'
                    }

                    let $this = $(e.target).closest('[data-value]');
                    let parentLength = $this.closest(elements.product).find(elements.index).length;
                    let id = $this.closest(elements.product).data('id');
                    let product = $this.closest(elements.product);
                    let index = parseInt($this.closest(elements.index).data('index'));
                    let hasMultipleVariants = $this.closest(elements.index).data('hasmultiplevariants');
                    let input = $this;
                    let inputval = input.data('value');
                    
                    dataIds[index] = inputval;

                    input.closest(elements.index).find(elements.value).removeClass('active');
                    input.addClass('active');

                    if(id && parentLength && product && dataIds) {
                        changeVariant(id, parentLength, product, dataIds, hasMultipleVariants);
                    }
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
                            let elements = {
                                'image': '[data-variant="image"]',
                                'id': '[data-variant="variantid"]',
                                'link': '[data-product="link"]',
                                'buy': '[data-product="buy"]',
                                'shopPopup': 'label[for="shopPopup"]'
                            };

                            if(data.data.length > 1) {
                                buyable = false;
                            }

                            // Set image to data[0].Picture if it exists
                            if (variant.Picture) {
                                product.find(elements.image).attr('src', variant.Picture);
                            } else {
                                product.find(elements.image).attr('src', product.find(elements.image).attr('data-ng-src'));
                            }

                            product.find(elements.id).val(variantId);
                            console.log(product.find(elements.id), variantId)
                            product.data('buyable', buyable);
                            product.find(elements.shopPopup).removeClass('disabled')
                            
                            
                            if (buyable) {
                                product.find(elements.buy).removeClass('ng-hide');
                                product.find(elements.link).addClass('ng-hide');
                            } else {
                                product.find(elements.buy).addClass('ng-hide');
                                product.find(elements.link).removeClass('ng-hide');
                            }
                        }
                    });
                }
            };
            
        }, 300);

    });



})(jQuery, window);