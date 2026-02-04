;(function($, platform, exports) {
	'use strict';

    if(!platform.page.isCheckout) {
        if (googleReviews.showBadge) {
            window.renderBadge = function () {
                var ratingBadgeContainer = document.createElement('div');
                document.body.appendChild(ratingBadgeContainer);
                window.gapi.load('ratingbadge', function () {
                    window.gapi.ratingbadge.render(
                        ratingBadgeContainer, {
                            "merchant_id": googleReviews.googleMerchantId,
                            "position": 'BOTTOM_RIGHT'
                        });
                });
            }
            
            $.getScript('https://apis.google.com/js/platform.js?onload=renderBadge');
        }
    }

})(jQuery, window.platform, window);