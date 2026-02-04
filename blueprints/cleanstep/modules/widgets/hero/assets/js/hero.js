(function($, document, undefined) {
    'use strict';

    $(function() {

        var hero = $('[data-swiper="hero"]');

        if (hero.length) {
            new Swiper(hero[0], {
                direction: 'horizontal',
                slidesPerView: 1,
                loop: true,
                /* autoplay: {
                    delay: 5000,
                    disableOnInteraction: false
                }, */
                pagination: {
                    el: '.swiper-pagination',
                },
                navigation: {
                    nextEl: hero.find('.swiper-button-next')[0],
                    prevEl: hero.find('.swiper-button-prev')[0],
                },
                autoHeight: true,
                /* cssMode: true, */
                on: {
                    slideChange: function() {
                        const activeSlide = this.slides[this.activeIndex];
                        if(activeSlide) {
                            const video = activeSlide.querySelector('video');
                            if (video) {
                                video.play();
                            }
                        }
                    },
                    slideNextTransitionStart: function() {
                        const previousSlide = this.slides[this.previousIndex];
                        if(previousSlide) {
                            const video = previousSlide.querySelector('video');
                            if (video) {
                                video.pause();
                            }
                        }
                    }
                }
            });
        }


    });


})(jQuery, document);