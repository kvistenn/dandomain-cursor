;(function($) {
	'use strict';

    var selectors = {
        search: '[data-user="search"]',
        reorder: '[data-user="reorder"]',
        order: '[data-user="order"]',
        orders: '[data-user="orders"]'
    }

    var UserOrders = function() {
    };

    UserOrders.prototype = {
        init: function() {
            this.bindEvents();
        },
        bindEvents: function() {
            var self = this;

            $(selectors.reorder).off('click').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();

                var $this = $(this);
                var url = $this.attr('href');

                location.href = url;
            });

            $(selectors.search).off('keyup').on('keyup', function() {
                var searchTerm = $(this).val().toLowerCase();
                console.log('Searching for:', searchTerm);
                $(selectors.orders).find(selectors.order).each(function() {
                    var $order = $(this);
                    console.log('Checking order:', $order.text().toLowerCase());
                    if ($order.text().toLowerCase().indexOf(searchTerm) > -1) {
                        $order.show();
                    } else {
                        $order.hide();
                    }
                });
            });
        },
    };

    $(function() {
        var userOrders = new UserOrders();
        if (platform.page.isUserOrders) {
            userOrders.init();
        }
    });

})(jQuery, window);