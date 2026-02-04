/*
 * Validate checkout before proceeding to actions
 */

import { DELIVERY_TYPE_DROPPOINT } from "./DeliveryTypes";

class Validator {

    text;
    delivery;
    country;
    errors;


    constructor(platform, text, delivery, country) {
        this.platform = platform;
        this.text = text;
        this.delivery = delivery;
        this.country = country;

        this.errors = [];
    }


    validate () {
        // reset errors for re-validation
        this.errors = [];

        const addressInformation = this.delivery.getAddressInformation();
        const countryInformation = this.country.get();

        const zipcode = addressInformation['zipcode'];
        const klarnaZipCode = addressInformation['klarnaZipCode'];
        const shipping = countryInformation['shipping'];
        const klarnaShipping = countryInformation['klarnaShipping'];

        const deliveryType = this.delivery.getDeliveryType();

        // collect errors and filter out successes
        this.hasErrorsZipCode(deliveryType, klarnaZipCode, zipcode);
        this.hasErrorsCountry(deliveryType, klarnaShipping, shipping);

        if (this.errors.length) {
            throw this.errors.join("\n");
        }
    }

    hasErrorsZipCode (deliveryType = 0, klarnaZipcode = '', systemZipcode = '') {
        console.log('%cValidation', 'font-weight:bold;color:white;background-color:orange;padding:5px;', 'Validator.js', 'hasErrorsZipCode',
            deliveryType,
            deliveryType === DELIVERY_TYPE_DROPPOINT,
            klarnaZipcode.trim(),
            systemZipcode.trim()
        );

        if (deliveryType === DELIVERY_TYPE_DROPPOINT) return;

        if (klarnaZipcode.trim() !== systemZipcode.trim()) {
            this.errors.push( this.text.KLARNAKCO_INVALID_ZIPCODE );
        }
    }

    hasErrorsCountry (deliveryType = 0, klarnaCountry = '', systemCountry = '') {
        console.log('%cValidation', 'font-weight:bold;color:white;background-color:orange;padding:5px;', 'Validator.js', 'hasErrorsCountry',
            deliveryType,
            deliveryType === DELIVERY_TYPE_DROPPOINT,
            klarnaCountry.toLowerCase(),
            systemCountry.toLowerCase()
        );

        if (deliveryType === DELIVERY_TYPE_DROPPOINT) return;

        if (!systemCountry || !klarnaCountry || klarnaCountry.toLowerCase() !== systemCountry.toLowerCase()) {
            this.errors.push( this.text.KLARNAKCO_INVALID_DELIVERY_COUNTRY );
        }
    }
}

export { Validator }
