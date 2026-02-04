{$imageWidth = 64}
{$imageHeight = 64}

{collection controller=orderLine assign=orderLinesUser userId=$user->Id isProcessed=true}
{placeholdImage assign=placeholder width=$imageWidth height=$imageHeight background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

{if $orderLinesUser->getActualSize() gt 0}

    <div class="flex flex-col border border-gray-200 rounded">
        <div class="border-b border-gray-200 last:border-b-0 flex text-xs font-bold gap-4">
            <span class="p-2 w-16 flex-none"></span>
            <span class="p-2 flex-auto">{$text.PRODUCT_CATALOG_PRODUCT}</span>
            <span class="p-2 w-1/4 flex-none text-right">{$text.CART_PRICE}</span>
            <span class="p-2 w-1/4 flex-none text-right">{$text.BLOG_ADMIN}</span>
        </div>
        <div class="flex flex-col rounded overflow-hidden">
                
            {foreach $orderLinesUser->getData() as $line}
                {if $line->Type != 'wrapping' and $line->Type != 'sale'}

                    {$productImage = null}
                    {$variantImage = null}
                    
                    {if $line->ProductId && is_numeric($line->ProductId)}
                        {if $line->ProductId}
                            {entity assign=productImage controller=files type=product productId=$line->ProductId}
                        {/if}
                        {if $line->VariantId}
                            {entity assign=variantImage controller=files type=variant variantId=$line->VariantId}
                        {/if}

                        {if $variantImage}
                            {$productImage = $variantImage->thumbnail($imageWidth, $imageHeight, true)|solutionPath}
                        {elseif $productImage}
                            {$productImage = $productImage->thumbnail($imageWidth, $imageHeight, true)|solutionPath}
                        {else}
                            {$productImage = $placeholder->getRelativeFile()|solutionPath}
                        {/if}
                    {/if}

                    <div class="flex border-b border-gray-200 last:border-b-0 items-center gap-4 relative" data-mostsold="line" data-amount="{$line->Amount}" data-price="{$line->Price * $line->Amount}">
                        <div class="w-16 flex-none p-2">
                            <figure class="w-full border border-gray-200 rounded">
                                {if $productImage}
                                    <img src="{$productImage}" class="w-full rounded-lg" alt="{$line->ProductTitle}" itemprop="image" />
                                {else}
                                    <img src="{$placeholder->getRelativeFile()|solutionPath}" class="w-full rounded-lg" alt="{$line->ProductTitle}" itemprop="image"/>
                                {/if}
                            </figure>
                        </div>
                        <div class="flex-auto flex flex-col gap-2 text-sm p-2">
                            <strong itemprop="name">
                                {$line->Amount}x {$line->ProductTitle}
                            </strong>

                            {if $line->VariantTitle}
                                <span class="text-xs">{$line->VariantTitle}</span>
                            {/if}

                            {if $line->CouponId}
                                <div class="flex text-xs">
                                    <span>{$text.MY_ORDERS_NUMBER}: </span>
                                    <span>{$line->CouponId}</span>
                                </div>
                            {/if}

                            {* {if $line->AdditionalTitle}
                                <span class="text-xs">{$line->AdditionalTitle}</span>
                            {/if} *}

                            {if $line->PacketTitle}
                                <span class="text-xs">{$line->PacketTitle}</span>
                            {/if}

                            {if isset($line->CouponTo)}
                                <div class="flex">
                                    <span>{$text.GIFT_CARD_NAME}: </span>
                                    <span>{$line->CouponTo}</span>
                                </div>
                                {if isset($line->CouponCode)}
                                    <div class="flex">
                                        <span>{$text.GIFT_CARD_CODE}: </span>
                                        <span>{$line->CouponCode}</span>
                                    </div>
                                {/if}
                            {/if}
                            {if isset($line->FileDownloadLink)}
                                <span class="text-xs"><a href="/{$text.FILE_SALE_LINK}/{$line->FileDownloadLink}" target="_blank" rel="noopener">{$text.FILE_SALE_MENU}</a></span>
                            {/if}

                            {if $line->ItemNumber && $settings.shop_product_number eq true}
                                <div class="flex text-xs">
                                    <span>{$text.PRODUCT_CATALOG_PRODUCT_NUMBER}: </span>
                                    <span>{$line->ItemNumber}</span>
                                </div>
                            {/if}
                        </div>
                        <div class="w-1/4 flex-none text-right text-xs p-2">
                            <div>
                            {if $line->FullPrice == $line->Price}
                                {($line->Price * $line->Amount)|formatPriceOrder:$orderId}
                            {else}
                                <s class="text-[10px]">{($line->FullPrice * $line->Amount)|formatPriceOrder:$orderId}</s><br>
                                {($line->Price * $line->Amount)|formatPriceOrder:$orderId}
                            {/if}
                            </div>
                        </div>
                        <div class="w-1/4 flex-none text-right text-xs p-2 flex justify-end items-center pr-4">
                            <a href="/actions/cart/reorderItem?id={$line->LineId}&{csrf type='get'}" class="bg-white px-3 h-8 flex items-center gap-2 rounded border border-gray-200 text-xs w-fit hover:scale-105 hover:shadow-lg transition-all">
                                {$text.MY_ORDERS_REORDER}
                            </a>
                        </div>
                    </div>

                {/if}
            {/foreach}

        </div>

    </div>

{/if}