(function($, document, undefined) {
    'use strict';

    
    $(function() {
        
        var usp = $('[data-swiper="usp"]');
        
        if (usp.length) {
            new Swiper(usp[0], {
                slidesPerView: 1,
                loop: true,
                autoHeight: true,
                autoplay: {
                    delay: 3000
                },
                breakpoints: {
                    1024: {
                        direction: 'horizontal',
                        slidesPerView: 5,
                    },
                }
            });
        }

    });


})(jQuery, document);