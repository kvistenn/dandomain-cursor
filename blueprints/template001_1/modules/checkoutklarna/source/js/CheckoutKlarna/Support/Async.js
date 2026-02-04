import { getAll } from "./UrlParameters";

class Async {

    endpoint = '/actions/handler/ajax';
    defaultProps = {
        subpage: 'klarna',
        page: 'checkout'
    };

    constructor(transition, checkoutIntermediate) {
        this.transition = transition;
        this.checkoutIntermediate = checkoutIntermediate;

        // rewrite the ajax urls to always contain subpage=klarna for klarna checkout
        $.ajaxPrefilter((options, originalOptions, jqXHR) => {
            const url = options.url;

            // we only want to rewrite ajax endpoint urls
            if (!url || url.indexOf(this.endpoint) === -1) { return; }

            // we only want to rewrite ajax requests we didn't make ourselves
            if (options.type === 'post'
             && (url.indexOf('action=klarna_finalize') > -1 || url.indexOf('action=user_type') > -1)
            ) { return; }

            const data = getAll("?"+options.data);
            const params = $.extend( {}, this.defaultProps, data);
            options.data = $.param(params);
        });
    }

    finalize (
        checkoutData = {},
        contactInfo = {},
        deliveryData = {},
        orderSummary = {}
    ) {
        const getData = {
            'action': 'klarna_finalize',
            ...checkoutData,
            ...this.defaultProps
        };

        const postData = {
            ...contactInfo,
            ...deliveryData,
            ...orderSummary
        };

        $.post(this.endpoint + '?' + $.param(getData), postData).always(() => {
            this.transition(
                {status: 'loading'},
                {type: 'KLARNA_FINALIZED'}
            );
        });
    }

    usertype() {
        $.when( this.checkoutIntermediate.bind('deliveryMethodsLoaded', () => { }, true) )
        .always(() => {
            this.transition(
                { status: 'loading' },
                { type: 'SET_USER_TYPE' }
            );
        });
    }

    delivery() {
        this.checkoutIntermediate.bind('done', () => {
            this.transition(
                { status: 'idle' },
                { type: 'SET_SHIPPING_METHOD' }
            );
        }, true);
    }

    payment() {
        this.checkoutIntermediate.bind('done', () => {
            this.transition(
                { status: 'idle' },
                { type: 'SET_PAYMENT_METHOD' }
            );
        }, true);
    }
}

export { Async };
