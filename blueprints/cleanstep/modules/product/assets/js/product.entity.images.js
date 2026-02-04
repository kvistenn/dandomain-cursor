;(function ($, eksport) {
    'use strict';

    var selectors = {
        images: "[data-product='images']",
        thumbs: "[data-product='thumbs']"
    }

    $(function() {
        // Tjek først om begge slidere findes på siden
        if ($(selectors.images).length && $(selectors.thumbs).length) {

            // 1. Initialiser thumbnail-slideren FØRST
            var productThumbsSwiper = new Swiper(selectors.thumbs, {
                slidesPerView: 4,
                spaceBetween: 12,
                direction: 'horizontal',
                watchSlidesProgress: true,
                freeMode: true,
                breakpoints: {
                    480: {
                        slidesPerView: 5
                    },
                    640: {
                        slidesPerView: 6
                    },
                    768: {
                        direction: 'vertical',
                        spaceBetween: 0,
                        slidesPerView: 'auto'
                    }
                }
            });

            // 2. Initialiser hovedslideren og link den til thumbs-slideren
            var productImageSwiper = new Swiper(selectors.images, {
                slidesPerView: 1,
                thumbs: {
                    swiper: productThumbsSwiper
                }
            });
        }
    });

})(jQuery, window);
