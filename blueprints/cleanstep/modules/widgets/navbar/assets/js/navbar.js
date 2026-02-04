(function($, document, undefined) {
    'use strict';

    $(function() {

        const $navigation = $('[data-component="header"]');
        let lastScrollTop = 0;
        const scrollThreshold = 300;
        
        $(window).on('scroll', function() {
            const scrollTop = $(this).scrollTop();
        
            if (scrollTop > lastScrollTop && scrollTop > scrollThreshold) {
                $navigation.addClass('hide');
            } else {
                $navigation.removeClass('hide');
            }
        
            lastScrollTop = scrollTop;
        });
    });

})(jQuery, document);