(function ($, eksport, undefined) {
    'use strict';

    var api = "https://autoorder.cleanstepapp.dk";

    var selectors = {
        form: '[data-shop="form"]',
        openForm: '[data-shop="openform"]',
        list: '[data-shop="list"]',
        listItem: '[data-shop="listitem"]',
        checklist: '[data-shop="checklist"]',
        submit: '[data-shop="submit"]',
        checkbox: '[data-shop="checkbox"]',
        save: '[data-shop="save"]',
        delete: '[data-shop="delete"]',
        viewProducts: '[data-shop="viewproducts"]',
        productItem: '[data-shop="productitem"]',
        deleteProduct: '[data-shop="deleteproduct"]',
        buyProduct: '[data-shop="buyproduct"]',
        buyAllProducts: '[data-shop="buyallproducts"]',
        search: '[data-shop="search"]',
        itemNumber: '[data-shop="itemnumber"]',
        addItemNumber: '[data-shop="additemnumber"]',
        removeItemNumber: '[data-shop="removeitemnumber"]',
        itemnumbers: '[data-shop="itemnumbers"]',
        popupTrigger: '[for="shopPopup"]',
        itemNumbersContainer: '[data-shop="itemnumberscontainer"]',
        uploadCsv: '[data-shop="uploadcsv"]',
        uploadCsvMultiple: '[data-shop="uploadcsv-multiple"]',
        importCsvMultipleBtn: '[data-shop="import-csv-multiple-btn"]',
        listSelectCheckbox: '[data-shop="list-select-checkbox"]',
    };

    var Shop = function () {
        this.shopList = $.templates('[data-shop="listmarkup"]');
        this.shopChecklist = $.templates('[data-shop="checklistmarkup"]');
        this.shopNumbers = $.templates('[data-shop="itemnumbersmarkup"]');
        this.data = null;
        this.selectedId = null;
        this.selectedVariantId = null;
    }

    Shop.prototype = {
        init: function () {
            var self = this;

            $.get(api + '/api/AutoOrders/GetManualConfigurations?userId=' + platform.user.Id, function (res) {

                // Sort res by name A-Z
                res.sort(function (a, b) {
                    if (a.name < b.name) return -1;
                    if (a.name > b.name) return 1;
                    return 0;
                });

                if (document.location.href.indexOf('page=shop') > -1) {
                    self.loadList(res);
                }

                self.loadChecklist(res);
                self.loadItemNumbers();
            });
        },
        loadList: function (data) {
            var self = this;

            var htmlOutput = self.shopList.render(data, {
                currency: platform.currency_format,
                user: platform.user || {},
            });

            $(selectors.list).html(htmlOutput);

            self.bindEvents();
        },
        loadChecklist: function (data) {
            var self = this;

            var htmlOutput = self.shopChecklist.render(data, {
                currency: platform.currency_format,
                user: platform.user || {},
            });

            $(selectors.checklist).html(htmlOutput);

            if (platform.page.isProduct) {
                $(platform).on('fetch.productlist', function () {
                    setTimeout(function () {
                        self.bindEvents();
                    }, 100);
                });
            } else {
                self.bindEvents();
            }
        },
        loadItemNumbers: function () {
            var self = this;
            var itemNumbers = [];
            var cookieValue = self.getCookie('shopnumbers');
            if (cookieValue) {
                try {
                    itemNumbers = JSON.parse(cookieValue);
                } catch (e) {
                    itemNumbers = [];
                }
            }

            if (itemNumbers.length > 0) {
                $(selectors.itemNumbersContainer).show();
            } else {
                $(selectors.itemNumbersContainer).hide();
            }

            var itemNumbersHtml = self.shopNumbers.render(itemNumbers);
            $(selectors.itemnumbers).html(itemNumbersHtml);

            self.bindEvents();
        },
        bindEvents: function () {
            var self = this;

            // Shop list
            $(selectors.list).find('li').each(function () {
                var $this = $(this);

                // Bind click event to the save button
                $this.find(selectors.save).off('click').on('click', function () {
                    var li = $(this).closest('li');
                    var id = li.data('id');
                    var title = li.find('input[name="name"]').val();
                    var cronForCreation = self.convertDaysToCron(li.find('input[name="cronForCreation"]').val());
                    var orderComment = li.find('input[name="comment"]').val();
                    var deliveryInfo = {
                        firstName: platform.user.Firstname || '',
                        lastName: platform.user.Lastname || '',
                        companyName: platform.user.Company || '',
                        address: li.find('input[name="address"]').val() || platform.user.Address || '',
                        zip: li.find('input[name="zipCode"]').val() || platform.user.Zipcode || '',
                        city: li.find('input[name="city"]').val() || platform.user.City || '',
                        country: li.find('select[name="country"]').val() || platform.user.Country || '',
                        phone: li.find('input[name="phone"]').val() || platform.user.Phone || '',
                    };

                    self.updateDeliveryInformation(id, title, cronForCreation, deliveryInfo, orderComment, function () {
                        self.init();
                    });
                });

                // Bind click event to the delete button
                $this.find(selectors.delete).off('click').on('click', function () {
                    var id = $this.data('id');
                    self.removeShopList(id, function () {
                        self.init();
                    });
                });

                // Bind click event to buy all products button
                $this.find(selectors.buyAllProducts).off('click').on('click', function () {
                    var li = $(this).closest(selectors.listItem);
                    var products = li.data('products') || [];

                    console.log('Buying all products from list:', li.data('id'), 'with products:', products);

                    var productLi = li.find(selectors.productItem);

                    // Loop through products and set amount to what is in the input field
                    productLi.each(function () {
                        var $productLi = $(this);
                        var productId = $productLi.data('productid');
                        var variantId = $productLi.data('variantid');
                        var amount = parseInt($productLi.find('input[name="quantity"]').val()) || 0;
                        var kolli = 1;

                        if($productLi.find('select[name="kolli"]').length > 0) {
                            kolli = parseInt($productLi.find('select[name="kolli"]').val()) || 1;
                        }

                        amount = amount * kolli;

                        if (amount > 0) {
                            products.push({
                                productId: productId,
                                variantId: variantId,
                                amount: amount
                            });
                        }
                    });

                    if (products.length > 0) {
                        self.addProductsToBasket(products);
                    }
                });
            });

            // Bind change event to the upload CSV input
            $(selectors.list).find(selectors.uploadCsv).off('change').on('change', function (e) {
                var file = e.target.files[0];
                var $li = $(this).closest('li');
                var listId = $li.data('id');

                if (file) {
                    self.parseCsv(file, function(products) {
                        if (products && products.length > 0) {
                            self.addProductsToList(products, listId, function () {
                                self.init();
                            });
                        } else {
                            alert('No valid products found in CSV file');
                        }
                    });
                }
                // Reset input value to allow uploading the same file again
                $(this).val('');
            });

            // Bind change event to the upload CSV multiple input
            $(selectors.uploadCsvMultiple).off('change').on('change', function (e) {
                var file = e.target.files[0];
                var selectedLists = [];

                $(selectors.listSelectCheckbox + ':checked').each(function() {
                    selectedLists.push($(this).val());
                });

                if (selectedLists.length === 0) {
                    alert(text.CSV_MULTIPLE_SELECT_ERROR);
                    $(this).val('');
                    return;
                }

                if (file) {
                    self.parseCsv(file, function(products) {
                        if (products && products.length > 0) {
                            var promises = [];
                            selectedLists.forEach(function(listId) {
                                var promise = new Promise(function(resolve, reject) {
                                    self.addProductsToList(products, listId, function() {
                                        resolve();
                                    });
                                });
                                promises.push(promise);
                            });

                            Promise.all(promises).then(function() {
                                alert('Products imported to selected lists successfully.');
                                self.init();
                            });
                        } else {
                            alert('No valid products found in CSV file');
                        }
                    });
                }
                // Reset input value to allow uploading the same file again
                $(this).val('');
            });

            // New shop list
            $(selectors.submit).off('click').on('click', function () {

                var user = platform.user || {};
                var firstName = $('[name="firstname"]').length ? $('[name="firstname"]').val() : user.Firstname;
                var lastName = $('[name="lastname"]').length ? $('[name="lastname"]').val() : user.Lastname;
                var companyName = $('[name="company"]').length ? $('[name="company"]').val() : user.Company;
                var address = $('[name="address"]').length ? $('[name="address"]').val() : user.Address;
                var zipCode = $('[name="zipcode"]').length ? $('[name="zipcode"]').val() : user.Zipcode;
                var city = $('[name="city"]').length ? $('[name="city"]').val() : user.City;
                var country = $('[name="country"]').length ? $('[name="country"]').val() : user.Country;
                var phone = $('[name="phone"]').length ? $('[name="phone"]').val() : user.Phone;
                var comment = $('[name="comment"]').length ? $('[name="comment"]').val() : '';
                var title = $('[name="title"]').val() || 'Unavngivet liste';
                var cron = null;

                var data = {
                    "cronForCreation": null,
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
                    success: function (res) {
                        $(selectors.form).find('input[type="text"], input[type="number"], textarea').val('');
                        $(selectors.form).slideUp();

                        self.init();
                    }
                });
            });

            // Open/close form
            $(selectors.openForm).off('click').on('click', function () {
                var $form = $(selectors.form);
                $form.slideToggle();
            });

            // Productlist checkbox
            $(selectors.checkbox).off('change').on('change', function () {
                var $this = $(this);
                var listId = $this.val();
                var isChecked = $this.is(':checked');
                var products = [];


                if (isChecked) {

                    if (self.selectedId) {

                        products.push({
                            productId: self.selectedId,
                            variantId: self.selectedVariantId,
                            amount: 0
                        });

                        self.addProductsToList(products, listId);

                    } else {

                        var cookie = self.getCookie('shopnumbers');
                        if (cookie) {
                            cookie = JSON.parse(cookie);
                            cookie.forEach(function (item) {
                                products.push({
                                    productId: item.id,
                                    variantId: item.variant,
                                    amount: 0
                                });
                            });

                            self.addProductsToList(products, listId, function (res) {
                                self.setCookie('shopnumbers', '', -1); // Clear cookie after adding products
                                self.loadItemNumbers(); // Reload item numbers after adding products
                            });
                        }
                    }

                } else {
                    self.removeProductFromList(self.selectedId, listId);
                }
            });

            // View products in shop list
            $(selectors.viewProducts).off('click').on('click', function () {
                var $this = $(this);
                var $li = $this.closest('li');
                var listId = $li.data('id');
                var $productsList = $li.find('[data-shop="productslist"]');

                // Toggle visibility
                if ($productsList.is(':visible')) {
                    $productsList.slideUp();
                    $this.text(text.SHOW_ALL);
                } else {
                    // Show loading state
                    $productsList.html('<li class="text-gray-500 text-sm p-2">' + text.PRODUCTS_LOADING + '</li>');
                    $productsList.slideDown();

                    // Get the shop list data
                    self.getShopList(listId, function (res) {
                        if (res && res.autoOrderProducts && res.autoOrderProducts.length > 0) {

                            self.enrichProductData(res.autoOrderProducts, function (enrichedProducts) {
                                if (enrichedProducts.length > 0) {
                                    var productsTemplate = $.templates('[data-shop="productsmarkup"]');
                                    var htmlOutput = productsTemplate.render({ products: enrichedProducts }, {
                                        currency: platform.currency_format,
                                        user: platform.user || {},
                                        template: platform.template
                                    });

                                    $productsList.html(htmlOutput);
                                    $this.text(text.HIDE_ALL);

                                    // Make products sortable after they're loaded
                                    self.makeProductsSortable();
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
            $(selectors.search).off('input').on('input', function () {
                var searchTerm = $(this).val().toLowerCase();
                $(selectors.listItem).each(function () {
                    var $item = $(this);
                    var itemName = $item.find('input[name="name"]').val().toLowerCase();
                    if (itemName.includes(searchTerm)) {
                        $item.show();
                    } else {
                        $item.hide();
                    }
                });
            });

            // Delete product from shop list
            $(selectors.deleteProduct).off('click').on('click', function () {
                var $this = $(this);
                var $listLi = $this.closest(selectors.listItem);
                var $productLi = $this.closest(selectors.productItem);
                var listId = $listLi.data('id');
                var productId = $productLi.data('productid');

                if (confirm(text.PRODUCT_CONFIRM_DELETE)) {
                    self.removeProductFromList(productId, listId, function () {
                        $productLi.remove();
                    });
                }
            });

            // Buy product from shop list
            $(selectors.buyProduct).off('click').on('click', function () {
                var $this = $(this);
                var $productLi = $this.closest(selectors.productItem);
                var productId = $productLi.data('productid');
                var variantId = $productLi.data('variantid');
                var amount = parseInt($productLi.find('input[name="quantity"]').val()) || 0;
                var kolli = parseInt($productLi.find('select[name="kolli"]').val()) || 1;

                if (amount > 0) {

                    let productData = {
                        productId: productId,
                        amount: amount * kolli
                    }

                    if (variantId) {
                        productData['variantId'] = variantId;
                    }

                    let products = [productData];

                    self.addProductsToBasket(products);
                }
            });

            // Bind add item number functionality
            $(selectors.addItemNumber).off('click').on('click', function () {
                var itemNumber = $(selectors.itemNumber).val();
                var existingNumbers = [];
                var cookieValue = self.getCookie('shopnumbers');

                if (itemNumber) {

                    itemNumber = itemNumber.toUpperCase();

                    $.get('/json/product-by-number/id/' + itemNumber, function (res) {

                        if (res.result == null) {
                            $(selectors.itemNumber).val('');
                            alert(text.CART_ADD_ERROR_EXTENDED_OPENCART_PRODUCT_NONE);
                            return;
                        }

                        var product = {
                            number: itemNumber,
                            id: res.result,
                            variant: res.variant
                        };

                        if (cookieValue) {
                            try {
                                existingNumbers = JSON.parse(cookieValue);
                            } catch (e) {
                                existingNumbers = [];
                            }
                        }

                        // Check if the product number already exists in the array
                        var alreadyExists = existingNumbers.some(function (item) {
                            return item.number === product.number;
                        });

                        if (!alreadyExists) {
                            existingNumbers.push(product);
                        }

                        self.setCookie('shopnumbers', JSON.stringify(existingNumbers), 30);
                        $(selectors.itemNumber).val('');

                        self.loadItemNumbers(); // Reload to update item numbers

                    });
                }
            });

            // When key "Enter" trigger selectors.addItemNumber click
            $(selectors.itemNumber).off('keypress').on('keypress', function (e) {
                if (e.which === 13) {
                    e.preventDefault();
                    $(selectors.addItemNumber).trigger('click');
                }
            });

            // Bind remove item number functionality
            $(selectors.removeItemNumber).off('click').on('click', function () {

                var $this = $(this);
                var itemNumber = $this.data('itemnumber');
                var existingNumbers = [];
                var cookieValue = self.getCookie('shopnumbers');

                if (cookieValue) {
                    try {
                        existingNumbers = JSON.parse(cookieValue);
                    } catch (e) {
                        existingNumbers = [];
                    }
                }

                console.log('Removing item number:', itemNumber, 'from', existingNumbers);

                // Remove the item number
                existingNumbers = existingNumbers.filter(function (num) {
                    return num.number != itemNumber;
                });

                self.setCookie('shopnumbers', JSON.stringify(existingNumbers), 30);
                self.loadItemNumbers(); // Reload to update item numbers
            });

            // Bind click event for the popup trigger
            $(selectors.popupTrigger).off('click').on('click', function () {

                var $this = $(this);
                var id = $this.closest('.product').data('id');
                var variantId = $this.closest('.product').find('[data-variant="variantid"]').val();

                console.log("POPUP", $this, id, variantId)

                if (id) {
                    if (id !== 'cookie') {
                        self.selectedId = id;
                        self.selectedVariantId = variantId;

                        self.checkChecklist(id, variantId);
                    } else {
                        self.selectedId = null;
                        self.selectedVariantId = null;
                    }
                }
            });

            // Bind change event for shop add checkbox
            $('#shopAdd').on('change', function () {
                self.setCookie('shopAdd', $(this).is(':checked') ? '1' : '0', 0.125);
            });

            // Addresses
            $('[data-addresses="select"]').on('change', function () {
                var $select = $(this);
                var data = JSON.parse($select.val());

                var country = "DK";
                if (isNaN(parseInt(data.country))) {
                    country = data.country;
                } else if (data.country == "2397") {
                    country = "DK";
                } else if (data.country == "2540") {
                    country = "SE";
                } else if (data.country == "2410") {
                    country = "FO";
                }

                // Set alternative values
                $(selectors.form).find('[name="firstname"]').val(platform.user.Firstname);
                $(selectors.form).find('[name="lastname"]').val(platform.user.Lastname);
                $(selectors.form).find('[name="company"]').val(data.name || platform.user.Company);
                $(selectors.form).find('[name="address"]').val(data.address || platform.user.Address);
                $(selectors.form).find('[name="zipcode"]').val(data.zipCode || platform.user.Zipcode);
                $(selectors.form).find('[name="city"]').val(data.city || platform.user.City);
                $(selectors.form).find('[name="country"]').val(country);
                $(selectors.form).find('[name="deliveryPhone"]').val(platform.user.Phone);
                $(selectors.form).find('[name="comment"]').val(data.attention || "");
            });

        },
        removeShopList: function (id, callback) {
            if (confirm(text.LIST_CONFIRM_DELETE)) {
                $.ajax({
                    url: api + '/api/AutoOrders/DeleteAutoOrder/' + id,
                    type: 'GET',
                    success: function (res) {
                        if (typeof callback === 'function') {
                            callback();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error deleting shop list:', error);
                        console.error('Response text:', xhr.responseText);
                        console.error('Status:', xhr.status);
                    }
                });
            }
        },
        addProductsToList: function (products, listId, callback) {
            var self = this;

            self.getShopList(listId, function (res) {

                if (res) {

                    var existingProducts = res.autoOrderProducts || [];

                    // Loop through each product to add
                    for (var j = 0; j < products.length; j++) {
                        var product = products[j];
                        var productExists = false;

                        for (var i = 0; i < existingProducts.length; i++) {
                            if (product.variantId) {
                                if (existingProducts[i].productId === product.productId && existingProducts[i].variantId === parseInt(product.variantId)) {
                                    productExists = true;
                                    break;
                                }
                            } else {
                                if (existingProducts[i].productId === product.productId) {
                                    productExists = true;
                                    break;
                                }
                            }
                        }

                        if (!productExists) {
                            existingProducts.push({
                                productId: product.productId,
                                variantId: product.variantId,
                                amount: product.amount || 0
                            });
                        }
                    }

                    var data = {
                        cronForCreation: null,
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
                        success: function (res) {

                            var message = platform.Message;
                            message.load(text.SHOP_ADD_SUCCESS, '0');

                            if (typeof callback === 'function') {
                                callback(res);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error updating shop list:', error);
                            console.error('Response text:', xhr.responseText);
                            console.error('Status:', xhr.status);
                        }
                    });
                }
            });
        },
        removeProductFromList: function (productId, listId, callback) {
            var self = this;
            self.getShopList(listId, function (res) {
                if (res) {
                    var products = res.autoOrderProducts || [];
                    products = products.filter(function (item) {
                        return item.productId !== productId;
                    });
                    var data = {
                        cronForCreation: null,
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
                        success: function (res) {
                            if (typeof callback === 'function') {
                                callback(res);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error removing product from shop list:', error);
                            console.error('Response text:', xhr.responseText);
                            console.error('Status:', xhr.status);
                        }
                    });
                }
            });
        },
        updateDeliveryInformation: function (listId, title, cronForCreation, deliveryInfo, orderComment, callback) {
            var self = this;

            self.getShopList(listId, function (res) {
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
                        cronForCreation: null,
                        name: title,
                        customerId: res.userId,
                        Products: res.autoOrderProducts || [],
                        deliveryInformation: deliveryInfo,
                        orderComment: orderComment || res.orderComment || '',
                    };

                    $.ajax({
                        url: api + '/api/AutoOrders/' + listId,
                        type: 'PUT',
                        data: JSON.stringify(data),
                        contentType: 'application/json',
                        success: function (res) {
                            if (typeof callback === 'function') {
                                callback(res);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error updating delivery information:', error);
                            console.error('Response text:', xhr.responseText);
                            console.error('Status:', xhr.status);
                        }
                    });
                }
            });
        },
        updateProductFromList: function (productId, listId, amount, callback) {
            var self = this;

            self.getShopList(listId, function (res) {
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
                        cronForCreation: null,
                        name: res.name,
                        customerId: res.userId,
                        Products: products,
                        deliveryInformation: res.deliveryInformation || {},
                        orderComment: res.orderComment || ''
                    };

                    $.ajax({
                        url: api + '/api/AutoOrders/' + listId,
                        type: 'PUT',
                        data: JSON.stringify(data),
                        contentType: 'application/json',
                        success: function (res) {
                            if (typeof callback === 'function') {
                                callback(res);
                            }
                        }
                    }).fail(function (xhr, status, error) {
                        console.error('Error updating product in shop list:', error);
                        console.error('Response text:', xhr.responseText);
                        console.error('Status:', xhr.status);
                    });

                }
            });
        },
        getShopList: function (id, callback) {
            $.get(api + '/api/AutoOrders/' + id, function (res) {
                if (typeof callback === 'function') {
                    callback(res);
                }
            }).fail(function (xhr, status, error) {
                console.error('Error fetching shop list:', error);
                console.error('Response text:', xhr.responseText);
                console.error('Status:', xhr.status);
            });
        },
        addProductsToBasket: function (products) {
            var self = this;
            var index = 0;

            function addNextProduct() {
                if (index >= products.length) {
                    platform.ajaxCart.load();
                    platform.ajaxCart.open();
                    return;
                }

                var product = products[index];
                if (product.amount <= 0) {
                    index++;
                    addNextProduct();
                    return;
                }

                var data = {};
                var key = 'product[' + product.productId + '][amount]';
                data[key] = product.amount || 0;

                if (product.variantId) {
                    key = 'product[' + product.productId + '][variant]';
                    data[key] = product.variantId;
                }

                $.ajax({
                    url: '/actions/cart/add',
                    type: 'POST',
                    data: data
                }).done(function () {
                    index++;
                    addNextProduct();
                }).fail(function (error) {
                    console.error('Error adding product to basket:', error);
                    index++;
                    addNextProduct();
                });
            }

            addNextProduct();
        },
        checkChecklist: function (id, variantId) {
            var self = this;

            $(selectors.checklist).find(selectors.checkbox).each(function () {

                var $this = $(this);
                var productIds = $this.attr('data-ids');

                if (productIds.indexOf(',') > -1) {
                    productIds = productIds.split(',').map(function (item) {
                        return item.trim();
                    });
                } else {
                    productIds = [productIds.trim()];
                }
                id = id.toString();

                if (variantId) {
                    id += "/" + variantId;
                }

                if (productIds.includes(id)) {
                    $this.prop('checked', true);
                } else {
                    $this.prop('checked', false);
                }
            });
        },
        makeProductsSortable: function () {
            var self = this;

            // Make products lists sortable
            $('[data-shop="productslist"]').sortable({
                items: 'li:not(:last-child)',
                handle: '.drag-handle', // Use specific handle
                cursor: 'move',
                placeholder: 'sortable-placeholder',
                tolerance: 'pointer',
                update: function (event, ui) {
                    var $productsList = $(this);
                    var $listItem = $productsList.closest('[data-shop="listitem"]');
                    var listId = $listItem.data('id');

                    // Get the new order of products
                    var newOrder = [];
                    $productsList.find('[data-shop="productitem"]').each(function (index) {
                        var productId = $(this).data('productid');
                        var quantity = parseInt($(this).find('input[name="quantity"]').val()) || 0;
                        newOrder.push({
                            productId: productId,
                            variantId: null,
                            amount: quantity,
                            sortOrder: index
                        });
                    });

                    // Update the list with new order
                    self.updateProductOrder(listId, newOrder);
                }
            });
        },
        updateProductOrder: function (listId, products, callback) {
            var self = this;

            self.getShopList(listId, function (res) {
                if (res) {
                    var data = {
                        cronForCreation: null,
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
                        success: function (res) {
                            if (typeof callback === 'function') {
                                callback(res);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error updating product order:', error);
                        }
                    });
                }
            });
        },
        enrichProductData: function (autoOrderProducts, callback) {
            var products = [];
            var productPromises = [];

            for (var i = 0; i < autoOrderProducts.length; i++) {
                var productId = autoOrderProducts[i].productId;
                var variantId = autoOrderProducts[i].variantId;
                var productPromise = $.get('/json/products/id/' + productId);

                if (variantId) {
                    var variantPromise = $.get('/json/productvariants/id/' + productId + '/' + variantId);
                    productPromises.push(Promise.all([productPromise, variantPromise]));
                } else {
                    productPromises.push(productPromise.then(function (response) {
                        return [response, null];
                    }));
                }
            }

            Promise.all(productPromises).then(function (responses) {
                // Map enriched products with sortOrder
                for (var j = 0; j < responses.length; j++) {
                    var productResponse = responses[j][0];
                    var variantResponse = responses[j][1];

                    if (productResponse.products && productResponse.products[0]) {
                        var enrichedProduct = productResponse.products[0];
                        enrichedProduct.Quantity = autoOrderProducts[j].amount;
                        enrichedProduct.productId = autoOrderProducts[j].productId;
                        enrichedProduct.variantId = autoOrderProducts[j].variantId;
                        enrichedProduct.sortOrder = autoOrderProducts[j].sortOrder !== undefined ? autoOrderProducts[j].sortOrder : j;

                        if (variantResponse) {
                            enrichedProduct.variantData = variantResponse.data[0];
                        }

                        products.push(enrichedProduct);
                    }
                }

                // Sort by sortOrder
                products.sort(function (a, b) {
                    return (a.sortOrder || 0) - (b.sortOrder || 0);
                });

                callback(products);
            }).catch(function (error) {
                console.error('Error enriching product data:', error);
                callback([]);
            });
        },
        convertDaysToCron: function (days) {
            var cron = null;

            if (days === 0 || isNaN(days)) return cron;

            if (days === 30) {
                cron = '0 0 1 * *'; // Every month
            } else if (days === 7) {
                cron = '0 0 * * 0'; // Every week
            } else {
                cron = '0 0 */' + days + ' * *'; // Every X days
            }
            return cron;
        },
        cronToDays: function (cron) {
            if (!cron || cron.trim() === '') {
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
        jsonEncode: function (data) {
            return JSON.stringify(data);
        },
        jsonEncodeProducts: function (products) {
            return products.map(function (product) {
                var returnString = product.productId;
                if (product.variantId) {
                    returnString += ("/" + product.variantId)
                }
                return returnString;
            });
        },
        setCookie: function (name, value, days) {
            var expires = "";
            if (days) {
                var date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toUTCString();
            }
            document.cookie = name + "=" + (value || "") + expires + "; path=/";
        },
        getCookie: function (name) {
            var nameEQ = name + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        },
        parseCsv: function(file, callback) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var csv = e.target.result;
                var lines = csv.split(/\r\n|\n/);
                var headers = lines[0].split(',').map(function (header) {
                    return header.trim().toLowerCase();
                });

                var productNumberIndex = headers.indexOf('productnumber');
                var amountIndex = headers.indexOf('amount');

                if (productNumberIndex === -1) {
                    alert('CSV file must contain "ProductNumber" column');
                    if (typeof callback === 'function') callback(null);
                    return;
                }

                var promises = [];

                for (var i = 1; i < lines.length; i++) {
                    var line = lines[i].split(',');
                    if (line.length > productNumberIndex) {
                        var productNumber = line[productNumberIndex].trim();
                        var amount = amountIndex !== -1 && line[amountIndex] ? parseInt(line[amountIndex].trim()) : 0;

                        if (productNumber) {
                            (function(num, amt) {
                                var promise = new Promise(function(resolve, reject) {
                                    $.get('/json/product-by-number/id/' + num, function (res) {
                                        if (res.result != null) {
                                            resolve({
                                                productId: res.result,
                                                variantId: res.variant,
                                                amount: isNaN(amt) ? 0 : amt
                                            });
                                        } else {
                                            console.warn('Product not found for number:', num);
                                            resolve(null);
                                        }
                                    }).fail(function() {
                                        console.error('Failed to fetch product for number:', num);
                                        resolve(null);
                                    });
                                });
                                promises.push(promise);
                            })(productNumber, amount);
                        }
                    }
                }

                Promise.all(promises).then(function(results) {
                    var products = results.filter(function(p) { return p !== null; });
                    if (typeof callback === 'function') callback(products);
                });
            };
            reader.readAsText(file);
        }
    }

    $(function () {

        var shop = new Shop();

        $.views.helpers({
            cronToDays: shop.cronToDays,
            jsonEncode: shop.jsonEncode,
            jsonEncodeProducts: shop.jsonEncodeProducts,
        });

        if (platform.user) {
            shop.init();
        }

    });

})(jQuery, window);