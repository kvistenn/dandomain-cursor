{*

# Description
Controller and template for the User Orders page type.


## Date last modified
2015-04-21


## Primary variables
+ $deliveryCountries                                                    - Collection of deliveryCountryController
+ $interestFields                                                       - Collection of interestFieldController
+ $page                                                                 - Global scope variable containing all information about the page type
+ $settings                                                             - Global scope variable containing platform settings
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/widgets/order/order.tpl"                                    - Template widget for the User Order Details
+ "/modules/order/order/userorders-list.tpl"                            - Template for User order list

*}

<header class="text-center mb-6 sm:mb-10 md:mb-14">
    <h1 class="text-lg sm:text-xl md:text-2xl">{$page.title}</h1>
</header>

<div class="p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col gap-5">
    {if isset($smarty.get.order)}
        {if isset($smarty.get.invoice)}
            {include file='modules/widgets/order/order.tpl' orderId=$smarty.get.order invoiceId=$smarty.get.invoice}
        {else}
            {include file='modules/widgets/order/order.tpl' orderId=$smarty.get.order}
        {/if}
        <div class="justify-between sm:justify-start flex flex-wrap sm:flex-nowrap gap-3 lg:gap-5">
            <a class="text-xs block w-fit lg:text-sm bg-black text-white px-4 lg:px-6 py-2 lg:py-3 rounded-full text-center" href="/{$Text.MY_ORDERS_LINK}/">{$Text.BACK}</a>
            <a class="block w-fit text-xs lg:text-sm bg-gray-700 text-white px-4 lg:px-6 py-2 lg:py-3 rounded-full text-center" href="/actions/cart/reorder?id={(int)$smarty.get.order}&{csrf type='get'}">{$Text.MY_ORDERS_REORDER}</a>
        </div>
    {else}
        {include file='modules/userorders/userorders-list.tpl'}
    {/if}
</div>