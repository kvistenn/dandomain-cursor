(function($, eksport, undefined) {
    'use strict';

    var api = "https://autoorder.cleanstepapp.dk";

    var selectors = {
        form: '[data-reorder="form"]',
        openForm: '[data-reorder="openform"]',
        list: '[data-reorder="list"]',
        listItem: '[data-reorder="listitem"]',
        checklist: '[data-reorder="checklist"]',
        submit: '[data-reorder="submit"]',
        checkbox: '[data-reorder="checkbox"]',
        save: '[data-reorder="save"]',
        delete: '[data-reorder="delete"]',
        viewProducts: '[data-reorder="viewproducts"]',
        productItem: '[data-reorder="productitem"]',
        deleteProduct: '[data-reorder="deleteproduct"]',
        buyProduct: '[data-reorder="buyproduct"]',
        buyAllProducts: '[data-reorder="buyallproducts"]',
        search: '[data-reorder="search"]',
        itemNumber: '[data-reorder="itemnumber"]',
        addItemNumber: '[data-reorder="additemnumber"]',
        removeItemNumber: '[data-reorder="removeitemnumber"]',
        itemnumbers: '[data-reorder="itemnumbers"]',
        itemNumbersContainer: '[data-reorder="itemnumberscontainer"]',
    };

    var Reorder = function() {
        this.reorderList = $.templates('[data-reorder="listmarkup"]');
        this.reorderChecklist = $.templates('[data-reorder="checklistmarkup"]');
        this.reorderNumbers = $.templates('[data-reorder="itemnumbersmarkup"]');
        this.data = null;
        this.selectedId = null;
    }

    Reorder.prototype = {
        init: function() {
            var self = this;

            $.get(api + '/api/AutoOrders/GetAutoConfigurations?userId=' + platform.user.Id, function(res) {

                // Sort res by name A-Z
                res.sort(function(a, b) {
                    if (a.name < b.name) return -1;
                    if (a.name > b.name) return 1;
                    return 0;
                });

                if(document.location.href.indexOf('page=reorder') > -1) {
                    self.loadList(res);
                }

                self.loadChecklist(res);
                self.loadItemNumbers();
            });
        },
        loadList: function(data) {
            var self = this;

            var htmlOutput = self.reorderList.render(data, {
                currency: platform.currency_format,
                user: platform.user || {},
            });

            $(selectors.list).html(htmlOutput);

            self.bindEvents();
        },
        loadChecklist: function(data) {
            var self = this;

            var htmlOutput = self.reorderChecklist.render(data, {
                currency: platform.currency_format,
                user: platform.user || {},
            });

            $(selectors.checklist).html(htmlOutput);

            if(platform.page.isProduct) {
                $(platform).on('fetch.productlist', function() {
                    setTimeout(function() {
                        self.bindEvents();
                    }, 100);
                });
            } else {
                self.bindEvents();
            }
        },
        loadItemNumbers: function() {
            var self = this;
            var itemNumbers = [];
            var cookieValue = self.getCookie('reordernumbers');
            if (cookieValue) {
                try {
                    itemNumbers = JSON.parse(cookieValue);
                } catch (e) {
                    itemNumbers = [];
                }
            }

            if( itemNumbers.length > 0) {
                $(selectors.itemNumbersContainer).show();
            } else {
                $(selectors.itemNumbersContainer).hide();
            }

            var itemNumbersHtml = self.reorderNumbers.render(itemNumbers);
            $(selectors.itemnumbers).html(itemNumbersHtml);

            self.bindEvents();
        },
        bindEvents: function() {
            var self = this;

            // Reorder list
            $(selectors.list).find('li').each(function() {
                var $this = $(this);

                // Bind click event to the remove button
                $this.find(selectors.delete).off('click').on('click', function() {
                    var id = $this.data('id');

                    self.removeReorderList(id, function() {
                        self.init();
                    });
                });

                // Bind click event to the save button
                $this.find(selectors.save).off('click').on('click', function() {
                    var li = $(this).closest('li');
                    var id = li.data('id');
                    var title = li.find('input[name="name"]').val();
                    var cronForCreation = self.convertDaysToCron(li.find('input[name="cronForCreation"]').val());
                    var deliveryInfo = {
                        firstName: platform.user.Firstname || '',
                        lastName: platform.user.Lastname || '',
                        companyName: platform.user.Company || '',
                        address: li.find('input[name="address"]').val() || platform.user.Address || '',
                        zip: li.find('input[name="zipcode"]').val() || platform.user.Zipcode || '',
                        city: li.find('input[name="city"]').val() || platform.user.City || '',
                        country: li.find('select[name="country"]').val() || platform.user.Country || '',
                        phone: li.find('input[name="phone"]').val() || platform.user.Phone || '',
                    };

                    self.updateDeliveryInformation(id, title, cronForCreation, deliveryInfo, function() {
                        self.init();
                    });
                });

                // Bind click event to buy all products button
                $this.find(selectors.buyAllProducts).off('click').on('click', function() {
                    var li = $(this).closest('li');
                    var products = li.data('products') || [];

                    if (products.length > 0) {
                        self.addProductsToBasket(products);
                    }
                });
            });

            // New reorder list
            $(selectors.submit).off('click').on('click', function() {

                var user = platform.user || {};
                var firstName = $('[name="firstname"]').length ? $('[name="firstname"]').val() : user.Firstname;
                var lastName = $('[name="lastname"]').length ? $('[name="lastname"]').val() : user.Lastname;
                var companyName = $('[name="company"]').length ? $('[name="company"]').val() : user.Company;
                var address = $('[name="address"]').length ? $('[name="address"]').val() : user.Address;
                var zipCode = $('[name="zipcode"]').length ? $('[name="zipcode"]').val() : user.Zipcode;
                var city = $('[name="city"]').length ? $('[name="city"]').val() : user.City;
                var country = $('[name="country"]').length ? $('[name="country"]').val() : user.Country;
                var phone = $('[name="phone"]').length ? $('[name="phone"]').val() : user.Phone;
                var title = $('[name="title"]').val() || 'Unavngivet liste';
                var comment = $('[name="comment"]').val() || '';
                var frequency = parseInt($('[name="frequency"]').val(), 10)
                var cron = self.convertDaysToCron(frequency);

                if(isNaN(frequency) || frequency == 0) {
                    cron = null;
                }

                console.log("Cron for creation:", cron);

                var data = {
                    "cronForCreation": cron,
                    "orderComment": comment,
                    "deliveryInformation": {
                        "firstName": firstName,
                        "lastName": lastName,
                        "companyName": companyName,
                        "address": address,
                        "zip": zipCode,
                        "city": city,
                        "country": country,
                        "phone": phone,
                    },
                    "active": true,
                    "customerId": platform.user.Id || 0,
                    "name": title,
                };

                $.ajax({
                    url: api + '/api/AutoOrders',
                    type: 'POST',
                    data: JSON.stringify(data),
                    contentType: 'application/json',
                    success: function(res) {
                        $(selectors.form).find('input[type="text"], input[type="number"], textarea').val('');
                        $(selectors.form).slideUp();

                        self.init();
                    }
                });
            });

            // Open/close form
            $(selectors.openForm).off('click').on('click', function() {
                var $form = $(selectors.form);
                $form.slideToggle();
            });

            // Productlist checkbox
            $(selectors.checkbox).off('change').on('change', function() {
                var $this = $(this);
                var listId = $this.val();
                var isChecked = $this.is(':checked');
                var products = [];


                if(isChecked) {

                    if(self.selectedId) {

                        products.push({
                            productId: self.selectedId,
                            variantId: null,
                            amount: 1
                        });

                        self.addProductsToList(products, listId);

                    } else {

                        var cookie = self.getCookie('reordernumbers');
                        if (cookie) {
                            cookie = JSON.parse(cookie);
                            cookie.forEach(function(item) {
                                products.push({
                                    productId: item.id,
                                    variantId: null,
                                    amount: 1
                                });
                            });

                            self.addProductsToList(products, listId, function(res) {
                                self.setCookie('reordernumbers', '', -1); // Clear cookie after adding products
                                self.loadItemNumbers(); // Reload item numbers after adding products 
                            });
                        }
                    }

                } else {
                    self.removeProductFromList(self.selectedId, listId);
                }
            });

            // View products in reorder list
            $(selectors.viewProducts).off('click').on('click', function() {
                var $this = $(this);
                var $li = $this.closest('li');
                var listId = $li.data('id');
                var $productsList = $li.find('[data-reorder="productslist"]');
                
                // Toggle visibility
                if ($productsList.is(':visible')) {
                    $productsList.slideUp();
                    $this.text(text.SHOW_ALL);
                } else {
                    // Show loading state
                    $productsList.html('<li class="text-gray-500 text-sm p-2">' + text.PRODUCTS_LOADING + '</li>');
                    $productsList.slideDown();
                    
                    // Get the reorder list data
                    self.getReorderList(listId, function(res) {
                        if (res && res.autoOrderProducts && res.autoOrderProducts.length > 0) {
                            
                            self.enrichProductData(res.autoOrderProducts, function(enrichedProducts) {
                                if (enrichedProducts.length > 0) {
                                    var productsTemplate = $.templates('[data-reorder="productsmarkup"]');
                                    var htmlOutput = productsTemplate.render(enrichedProducts, {
                                        currency: platform.currency_format,
                                        user: platform.user || {},
                                    });
                                    
                                    $productsList.html(htmlOutput);
                                    $this.text(text.HIDE_ALL);
                                } else {
                                    $productsList.html('<li class="text-red-500 text-sm p-2">' + text.PRODUCTS_ERROR + '</li>');
                                }

                                self.bindEvents(); // Rebind events for dynamically added elements
                            });
                            
                        } else {
                            $productsList.html('<li class="text-gray-500 text-sm p-2">' + text.PRODUCTS_EMPTY + '</li>');
                            $this.text(text.HIDE_ALL);
                        }
                    });
                }
            });

            // Bind search functionality
            $(selectors.search).off('input').on('input', function() {
                var searchTerm = $(this).val().toLowerCase();
                $(selectors.listItem).each(function() {
                    var $item = $(this);
                    var itemName = $item.find('input[name="name"]').val().toLowerCase();
                    if (itemName.includes(searchTerm)) {
                        $item.show();
                    } else {
                        $item.hide();
                    }
                });
            });

            // Delete product from reorder list
            $(selectors.deleteProduct).off('click').on('click', function() {
                var $this = $(this);
                var $listLi = $this.closest(selectors.listItem);
                var $productLi = $this.closest(selectors.productItem);
                var listId = $listLi.data('id');
                var productId = $productLi.data('productid');

                if (confirm(text.PRODUCT_CONFIRM_DELETE)) {
                    self.removeProductFromList(productId, listId, function() {
                        $productLi.remove();
                    });
                }
            });

            // Change product amount in reorder list
            $(selectors.productItem).find('input[type="number"]').off('change').on('change', function() {
                var $this = $(this);
                var $productLi = $this.closest(selectors.productItem);
                var productId = $productLi.data('productid');
                var listId = $productLi.closest(selectors.listItem).data('id');

                var amount = parseInt($this.val(), 10);
                if (isNaN(amount) || amount < 1) {
                    amount = 1; // Default to 1 if invalid
                    $this.val(amount);
                }

                self.updateProductFromList(productId, listId, amount);
            });

            // Buy product from reorder list
            $(selectors.buyProduct).off('click').on('click', function() {
                var $this = $(this);
                var $productLi = $this.closest(selectors.productItem);
                var productId = $productLi.data('productid');

                self.addProductsToBasket([
                    {
                        productId: productId
                    }
                ]);
            });

            // Bind add item number functionality
            $(selectors.addItemNumber).off('click').on('click', function() {
                var itemNumber = $(selectors.itemNumber).val();
                var existingNumbers = [];
                var cookieValue = self.getCookie('reordernumbers');
                
                if (itemNumber) {

                    itemNumber = itemNumber.toUpperCase();

                    $.get('/json/product-by-number/id/' + itemNumber, function(res) {

                        if(res.result == null) {
                            $(selectors.itemNumber).val('');
                            alert(text.CART_ADD_ERROR_EXTENDED_OPENCART_PRODUCT_NONE);
                            return;
                        }

                        var product = {
                            number: itemNumber,
                            id: res.result
                        };

                        if (cookieValue) {
                            try {
                                existingNumbers = JSON.parse(cookieValue);
                            } catch (e) {
                                existingNumbers = [];
                            }
                        }
                        
                        // Check if the product number already exists in the array
                        var alreadyExists = existingNumbers.some(function(item) {
                            return item.number === product.number;
                        });

                        if (!alreadyExists) {
                            existingNumbers.push(product);
                        }
                        
                        self.setCookie('reordernumbers', JSON.stringify(existingNumbers), 30);
                        $(selectors.itemNumber).val('');

                        self.loadItemNumbers(); // Reload to update item numbers

                    });
                }
            });

            // When key "Enter" trigger selectors.addItemNumber click
            $(selectors.itemNumber).off('keypress').on('keypress', function(e) {
                if (e.which === 13) {
                    e.preventDefault();
                    $(selectors.addItemNumber).trigger('click');
                }
            });

            // Bind remove item number functionality
            $(selectors.removeItemNumber).off('click').on('click', function() {

                var $this = $(this);
                var itemNumber = $this.data('itemnumber');
                var existingNumbers = [];
                var cookieValue = self.getCookie('reordernumbers');
                
                if (cookieValue) {
                    try {
                        existingNumbers = JSON.parse(cookieValue);
                    } catch (e) {
                        existingNumbers = [];
                    }
                }

                // Remove the item number
                existingNumbers = existingNumbers.filter(function(num) {
                    return num.number != itemNumber;
                });

                self.setCookie('reordernumbers', JSON.stringify(existingNumbers), 30);
                self.loadItemNumbers(); // Reload to update item numbers
            });

            // Bind change event for reorder add checkbox
            $('#reorderAdd').on('change', function() {
                self.setCookie('reorderAdd', $(this).is(':checked') ? '1' : '0', 0.125);
            });

        },
        removeReorderList: function(id, callback) {
            if (confirm(text.LIST_CONFIRM_DELETE)) {
                $.ajax({
                    url: api + '/api/AutoOrders/DeleteAutoOrder/' + id,
                    type: 'GET',
                    success: function(res) {
                        if (typeof callback === 'function') {
                            callback();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error deleting reorder list:', error);
                        console.error('Response text:', xhr.responseText);
                        console.error('Status:', xhr.status);
                    }
                });
            }
        },
        addProductsToList: function(products, listId, callback) {
            var self = this;

            self.getReorderList(listId, function(res) {

                if (res) {

                    var existingProducts = res.autoOrderProducts || [];

                    // Loop through each product to add
                    for (var j = 0; j < products.length; j++) {
                    var product = products[j];
                    var productExists = false;

                    for (var i = 0; i < existingProducts.length; i++) {
                        if (existingProducts[i].productId === product.productId) {
                        existingProducts[i].amount += 1;
                        productExists = true;
                        break;
                        }
                    }

                    if(!productExists) {
                        existingProducts.push({
                            productId: product.productId,
                            variantId: product.variantId,
                            amount: product.amount || 1
                        });
                    }
                }

                var data = {
                    cronForCreation: res.cronForCreation,
                    name: res.name,
                    customerId: res.userId,
                    Products: existingProducts,
                    orderComment: res.orderComment || '',
                    deliveryInformation: res.deliveryInformation || {}
                }

                $.ajax({
                    url: api + '/api/AutoOrders/' + listId,
                    type: 'PUT',
                    data: JSON.stringify(data),
                    contentType: 'application/json',
                    success: function(res) {
                        if (typeof callback === 'function') {
                        callback(res);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error updating reorder list:', error);
                        console.error('Response text:', xhr.responseText);
                        console.error('Status:', xhr.status);
                    }
                });
            }
            });
        },
        removeProductFromList: function(productId, listId, callback) {
            var self = this;
            self.getReorderList(listId, function(res) {
                if (res) {
                    var products = res.autoOrderProducts || [];
                    products = products.filter(function(item) {
                        return item.productId !== productId;
                    });
                    var data = {
                        cronForCreation: res.cronForCreation,
                        name: res.name,
                        customerId: res.userId,
                        Products: products,
                        orderComment: res.orderComment || '',
                        deliveryInformation: res.deliveryInformation || {}
                    };
                    $.ajax({
                        url: api + '/api/AutoOrders/' + listId,
                        type: 'PUT',
                        data: JSON.stringify(data),
                        contentType: 'application/json',
                        success: function(res) {
                            if (typeof callback === 'function') {
                                callback(res);
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('Error removing product from reorder list:', error);
                            console.error('Response text:', xhr.responseText);
                            console.error('Status:', xhr.status);
                        }
                    });
                }
            });
        },
        updateDeliveryInformation: function(listId, title, cronForCreation, deliveryInfo, callback) {
            var self = this;

            self.getReorderList(listId, function(res) {
                if (res) {

                    // Merge delivery information with existing data
                    deliveryInfo = {
                        firstName: deliveryInfo.firstName || res.deliveryInformation.firstName || '',
                        lastName: deliveryInfo.lastName || res.deliveryInformation.lastName || '',
                        companyName: deliveryInfo.companyName || res.deliveryInformation.companyName || '',
                        address: deliveryInfo.address || res.deliveryInformation.address || '',
                        zip: deliveryInfo.zip || res.deliveryInformation.zip || '',
                        city: deliveryInfo.city || res.deliveryInformation.city || '',
                        country: deliveryInfo.country || res.deliveryInformation.country || '',
                        phone: deliveryInfo.phone || res.deliveryInformation.phone || ''
                    };

                    var data = {
                        cronForCreation: self.convertDaysToCron(cronForCreation),
                        name: title,
                        customerId: res.userId,
                        Products: res.autoOrderProducts || [],
                        deliveryInformation: deliveryInfo
                    };

                    $.ajax({
                        url: api + '/api/AutoOrders/' + listId,
                        type: 'PUT',
                        data: JSON.stringify(data),
                        contentType: 'application/json',
                        success: function(res) {
                            if (typeof callback === 'function') {
                                callback(res);
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('Error updating delivery information:', error);
                            console.error('Response text:', xhr.responseText);
                            console.error('Status:', xhr.status);
                        }
                    });
                }
            });
        },
        updateProductFromList: function(productId, listId, amount, callback) {
            var self = this;
            
            self.getReorderList(listId, function(res) {
                if (res) {
                    var products = res.autoOrderProducts || [];
                    var productFound = false;

                    for (var i = 0; i < products.length; i++) {
                        if (products[i].productId === productId) {
                            products[i].amount = amount;
                            productFound = true;
                            break;
                        }
                    }
                    if (!productFound) {
                        products.push({
                            productId: productId,
                            variantId: null,
                            amount: amount || 1
                        });
                    }

                    var data = {
                        cronForCreation: res.cronForCreation,
                        name: res.name,
                        customerId: res.userId,
                        Products: products,
                        deliveryInformation: res.deliveryInformation || {}
                    };

                    $.ajax({
                        url: api + '/api/AutoOrders/' + listId,
                        type: 'PUT',
                        data: JSON.stringify(data),
                        contentType: 'application/json',
                        success: function(res) {
                            if (typeof callback === 'function') {
                                callback(res);
                            }
                        }
                    }).fail(function(xhr, status, error) {
                        console.error('Error updating product in reorder list:', error);
                        console.error('Response text:', xhr.responseText);
                        console.error('Status:', xhr.status);
                    });

                }
            });
        },
        getReorderList: function(id, callback) {
            $.get(api + '/api/AutoOrders/' + id, function(res) {
                if (typeof callback === 'function') {
                    callback(res);
                }
            }).fail(function(xhr, status, error) {
                console.error('Error fetching reorder list:', error);
                console.error('Response text:', xhr.responseText);
                console.error('Status:', xhr.status);
            });
        },
        addProductsToBasket: function(products) {
            var self = this;
            var index = 0;
            
            function addNextProduct() {
                if (index >= products.length) {
                    platform.ajaxCart.load();
                    platform.ajaxCart.open();
                    return;
                }
                
                var product = products[index];
                var data = {};
                var key = 'product[' + product.productId + '][amount]';
                data[key] = product.amount || 1;
                
                $.ajax({
                    url: '/actions/cart/add',
                    type: 'POST',
                    data: data
                }).done(function() {
                    index++;
                    addNextProduct();
                }).fail(function(error) {
                    console.error('Error adding product to basket:', error);
                    index++;
                    addNextProduct();
                });
            }
            
            addNextProduct();
        },
        checkChecklist: function(id) {
            var self = this;

            $(selectors.checklist).find(selectors.checkbox).each(function() {
                var $this = $(this);
                var productIds = $this.attr('data-ids');
                if(productIds.indexOf(',') > -1) {
                    productIds = productIds.split(',').map(function(item) {
                        return item.trim();
                    });
                } else {
                    productIds = [productIds.trim()];
                }
                id = id.toString();

                if (productIds.includes(id)) {
                    $this.prop('checked', true);
                } else {
                    $this.prop('checked', false);
                }
            });
        },
        enrichProductData: function(autoOrderProducts, callback) {
            var products = [];
            var productPromises = [];
            
            for(var i = 0; i < autoOrderProducts.length; i++) {
                var productId = autoOrderProducts[i].productId;
                var promise = $.get('/json/products/id/' + productId);
                productPromises.push(promise);
            }

            Promise.all(productPromises).then(function(responses) {
                for(var j = 0; j < responses.length; j++) {
                    if (responses[j].products && responses[j].products[0]) {
                        responses[j].products[0].Quantity = autoOrderProducts[j].amount;
                        responses[j].products[0].productId = autoOrderProducts[j].productId;
                        responses[j].products[0].variantId = autoOrderProducts[j].variantId;
                        products.push(responses[j].products[0]);
                    }
                }
                callback(products);
            }).catch(function(error) {
                console.error('Error enriching product data:', error);
                callback([]);
            });
        },
        convertDaysToCron: function(days) {
            var cron = null;

            if(days === 0 || isNaN(days)) return cron;

            if (days === 30) {
                cron = '0 0 1 * *'; // Every month
            } else if (days === 7) {
                cron = '0 0 * * 0'; // Every week
            } else {
                cron = '0 0 */' + days + ' * *'; // Every X days
            }
            return cron;
        },
        cronToDays: function(cron) {
            if(!cron || cron.trim() === '') {
                return 0; // Default to 0 days if cron is empty
            }

            var parts = cron.split(' ');
            if (parts.length < 5) {
                return 30; // Default to 30 days if cron is not valid
            }
            if (parts[2] === '1' && parts[3] === '*')
                return 30; // Monthly
            if (parts[4] === '0' && parts[2] === '*')
                return 7; // Weekly
            if (parts[2].startsWith('*/')) {
                var days = parseInt(parts[2].substring(2), 10);
                return isNaN(days) ? 30 : days; // Every X days
            }
            return 0; // Default to 0 days if cron is not recognized
        },
        jsonEncode: function(data) {
            return JSON.stringify(data);
        },
        jsonEncodeProducts: function(products) {
            return products.map(function(product) {
                return product.productId;
            });
        },
        setCookie: function(name, value, days) {
            var expires = "";
            if (days) {
                var date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toUTCString();
            }
            document.cookie = name + "=" + (value || "") + expires + "; path=/";
        },
        getCookie: function(name) {
            var nameEQ = name + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        }
    }

    $(function() {
        
        /* var reorder = new Reorder();

        $.views.helpers({
            cronToDays: reorder.cronToDays,
            jsonEncode: reorder.jsonEncode,
            jsonEncodeProducts: reorder.jsonEncodeProducts,
        });

        if(platform.user) {
            reorder.init();
        } */

    });

})(jQuery, window);