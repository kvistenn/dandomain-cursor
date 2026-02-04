(function($, document, undefined) {
    'use strict';

    
    $(function() {
        
        var blog = $('[data-swiper="blog"]');

        if (blog.length) {

            new Swiper(blog.find('.swiper')[0], {
                slidesPerView: 1.5,
                spaceBetween: 20,
                loop: true,
                navigation: {
                    nextEl: blog.find('.swiper-button-next')[0],
                    prevEl: blog.find('.swiper-button-prev')[0],
                },
                breakpoints: {
                    480: {
                        slidesPerView: 2.5
                    },
                    768: {
                        slidesPerView: 3.5
                    },
                    1024: {
                        slidesPerView: 4.5
                    },
                    1280: {
                        slidesPerView: 5
                    },
                    1400: {
                        slidesPerView: 6
                    }
                }
            });

        }
    });


})(jQuery, document);