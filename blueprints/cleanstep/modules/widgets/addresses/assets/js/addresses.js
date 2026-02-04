(function($, eksport, undefined) {
    'use strict';

    var api = "https://cleanstepapp.dk/Home";

    var selectors = {
        form: '[data-addresses="form"]',
        openForm: '[data-addresses="openform"]',
        list: '[data-addresses="list"]',
        save: '[data-addresses="save"]',
        delete: '[data-addresses="delete"]',
        submit: '[data-addresses="submit"]',
        search: '[data-addresses="search"]',
        select: '[data-addresses="select"]',
        importCsv: '[data-addresses="import-csv"]'
    };

    var Addresses = function() {
        this.list = $.templates('[data-addresses="listmarkup"]');
        this.select = $.templates('[data-addresses="selectmarkup"]');
    }

    Addresses.prototype = {
        load: async function() {
            var self = this;

            return new Promise(function(resolve, reject) {
                $.get(api + '/GetContacts?customerNumber=' + platform.user.Id, function(res) {

                    // Sort res by name A-Z
                    res.sort(function(a, b) {
                        if (a.name < b.name) return -1;
                        if (a.name > b.name) return 1;
                        return 0;
                    });

                    if(platform.page.isCheckout || platform.page.url.indexOf('page=shop') > -1) {
                        var htmlOutput = self.select.render({ addresses: res });
                        $(selectors.select).html(htmlOutput);
                    } else if(platform.page.url.indexOf('page=addresses') > -1) {
                        var htmlOutput = self.list.render(res);
                        $(selectors.list).html(htmlOutput);
                    }

                    self.bindEvents();
                    resolve(res);
                });
            });
        },

        batchCreate: async function(contacts) {
            var self = this;
            var successCount = 0;
            var errorCount = 0;

            for (var i = 0; i < contacts.length; i++) {
                var contact = contacts[i];
                
                try {
                    await new Promise((resolve, reject) => {
                        var data = {
                            Address: contact.Address,
                            Attention: contact.Attention,
                            City: contact.City,
                            Country: platform.user.Country,
                            CustomerNumber: platform.user.Id,
                            Email: contact.Email,
                            Name: contact.Name,
                            ZipCode: contact.ZipCode
                        };

                        $.ajax({
                            url: api + '/CreateContact',
                            type: 'POST',
                            data: JSON.stringify(data),
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function(res) {
                                if (res.success) {
                                    successCount++;
                                } else {
                                    errorCount++;
                                    console.error('Failed to create contact:', contact, res);
                                }
                                resolve();
                            },
                            error: function(err) {
                                errorCount++;
                                console.error('Error creating contact:', contact, err);
                                resolve(); // Resolve anyway to continue processing
                            }
                        });
                    });
                } catch (e) {
                    console.error('Unexpected error:', e);
                }
            }
            
            var msg = successCount + ' addresses created successfully.';
            if (errorCount > 0) {
                msg += ' ' + errorCount + ' failed.';
                platform.Message.load(msg, 0)
            } else {
                platform.Message.load(msg, 1)
            }

            self.load();
        },
        bindEvents: function() {
            var self = this;

            // Import CSV
            $(selectors.importCsv).on('change', function(e) {
                var file = e.target.files[0];
                if (!file) return;

                var reader = new FileReader();
                reader.onload = function(e) {
                    var text = e.target.result;
                    var lines = text.split('\n');
                    var headers = lines[0].split(',').map(function(h) { return h.trim().toLowerCase(); });
                    
                    var contacts = [];
                    
                    for (var i = 1; i < lines.length; i++) {
                        if (!lines[i].trim()) continue;
                        
                        var values = lines[i].split(',');
                        var contact = {};
                        var hasData = false;

                        for (var j = 0; j < headers.length; j++) {
                            var value = values[j] ? values[j].trim() : '';
                            
                            // Simple mapping based on headers
                            switch(headers[j]) {
                                case 'name': contact.Name = value; break;
                                case 'attention': contact.Attention = value; break;
                                case 'address': contact.Address = value; break;
                                case 'zipcode': contact.ZipCode = value; break;
                                case 'city': contact.City = value; break;
                                case 'email': contact.Email = value; break;
                            }
                            
                            if (value) hasData = true;
                        }

                        if (hasData && contact.Name) {
                            contacts.push(contact);
                        }
                    }

                    if (contacts.length > 0) {
                        if (confirm('Found ' + contacts.length + ' addresses. Import them now?')) {
                            self.batchCreate(contacts);
                        }
                    } else {
                        platform.notify('No valid addresses found in CSV.', 'error');
                    }
                    
                    // Reset input
                    $(selectors.importCsv).val('');
                };
                reader.readAsText(file);
            });

            // Open/close form
            $(selectors.openForm).off('click').on('click', function() {
                console.log('Open form');
                var $form = $(selectors.form);
                $form.slideToggle();
            });

            // Save address
            $(selectors.save).on('click', function() {
                var li = $(this).closest('li');
                var id = li.data('id');
                var name = li.find('input[name="name"]').val();
                var attention = li.find('input[name="attention"]').val();
                var address = li.find('input[name="address"]').val();
                var zipCode = li.find('input[name="zipCode"]').val();
                var city = li.find('input[name="city"]').val();
                var email = li.find('input[name="email"]').val();

                var data = {
                    Address: address,
                    Attention: attention,
                    City: city,
                    Country: platform.user.Country,
                    CustomerNumber: platform.user.Id,
                    Email: email,
                    Name: name,
                    ShopId: id,
                    ZipCode: zipCode
                };

                $.ajax({
                    url: api + '/UpdateContact',
                    type: 'POST',
                    data: JSON.stringify(data),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function(res) {
                        if(res.success) {
                            platform.notify('Address saved successfully.');
                            self.load();
                        } else {
                            platform.notify('Error saving address: ' + res.message, 'error');
                        }
                    },
                    error: function(xhr, status, error) {
                        platform.notify('Error saving address: ' + error, 'error');
                    }
                })
            });

            // Delete address
            $(selectors.delete).on('click', function() {
                var li = $(this).closest('li');
                var id = li.data('id');

                if(confirm(text.ADDRESSES_CONFIRM_DELETE)) {
                    $.ajax({
                        url: api + '/DeleteContact?shopId=' + id,
                        type: 'POST',
                        success: function(res) {
                            self.load();
                        }
                    });
                }
            });

            // Submit form
            $(selectors.submit).on('click', function(e) {
                var $this = $(this);
                var name = $(selectors.form).find('input[name="name"]').val();
                var attention = $(selectors.form).find('input[name="attention"]').val();
                var address = $(selectors.form).find('input[name="address"]').val();
                var zipCode = $(selectors.form).find('input[name="zipCode"]').val();
                var city = $(selectors.form).find('input[name="city"]').val();
                var email = $(selectors.form).find('input[name="email"]').val();

                var data = {
                    Address: address,
                    Attention: attention,
                    City: city,
                    Country: platform.user.Country,
                    CustomerNumber: platform.user.Id,
                    Email: email,
                    Name: name,
                    ZipCode: zipCode
                };

                $.ajax({
                    url: api + '/CreateContact',
                    type: 'POST',
                    data: JSON.stringify(data),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function(res) {
                        self.load();
                        $(selectors.form).slideUp();
                    }
                });
            });

            // Bind search functionality
            $(selectors.search).off('input').on('input', function() {
                var searchTerm = $(this).val().toLowerCase();
                $(selectors.list).find('li').each(function() {
                    var $item = $(this);
                    var itemName = $item.find('input[name="name"]').val().toLowerCase();
                    if (itemName.includes(searchTerm)) {
                        $item.show();
                    } else {
                        $item.hide();
                    }
                });
            });
        },
        jsonEncode: function(data) {
            return JSON.stringify(data);
        },
    }

    $(function() {

        var addresses = new Addresses();

        $.views.helpers({
            jsonEncode: addresses.jsonEncode,
        });

        if(platform.user) {
            addresses.load();
        }
    });

})(jQuery, window);