(function($, document, undefined) {
    'use strict';

    var slider = $('[data-slick="slider"]');

    $(function() {

        slider.each(function() {
            var $this = $(this);

            $this.slick({
                dots: true,
                arrows: false,
                autoplay: true,
                autoplaySpeed: 5000,
                speed: 500,
                slidesToShow: 1,
                slidesToScroll: 1,
                adaptiveHeight: true,
                infinite: false
            });
        });


    });


})(jQuery, document);