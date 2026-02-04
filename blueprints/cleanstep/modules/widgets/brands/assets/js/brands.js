(function($, document, undefined) {
    'use strict';

    
    $(function() {
        
        var brands = $('[data-swiper="brands"]');

        if (brands.length) {

            new Swiper(brands[0], {
                slidesPerView: 2,
                spaceBetween: 30,
                loop: true,
                autoHeight: true,
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false
                },
                breakpoints: {
                    480: {
                        slidesPerView: 4
                    },
                    768: {
                        slidesPerView: 6
                    },
                    1024: {
                        slidesPerView: 7
                    },
                    1200: {
                        slidesPerView: 10
                    }
                }
            });

        }
    });


})(jQuery, document);