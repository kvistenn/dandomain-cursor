{*

# Description
Template partial for the extrabuy products. Part of the Product page type.


## Date last modified
2020-10-05


## Primary variables
+ $productController                                                    - Instance of productController
+ $product                                                              - Entity of productController (the current product)
+ $extraBuyCategories                                                   - Collection of productExtraBuyCategoryController
+ $extraBuys                                                            - Collection of productExtraBuyController
+ $category                                                             - Entity of productCategoryController
+ $prices                                                               - Collection of productPriceController
+ $extraBuyImage                                                        - Entity of fileController with type product
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

{collection assign=extraBuyCategories controller=productExtraBuyCategory productId=$product->Id}

{if $extraBuyCategories->getActualSize() gt 0}
    <div data-controller="extraBuyProducts" class="w-full">
        {foreach $extraBuyCategories->getData() as $ebc}

            {if $ebc->Id neq 5}

                {collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$ebc->Id}

                {if $extraBuys->getActualSize() gt 0}

                    <div data-extrabuy="group" class="mt-6">
                        <strong class="text-sm block mb-2">{$text.PRODUCT_CATALOG_EXTRABUY}</strong>
                        <ul class="flex flex-col gap-3">
                            {foreach $extraBuys->getData() as $extraBuy}

                                {* IMAGE *}
                                {placeholdImage assign=placeholder width=48 height=48 background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

                                {* CUSTOM FIELDS *}
                                {collection assign=productCustomDataTypes controller=productCustomDataType productId=$extraBuy->Id}
                                {$ebcCustomDataTypes = []}
                                {foreach $productCustomDataTypes->getData() as $customType}
                                    {$customData = []}
                                    {collection assign=productCustomData controller=productCustomData productId=$extraBuy->Id typeId=$customType->Id}
                                    {foreach $productCustomData->getData() as $customDataItem}

                                        {$customDataTitle = $customDataItem->Title}

                                        {if $customDataItem->Title|strstr:' || '}
                                            {$customDataTitle = ' || '|explode:$customDataItem->Title}
                                        {/if}

                                        {if $productCustomData->getData()|@count gt 1}
                                            {$customData[] = $customDataTitle}
                                        {else}
                                            {$customData = $customDataTitle}
                                        {/if}
                                    {/foreach}
                                    {$ebcCustomDataTypes[$customType->Id] = ['Title' => $customType->Title, 'Data' => $customData]}
                                {/foreach}

                                {$onStock = !$extraBuy->Soldout}
                            
                                {* VARIANTS *}
                                {collection assign=productVariants controller=productVariant productId=$extraBuy->Id}
                                
                                {$contents = $ebcCustomDataTypes[7].Data}

                                {if $productVariants->getData()|@count eq 0}

                                    {* PRICE *}
                                    {collection assign=prices controller=productPrice productId=$extraBuy->Id}
                                    {$priceData = $prices->getData()}
                                    {$price = $priceData[0]}

                                    <li data-price="{$price->PriceMin}" data-id="{$extraBuy->Id}" data-unit="{$controller->getUnitTitle($item->UnitId)}" data-contents="{$contents}">
                                        <label class="bg-white flex items-center border border-gray-200 p-4 rounded gap-2 cursor-pointer" for="{$extraBuy->Id}">
                                        <div>
                                        <div class="flex overflow-hidden rounded w-fit">
                                            <input type="checkbox" pattern="[0-9]*" id="{$extraBuy->Id}" value="0" title="{$text.INSERT_AMOUNT}" data-extrabuy="amount" class="h-5 w-6 sm:w-8 sm:border-r border-gray-200 text-center text-xs">
                                        </div>
                                    </div>
                                            <figure class="flex-none w-12">
                                                {* Get the item image *}
                                                {entity assign=extraBuyImage controller=files type=product productId=$extraBuy->Id}
                                                {if !$extraBuyImage}
                                                    {entity assign=extraBuyImage controller=files type=product productId=$product->Id}
                                                {/if}

                                                {if $extraBuyImage}
                                                    <span title="{$extraBuy->Title}">
                                                        {img src="{$extraBuyImage->thumbnail(48, 48, 'fill')|solutionPath}" alt="{$extraBuy->Title}"}
                                                    </span>
                                                {else}
                                                    <span title="{$extraBuy->Title}">
                                                        {img placeholder="{$placeholdImage->thumbnail(48, 48, 'fill')}" alt="{$extraBuy->Title}"}
                                                    </span>
                                                {/if}
                                            </figure>
                                            <div class="flex flex-col xs:flex-row items-center justify-between flex-auto gap-2 xs:gap-1">
                                                <a href="{$productController->link($extraBuy->Id, false, $extraBuy)}" class="playfair text-sm flex flex-col">{$extraBuy->Title} 
                                                
                                                {if $settings.shop_product_delivery_time}

                                                    {if !$onStock}
                                                        <div class="flex items-center gap-1 text-xs">
                                                            <span class="w-2 h-2 min-w-2 bg-red-500 rounded-full mr-1"></span>
                                                            {if $item->DeliveryTimeId <= 0}
                                                                <span>{$text.PRODUCT_OUTOFSTOCK_BOTH}</span>
                                                            {else}
                                                                <span>{translation id=$item->DeliveryTimeId module='delivery_time' title='title_no_stock'}</span>
                                                            {/if}
                                                        </div>
                                                    {/if}
                                                    
                                                    {if $onStock}
                                                        <div class="flex items-center gap-1 text-xs">
                                                            <span class="w-2 h-2 min-w-2 bg-green-500 rounded-full mr-1"></span>
                                                            {if $extraBuy->DeliveryTimeId === 0}
                                                                <span>{$text.PRODUCT_INSTOCK_BOTH}</span>
                                                            {else if $extraBuy->DeliveryTimeId === -1}
                                                                <span>{$text.PRODUCT_CATALOG_STOCK_HOME}</span>
                                                            {else}
                                                                <span>{translation id=$extraBuy->DeliveryTimeId module='delivery_time' title='title_on_stock'}</span>
                                                            {/if}
                                                        </div>
                                                    {/if}

                                                {/if}
                                                </a>
                                                <div class="flex flex-col w-full xs:w-auto">
                                                {if $price->PriceMin neq $price->FullPriceMin}
                                                    {$oldPrice = $price->FullPriceMin}
                                                    {else}
                                                    {$oldPrice = null}
                                                {/if}
                                            <span class="text-xs font-bold text-right" data-extrabuy="price">{$price->PriceMin|formatPrice} {if $oldPrice}<s>{$oldPrice|formatPrice}</s>{/if}</span>
                                                    {* {if !empty($contents)}
                                                        <small class="text-2xs text-right" data-extrabuy="priceinfo">{(($text.PRODUCTLIST_QUANTITY|replace:'[[UNIT]]':$controller->getUnitTitle($item->UnitId))|replace:'[[AMOUNT]]':$price->Amount)|replace:'[[CONTENTS]]':"(`$contents`)"}</small>
                                                    {else}
                                                        <small class="text-2xs text-right" data-extrabuy="priceinfo">{(($text.PRODUCTLIST_QUANTITY|replace:'[[UNIT]]':$controller->getUnitTitle($item->UnitId))|replace:'[[AMOUNT]]':$price->Amount)|replace:'[[CONTENTS]]':""}</small>
                                                {/if} *}
                                                <a href="{$productController->link($extraBuy->Id, false, $extraBuy)}" class="text-2xs font-bold text-right">{$text.PRODUCT_CATALOG_PRODUCT_SHOW}</a>
                                                </div>
                                            </div>
                                        </label>
                                    </li>

                                {else}

                                    {foreach $productVariants->getData() as $extraBuyVariant}

                                        {if $extraBuyVariant->Soldout}
                                            {continue}
                                        {/if}

                                        {* TITLE *}
                                        {collection assign=variantDatas controller=productVariantData productId=$extraBuy->Id variantId=$extraBuyVariant->Id}
                                        {$VariantTitle = ''}
                                        {$VariantIds = []}
                                        {foreach $variantDatas->getData() as $variantData}
                                            {$VariantTitle = $VariantTitle|cat:" "|cat:$variantData->Title}
                                            {$VariantIds[] = $variantData->Id}
                                        {/foreach}

                                        {* PRICE *}
                                        {entity assign=extraBuyProduct controller=product productId=$extraBuy->Id variantId=$extraBuyVariant->Id}
                                        {$price = $extraBuyProduct->Prices[0]}

                                        <li data-price="{$price->FullPriceMinWithVat}" data-id="{$extraBuy->Id}" data-variantid="{$extraBuyVariant->Id}" data-dataids="{','|implode:$VariantIds}" data-unit="{$controller->getUnitTitle($item->UnitId)}" data-contents="{$contents}">
                                            <label class="bg-white flex items-center border border-gray-200 p-4 rounded gap-2 cursor-pointer" for="{$extraBuyVariant->Id}">
                                                <div>
                                                    <div class="flex overflow-hidden rounded w-fit">
                                                        <input type="checkbox" id="{$extraBuyVariant->Id}" pattern="[0-9]*" value="0" title="{$text.INSERT_AMOUNT}" data-extrabuy="amount" class="h-5 w-6 sm:w-8 sm:border-r border-gray-200 text-center text-xs">
                                                    </div>
                                                </div>
                                                <figure class="flex-none w-12">
                                                    {* Get the item image *}
                                                    {entity assign=extraBuyImage controller=files type=product productId=$extraBuy->Id variantId=$extraBuyVariant->Id}
                                                    {if !$extraBuyImage}
                                                        {entity assign=extraBuyImage controller=files type=product productId=$product->Id}
                                                    {/if}

                                                    {if $extraBuyImage}
                                                        <span title="{$extraBuyVariant->Title}">
                                                            {img src="{$extraBuyImage->thumbnail(48, 48, 'fill')|solutionPath}" alt="{$extraBuyVariant->Title}"}
                                                        </span>
                                                    {else}
                                                        <span title="{$extraBuyVariant->Title}">
                                                            {img placeholder="{$placeholdImage->thumbnail(48, 48, 'fill')}" alt="{$extraBuyVariant->Title}"}
                                                        </span>
                                                    {/if}
                                                </figure>
                                                <div class="flex flex-col xs:flex-row items-center justify-between flex-auto gap-1">
                                                <a href="{$productController->link($extraBuy->Id, false, $extraBuy)}" class="playfair text-sm">{$extraBuy->Title} - {$VariantTitle}</a>
                                                    <div class="flex flex-col w-full xs:w-auto">
                                                        <span class="text-xs font-bold text-right" data-extrabuy="price">{$price->FullPriceMinWithVat|formatPrice}</span>
                                                        {* {if !empty($contents)}
                                                            <small class="text-2xs text-right" data-extrabuy="priceinfo">{(($text.PRODUCTLIST_QUANTITY|replace:'[[UNIT]]':$controller->getUnitTitle($item->UnitId))|replace:'[[AMOUNT]]':$price->Amount)|replace:'[[CONTENTS]]':"(`$contents`)"}</small>
                                                        {else}
                                                            <small class="text-2xs text-right" data-extrabuy="priceinfo">{(($text.PRODUCTLIST_QUANTITY|replace:'[[UNIT]]':$controller->getUnitTitle($item->UnitId))|replace:'[[AMOUNT]]':$price->Amount)|replace:'[[CONTENTS]]':""}</small>
                                                        {/if} *}
                                                        <a href="{$productController->link($extraBuy->Id, false, $extraBuy)}" class="text-2xs font-bold text-right">{$text.PRODUCT_CATALOG_PRODUCT_SHOW}</a>
                                                    </div>
                                                </div>
                                            </label>
                                        </li>

                                    {/foreach}

                                {/if}
                            {/foreach}
                        </ul>
                    </div>
                {/if}

            {/if}
        {/foreach}
    </div>
{/if}