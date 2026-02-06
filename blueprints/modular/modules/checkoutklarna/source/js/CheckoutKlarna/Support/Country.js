/*
 *  Country utility
 */

class Country {

    billing;
    shipping;
    klarnaBilling
    klarnaShipping;

    platform;

    constructor(platform, klarna, intermediateCheckout, delivery) {
        this.platform = platform;
        this.delivery = delivery;

        klarna.hasKlarna() && klarna.bind('address', this.klarnaAddressChangeHandler.bind(this));
        intermediateCheckout.bind('countrychange',  this.checkoutAddressChangeHandler.bind(this));

        this.checkoutAddressChangeHandler();
    }

    klarnaAddressChangeHandler(e, data) {
        // unwrap pub/sub data
        if (data[0]) { data = data[0]; }

        if (e ==='customer') { return; }

        if (e === 'change') {
            this.setKlarnaShipping(data?.country);
        }

        if (e === 'billing_address_change') {
            this.setKlarnaBilling(data?.country);
        }

        if (e === 'shipping_address_change') {
            this.setKlarnaShipping(data?.country);
        }

        console.log('Country.js', 'klarnaAddressChangeHandler', e, data);
    }

    checkoutAddressChangeHandler(e) {
        this.shipping = this.delivery.getCountryAlpha3().toLowerCase();
        this.billing = this.shipping;

        console.log('Country.js', 'checkoutAddressChangeHandler', this.delivery.getCountryAlpha3().toLowerCase());
    }

    setKlarnaBilling (country = 'DK') {
        this.klarnaBilling = country.toLowerCase();
    }

    setKlarnaShipping (country = 'DK') {
        this.klarnaShipping = country.toLowerCase();
    }

    setBilling(country = 'DK') {
        this.billing = country.toLowerCase();
    }

    setShipping(country = 'DK') {
        this.shipping = country.toLowerCase();
    }

    // returns country as alpha3
    getBilling() {
        return this.klarnaBilling !== this.billing
            ? this.klarnaBilling
            : this.billing;
    }

    // returns country as alpha3
    getShipping() {
        return this.shipping;
    }

    // returns countries as alpha3
    get() {
        return {
            shipping: this.shipping,
            billing: this.billing,
            klarnaBilling: this.klarnaBilling,
            klarnaShipping: this.klarnaShipping
        }
    }
}

export { Country }
