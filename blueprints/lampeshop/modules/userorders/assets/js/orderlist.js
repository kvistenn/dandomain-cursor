; (function ($, eksport) {
    'use strict';

    if (platform.page.isUserOrders) {

        var tooltip = $('[data-tooltip]');


        tooltip.each(function () {
            var tooltip = $(this);
            var action = tooltip.data('tooltip-trigger');
            var target = tooltip.find('[role="tooltip"]');

            if (action === 'hover') {
                tooltip.hover(function () {
                    target.removeClass('invisible opacity-0');
                }, function () {
                    target.addClass('invisible opacity-0');
                });
            } else if (action === 'click') {
                tooltip.click(function () {
                    target.toggleClass('invisible opacity-0');
                });
                $(document).click(function (e) {
                    var target = $(e.target);
                    if (!target.closest('[data-tooltip]').length) {
                        tooltip.find('[role="tooltip"]').addClass('invisible opacity-0');
                    }
                });
            }
        });


    }


})(jQuery, window);