

/*
 * Selectors for elements
 */
const BLOCK = '[data-js-checkoutsteps="usertype"]';
const CONTACT = '.w-checkout-steps__step__toggle';
const CONTACT_INPUTS = 'input, textarea, select';

class AdditionalCustomerInformation {
    $parent = [];
    platform;
    $block = [];
    $contactInfoInputs = [];
    contactInfoValues = {};
    first = true;
    isOpen = false;

    // local transition function
    transition;

    // local checkout intermediate class
    checkoutIntermediate;

    constructor($parent, platform, transition, checkoutIntermediate) {
        this.$parent = $parent;
        this.platform = platform;
        this.transition = transition;
        this.checkoutIntermediate = checkoutIntermediate;

        this.$block = $parent.find(BLOCK);
        this.$contactInfoInputs =  this.$block.find(CONTACT).find(CONTACT_INPUTS);
    }

    get() {
        this.contactInfoValues = {};
        this.$contactInfoInputs.each((idx, el) => {

            // filter unwanted data
            if ((el.type === 'checkbox' || el.type === 'radio') && el.checked === false) { return; }
            if (el.type === 'hidden' && el.name !== 'post_packingType') { return; }
            if (el.type === 'text' && el.value.trim() === '') { return; }
            if (el.disabled) { return; }

            this.contactInfoValues[el.name] = el.value;

            if ((el.type === 'checkbox' || el.type === 'radio')) {
                this.contactInfoValues[el.name] = (el.value === 'on') ? true : el.value;
            }
        });

        return this.contactInfoValues;
    }

    wasFirst () {
        return this.state.length === 1;
    }

    open() {
        this.isOpen = true;
    }
}

export { AdditionalCustomerInformation };
