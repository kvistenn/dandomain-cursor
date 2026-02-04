;(function ($, eksport) {
    'use strict';

    var selectors = {
        input        : "[data-product='count']",
        count_colli  : "[data-product='count-colli']",
        btn_add      : "[data-product='add']",
        btn_sub      : "[data-product='subtract']",
        colli        : "[data-product='colli']",
        colliinfo    : "[data-product='colliinfo']"
    }

    var Actions = function(input) {
        var self        = this;

        this.$input       = $(input);
        this.$count_colli = $(selectors.count_colli);
        this.$parent      = $(input).parent();
        this.$btn_add     = this.$parent.find(selectors.btn_add);
        this.$btn_sub     = this.$parent.find(selectors.btn_sub);
        this.$colli       = $(selectors.colli);
        this.$colliinfo   = $(selectors.colliinfo);

        this.$btn_add.on("click", {event: "add"}, $.proxy(this.changeAmount, this));
        this.$btn_sub.on("click", {event: "subtract"}, $.proxy(this.changeAmount, this));
        this.$input.on("change", {event: "input"}, $.proxy(this.changeAmount, this));
        this.$colli.on("change", $.proxy(this.changeColli, this));

        this.$count_colli.on("change", $.proxy(this.changeColliAmount, this));
    }

    Actions.prototype = {
        changeAmount : function (e) {

            var self = this;

            var value = parseInt(this.$input.val(), 10),
                data = {
                    event       : e.data.event,
                    product     : this
                };


            if (this.$input.is(":disabled")) {
                return;
            }

            if (isNaN(value)) {
                return;
            }

            this.minAmount = parseInt(this.$input.attr("min"),10);

            if (e.data.event === "add") {
                this.handleAdd(data, value);
            }

            if (e.data.event === "subtract" && value !== 0) {
                this.handleSub(data, value);
            }

            // Update prices
            platform.product.updatePrices(platform.product.item);

        },
        handleAdd : function (data, value) {
            data.oldValue = value;
            data.value = (value === 0 && this.minAmount > 1) ? value + this.minAmount : value + 1;
            this.$input.val(data.value);
            // Update prices
            platform.product.updatePrices(platform.product.item);
        },
        handleSub : function(data, value) {
            data.oldValue = value;
            data.value = (value === 0 || value === this.minAmount) ? this.minAmount : value - 1;
            this.$input.val(data.value);
            // Update prices
            platform.product.updatePrices(platform.product.item);
        },
        changeColliAmount: function() {
            var self = this;

            var amount = parseInt(self.$count_colli.val()),
                colli = parseInt(self.$colli.val());

            if (isNaN(amount) || isNaN(colli)) {
                return;
            }

            if (colli === 1) {
                self.$input.val(amount);
                self.$input.trigger("change");
            } else {
                var colliAmount = amount * colli;
                self.$input.val(colliAmount);
                self.$input.trigger("change");
            }
        },
        changeColli : function () {
            var self = this;
            if (self.$colli.val() == "1") {
                self.$colliinfo.addClass('hidden');
            } else {
                self.$colliinfo.removeClass('hidden');
            }

            self.changeColliAmount();
        }
    };

    // ==========================================================================
    // Init
    // ==========================================================================

    $(function() {
        $(selectors.input).each(function () {
            $(this).data("product", new Actions(this));
        });
    });

})(jQuery, window);
