{*

# Description
Checkout template partial, that is included when the payment has been declined. Part of Checkout page type.


## Date last modified
2017-05-19


## Primary variables
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

{* if orderId is empty this means that the order exists as a non received order, display 'order not received' *}
{if empty($page.orderId)}
    {$headline = $text.CHECKOUT_PAYMENT_ERROR_HEADLINE}
    {$text = $text.CHECKOUT_PAYMENT_ERROR_TEXT}
{* if orderId is set this means that the order exists as a received order, display 'order received' *}
{else}
    {$headline = $text.CHECKOUT_STEP_FIVE_HEADLINE}
    {$text = $text.CHECKOUT_STEP_FIVE_TEXT}
{/if}
<br>

<div class="checkoutFrame" itemscope itemtype="http://schema.org/CheckoutPage">
    <div class="modules m-checkout-declined">
        <header class="m-checkout-declined-header page-title">
            <h1 class="m-checkout-declined-headline">{$headline}</h1>
        </header>

        <div class="panel panel-warning">
            <div class="panel-body">
    	       <span>{$text}</span>
            </div>
        </div>
    </div>
</div>