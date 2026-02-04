(function($, document, undefined) {
    'use strict';

    var selectors = {
        toggle: '[data-compare="toggle"]',
        count: '[data-compare="count"]',
        compareList: '[data-compare="list"]',
    }

    var compareCookie = "";
    if(typeof $.cookie('compare') !== 'undefined') {
        compareCookie = $.cookie('compare');
    }
    var compareCookieArray = compareCookie ? compareCookie.split(',') : [];

    var Compare = function() {
        this.$toggle = $(selectors.toggle);
        this.$count = $(selectors.count);
        this.$compareList = $(selectors.compareList);
        this.template = $.templates('#render-compare');
        this.templateToolbar = $.templates('#render-compare-toolbar');
    }

    Compare.prototype = {
        load: async function() {
            var self = this;

            return new Promise(function(resolve, reject) {
                $.get('/json/compare', function(res) {

                    var newAmount = res.CompareProduct.length;
                    if(newAmount > 0) {
                        self.$count.text(newAmount);
                    } else {
                        self.$count.text('');
                    }

                    var htmlOutput = self.template.render(res, {
                        currency: platform.currency_format,
                    });

                    var htmlOutputToolbar = self.templateToolbar.render(res, {
                        currency: platform.currency_format,
                    });

                    $('#ajaxcompare').html(htmlOutput);
                    $('#ajaxcomparetoolbar').html(htmlOutputToolbar);

                    $(platform).on('loaded.productlist', function() {
                        setTimeout(function() {
                            var productlist = $(document).find(selectors.toggle);
                            productlist.each(function() {
                                var productItem = $(this);
                                var productId = productItem.data('id');
                                var inCompare = res.CompareProduct.find(function(product) {
                                    return product.Id === productId;
                                })

                                if(inCompare) {
                                    productItem.addClass('active');
                                }
                            });
                        }, 100);
                    });

                    if(platform.page.isProduct && platform.page.productId) {
                        var productId = platform.page.productId.toString();
                        if(compareCookieArray.indexOf(productId) !== -1) {
                            var productlist = $(document).find(selectors.toggle + '[data-id="' + productId + '"]');
                            productlist.addClass('active');
                        }
                    }

                    // Data equalizer for fields
                    var fieldHeight = 0;
                    $(selectors.compareList).find('[data-equalizer="field"]').each(function () {
                        var $this = $(this);
                        var height = $this.outerHeight();
                        if (height > fieldHeight) {
                            fieldHeight = height;
                        }
                    });
                    $(selectors.compareList).find('[data-equalizer="field"]').outerHeight(fieldHeight);

                    $(document).on('click', '[data-compare="delete"]', function (e) {
                        e.preventDefault();
                        var $this = $(this);
                        var productId = $this.data('id').toString();
                        var compareIds = compareCookieArray;
                        var index = compareIds.indexOf(productId);

                        // Remove toggle class
                        if(index > -1) {
                            var productlist = $(document).find(selectors.toggle + '[data-id="' + productId + '"]');
                            productlist.removeClass('active');
                        }
                        

                        if (index > -1) {
                            compareIds.splice(index, 1);
                        }

                        $.cookie('compare', compareIds.join(','), { expires: 7, path: '/' });
                        compareCookieArray = compareIds;
                        self.load();
                    });

                    resolve(res);
                });
            });
        },
        toggle: function() {
            var self = this;

            $(document).on('click', selectors.toggle, function(e) {
                e.preventDefault();
                var $this = $(this);
                var productId = $this.data('id').toString();

                if(compareCookieArray.indexOf(productId) === -1) {
                    if($.cookie('compare')) {
                        var compareIds = compareCookieArray;
                        if(compareIds.indexOf(productId) === -1) {
                            compareIds.push(productId);
                        }
                        $.cookie('compare', compareIds.join(','), { expires: 7, path: '/' });
                        compareCookieArray = compareIds;
                        self.load();
                    } else {
                        $.cookie('compare', productId, { expires: 7, path: '/' });
                        compareCookieArray.push(productId);
                        self.load();
                    }
                    
                    $this.addClass('active');
                } else {
                    var compareIds = compareCookieArray;
                    var index = compareIds.indexOf(productId);
                    if (index > -1) {
                        compareIds.splice(index, 1);
                    }
                    $.cookie('compare', compareIds.join(','), { expires: 7, path: '/' });
                    compareCookieArray = compareIds;
                    self.load();
                    $this.removeClass('active');
                }
            });
        }
    }

    $(function() {
        
        var compare = new Compare();
        compare.load();
        compare.toggle();

    });


})(jQuery, document);