

<div class="flex flex-col lg:flex-row border border-gray-200 rounded-xl mt-6">

    {include file="modules/userlayout/sidebar.tpl" active=2}

    <div id="userorder" class="flex-auto p-6 lg:p-12 border-t lg:border-l lg:border-t-0 border-gray-200">

        {if isset($smarty.get.order)}
            <div class="flex justify-between items-center gap-4 mb-6">
                <h1 class="text-xl lg:text-2xl">{$text.CHECKOUT_MAIL_ORDER_SUBJECT_VARIABLE|replace:'#ORDER_NUMBER#':$smarty.get.order}</h1>
                <div>
                    <a href="/actions/cart/reorder?id={(int)$smarty.get.order}&{csrf type='get'}" class="bg-primary px-4 h-10 flex items-center gap-2 rounded text-white text-sm w-fit hover:bg-primary-hover transition-colors">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0 3.181 3.183a8.25 8.25 0 0 0 13.803-3.7M4.031 9.865a8.25 8.25 0 0 1 13.803-3.7l3.181 3.182m0-4.991v4.99" />
                        </svg>                  
                        {$text.MY_ORDERS_REORDER}
                    </a>
                </div>
            </div>
        {else}
            <h1 class="text-xl lg:text-2xl mb-6">{$text.MY_ORDERS_HEADLINE}</h1>
        {/if}

        {if isset($smarty.get.order)}
            {if isset($smarty.get.invoice)}
                {include file='modules/widgets/order/order.tpl' orderId=$smarty.get.order invoiceId=$smarty.get.invoice}
            {else}
                {include file='modules/widgets/order/order.tpl' orderId=$smarty.get.order}
            {/if}
        {else}
            {include file='modules/userorders/userorders-list.tpl'}
        {/if}

    </div>

</div>