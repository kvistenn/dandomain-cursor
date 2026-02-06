/**
 * Slider widget – Swiper JS init.
 * Handles [data-swiper="slider"] (page and product sliders).
 * Options via data-swiper-*: speed, pagination, nav, autoplay.
 */
(function ($, document) {
    'use strict';

    function initSliders() {
        var $containers = $('[data-swiper="slider"]');
        $containers.each(function () {
            var el = this;
            if (el._swiperSlider) return;
            var $el = $(el);
            var speed = parseInt($el.data('swiper-speed'), 10) || 5000;
            var pagination = $el.data('swiper-pagination');
            var nav = $el.data('swiper-nav');
            var autoplay = $el.data('swiper-autoplay');
            if (pagination === undefined || pagination === '') pagination = true;
            if (nav === undefined || nav === '') nav = true;
            if (autoplay === undefined || autoplay === '') autoplay = true;
            if (pagination === 'false' || pagination === false) pagination = false;
            if (nav === 'false' || nav === false) nav = false;
            if (autoplay === 'false' || autoplay === false) autoplay = false;

            var paginationEl = el.querySelector('.swiper-pagination');
            var nextEl = el.querySelector('.swiper-button-next');
            var prevEl = el.querySelector('.swiper-button-prev');

            var opts = {
                direction: 'horizontal',
                slidesPerView: 1,
                loop: true,
                autoHeight: true,
                autoplay: autoplay ? { delay: speed, disableOnInteraction: false } : false,
                pagination: pagination && paginationEl ? { el: paginationEl } : false,
                navigation: nav && nextEl && prevEl ? { nextEl: nextEl, prevEl: prevEl } : false,
                on: {
                    slideChange: function () {
                        var activeSlide = this.slides[this.activeIndex];
                        if (activeSlide) {
                            var video = activeSlide.querySelector('video');
                            if (video) video.play();
                        }
                    },
                    slideNextTransitionStart: function () {
                        var prevSlide = this.slides[this.previousIndex];
                        if (prevSlide) {
                            var video = prevSlide.querySelector('video');
                            if (video) video.pause();
                        }
                    },
                    slidePrevTransitionStart: function () {
                        var prevSlide = this.slides[this.previousIndex];
                        if (prevSlide) {
                            var video = prevSlide.querySelector('video');
                            if (video) video.pause();
                        }
                    }
                }
            };

            if (typeof Swiper !== 'undefined') {
                el._swiperSlider = new Swiper(el, opts);
            }
        });
    }

    $(function () {
        if (document.readyState === 'complete') {
            initSliders();
        } else {
            $(window).on('load', initSliders);
        }
    });
})(jQuery, document);
