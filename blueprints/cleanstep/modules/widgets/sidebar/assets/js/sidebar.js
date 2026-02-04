(function($, document, undefined) {
    'use strict';

    var open = $('[data-sidebar="open"]'),
        sidebar = $('[data-sidebar="sidebar"]'),
        sidebarOverlay = $('[data-sidebar="overlay"]'),
        sidebarClose = $('[data-sidebar="close"]'),
        sidebarMenu = $('[data-sidebar="menu"]');

    $(function() {
        
        // Open sidebar
        open.on('click', function(e) {
            e.preventDefault();
            sidebar.addClass('show');
            sidebarOverlay.addClass('show');
        });

        // Close sidebar
        sidebarClose.on('click', function(e) {
            e.preventDefault();
            sidebar.removeClass('show');
            sidebarOverlay.removeClass('show');
        });

        // Close sidebar when clicking on overlay
        sidebarOverlay.on('click', function(e) {
            e.preventDefault();
            sidebar.removeClass('show');
            sidebarOverlay.removeClass('show');
        });

        // Sidebar submenu
        sidebarMenu.find('[data-sidebar="toggle"]').parent().on('click', function(e) {
            e.preventDefault();
            $(this).parent().find('> div').slideToggle();
        });

    });


})(jQuery, document);