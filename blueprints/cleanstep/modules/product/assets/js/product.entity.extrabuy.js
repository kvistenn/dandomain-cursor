;(function ($, eksport) {
    'use strict';

    var selectors = {
        container: '[data-product="extrabuy"]',
        checkboxes: '[data-extrabuy="checkbox"]',
        variant: '[data-extrabuy="variant"]'
    };

    var ExtraBuy = function() {
        var self        = this;
        var $container = $(selectors.container);
        var $checkboxes = $(selectors.checkboxes);
        var $variant = $(selectors.variant);
    }

    ExtraBuy.prototype = {
        init: function() {
            var self = this;
            self.bindEvents();
        },
        bindEvents: function() {
            var self = this;

            // Handle checkbox change
            $(selectors.checkboxes).on('change', function(e) {
                e.preventDefault();
                self.handleSelect(e);
            });

            $(selectors.variant).on('change', function(e) {
                e.preventDefault();
                self.handleSelect(e);
            });
        },
        handleSelect: function(e) {
            var self = this;
            self.getSelectedData().then(function(selectedData) {
                window.platform.extrabuy = window.platform.extrabuy || {};
                window.platform.extrabuy.products = window.platform.extrabuy.products || [];
                window.platform.extrabuy.products = selectedData.products || [];
                window.platform.extrabuy.totalPrice = selectedData.totalPrice || 0;

                // Update prices
                platform.product.updatePrices(platform.product.item);
            });
        },
        getSelectedData: function() {
            var self = this;
            var selectedData = [];
            var totalPrice = 0;
            var ajaxCalls = [];

            $(selectors.checkboxes).each(function() {
                var $checkbox = $(this);
                var $label = $checkbox.closest('label');

                var productId = $checkbox.attr('id');
                if ($checkbox.is(':checked')) {
                    var data = {
                        id: productId
                    };

                    var dataIds = [];
                    var variantInput = $label.find(selectors.variant);

                    if (variantInput.length > 0) {
                        variantInput.each(function() {
                            dataIds.push($(this).val());
                        });

                        // Push ajax call promise to array
                        var ajaxPromise = $.ajax({
                            url: '/json/productvariants/' + productId + '?dataIds=' + dataIds.join(','),
                            method: 'GET',
                            dataType: 'json'
                        }).then(function(res) {
                            var item = res.data[0];
                            data.variantid = item.Id;
                            /* self.setVariantPrice(productId, item.Id, item.Price); */
                        });

                        ajaxCalls.push(ajaxPromise);
                    }

                    selectedData.push(data);
                    totalPrice += parseFloat($checkbox.data('price'));
                }
            });

            // Wait for all ajax calls to finish before returning data
            return $.when.apply($, ajaxCalls).then(function() {
                return {
                    products: selectedData,
                    totalPrice: totalPrice
                };
            });
        },
        setVariantPrice: function(productId, variantId, price) {
            var $label = $('[data-extrabuy="checkbox"][id="' + productId + '"]').closest('label');
            $label.find('[data-extrabuy="price"]').text('+ ' + platform.currency_format(price));
        }
    }

    // ==========================================================================
    // Init
    // ==========================================================================

    $(function() {
        var extrabuy = new ExtraBuy();
        extrabuy.init();
    });

})(jQuery, window);
