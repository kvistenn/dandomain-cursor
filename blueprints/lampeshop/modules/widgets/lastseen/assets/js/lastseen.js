;(function($, platform) {

    var lastSeenIds = [];
    if(typeof $.cookie('lastseen') !== "undefined") {
        var cookieString = decodeURIComponent($.cookie('lastseen'))
        var cookieArray = cookieString.split(',');
        lastSeenIds = $.merge(lastSeenIds, cookieArray);
    }

    function handleLastSeen() {
        var masterId = platform.page.productId.toString();
        if (lastSeenIds.indexOf(masterId) == -1) {
            lastSeenIds.push(masterId);
            if (lastSeenIds.length == 6) {
                lastSeenIds.shift();
            }
            $.cookie('lastseen', lastSeenIds.join(','), { path: '/' });
        }
    }

    if(platform.page.isProduct && platform.page.productId !== null) {
        handleLastSeen();
    }
    
})(jQuery, platform);