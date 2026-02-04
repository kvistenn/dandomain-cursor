{*

# Description
Template partial for the User Orders List. Part of the User orders page type.


## Date last modified
2015-08-25


## Primary variables
+ $orders                                                               - Collection of orderController
+ $orderLinesUser                                                       - Collection of orderLineUserController
+ $orderLine                                                            - Collection of orderLineController
+ $page                                                                 - Global scope variable containing all information about the page type
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/widgets/recaptcha/recaptcha.tpl"                            - Recaptcha widget, for blog comments
+ "/modules/widgets/meta/opengraph.tpl"                                 - Social meta data

*}


{* Order collection *}
{collection controller=order assign=orders userId=$user->Id}

{* OrderLines collection for preorder *}
{collection controller=orderLine assign=orderLinesUser userId=$user->Id isProcessed=true}

<div class="flex flex-col lg:grid lg:grid-cols-2 gap-5 lg:gap-8">
    {if $orders->getActualSize() gt 0}
        <div class="p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col gap-5">
            <h5 class="text-lg font-medium text-gray-900 mb-2">{$text.MY_ORDERS_HISTORY}</h5>

            {foreach $orders->getData() as $order}

                {* Order Lines collection *}
                {collection controller=orderLine assign=orderLine orderId=$order->Id}

                {* Group order collection by class *}
                {$orderList = $orderLine->groupByClass()}

                <div class="p-4 border border-gray-150 rounded flex items-center gap-4 text-sm justify-between flex-wrap">

                    <div class="w-10 flex-none text-center">
                        <span
                            class="flex items-center justify-center w-10 h-10 rounded border border-gray-200">{$order->Id}</span>
                    </div>

                    <div>
                        <small class="text-xs text-gray-400 block mb-1">{$text.MY_ORDERS_DATE}</small>
                        <span class="block">{$order->Date|date_format:$text.DATE_FORMAT}</span>
                    </div>

                    <div>
                        <small class="text-xs text-gray-400 block mb-1">{$text.MY_ORDERS_STATUS}</small>
                        <span class="block">{$order->StatusText}</span>
                    </div>

                    <div data-tooltip-trigger="click" data-tooltip class="relative cursor-pointer">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M12 6.75a.75.75 0 110-1.5.75.75 0 010 1.5zM12 12.75a.75.75 0 110-1.5.75.75 0 010 1.5zM12 18.75a.75.75 0 110-1.5.75.75 0 010 1.5z" />
                        </svg>
                        <div class="invisible opacity-0 absolute bottom-[125%] left-[-40px] right-[-35px] tooltip !transition-all !duration-100"
                            role="tooltip">
                            <ul class="text-sm font-medium text-white py-1 px-3 bg-black z-10 relative w-max rounded">
                                <li><a href="?order={$order->Id}">{$text.MY_ORDERS_DETAILS_SEE}</a></li>
                                {entity assign=invoiceFile controller=files type=invoice id=$order->Id userId=$user->Id}
                                {if $invoiceFile}
                                    <li><a target="_blank" rel="noopener"
                                            href="{$invoiceFile->getFile()}">{$text.MY_ORDERS_INVOICE}</a></li>
                                {elseif $order->Invoice}
                                    <li><a
                                            href="?order={$order->Id}&amp;invoice={$order->Invoice->Id}">{$text.MY_ORDERS_INVOICE}</a>
                                    </li>
                                {/if}
                            </ul>
                            <div class="tooltip-arrow bg-black" data-popper-arrow></div>
                        </div>
                    </div>

                </div>

            {/foreach}
        </div>

        <div class="p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col gap-5">
            <h5 class="text-lg font-medium text-gray-900 mb-2">{$text.MY_ORDERS_POPULAR}</h5>
            <div class="bg-white border border-gray-150 overflow-hidden rounded">
                {if $orderLinesUser->getActualSize() gt 0}

                    <div class="flex flex-col">
                        <div>
                            <ul class="bg-gray-50 text-xs text-gray-400 py-2 px-4 rounded-lg hidden xs:grid grid-cols-4 gap-2">
                                <li>{$text.PRODUCT_CATALOG_PRODUCT}</li>
                                <li>{$text.CART_COUNT}</li>
                                <li>{$text.CART_PRICE}</li>
                                <li>{$text.MY_ORDERS_REORDER}</li>
                            </ul>
                            <ul class="px-4">
                                {$count = 1}
                                {foreach $orderLinesUser->getData() as $line key=$k}
                                    {if $line->Type != 'wrapping' and $line->Type != 'sale'}
                                        <li
                                            class="rounded-lg flex justify-between flex-wrap xs:grid xs:grid-cols-4 gap-2 text-sm{if $k > 0} border-t border-gray-200{/if}">
                                            <div class="py-4 flex items-center">
                                                <span class="text-gray-800 mr-2">{$count}.</span>
                                                <span class="text-gray-800">{$line->ProductTitle} {$line->VariantTitle}</span>
                                            </div>
                                            <div class="py-4 flex items-center">
                                                <span class="text-gray-600">{$line->Amount} {$line->UnitTitle}</span>
                                            </div>
                                            <div class="py-4 flex items-center">
                                                <span class="text-gray-600 flex flex-col">
                                                    {collection assign=price controller=productPrice productId=$line->ProductId variantId=$line->VariantId}

                                                    {$priceData = $price->getData()}
                                                    {$priceInterval = $priceData[0]}

                                                    {$priceInterval->PriceMin|formatPrice}
                                                    {if $priceInterval->PriceMin lt $priceInterval->FullPriceMin}
                                                        <del>{$priceInterval->FullPriceMin|formatPrice}</del>
                                                    {/if}
                                                </span>
                                            </div>
                                            <div class="py-4 flex items-center">
                                                <a class="px-4 py-2 sm:px-6 sm:py-3 text-xs md:text-sm uppercase rounded-full bg-black text-white w-fit"
                                                    href="/actions/cart/reorderItem?id={$line->LineId}&{csrf type='get'}">{$text.MY_ORDERS_REORDER}</a>
                                            </div>
                                        </li>
                                    {/if}
                                {/foreach}
                            </ul>
                        </div>
                    </div>

                {else}
                    <p>{$text.MY_ORDERS_NONE}</p>
                {/if}
            </div>
        </div>
    {else}
        <p>{$text.MY_ORDERS_NONE}</p>
    {/if}
</div>