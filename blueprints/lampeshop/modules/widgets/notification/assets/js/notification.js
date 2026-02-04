;(function($, eksport) {
    'use strict';

    var Message = function() {
        this.$el = $('[data-notification]');
    }
    
    Message.prototype = {

        load: function(message, status) {

            var self = this;
            var $el = self.$el;
    
            if (status == '0') {
                $el.removeClass('error');
                $el.addClass('success');
            } else {
                $el.removeClass('success');
                $el.addClass('error');
            }
            
            $el.find('.panel-body').html(message);
    
            $el.addClass('animate');

            setTimeout(function() {
                $el.removeClass('animate');
            }, 5000);

        }


    }

    var message = new Message();
    eksport.platform.Message = message;

})(jQuery, window);