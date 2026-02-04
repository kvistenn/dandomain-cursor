{collection assign=variantTypes controller=productVariantType productId=$product->Id}
{$variantSize = $variantTypes->getActualSize()}

<div data-variant="buttons" class="my-6 flex flex-col gap-6" data-variant="buttons">

    <input type="hidden" data-controller="variant" data-variant="variantid" name="product[{$product->Id}][variant]" value="">

    {foreach $variantTypes->getData() as $variantType}
        <div class="flex flex-col gap-2">
            <strong>{$variantType->Title}</strong>
            <div id="m-product-buttons-type-{$variantType->Id}" data-variantType="buttons" class="w-full flex flex-col gap-2" data-variantTypeId="{$variantType->Id}">
                <div class="flex flex-wrap gap-2">
                    {collection assign=variantDatas controller=productVariantData productId=$product->Id typeId=$variantType->Id}
                    {foreach $variantDatas->getData() as $variantData}

                        <div id="m-product-buttons-data-{$variantData->Id}" data-mh="buttons-{$variantType->Id}">
                            <div data-variantData="buttons" data-variantDataId="{$variantData->Id}">
                                <input class="peer hidden" hidden type="radio" name="{$variantType->Title}" value="{$variantData->Id}" id="variant_type_{$variantType@index}_{$variantData@index}">
                                <label class="cursor-pointer text-sm p-3 leading-none border rounded flex items-center justify-center border-gray-200 transition-colors hover:border-black peer-checked:border-black peer-checked:bg-black peer-checked:text-white" for="variant_type_{$variantType@index}_{$variantData@index}">
                                    {$variantData->Title}
                                </label>
                            </div>
                        </div>

                    {/foreach}
                </div>
            </div>
        </div>

    {/foreach}
</div>

{if $variantSize gt 0}

    {*** Include product actions; buy and amount ***}
    {if $product->Type!=='discontinued'}
        {include file="modules/product/partials/entity-actions.tpl" product=$product inputName="product[{$product->Id}][amount]" inputValue=$product->MinAmount data="data-variant='amount'" disabled=true buttonText=$text.PRODUCT_CATALOG_PRODUCT_CHOOSE_VARIANT buttonTextDefault=$text.PRODUCT_CATALOG_PRODUCT_ADD_TO_CART}
    {/if}
    
{/if}