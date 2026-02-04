{* Order collection *}
{collection controller=order assign=orders userId=$user->Id}

{* OrderLines collection for preorder *}
{collection controller=orderLine assign=orderLinesUser userId=$user->Id isProcessed=true}

{if $orders->getActualSize() gt 0}

    <div class="flex flex-col gap-2">
        <label class="flex flex-col gap-1">
            <input type="text" placeholder="{$text.SEARCH}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" data-user="search">
        </label>
    </div>

    <div class="flex flex-col border border-gray-200 rounded overflow-hidden mt-4" data-user="orders">
        {foreach $orders->getData() as $order}

            {* Order Lines collection *}
            {collection controller=orderLine assign=orderLine orderId=$order->Id}

            {* Order customer *}
            {entity controller=orderCustomer assign=customer orderId=$order->Id}

            {* Group order collection by class *}
            {$orderList = $orderLine->groupByClass()}

            {$orderId = $order->Id}
            {if $orderId|strlen < 8}
                {$orderId = "00000000"|cat:$orderId}
                {$orderId = $orderId|substr:-8}
            {/if}

            <div class="flex border-b border-gray-200 last:border-b-0 hover:bg-gray-100 transition-colors" data-user="order">
                <a href="/{$text.MY_ORDERS_LINK}/?order={$order->Id}&amp;invoice={$order->Invoice->Id}" data-fancybox data-type="ajax" data-filter="#userorder" data-width="900" class="flex-auto flex gap-1 items-center py-1 pl-1">
                    <div class="w-12 flex-none p-1">
                        <div class="flex flex-col gap-0.5 py-2 border border-gray-200 rounded-lg text-center bg-white">
                            <span class="block text-xl leading-none">{$order->Date|date_format:"%d"}</span>
                            <span class="block text-[10px] uppercase tracking-wider leading-none">{$order->Date|date_format:"%b"}</span>
                        </div>
                    </div>
                    <div class="w-20 flex-none p-1">
                        <div class="flex flex-col gap-1.5">
                            <span class="text-[10px] tracking-wider uppercase text-gray-600 leading-none">{$text.MY_ORDERS_NUMBER}:</span>
                            <span class="leading-none text-sm">{$orderId}</span>
                        </div>
                    </div>
                    <div class="hidden lg:block w-40 flex-none p-1">
                        <div class="flex flex-col gap-1.5">
                            <span class="text-[10px] tracking-wider uppercase text-gray-600 leading-none">{$text.COMPANY}:</span>

                            {if $customer->ShippingCompany}
                                <span class="text-xs line-clamp-1">{$customer->ShippingCompany}</span>
                            {else}
                                <span class="text-xs line-clamp-1">{$customer->Company}</span>
                            {/if}
                        </div>
                    </div>
                    <div class="hidden lg:block w-1/4 flex-none p-1">
                        <div class="flex flex-col gap-1.5">
                            <span class="text-[10px] tracking-wider uppercase text-gray-600 leading-none">{$text.CHECKOUT_DELIVERY_ADDRESS}:</span>
                            {if $customer->ShippingAddress}
                                <span class="text-xs line-clamp-1">{$customer->ShippingAddress}, {$customer->ShippingZip} {$customer->ShippingCity}</span>
                            {else}
                                <span class="text-xs line-clamp-1">{$customer->Address}, {$customer->Zip} {$customer->City}</span>
                            {/if}
                        </div>
                    </div>
                    <div class="hidden lg:block w-20 flex-none p-1">
                        <div class="flex flex-col gap-1.5">
                            <span class="text-[10px] tracking-wider uppercase text-gray-600 leading-none">{$text.MY_ORDERS_STATUS}:</span>
                            <span class="leading-none text-sm">{$order->StatusText}</span>
                        </div>
                    </div>
                    <div class="hidden lg:block flex-auto p-1">
                        <div class="flex flex-col gap-1.5">
                            <span class="text-[10px] tracking-wider uppercase text-gray-600 leading-none">{$text.MY_ORDERS_PRICE}:</span>
                            <span class="leading-none text-sm">{$orderList.CollectionOrderTotalLine.0->Price|formatPriceOrder:$order->Id}</span>
                        </div>
                    </div>
                </a>
                <a href="/actions/cart/reorder?id={$order->Id}&{csrf type='get'}" class="w-fit flex-none flex items-center py-1 px-4">
                    <div class="bg-white px-3 h-8 flex items-center gap-2 rounded border border-gray-200 text-xs w-fit hover:scale-105 hover:shadow-lg transition-all">
                        {$text.MY_ORDERS_REORDER}
                    </div>
                </a>
            </div>

        {/foreach}
    </div>
{else}
    <p>{$text.NO_ORDERS}</p>
{/if}