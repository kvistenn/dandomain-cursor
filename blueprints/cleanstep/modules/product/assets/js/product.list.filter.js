;(function ($, eksport) {
    'use strict';

    if (platform.page.isProduct && platform.page.productId == null) {
        var productlistString = 'fetch.productlist';
    } else {
        var productlistString = 'loaded.productlist';
    }

    $(platform).on(productlistString, (e) => {
        setTimeout(function () {

            var filterButtons = $('[for="toggle-filter"]');
            var filterContainer = $('[data-filter="container"]');
            var filterTogglers = $('[data-filter="toggler"]');

            filterButtons.on('click', function (e) {
                var filterGroup = $(this).attr('data-filter');

                filterTogglers.each(function () {
                    $(this).prop('checked', false);
                    $(this).trigger('change');
                });

                if(filterGroup != undefined) {
                    filterContainer.find('input[type="checkbox"]#toggle-filter-' + filterGroup).each(function () {
                        $(this).prop('checked', true);
                        $(this).trigger('change');
                    });
                }

            });

            /* Filter: Price */
            var priceCheckbox = $('[name="filterprice"]');
            var priceMinInput = $('[data-filter="price-min"]');
            var priceMaxInput = $('[data-filter="price-max"]');

            priceCheckbox.on('change', function () {
                var minPrice = $(this).data('min');
                var maxPrice = $(this).data('max');

                console.log('Price filter changed:', minPrice, maxPrice);

                if ($(this).is(':checked')) {
                    priceMinInput.val(minPrice);
                    priceMaxInput.val(maxPrice);
                }
            });

        }, 0);

    });

})(jQuery, window.platform = window.platform || {});