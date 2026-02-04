;(function ($, eksport, undefined) {
    'use strict';

    // ==========================================================================
    // Product Prototype
    // ==========================================================================

    var Product = function(id) {
        var self = this;
        this.id = id;
        this.tries = 0;
        this.version = 20191219;

        this.API = {
            product : "/json/products/id/{productId}"
        };

        this.selectors = {
            buy                     : "[data-controller='buy']",
            unitTitle               : "[data-controller='unittitle']",
            input                   : "[data-controller='input']",
            amount                  : "[data-controller='amount']",
            itemNumber             : "[data-controller='itemnumber']",
            onstock                : "[data-controller='onstock']",
            nostock                : "[data-controller='nostock']",
            stocktext              : "[data-controller='stocktext']",
            shortdescription       : "[data-controller='shortdescription']",
            description            : "[data-controller='description']",
            prices                : "#prices"
        }

        // Get used elements from DOM
        this.$buy                   = $(this.selectors.buy);
        this.$input                 = $(this.selectors.input);
        this.$amount                = $(this.selectors.amount);
        this.$itemNumber             = $(this.selectors.itemNumber);
        this.$onstock               = $(this.selectors.onstock);
        this.$nostock               = $(this.selectors.nostock);
        this.$stocktext             = $(this.selectors.stocktext);
        this.$shortdescription      = $(this.selectors.shortdescription);
        this.$description           = $(this.selectors.description);
        this.$prices                = $(this.selectors.prices);
        this.$pricesTemplate        = $.templates('#render-prices');
    };


    Product.prototype = {
        get : function(cb) {

            if (!this.id) {
                return;
            }

            var self = this;
            self.tries = self.tries + 1;

            $.get(this.API.product.replace("{productId}", this.id))
                .done(function( data ) {
                    self.item = (data.amount && data.products) ? data.products[0] : undefined;
                    $.extend(self, self.item);
                    self.updatePrices(self.item);
                    cb( self.item );
                })
                .fail(function () {
                    if (self.tries < 3) {
                        self.get(self.id);
                    } else {
                        self.item = undefined;
                        cb( self.item );
                    }
                });
        },
        showWarning : function(stop) {
            var self = this;

            console.log("showWarning");
            
        },
        updateItemNumber : function(item) {
            var self = this;
            var itemNumber = item ? item.ItemNumber : "";

            if (itemNumber) {
                self.$itemNumber.text(itemNumber);
            } else {
                self.$itemNumber.text("");
            }
        },
        updateStock : function(item) {
            var self = this;

            if(item.Stock > 0 && item.Buyable) {
                self.$onstock.show();
                self.$nostock.hide();
                self.$onstock.find(self.selectors.stocktext).text(item.DeliveryTimeText);
                self.$buy.removeAttr("disabled");
            } else {
                self.$onstock.hide();
                self.$nostock.show();
                self.$nostock.find(self.selectors.stocktext).text(item.DeliveryTimeText);
                self.$buy.attr("disabled", "disabled");
            }
        },
        updateDescriptions : function(item) {
            var self = this;

            if(item.Description !== "") {
                self.$description.html(item.Description);
            }

            if(item.DescriptionShort !== "") {
                self.$shortdescription.html(item.DescriptionShort);
            }
        },
        updatePrices: function(item) {
            var self = this;
            var prices = item.Prices || [];
            var hasVatIncludedLabel = false;

            var calculatedPrice = prices[0] ? prices[0].PriceMin : 0;
            prices.forEach(function(price) {
                if (price.Amount <= self.$amount.val()) {
                    calculatedPrice = price.PriceMin * self.$amount.val();
                }
            });

            if(platform.extrabuy) {
                calculatedPrice += platform.extrabuy.totalPrice;
            }

            /* $currency.hasVat and ($settings.vat_label_advanced eq false or $priceInterval->PriceMinWithVat gt $priceInterval->PriceMinWithoutVat) */
            if(platform.currency.hasVat && (platform.settings.vat_label_advanced == false || prices[0].PriceMinWithVat > prices[0].PriceMinWithoutVat)) {
                hasVatIncludedLabel = true;
            }

            var htmlOutput = self.$pricesTemplate.render(prices, {
                currency: platform.currency_format,
                unitTitle: item.UnitTitle,
                settings: platform.settings,
                hasVatIncludedLabel: hasVatIncludedLabel,
                calculatedPrice: calculatedPrice,
                specialPrice: item.SpecialPrice,
                template: platform.template
            });

            $(self.selectors.prices).html(htmlOutput);
        }
    };

    eksport.platform = eksport.platform || {};
    eksport.platform.classes = eksport.platform.classes || {};
    eksport.platform.classes.Product = Product;

})(jQuery, window);
