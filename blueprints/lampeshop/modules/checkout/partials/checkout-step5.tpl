{*

# Description
Template partial for Checkout step 5 of the checkout process. Part of Checkout page type.
Consisting mostly of a [jsRender Template](http://www.jsviews.com/#jsrender).


## Date last modified
2020-10-05


## Resource
+ [jsRender Template](http://www.jsviews.com/#jsrender)


## Primary variables


## Partials (templates)
No extra templates required for this template

*}
{literal}
<script id="orderSummaryTemplate" type="text/x-jsrender">

    <div id="orderLines" class="flex flex-col gap-3 pb-5 border-b border-gray-300">
        {{for orderLines.lines tmpl="#orderLineTemplate"/}}
        {{if coupon}}
            <div class="flex leading-none">
                <figure class="w-16	flex-none relative">
                    <div class="w-full aspect-square h-auto border border-gray-200 rounded-md flex items-center justify-center bg-gray-100 text-gray-500 text-xs">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 14.25l6-6m4.5-3.493V21.75l-3.75-1.5-3.75 1.5-3.75-1.5-3.75 1.5V4.757c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0c1.1.128 1.907 1.077 1.907 2.185zM9.75 9h.008v.008H9.75V9zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm4.125 4.5h.008v.008h-.008V13.5zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                        </svg>
                    </div>
                </figure>
                <div class="flex flex-col flex-auto w-64 px-4">
                    <strong class="text-sm line-clamp-2">{{:coupon.title}}</strong>
                </div>
                <div class="flex-auto w-32 flex flex-col items-end justify-between">
                    <a href="/{{:~text('CART_LINK')}}/" class="text-gray-500">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0115.75 21H5.25A2.25 2.25 0 013 18.75V8.25A2.25 2.25 0 015.25 6H10" />
                        </svg>
                    </a>
                    <strong class="text-sm whitespace-nowrap">{{:coupon.priceFormatted}}</strong>
                </div>
            </div>
            {{/if}}
    </div>

    {{if !coupon}}
    <div class="flex gap-4 py-5 border-b border-gray-300">
        <input type="text" id="discountCode" class="bg-white border border-gray-300 rounded flex-auto px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{{:~text('SHOP_DISCOUNT_CODE')}}" />
        <button type="button" id="discountCodeSubmit" class="px-3 md:px-6 h-10 md:h-12 rounded bg-gray-500 text-white text-xs md:text-sm">{{:~text('POS_DISCOUNT_ADD_DISCOUNT')}}</button>
    </div>
    {{/if}}

    <div class="py-5 border-b border-gray-300 flex flex-col gap-3 text-sm">
        <div class="flex justify-between gap-4">
            <span>{{:~text('CHECKOUT_STEP_FOUR_DELIVERY')}} {{:delivery.title}}</span>
            <strong>{{:delivery.priceFormatted}}</strong>
        </div>
        <div class="flex justify-between gap-4">
            <span>{{:~text('CART_PRICE_SUM')}}</span>
            <strong>{{:subTotalFormatted}}</strong>
        </div>
        <div class="flex justify-between gap-4">
            <span>
                {{if ~hasVat}}
                    {{:~text('CART_VAT_INCLUSIVE')}}
                {{else}}
                    {{:~text('CART_VAT_EXCLUSIVE')}}
                {{/if}}
            </span>
            <strong>{{:totalvatFormatted}}</strong>
        </div>
        {{if payment.price != "0"}}
        <div class="flex justify-between gap-4">
            <span>{{:~text('MY_ORDERS_FEE')}}</span>
            <strong>{{:payment.priceFormatted}}</strong>
        </div>
        {{/if}}
    </div>

    <div class="pt-6">
        <div class="flex justify-between gap-4">
            <span>{{:~text('CART_TOTAL')}}</span>
            <strong class="text-2xl flex items-center gap-1.5">{{:totalFormatted}}</strong>
        </div>
    </div>
    
</script>

<script id="orderLineTemplate" type="text/x-jsrender">

    <div class="flex leading-none{{if ~root.orderLineLimit && #index >= ~root.orderLineLimit}} hidden{{/if}}">
        <figure class="w-16	flex-none relative">
            <span class="w-5 h-5 flex items-center justify-center rounded-full bg-gray-500 text-white absolute top-0 right-0 text-xs -translate-y-1/3 translate-x-1/4">{{:amount}}</span>
            {{if image}}
                <img src="{{:image}}" width="64" height="64" alt="" loading="lazy" class="w-full h-auto border border-gray-200 rounded-md" />
            {{else}}
                <div class="w-full aspect-square h-auto border border-gray-200 rounded-md flex items-center justify-center bg-gray-100 text-gray-500 text-xs">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 14.25l6-6m4.5-3.493V21.75l-3.75-1.5-3.75 1.5-3.75-1.5-3.75 1.5V4.757c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0c1.1.128 1.907 1.077 1.907 2.185zM9.75 9h.008v.008H9.75V9zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm4.125 4.5h.008v.008h-.008V13.5zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                    </svg>
                </div>
            {{/if}}
        </figure>
        <div class="flex flex-col flex-auto w-64 px-4">
            <strong class="text-sm line-clamp-2">{{:title}}</strong>
        </div>
        <div class="flex-auto w-32 flex flex-col items-end justify-between">
            <a href="/{{:~text('CART_LINK')}}/" class="text-gray-500">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0115.75 21H5.25A2.25 2.25 0 013 18.75V8.25A2.25 2.25 0 015.25 6H10" />
                </svg>
            </a>
            <strong class="text-sm whitespace-nowrap">{{:priceTotal}}</strong>
        </div>
    </div>

</script>
{/literal}

<div class="orderSummary"></div>