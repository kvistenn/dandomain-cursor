(function($, document, undefined) {
    'use strict';

    var usp = $('[data-usp="slider"]');

    $(function() {
        
        usp.slick({
            autoplay: true,
            autoplaySpeed: 3000,
            dots: false,
            arrows: false,
            mobileFirst: true,
            slidesToShow: 1,
            slidesToScroll: 1,
            responsive: [
                {
                    breakpoint: 767,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 1199,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4,
                        variableWidth: true
                    }
                }
            ]
        })

    });


})(jQuery, document);