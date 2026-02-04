(function($) {
    'use strict';

    $(function() {

        var categories = $('[data-swiper="categories"]');
        
        if (categories.length ) {
            new Swiper(categories.find('.swiper')[0], {
                direction: 'horizontal',
                loop: true,
                slidesPerView: 12,
                spaceBetween: 30,
                calculateHeight:true,
                navigation: {
                    nextEl: categories.find('.swiper-button-next')[0],
                    prevEl: categories.find('.swiper-button-prev')[0],
                },
                breakpoints: {
                    1600: {
                        slidesPerView: 10,
                    },
                    1400: {
                        slidesPerView: 9,
                    },
                    1280: {
                        slidesPerView: 8,
                    },
                    1024: {
                        slidesPerView: 6.5,
                    },
                    768: {
                        slidesPerView: 5.5,
                    },
                    640: {
                        slidesPerView: 4.5,
                    },
                    480: {
                        slidesPerView: 3.5,
                    },
                    0: {
                        slidesPerView: 2.5,
                    }
                }
            });
        }

    });

})(jQuery);