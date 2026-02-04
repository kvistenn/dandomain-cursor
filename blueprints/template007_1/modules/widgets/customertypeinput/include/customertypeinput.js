$(function () {
    var customerTypeInput = $('input[name=customer-type]', self.wrapper);
    if (customerTypeInput.length < 1) return;
    
        // Set up listeners
    customerTypeInput.on('click', function (e) {
        toggleActiveOption(e.currentTarget.parentNode)
    });

    customerTypeInput.on('change', function (e) {
        toggleActiveInputs(e.target.value);
    });

    // Preselct customer type if fields are filled
    var $cvrEl = $('#vatNumber');
    var $eanEl = $('#eanNumber');				

    var cvr = $cvrEl.val();
    var ean = $eanEl.val();				
    
    if ($cvrEl.length && cvr !== '') {
        // Re-select company if data is present
        toggleActiveInputs('company');
    } else if ($eanEl.length && ean !== '') {
        // Re-select institution if data is present
        toggleActiveInputs('institution');
    } else if ($('input[name="customer-type"][value="private"]').length === 0) {
        // select company field if private option is disabled and no other field was select
        toggleActiveInputs('company');
    }

    function toggleActiveOption(activeOption) {
        $('input[name=customer-type]').each(function (index, el) {
            $(el.parentNode).addClass('button');
            $(el.parentNode).removeClass('button-primary');
        })
        $(activeOption).addClass('button-primary');    
        $(activeOption).removeClass('button');    
    }

    function disableField () {
        var input = $(this).find('input');
        input.val('');
        input.prop('required', false);
        input.prop('disabled', true);
        $(this).hide();
    }

    function enableField () {
        var el = $(this)
        el.find('input').prop('disabled', false);
        el.find('[data-is-required]').prop('required', true);
        el.show();
    }

    function toggleActiveInputs (selectedCustomerType) {
        var privateInputFields = $('[data-active-on-customer-type="private"]');
        var companyInputFields = $('[data-active-on-customer-type="company"]');
        var institutionInputFields = $('[data-active-on-customer-type="institution"]');

        if (selectedCustomerType === 'company') {
            toggleActiveOption($('input[name="customer-type"][value="company"]').parent());
            $.each(companyInputFields, enableField);
            $.each(institutionInputFields, disableField);
            $.each(privateInputFields, disableField);
        } else if (selectedCustomerType === 'institution') {
            toggleActiveOption($('input[name="customer-type"][value="institution"]').parent());
            $.each(companyInputFields, disableField);
            $.each(institutionInputFields, enableField);
            $.each(privateInputFields, disableField);
        } else { // Private
            toggleActiveOption($('input[name="customer-type"][value="private"]').parent());
            $.each(institutionInputFields, disableField);
            $.each(companyInputFields, disableField);
            $.each(privateInputFields, enableField);
        }
    }
})
