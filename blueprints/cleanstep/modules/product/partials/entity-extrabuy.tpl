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
    <div data-product="extrabuy" class="w-full">
        {foreach $extraBuyCategories->getData() as $ebc}

            {collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$ebc->Id}

            {if $extraBuys->getActualSize() gt 0}

                <div data-extrabuy="group" class="mt-6">
                    <strong class="text-sm block mb-2">{$ebc->Title}</strong>
                    <ul class="flex flex-col gap-3">
                        {foreach $extraBuys->getData() as $extraBuy}

                            {* IMAGE *}
                            {placeholdImage assign=placeholder width=48 height=48 background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

                            {* PRICE *}
                            {collection assign=prices controller=productPrice productId=$extraBuy->Id}
                            {$priceData = $prices->getData()}
                            {$price = $priceData[0]}

                            {* VARIANTS *}
                            {collection assign=productVariants controller=productVariant productId=$extraBuy->Id}

                            {if $price->PriceMin neq $price->FullPriceMin}
                                {$oldPrice = $price->FullPriceMin}
                            {else}
                                {$oldPrice = null}
                            {/if}

                            <li>
                                <label class="bg-white flex items-center border border-gray-200 p-4 rounded gap-2 cursor-pointer" for="{$extraBuy->Id}">
                                    <div class="flex-none w-fit leading-none">
                                        <input type="checkbox" pattern="[0-9]*" id="{$extraBuy->Id}" data-price="{$price->PriceMin}" title="{$text.INSERT_AMOUNT}" data-extrabuy="checkbox" class="w-6 h-6 cursor-pointer">
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
                                    <div class="flex-auto">
                                        <a href="{$productController->link($extraBuy->Id, false, $extraBuy)}" class="playfair text-sm flex flex-col underline">{$extraBuy->Title}</a>
                                        <span class="text-xs font-bold text-right" data-extrabuy="price">+ {$price->PriceMin|formatPrice} {if $oldPrice}<s>{$oldPrice|formatPrice}</s>{/if}</span>
                                        {if $page.url|strstr:'?bewise' && $productVariants->getActualSize() gt 0}
                                            <select class="text-xs text-gray-500" data-extrabuy="variant">
                                                {foreach $productVariants->getData() as $variant}
                                                    {entity assign=variantProduct controller=productVariantData id=$variant->ProductId variantId=$variant->Id}
                                                    <option value="{$variantProduct->Id}">{$variantProduct->Title}</option>
                                                {/foreach}
                                            </select>
                                        {/if}
                                    </div>
                                </label>
                            </li>
                            
                        {/foreach}
                    </ul>
                </div>
            {/if}

        {/foreach}
    </div>
{/if}