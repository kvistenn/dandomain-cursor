(function() {
    
    if(document.location.href.indexOf('?cat=') > -1 && platform.page.isBlog) {
        var activeCat = document.location.href.split('?cat=')[1];
        $('[data-blog="categories"] a[data-id="' + activeCat + '"]').addClass('bg-brand text-white');
    }

})()