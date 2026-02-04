;(function ($, eksport, undefined) {
    'use strict';

    var VARIANT_TYPE = "dropdown",
        VARIANT_TYPE_SELECTOR = "[data-variantType='"+ VARIANT_TYPE +"']",
        VARIANT_DATA_SELECTOR = "[data-variantData='"+ VARIANT_TYPE +"']",
        VARIANT_LIST_SELECTOR = "[data-variantList='"+ VARIANT_TYPE +"']",
        VARIANT_TRIGGER_SELECTOR = "[data-variantTrigger='"+ VARIANT_TYPE +"']",
        VARIANT_SEEMORE_SELECTOR = "[data-variant='seemore']",
        PRODUCT_IMAGE_SELECTOR = "[data-product='images']",
        BUYBUTTON_SELECTOR = "[data-product='buyButton']",
        VARIANTINFO_SELECTOR = "[data-product='variantinfo']",
        CHOOSE_VARIANT_SELECTOR = "[data-product='choosevariant']",
        PRODUCT_PRICES = "[data-product='prices']";


    var selectedVariant = false;

    // ==========================================================================
    // Variant Prototype
    // ==========================================================================

    var Variant = function(product) {
        var self = this;

        this.API = {
            // product variantTypes
            types       : "/json/productvariants/types/{productId}",

            // product variantTypes with data
            typesData   : "/json/productvariants/types/{productId}?fields=data",

           // product variantDatas
            datas       : "/json/productvariants/data/{productId}",

            // product variantTypes with data
            typeData    : "/json/productvariants/data/{productId}?typeId={typeId}",

            // product variantTypes with data
            typeDatas   : "/json/productvariants/data/{productId}?typeId={typeId}&dataIds={dataIds}",
            //typeDatas   : "/json/productvariants/data/{productId}",

            // product variant from datas
            variant     : "/json/productvariants/{productId}"
        };

        this.variantTypes = [];
        this.hasVariant = false;
        this.product = product;
        this.tries = 0;
    };


    
    Variant.prototype = {

        //
        // Init function
        //

        init : function () {
            var self = this,
                $variants = $(VARIANT_TYPE_SELECTOR);

            $variants.each(function (idx) {
                var $this = $(this),
                    settings = {
                        $this       : $this,
                        productId   : self.product.Id,
                        id          : $this.data("varianttypeid")
                    };

                var variantType = new VariantType(settings);
                variantType.init();
                self.variantTypes.push(variantType);
            });

            self.handleVariantDataUpdate = $.proxy(self.handleVariantDataUpdate, self);

            window.platform.subscribe("/variant/variantData/selected", self.handleVariantDataUpdate);
            window.platform.subscribe("/variant/variantData/unselected", self.handleVariantDataUpdate);

            if($("html").hasClass("ielt9")) {
                self.addListener();
            }

            // Get variantId from url
            var url = window.location.href;
            var variantId = url.split('?variantId=')[1];

            if(variantId) {

                $.get('/json/productvariants/' + self.product.Id + '?variantId=' + variantId, function(res) {
                    
                    var dataIds = [];

                    if(res.data.length > 0) {

                        res.data[0].Types.forEach(function(type) {
                            
                            var dataId = type.Data[0].Id;
                            dataIds.push(dataId);

                            $variants.find('[data-variantdataid="' + dataId + '"] > label').trigger('click');

                            $variants.find('[data-variantdataid="' + dataId + '"]').siblings().find('label').on('click', function(e) {
                                e.preventDefault();

                                var variantTypeId = $(this).closest(VARIANT_TYPE_SELECTOR).data('varianttypeid');
                                var siblingDataId = $(this).closest(VARIANT_DATA_SELECTOR).data('variantdataid');
                                var selectedDataIds = [siblingDataId];

                                self.variantTypes.forEach(function(variantType) {
                                    if(variantType.id != variantTypeId) {
                                        selectedDataIds.push(variantType.dataId);
                                    }
                                });

                                $.get('/json/productvariants/' + self.product.Id + '?dataIds=' + selectedDataIds.join(','), function(res2) {
                                    var newVariantId = res2.data[0].Id;
                                    
                                    // Change url to new variantId
                                    var newUrl = url.substring(0, url.lastIndexOf('/') + 1) + '?variantId=' + newVariantId;
                                    document.location.href = newUrl;
                                });
                                
                            });
                        });

                    }
                })
            } else {
                /* self.selectFirstVariant(); */
            }

            self.handleSeeMore();

            return self;
        },

        handleSeeMore : function () {
            var self = this;

            $(VARIANT_SEEMORE_SELECTOR).on("click", function() {
                var $this = $(this);

                if($this.closest(VARIANT_TYPE_SELECTOR).hasClass('active')) {
                    $this.closest(VARIANT_TYPE_SELECTOR).removeClass('active');
                    $this.text(text.CHECKOUT_WIDGET_SHOW_MORE);
                } else {
                    $this.closest(VARIANT_TYPE_SELECTOR).addClass('active');
                    $this.text(text.CHECKOUT_WIDGET_SHOW_LESS);
                }
            });
        },


        selectFirstVariant : function () {

            $(VARIANT_TYPE_SELECTOR).each(function () {
                $(this).find(VARIANT_DATA_SELECTOR).eq(0).find('label').trigger("click");
            });

            setTimeout(function () {
                selectedVariant = true;
            }, 1000);
        },


        addListener : function () {
            var self = this;

            $(VARIANT_DATA_SELECTOR).find("label").on("click", function(e) {
                var $this = $(this),
                    $for = $this.prop("for");

                console.log('Trigger click123', $this);

                if ($for !== "") {
                    $this.parents("[data-variantdata]").find("#" + $for).trigger("click");
                }

                e.preventDefault();
                e.stopPropagation();
            });
        },


        changeImage : function (fileId) {
            var slideIndex = $(PRODUCT_IMAGE_SELECTOR).find('[data-fileid="' + fileId + '"]').closest('.slick-slide').data('slick-index');

            if(selectedVariant) {
                $(PRODUCT_IMAGE_SELECTOR).slick('slickGoTo', slideIndex);
            } else {
                $(PRODUCT_IMAGE_SELECTOR).slick('slickGoTo', slideIndex, true);
            }
        },



        handleVariantDataUpdate : function (event, args) {
            var self = this,
                selectedVariantDatas = self.getSelectedVariantDatas(args[0]);
            /**
             * args:
             *  0 : variantTypeId,
             *  1 : variantDataId,
             */

            self.getVariant(selectedVariantDatas, function (variant) {

                if (variant && variant.Id) {

                    self.hasVariant = true;
                    self.variant = variant;
                    window.platform.publish("/product/variant/selected", [self.variant]);

                    self.changeImage(variant.FileId);

                } else {
                    self.hasVariant = false;
                    self.variant = undefined;
                    window.platform.publish("/product/variant/unselected");
                }
            });
        },




        getSelectedVariantDatas : function (selectedTypeId) {
            var self = this,
                selected = {},
                count = 0;

            for (var i = self.variantTypes.length - 1; i >= 0; i--) {
                if (self.variantTypes[i].hasVariantData()) {
                    selected[self.variantTypes[i].id] = {dataId : self.variantTypes[i].getDataId()};
                    count++;
                }
            };

            selected.count = count;

            return selected;
        },




        updateVariantTypes : function (selected) {
            var self = this;

            for (var i = self.variantTypes.length - 1; i >= 0; i--) {
                self.variantTypes[i].updateVariantDatas(selected);
            };

        },

        getVariant : function (selectedVariantDatas, cb) {
            var self = this;

            if (typeof cb !== "function") return;

            $.get(this.API.variant.replace("{productId}", self.product.Id)).done(function( data ) {

                $(VARIANT_DATA_SELECTOR).each(function() {
                    $(this).addClass('disabled');
                });

                self.variantTypes[0].$this.find(VARIANT_DATA_SELECTOR).each(function() {
                    $(this).removeClass('disabled');
                });

                let combinations = []; // combinations = [[10, 20, 30], [10, 21, 30], [10, 21, 31]]
                data.data.forEach(function(variant) {

                    let combination = [];

                    variant.Types.forEach(function(type) {
                        combination.push(type.Data[0].Id);
                    });

                    combinations.push(combination);
                });

                var selected = []; // selected = [10, 21]
                var selectedVariantDataKeys = Object.keys(selectedVariantDatas);
                selectedVariantDataKeys.forEach(function(key) {
                    if(key != 'count')
                    selected.push(selectedVariantDatas[key].dataId);
                });

                console.log("selectedVariantDatas", selectedVariantDatas)

                var selectedCombinations = [];
                combinations.forEach(function(combination) {
                    let found = true;
                    selected.forEach(function(dataId) {
                        if(combination.indexOf(dataId) == -1) {
                            found = false;
                        }
                    });

                    if(found) {
                        selectedCombinations.push(combination);
                    }
                });

                selectedCombinations.forEach(function(selectedCombination) {
                    selectedCombination.forEach(function(dataId) {
                        $('[data-variantdataid="' + dataId + '"]').removeClass('disabled');
                    });
                });

            });

            self.tries = self.tries + 1;

            var dataIds = [];
            $(VARIANT_DATA_SELECTOR).each(function() {
                if($(this).find('label').hasClass('selected')) {
                    dataIds.push($(this).data('variantdataid'));
                }
            });

            $.get(this.API.variant.replace("{productId}", self.product.Id), {dataIds: dataIds.join(",")})
                .done(function( data ) {
                    self.item = (data.count) ? data.data[0] : undefined;
                    $.extend(self, self.item);
                    cb( self.item );

                    $(VARIANTINFO_SELECTOR).show();
                    $(CHOOSE_VARIANT_SELECTOR).hide();

                    if(self.item && self.item.Stock > 0) {

                        var stock = self.item.Stock;
                        var prices = self.item.Prices;
                        var buyable = self.item.Buyable;
                        var unitTitle = self.item.UnitTitle;
                        var deliveryTimeText = self.item.DeliveryTimeText;

                        if(stock > 0) {
                            $(VARIANTINFO_SELECTOR).find("[data-product='variantinfo-instock']").show();
                            $(VARIANTINFO_SELECTOR).find("[data-product='variantinfo-outofstock']").hide();

                            if(deliveryTimeText) {
                                $(VARIANTINFO_SELECTOR).find("[data-product='variantinfo-instock'] > span:last-child").text(deliveryTimeText);
                            }
                        }  else {
                            $(VARIANTINFO_SELECTOR).find("[data-product='variantinfo-instock']").hide();
                            $(VARIANTINFO_SELECTOR).find("[data-product='variantinfo-outofstock']").show();

                            if(deliveryTimeText) {
                                $(VARIANTINFO_SELECTOR).find("[data-product='variantinfo-outofstock'] > span:last-child").text(deliveryTimeText);
                            }
                        }
                        
                        if (buyable) {
                            $(BUYBUTTON_SELECTOR).removeClass("opacity-30");
                            $(BUYBUTTON_SELECTOR).attr("disabled", false);
                        } else {
                            $(BUYBUTTON_SELECTOR).addClass("opacity-30");
                            $(BUYBUTTON_SELECTOR).attr("disabled", true);
                        }

                        if(prices) {
                            $(PRODUCT_PRICES).children('div').each(function(i, line) {
                                var $line = $(line);
                                var lineAmount = $line.data('amount')
                                
                                prices.forEach(function(price) {
                                    if(price.Amount == lineAmount) {
                                        $line.find('[data-price="from"]').hide();
                                        $line.find('[data-price="price"]').text(platform.currency_format(price.PriceMin));
                                        $line.find('[data-price="discount"]').text(platform.currency_format(price.FullPriceMin));
                                        
                                        let discountPercentage = ((price.FullPriceMin - price.PriceMin) / price.FullPriceMin) * 100;
                                        if(discountPercentage > 0) {
                                            $line.find('[data-price="discountpercentage"]').show();
                                            $line.find('[data-price="discountpercentage"]').text('-' + discountPercentage.toFixed(0) + '%');
                                        } else {
                                            $line.find('[data-price="discountpercentage"]').hide();
                                        }
                                    }
                                });
                            });
                        }
                    } else {
                        $(BUYBUTTON_SELECTOR).addClass("opacity-30");
                        $(BUYBUTTON_SELECTOR).attr("disabled", true);
                    }
                })
                .fail(function () {
                    if (self.tries < 3) {
                        self.getVariant(selectedVariantDatas, cb);
                    } else {
                        self.item = undefined;
                        cb( self.item );
                    }
                });
        },




        getDataIds : function (selected) {
            var self = this;
            return _.map(_.filter(selected, 'dataId'), 'dataId').join(",");
        },



        canDoActions : function () {
            var self = this;
            return self.hasVariant && self.variant && (self.variant.Stock >= self.variant.MinAmount || (self.variant.Stock < self.variant.MinAmount && self.variant.AllowOutOfStockPurchase));
        }
    };








    // ==========================================================================
    // VariantType Prototype
    // ==========================================================================

    var VariantType = function (args) {
        var self = this;

        this.API = {
            // product variantTypes with data
            typeDatas   : "/json/productvariants/data/{productId}?typeId={typeId}&dataIds={dataIds}",
            //typeDatas   : "/json/productvariants/data/{productId}?typeId={typeId}"
        };

        this.variantDatas = [];
        this.tries = 0;

        $.extend(this, args);
    };



    VariantType.prototype = {

        //
        // Init function
        //

        init : function () {
            var self = this,
                $variantDatas = self.$this.find(VARIANT_DATA_SELECTOR);

            $variantDatas.each(function (idx) {
                var $this = $(this),
                    settings = {
                        $this           : $this,
                        productId       : self.productId,
                        id              : $this.data("variantdataid"),
                        variantTypeId   : self.id
                    };

                var variantData = new VariantData(settings);
                variantData.init();
                self.variantDatas.push(variantData);
            });
        },




        hasVariantData : function () {
            var self = this,
                hasVariantData = false;

            for (var i = self.variantDatas.length - 1; i >= 0; i--) {
                if ( self.variantDatas[i].isSelected() ) {
                    self.dataId = self.variantDatas[i].id;
                    hasVariantData = true;
                    break;
                }
            };

            if (hasVariantData === false) {
                delete self.dataId;
            }

            return hasVariantData;
        },




        getDataId : function () {
            var self = this;
            return self.dataId;
        },




       updateVariantDatas : function (selected) {
            var self = this;

            self.getVariantDataIds(selected, function (datas) {
                for (var i = self.variantDatas.length - 1; i >= 0; i--) {
                    self.variantDatas[i].enable(datas);
                };
            });

            $(BUYBUTTON_SELECTOR).attr('disabled', true);
            $(BUYBUTTON_SELECTOR).addClass('opacity-30');

        },





        getVariantDataIds : function (selected, cb) {
            var self = this;

            if (typeof cb !== "function") return;

            self.tries = self.tries + 1;

            $.get(this.API.typeDatas.replace("{productId}", self.productId).replace("{typeId}", self.id), {dataIds: self.getDataIds(selected)})
                .done(function( data ) {
                    cb( data );
                })
                .fail(function () {
                    if (self.tries < 3) {
                        self.getVariantDataIds(selected, cb);
                    } else {
                        cb( undefined );
                    }
                });
        },




        getDataIds : function(selected) {
            var self = this;
            return _.map(_.filter(selected, 'dataId'), 'dataId').join(",");
        }
    };








    // ==========================================================================
    // VariantData Prototype
    // ==========================================================================

    var VariantData = function (args) {
        var self = this;

        this.hasVariantData = false;

        $.extend(this, args);
    };



    VariantData.prototype = {

        //
        // Init function
        //

        init : function () {
            var self = this;

            self.$checkbox = self.$this.find("input[type='radio']");
            self.$inputGroup = self.$this.find(".input-group");

            self.$checkbox.on("change", function (e) {
                //e.preventDefault();
                //e.stopPropagation();
                if(self.$checkbox.is(":disabled")) return;

                if(document.location.href.indexOf('?bewise') > -1) {
                    
                    if(self.$checkbox.is(":checked")) {

                        window.platform.publish("/variant/variantData/unselect", [self.variantTypeId, self.id]);

                    } else {

                        window.platform.publish("/variant/variantData/selected", [self.variantTypeId, self.id]);
                    }

                } else {

                    var $variantData = self.$this.closest(VARIANT_DATA_SELECTOR);

                    if(self.$checkbox.is(":checked")) {

                        // Unselect all other varianttype variantdatas
                        var $variantType = self.$this.closest(VARIANT_TYPE_SELECTOR);
                        var $variantTypes = $variantType.siblings(VARIANT_TYPE_SELECTOR);

                        $variantTypes.each(function() {
                            var $variantDatas = $(this).find(VARIANT_DATA_SELECTOR);
                            $variantDatas.each(function() {
                                var $checkbox = $(this).find("input[type='radio']");
                                $checkbox.prop("checked", false);
                                window.platform.publish("/variant/variantData/unselected", [self.variantTypeId, $checkbox.data("variantdataid")]);
                            });
                        });

                        window.platform.publish("/variant/variantData/unselect", [self.variantTypeId, self.id]);
                        window.platform.publish("/variant/variantData/selected", [self.variantTypeId, self.id]);

                    } else {

                        window.platform.publish("/variant/variantData/unselected", [self.variantTypeId, self.id]);
                    }

                    $variantData.find('label').addClass('selected');
                    $variantData.siblings().find('label').removeClass('selected');
                
                }

            });

            self.unselect = $.proxy(self.unselect, self);

            window.platform.subscribe("/variant/variantData/unselect", self.unselect);
        },



        unselect : function (event, args) {
            var self = this;

            /**
             * args:
             *  0 : variantTypeId,
             *  1 : variantDataId,
             */

            if ( self.variantTypeId == args[0] && self.id !== args[1] ) {
                self.$checkbox.prop("checked", false);
                /* self.hide(null, true); */

                $(BUYBUTTON_SELECTOR).attr('disabled', true);
                $(BUYBUTTON_SELECTOR).addClass('opacity-30');
            }
        },



        hide: function (/* array */ selected, force) {
            var self = this;
            if (selected && selected[self.variantTypeId] && selected[self.variantTypeId].dataId === self.id && !force) {

            } else {
                self.$checkbox.hide();
            }
        },




        show : function () {
            var self = this;
            self.$checkbox.show();
        },




        disable : function () {
            var self = this;

            self.$inputGroup
                .addClass("is-disabled");

            self.$checkbox
                .addClass("is-disabled")
                .prop("disabled", true);
        },




        enable : function (/* array */ selected) {
            var self = this;

            if ( !_.isEmpty(_.filter(selected, {"Id": self.id})) || _.isEmpty(selected) ) {
                self.$inputGroup
                    .removeClass("is-disabled");

                self.$checkbox
                    .removeClass("is-disabled")
                    .prop("disabled", false);
            }
        },




        isSelected : function () {
            var self = this;

            $(BUYBUTTON_SELECTOR).attr('disabled', false);
            $(BUYBUTTON_SELECTOR).removeClass('opacity-30');

            return self.$checkbox.is(":checked");
        }
    };






    eksport.platform = eksport.platform || {};
    eksport.platform.classes = eksport.platform.classes || {};
    eksport.platform.classes.variant = eksport.platform.classes.variant || {};
    eksport.platform.classes.variant.Buttons = Variant;
})(jQuery, window);
