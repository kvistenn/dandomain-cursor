;(function ($, eksport) {
    'use strict';

    var selectors = {
        input       : "[data-product='count']",
        btn_add     : "[data-product='add']",
        btn_sub     : "[data-product='subtract']",
        custom_data : "[data-product='custom-data']",
        custom_data_list : "[data-product='custom-data-list']",
        addonOption : "[data-addon='option']",
        addonImage  : "[data-addon='image']",
        addonInput  : "[data-addon='input']"
    }

    var Actions = function(input) {
        var self        = this;

        this.$input      = $(input);
        this.$parent     = $(input).parent();
        this.$btn_add    = this.$parent.find(selectors.btn_add);
        this.$btn_sub    = this.$parent.find(selectors.btn_sub);
        this.$addonOption = $(selectors.addonOption);
        this.$addonImage = $(selectors.addonImage);
        this.$addonInput = $(selectors.addonInput);

        this.$btn_add.on("click", {event: "add"}, $.proxy(this.changeAmount, this));
        this.$btn_sub.on("click", {event: "subtract"}, $.proxy(this.changeAmount, this));
        this.$input.on('blur', this.onBlur.bind(this));
        this.$addonOption.on('change', this.handleAddonChange.bind(this));
    }




    Actions.prototype = {
        changeAmount : function (e) {
            var value = parseInt(this.$input.val(), 10),
                data = {
                    event       : e.data.event,
                    product     : this
                };


            if (this.$input.is(":disabled")) {
                return;
            }

            if (isNaN(value)) {
                // eventHandler.trigger("invalidInput", data);
                return;
            }

            this.minAmount = parseInt(this.$input.data("productMinamount"),10);

            if (e.data.event === "add") {
                this.handleAdd(data, value);
                // eventHandler.trigger(e.data.event+"Product", data);
            }

            if (e.data.event === "subtract" && value !== 0) {
                this.handleSub(data, value);
                // eventHandler.trigger(e.data.event+"Product", data);
            }

        },




        handleAdd: function(data, value) {
            data.oldValue = value;
            data.value = (value === 0 && this.minAmount > 1) ? value + this.minAmount : value + 1;
            if (this.$input.attr('max')) {
                var maxVal = parseInt(this.$input.attr('max'));
                if (data.value > maxVal) {
                    data.value = maxVal;
                }
            }
            this.$input.val(data.value);
        },


        onBlur: function(data) {
            var inputValue = parseInt(this.$input.val());
            if (isNaN(inputValue)) {
                this.$input.val(data.oldValue);
            } else {
                if (this.$input.attr('max')) {
                    var maxVal = parseInt(this.$input.attr('max'));
                    if (inputValue > maxVal) {
                        this.$input.val(maxVal);
                        data.value = maxVal;
                    } else {
                        data.value = inputValue;
                    }
                } else {
                    data.value = inputValue;
                }
            }
        },

        handleSub : function(data, value) {
            data.oldValue = value;
            data.value = (value === 0 || value === this.minAmount) ? 0 : value - 1;
            this.$input.val(data.value);
        },

        handleAddonChange: function(e) {
            var self = this;

            var image = self.$addonImage;
            var itemImageSrc = $(e.target).closest('li').attr('data-image');

            var input = self.$addonInput;
            var itemTitle = $(e.target).closest('li').attr('data-title');

            if(itemTitle) {
                itemTitle = platform.replaceSpecialChars(itemTitle);
                input.val(itemTitle);
            } else {
                input.val(text.POS_CHECKOUT_DELIVERY_DEFAULT);
            }

            if(itemImageSrc) {
                image.attr('src', itemImageSrc);
            } else {
                image.attr('src', image.attr('data-defaultimage'));
            }
        }
    };


    // ==========================================================================
    // Init
    // ==========================================================================

    $(function() {

        $(selectors.input).each(function () {
            $(this).data("product", new Actions(this));
        });

        // If custom_data_list is empty remove custom_data
        if($.trim($(selectors.custom_data_list).text()) == "") {
            $(selectors.custom_data).remove();
        }

    });

})(jQuery, window);

