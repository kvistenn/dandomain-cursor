;(function ($, eksport) {
    'use strict';

    if (platform.page.isProduct && platform.page.productId == null) {
        var productlistString = 'fetch.productlist';
    } else {
        var productlistString = 'loaded.productlist';
    }

    $(platform).on(productlistString, (e) => {
        setTimeout(function () {

            var sortingToggler = $('#toggle-sorting');
            var sortingOptions = $('[name="option-orderby"]');
            var sortingSelect = $('[data-sorting="select"]');

            sortingToggler.on('change', function (e) {
                if(!$(this).is(':checked')) {
                    sortingOptions.each(function () {
                        if($(this).is(':checked')) {
                            sortingSelect.val("string:" + $(this).val()).trigger('change');
                        }
                    });
                }
            });

        }, 0);

    });

})(jQuery, window.platform = window.platform || {});