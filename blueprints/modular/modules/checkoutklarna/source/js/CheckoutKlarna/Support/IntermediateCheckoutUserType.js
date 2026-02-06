/*
 * Usertype and Delivery intermediate
 *
 * A class to handle communication between delivery and user types
 */

class IntermediateCheckoutUserType {

    constructor(checkoutIntermediate, customerType) {
        this.checkoutIntermediate = checkoutIntermediate;
        this.customerType = customerType;

        this.oldRelevantFieldDatas = this.checkoutIntermediate.overwriteRelevantFieldDatas(
            this.ourRelevantFieldDatas.bind(this)
        );
    }

    ourRelevantFieldDatas(noDelivery) {
        let data = this.oldRelevantFieldDatas(noDelivery),
            userData = this.checkoutIntermediate.relevantFieldsFromUsertype(this.customerType.get());

        return {
            'paymentMethod': 9,
            ...data,
            ...userData
        }
    }
}

export { IntermediateCheckoutUserType }
