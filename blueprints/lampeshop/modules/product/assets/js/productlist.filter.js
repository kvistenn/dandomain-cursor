;(function ($, eksport) {
    'use strict';

    var filter = $('[data-filter="filter"]'),
        open = $('[data-filter="open"]'),
        close = $('[data-filter="close"]'),
        overlay = $('[data-filter="overlay"]'),
        toggle = $('[data-filter="toggle"]');

    $(function() {
        
        open.on('click', function(e) {
            e.preventDefault();
            filter.addClass('show');
            overlay.addClass('show');
        });

        close.on('click', function(e) {
            e.preventDefault();
            filter.removeClass('show');
            overlay.removeClass('show');
        });

        overlay.on('click', function(e) {
            e.preventDefault();
            filter.removeClass('show');
            overlay.removeClass('show');
        });

        $(document).on('click', '[data-filter="toggle"] > strong', function(e) {
            e.preventDefault();
            $(e.target).closest('[data-filter="toggle"]').find('> div').slideToggle(function() {
                if($(this).is(':visible')) {
                    $(e.target).closest('[data-filter="toggle"]').removeClass('folded');
                } else {
                    $(e.target).closest('[data-filter="toggle"]').addClass('folded');
                }
            });
            $(e.target).closest('[data-filter="toggle"]').find('[data-filter="arrow"]').toggleClass('rotate-180');
        });

        $(document).on('click', '[data-filter="toggle"] [data-filter="more"]', function(e) {
            e.preventDefault();
            $(e.target).closest('[data-filter="toggle"]').toggleClass('show');
            $(e.target).closest('[data-filter="more"]').toggleClass('show');
        });

    });

})(jQuery, window);
