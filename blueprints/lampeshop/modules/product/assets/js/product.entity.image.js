;(function ($, eksport) {
    'use strict';

    var selectors = {
        images: "[data-product='images']",
        thumbs: "[data-product='thumbs']"
    }

    $(function() {

        if($(selectors.thumbs).children().length > 5) {
            
            $(selectors.images).slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                asNavFor: selectors.thumbs,
                adaptiveHeight: true,
                prevArrow: '<span class="absolute top-1/2 -translate-y-1/2 left-0 z-20 -translate-x-1/4 2xl:-translate-x-full cursor-pointer"><span class="2xl:mr-3 w-10 h-10 bg-white border border-gray-200 2xl:border-none rounded-full flex items-center justify-center"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 2xl:w-5 2xl:h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" /></svg></span></span>',
                nextArrow: '<span class="absolute top-1/2 -translate-y-1/2 right-0 z-20 translate-x-1/4 2xl:translate-x-full cursor-pointer"><span class="2xl:ml-3 w-10 h-10 bg-white border border-gray-200 2xl:border-none rounded-full flex items-center justify-center"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 2xl:w-5 2xl:h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" /></svg></span></span>'
            });

            $(selectors.thumbs).slick({
                arrows: false,
                slidesToShow: 5,
                slidesToScroll: 1,
                asNavFor: selectors.images,
                focusOnSelect: true,
                responsive: [
                    {
                        breakpoint: 768,
                        settings: {
                            slidesToShow: 3
                        }
                    }
                ]
            });

        } else {

            $(selectors.images).slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                adaptiveHeight: true,
                prevArrow: '<span class="absolute top-1/2 -translate-y-1/2 left-0 z-20 -translate-x-1/4 2xl:-translate-x-full cursor-pointer"><span class="2xl:mr-3 w-10 h-10 bg-white border border-gray-200 2xl:border-none rounded-full flex items-center justify-center"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 2xl:w-5 2xl:h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" /></svg></span></span>',
                nextArrow: '<span class="absolute top-1/2 -translate-y-1/2 right-0 z-20 translate-x-1/4 2xl:translate-x-full cursor-pointer"><span class="2xl:ml-3 w-10 h-10 bg-white border border-gray-200 2xl:border-none rounded-full flex items-center justify-center"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 2xl:w-5 2xl:h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" /></svg></span></span>'
            });

            $(selectors.thumbs).children().on('click', function() {
                $(selectors.images).slick('slickGoTo', $(this).index());
            });
        }
    });

})(jQuery, window);
