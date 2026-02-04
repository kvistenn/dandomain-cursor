import { Async } from "./Support/Async";
import { CheckoutStates } from "./CheckoutState";
import { Country } from "./Support/Country";
import { Delivery } from "./Delivery";
import { IntermediateCheckout } from "./Support/IntermediateCheckout";
import { IntermediateCheckoutUserType } from "./Support/IntermediateCheckoutUserType";
import { CustomerType } from "./Support/CustomerType";
import { KlarnaCheckout } from "./Support/KlarnaCheckout";
import { Steps } from "./Steps";
import { AdditionalCustomerInformation } from "./AdditionalCustomerInformation";
import { Validator } from "./Support/Validator";


import { subscribe } from "./Support/PubSub";
import { runActions, transition } from "./Support/StateMachine";


class Checkout {

    klarnaHasLoaded = false;
    klarnaShipping = {};
    isLoading = true;

    constructor($el, isCheckoutComplete, platform, text) {
        this.$el = $el;
        this.isCheckoutComplete = isCheckoutComplete;
        this.platform = platform;
        this.text = text;

        if (!$el.length) { return; }

        this.bootstrap();
    }

    bootstrap() {
        const self = this;

        // Init utils
        this.transitionFn = transition(CheckoutStates);
        this.runActionsFn = runActions(this);

        this.checkoutIntermediate = new IntermediateCheckout(this.platform);
        this.async = new Async(this.transitionFn, this.checkoutIntermediate);
        this.klarna = new KlarnaCheckout(this.$el, this.transitionFn);
        this.steps = new Steps(this.$el, this.transitionFn);
        this.delivery = new Delivery(this.$el, this.platform, this.text, this.transitionFn, this.klarna, this.checkoutIntermediate);
        this.country = new Country(this.platform, this.klarna, this.checkoutIntermediate, this.delivery);
        this.additionalInformationHandler = new AdditionalCustomerInformation(this.$el, this.platform, this.transitionFn, this.checkoutIntermediate);
        this.customerType = new CustomerType(this.$el, this.platform, this.transitionFn, this.klarna, this.checkoutIntermediate);
        this.checkoutUserTypeIntermediate = new IntermediateCheckoutUserType(this.checkoutIntermediate, this.customerType);
        this.checkoutValidator = new Validator(this.platform, this.text, this.delivery, this.country);

        //
        //
        // Listen to klarna events

        // Listen to checkout load
        this.klarna.bind('load', (event, data) => {
            console.log('%cKlarna - Load', 'font-weight:bold;color:black;background-color:Azure;border:1px solid SkyBlue;padding:4px 5px;', 'Loaded');

            this.klarnaHasLoaded = true;
            this.transitionFn(
                { status: 'loading' },
                { type: 'KLARNA_CHECKOUT_READY' }
            );
        });

        // Listen to checkout approved load
        this.klarna.bind('load_confirmation', (event, data) => {
            console.log('%cKlarna - Load approved', 'font-weight:bold;color:black;background-color:Azure;border:1px solid SkyBlue;padding:4px 5px;', 'Loaded');
            this.klarnaHasLoaded = true;
            this.transitionFn(
                { status: 'loading' },
                { type: 'KLARNA_APPROVED_READY' }
            );
        });

        // Listen to redirect
        this.klarna.bind('validation_callback', (event, [data, callback]) => {
            this.klarnaCallback = callback || false;

            try {
                this.checkoutValidator.validate();
            } catch (err) {
                console.log('%cKlarna - Validate', 'font-weight:bold;color:white;background-color:#654be8;padding:5px;', 'Failed', err);
                callback({ should_proceed: false, message: err });
                return;
            }

            this.transitionFn(
                { status: 'idle' },
                { type: 'KLARNA_CHECKOUT_FINALIZE' }
            );
        });


        // handle cases where Klarna didn't load
        setTimeout(() => {
            if (!this.klarnaHasLoaded) {
                console.log('%cKlarna - Load', 'font-weight:bold;color:black;background-color:Azure;border:1px solid SkyBlue;padding:4px 5px;', 'Failed');
                this.transitionFn(
                    { status: 'blocking' },
                    { type: 'KLARNA_NOT_READY' }
                );
            }
        }, 15000);

        // add up event listeners
        subscribe("transition", this.transitionReducer.bind(this));
    }


    /*
     * In case there is a issue loading Klarna show toast to go to original checkout
     */
    errorLoading() {
        console.log('%cError', 'font-weight:bold;color:white;background-color:firebrick;padding:5px;', 'CheckoutKlarna.js', 'handleErrorLoading');

        $('.checkoutError').removeClass('is-hidden');
        $('.checkoutLoading.preloader').addClass('is-hidden');
    }

    /*
     * Handle incoming transitions from state machine
     */
    transitionReducer(event, state) {
        console.log('%cState', 'font-weight:bold;color:white;background-color:#9FE2BF;padding:5px;', event, state.status, state.actions);

        switch (state.status) {
            case 'loading':
                if (!this.isLoading) {
                    this.setLoading(true);
                    this.setBlocking(false);
                }

                this.isLoading = true;

                break;

            case 'idle':
                this.setLoading(false);
                this.setBlocking(false);

                this.isLoading = false;

                break;

            case 'blocking':
                this.setBlocking(true);

                break;

            default: return;
        }

        if (state.actions) {
            this.runActionsFn(state.actions);
        }
    }

    /*
     * Proxy for cpmplete action into steps
     */
    complete(step) {
        this.steps.complete(step);
    }

    openDelivery() {
        this.delivery.open();
    }

    openMiscInformation() {
        this.additionalInformationHandler.open();
    }

    /*
     * Proxy for open action into steps
     */
    open(step) {
        this.steps.open(step);
    }

    /*
     * Enable checkout, after Klarna has been loaded
     */
    enableCheckout() {
        this.platform.checkout.loaded({});
    }

    /*
     * Set the loading ui
     */
    setLoading(isLoading) {
        this.steps.setLoading(isLoading);
    }

    /*
     * Set the complete ui as blocking (show modals)
     */
    setBlocking(shouldBlock) {
        console.log('CheckoutKlarna.js', 'setBlocking', shouldBlock);
    }

    /*
     * Reducer for ASYNC events
     */
    asyncUpdate(action) {
        console.log('%cAsyncUpdate', 'font-weight:bold;background-color:#FFBF00;color:white;padding:5px;', action);

        switch (action) {
            case 'delivery':
                this.async?.[action]();
                break;

            case 'user_type':
                this.async.usertype();
                break;

            case 'finalize':
                const orderSummary = this.checkoutIntermediate.getOrderSummaryData();
                this.async.finalize(
                    orderSummary,
                    this.additionalInformationHandler.get(),
                    this.delivery.getDeliveryData(),
                    orderSummary
                );
                break;

            default:
                break;
        }
    }

    /*
     * Pause klarna iframe for backend input
     */
    pauseKlarna() {
        this.klarna.pause();
    }

    /*
     * Resume klarna iframe after backend input
     */
    resumeKlarna() {
        this.klarna.resume();
    }

    /*
     * Resume after validated
     */
    validateKlarnaCallback() {
        if (typeof this.klarnaCallback === 'function') {
            this.klarnaCallback({ should_proceed: true });
        }
    }
}

export { Checkout };
