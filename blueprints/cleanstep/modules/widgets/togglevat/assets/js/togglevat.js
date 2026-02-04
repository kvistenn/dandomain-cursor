(function($, document, undefined) {
    'use strict';

    $(function() {

        var $toggleVat = $('[data-vat="toggle"]');

        if($toggleVat.length) {
            $toggleVat.find('[data-vat]').on('click', function() {
                var vat = $(this).data('vat');
                $.cookie('vatPopup', 'hide', { expires: 10, path: '/' });
                window.location = '/actions/vat/change?select='+ vat;
            });
        }

        setTimeout(function() {
            if(platform.general.siteId == "1" && platform.currency.hasVat) {
                $.ajax({
                    type: 'GET',
                    url: '/actions/vat/change?select=no_vat',
                });
            }
        }, 1000);
    });

})(jQuery, document);