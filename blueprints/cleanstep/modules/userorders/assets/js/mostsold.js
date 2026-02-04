;(function($) {
	'use strict';

    var selectors = {
        select: '[data-mostsold="select"]',
        input: '[name="mostsold-orderby"]',
        line: '[data-mostsold="line"]',
    }

    var MostSold = function() {
    };

    MostSold.prototype = {
        init: function() {
            var self = this;
            self.bindEvents();

            // Set initial value
            var initialValue = $(selectors.input + ':checked').val();
            $(selectors.select).val(initialValue);
            $(selectors.select).trigger('change');
        },
        bindEvents: function() {
            var self = this;

            $(selectors.input).on('change', function() {
                var value = $(this).val();
                $(selectors.select).val(value);
                $(selectors.select).trigger('change');
            });

            $(selectors.select).on('change', function() {
                var value = $(this).val();
                self.changeOrder(value);
            });
        },
        changeOrder: function(value) {
            var self = this;
            var $lines = $(selectors.line);

            console.log('Changing order to:', value);

            $lines.each(function() {
                var amount = parseInt($(this).data('amount'), 10);
                var price = parseFloat($(this).data('price'));
                var orderValue = 0;

                if (value === 'most_sold') {
                    orderValue = -amount; // Descending by amount
                } else if (value === 'price_desc') {
                    orderValue = -price; // Descending by price
                } else {
                    orderValue = 0; // Default order
                }

                $(this).css('order', orderValue);
            });
        },
    };

    $(function() {
        var mostSold = new MostSold();
        if (platform.page.isUserEdit) {
            mostSold.init();
        }
    });

})(jQuery, window);