
; (function ($, eksport) {
    'use strict';

    if (platform.page.isProduct && platform.page.productId == null) {
        var productlistString = 'fetch.productlist';
    } else {
        var productlistString = 'loaded.productlist';
    }

    $(platform).on(productlistString, (e) => {
        setTimeout(function () {

            $(document).off('click', '[data-productlist="togglepricelines"]'); // Unsubscribe previous events

            $(document).on('click', '[data-productlist="togglepricelines"]', function (e) {
                e.preventDefault();

                var $this = $(e.target);
                var product = $this.closest('.product');

                product.find('[data-productlist="pricelines"]').slideToggle();

            });

        });
    });

})(jQuery, window);