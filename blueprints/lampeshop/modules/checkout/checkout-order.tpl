{*

# Description
Checkout template partial, where customers input all the data (includes step 1, 2, 3, 4 and 5). Part of Checkout page type.


## Date last modified
2021-02-01


## Primary variables
+ $boxes                                                    			- Global scope variable containing column boxes
+ $columns                                                  			- Global scope variable containing columns


## Partials (templates)
+ "/modules/widgets/order/order.tpl"                        			- Template widget for the User Order Details
+ "/modules/checkout/partials/checkout-step1.tpl"						- Template partial containing step 1 info
+ "/modules/checkout/partials/checkout-step2.tpl"						- Template partial containing step 2 info
+ "/modules/checkout/partials/checkout-step3.tpl"						- Template partial containing step 3 info
+ "/modules/checkout/partials/checkout-step4.tpl"						- Template partial containing step 4 info
+ "/modules/checkout/partials/checkout-step5.tpl"						- Template partial containing step 5 info

*}

{* Add required JS asset *}
{addScript src='modules/checkout/includes/js/checkout.js'}

{* Define standard class for columns *}
{$stepClass = "col-s-4 col-m-4 col-l-4 col-xl-8"}

{* Calculate number of columns needed *}
{if $columns gt 0}
	{$stepClass = "col-s-4 col-m-12 col-l-12 col-xl-24"}
{/if}

{assign var=stepNum value=1}

<div class="checkoutLoading flex justify-center items-center lg:h-screen">
    <svg width="44" height="44" viewBox="0 0 44 44" xmlns="http://www.w3.org/2000/svg" stroke="#000">
        <g fill="none" fill-rule="evenodd" stroke-width="2">
            <circle cx="22" cy="22" r="1">
                <animate attributeName="r"
                    begin="0s" dur="1.8s"
                    values="1; 20"
                    calcMode="spline"
                    keyTimes="0; 1"
                    keySplines="0.165, 0.84, 0.44, 1"
                    repeatCount="indefinite" />
                <animate attributeName="stroke-opacity"
                    begin="0s" dur="1.8s"
                    values="1; 0"
                    calcMode="spline"
                    keyTimes="0; 1"
                    keySplines="0.3, 0.61, 0.355, 1"
                    repeatCount="indefinite" />
            </circle>
            <circle cx="22" cy="22" r="1">
                <animate attributeName="r"
                    begin="-0.9s" dur="1.8s"
                    values="1; 20"
                    calcMode="spline"
                    keyTimes="0; 1"
                    keySplines="0.165, 0.84, 0.44, 1"
                    repeatCount="indefinite" />
                <animate attributeName="stroke-opacity"
                    begin="-0.9s" dur="1.8s"
                    values="1; 0"
                    calcMode="spline"
                    keyTimes="0; 1"
                    keySplines="0.3, 0.61, 0.355, 1"
                    repeatCount="indefinite" />
            </circle>
        </g>
    </svg>
</div>

<div class="checkoutFrame" itemscope itemtype="http://schema.org/CheckoutPage" style="display:none">
    <form action="/actions/checkout/checkAll" method="post" class="checkoutForm" autocomplete="off">
        {csrf type="input"}
        <input id="check_stage_all_loaded" type="hidden" name="check_stage_all_loaded" value="0" />

        <div class="flex flex-col lg:grid lg:grid-cols-2 lg:h-screen">
            <div class="bg-white h-full border-r border-gray-200">
                <div class="w-full lg:w-[700px] max-w-full h-full ml-auto p-6 md:p-10">
                    
                    {* TITLE *}
                    <a href="/" class="block text-2xl mb-4">
                        {if $general.languageIso639 === 'da'}
                        <img src="{$template.path}/assets/images/logo.png" width="450" height="50" alt="{$contactdata.company}" class="flex-none max-w-full h-auto w-[200px] lg:w-[300px]">
                        {else}
                        <img src="{$template.path}/assets/images/logo-se.webp" width="450" height="50" alt="{$contactdata.company}" class="flex-none max-w-full h-auto w-[200px] lg:w-[300px]">
                        {/if}
                    </a>
                    
                    {* STEPS *}
                    <div class="flex flex-wrap items-center gap-2 text-xs mb-8">
                        <a href="{$text.CART_LINK|formatUrl}" class="font-bold">{$text.CART_HEADLINE}</a>
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                                <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
                            </svg>
                        </span>
                        <span class="cursor-pointer font-bold" data-checkout="stepTitle" data-step="1" data-target="1">{$text.CHECKOUT_STEP_ONE}</span>
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                                <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
                            </svg>
                        </span>
                        <span class="cursor-pointer" data-checkout="stepTitle" data-step="2" data-target="2">{$text.CHECKOUT_STEP_TWO}</span>
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                                <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
                            </svg>
                        </span>
                        <span class="cursor-pointer" data-checkout="stepTitle" data-step="4" data-target="4">{$text.CHECKOUT_STEP_FOUR}</span>
                    </div>

                    {include file='modules/checkout/partials/checkout-overview.tpl'}

                    {* CONTENT *}
                    <div class="border-gray-300 flex flex-col gap-10 pb-6">

                        {* STEP 1 *}
                        <div class="step step1" data-step="1">
                            {include file='modules/checkout/partials/checkout-step1.tpl'}
                        </div>

                        {* STEP 2 *}
                        <div class="step step2" data-step="2" style="display:none">
                            {include file='modules/checkout/partials/checkout-step2.tpl'}
                        </div>

                        {* STEP 3 *}
                        {* <div class="step step3" data-step="3" style="display:none">
                            {include file='modules/checkout/partials/checkout-step3.tpl'}
                        </div> *}

                        {* STEP 4 *}
                        <div class="step step4" data-step="4" style="display:none">
                            {include file='modules/checkout/partials/checkout-step4.tpl'}
                        </div>

                    </div>

                </div>
            </div>
            <div class="bg-gray-50 h-full">
                <div class="step5 w-full lg:w-[500px] max-w-full h-full mr-auto p-6 md:p-10 relative">
                    
                    <div class="sticky top-10">

                        {include file='modules/checkout/partials/checkout-step5.tpl'}
                        {if $settings.module_shop_packing}
                            <div class="step3">
                                {include file='modules/checkout/partials/checkout-step3.tpl'}
                            </div>
                        {/if}
                        {include file='modules/checkout/partials/checkout-step5-conditions.tpl'}

                    </div>

                </div>
            </div>
        </div>
    </form>
</div>