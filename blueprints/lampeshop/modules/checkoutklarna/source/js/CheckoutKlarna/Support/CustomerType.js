// Standard UserTypes to Klarna Checkout types
const CORRELATION_MAP = {
    "private": ["person"],
    "company": ["organization"],
    "institution": ["organization"]
};

// Reverse
const REVERSE_CORRELATION_MAP = {
    "person": "private",
    "organization":  "company"
}


class CustomerType {

    logStyle = 'background-color:DarkKhaki;color:white;font-weight:bold;padding:5px;';
    customerType = 'person';

    constructor($el, platform, transition, klarna, checkoutIntermediate) {
        if (!$el.length) { return; }

        this.transition = transition;
        this.checkoutIntermediate = checkoutIntermediate;

        klarna.bind('customer', this.customerHandler.bind(this));
        klarna.bind('load', this.loadHandler.bind(this));
    }

    customerHandler(e, data) {
        this.customerType = data[0]?.type ?? 'person';
        this.pushCustomerChange();
    }

    loadHandler(e, data) {
        if (data[0].customer) {
            this.customerType = data[0].customer?.type ?? 'person';
            this.pushCustomerChange();
        }
    }

    pushCustomerChange () {
        // trigger old checkout
        this.checkoutIntermediate.updateCheckoutUserType();

        // transition new checkout
        this.transition(
            { status: 'idle' },
            { type: 'PICK_USER_TYPE' }
        );
    }

    get() {
        return REVERSE_CORRELATION_MAP[this.customerType] ?? REVERSE_CORRELATION_MAP['person'];
    }
}

export {
    CustomerType,
    CORRELATION_MAP,
    REVERSE_CORRELATION_MAP
}
