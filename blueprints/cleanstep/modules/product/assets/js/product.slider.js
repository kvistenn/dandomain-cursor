;(function ($, eksport) {
    'use strict';

    $(function() {
        
        var $sliders = $('[data-swiper="productslider"]');
        if ($sliders.length) {
            $sliders.each(function() {

                var slidesPerView = $(this).data('swiper-slides') || 5;

                new Swiper(this.querySelector('.swiper'), {
                    navigation: {
                        nextEl: this.querySelector('.swiper-button-next'),
                        prevEl: this.querySelector('.swiper-button-prev'),
                    },
                    loop: true,
                    slidesPerView: 1.5,
                    spaceBetween: 20,
                    breakpoints: {
                        640: {
                            slidesPerView: 2.5,
                        },
                        768: {
                            slidesPerView: 3.5,
                        },
                        1024: {
                            slidesPerView: 4.5,
                        },
                        1280: {
                            slidesPerView: slidesPerView,
                        }
                    }
                });
            });
        }

    });

})(jQuery, window);
