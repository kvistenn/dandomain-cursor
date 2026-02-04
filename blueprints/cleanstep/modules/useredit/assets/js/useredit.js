;(function($) {
	'use strict';

    function checkDeliveryActive() {
        if ($('[data-user="deliveryActive"]').is(':checked')) {
            $('[data-user="delivery"]').show();
            $('[data-user="delivery"] input').attr('disabled', false);
        } else {
            $('[data-user="delivery"]').hide();
            $('[data-user="delivery"] input').attr('disabled', true);
        }
    }

    $('[data-user="deliveryActive"]').on('change', function (e) {
        checkDeliveryActive();
    });

    checkDeliveryActive();

})(jQuery, window);