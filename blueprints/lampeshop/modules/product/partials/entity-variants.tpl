{* Preload related entities to optimize load times *}
{include file='modules/product/partials/entity-variant-buttons-preload.tpl' scope=parent}

{*** VariantType collection - all types associated with product ***}
{collection assign=variantTypes controller=productVariantType productId=$product->Id}
{$variantSize = $variantTypes->getActualSize()}

{$variantImageWidth = 56}
{$variantImageHeight = 56}

{placeholdImage assign=placeholder width=$variantImageWidth height=$variantImageHeight background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}
{$defaultImage = $placeholder->thumbnail($variantImageWidth, $variantImageHeight, false, $template.watermark)|solutionPath}

<div data-variant="dropdown" class="flex flex-col gap-4 xl:gap-6 print:hidden">

    <input type="hidden" data-variant="input" data-controller="input" name="product[{$product->Id}][variant]" value="">

    <div class="px-6 xl:px-8 py-4 xl:py-6 bg-[#f9f9f9] rounded flex flex-col gap-4 xl:gap-6">
        {foreach $variantTypes->getData() as $variantType key=x}

            {collection assign=variantDatas controller=productVariantData productId=$product->Id typeId=$variantType->Id}
            
            <div class="group" id="m-product-dropdown-type-{$variantType->Id}" data-variantType="dropdown" data-variantTypeId="{$variantType->Id}">
                <span class="block text-lg xl:text-xl font-bold mb-3 xl:mb-5">{$variantType->Title}</span>
                <div>
                    <div class="w-full relative">
                        <div class="w-full h-auto overflow-hidden" data-variantlist="dropdown">
                            {foreach $variantDatas->getData() as $variantData key=i}

                                {entity assign=productVariantData controller=productVariant productId=$product->Id dataIds=$variantData->Id}
                                {$fileId = $productVariantData->FileId}

                                {entity assign=productVariantImage controller=files productId=$productId type=product id=$fileId}

                                <div data-variantData="dropdown" data-variantDataId="{$variantData->Id}" class="mb-2{if $i >= 5} !hidden{/if} group-[.active]:!block [&.disabled]:opacity-30 [&.disabled]:pointer-events-none">
                                    <label class="flex bg-white gap-4 cursor-pointer rounded hover:bg-[#edebe6] transition-colors [&.selected]:bg-[#edebe6]">
                                        <input type="radio" name="{$variantType->Title}" value="{$variantData->Id}" id="variant_type_{$variantType@index}_{$variantData@index}" hidden>
                                        <span class="w-12 p-[2px] flex-none">
                                            <span class="bg-white">
                                                {if !$productVariantImage}
                                                    <span class="w-full h-auto aspect-square block"></span>
                                                {else}
                                                    {$productVariantImage = $productVariantImage->thumbnail(56,56)|solutionPath}
                                                    <img src="{$productVariantImage}" alt="" width="56" height="56" class="w-full h-auto aspect-square object-cover" />
                                                {/if}
                                            </span>
                                        </span>
                                        <span class="flex-auto flex items-center text-sm">{$variantData->Title}</span>
                                    </label>
                                </div>

                            {/foreach}
                        </div>
                        {if $variantDatas->getActualSize() gt 5}
                            <div class="w-full text-center py-4 cursor-pointer" data-variant="seemore">
                                {$text.CHECKOUT_WIDGET_SHOW_MORE}
                            </div>
                        {/if}
                    </div>
                </div>
            </div>

        {/foreach}
    </div>

</div>

{if $page.url|strstr:'?variantId='}
    <a href="{$page.request}" class="mt-6 px-5 h-10 bg-black text-white hover:text-white text-sm rounded flex items-center w-fit">{$text.PRODUCT_CATALOG_PRODUCT_PRESELECT_RESET_BUTTON}</a>
{/if}

{* Addon *}
{include file='modules/product/partials/entity-addon.tpl' product=$product}

<div data-product="variantinfo" style="display: none;" class="print:hidden">

    <div class="my-6">

        <div class="flex items-center gap-2 font-bold" style="display: none;" data-product="variantinfo-outofstock">
            <span class="w-3 h-3 rounded-full bg-red-500 flex-none"></span>
            <span class="text-sm">{$text.PRODUCT_CATALOG_STOCK_NOT_HOME}</span>
        </div>

        <div class="flex items-center gap-2 font-bold" style="display: none;" data-product="variantinfo-instock">
            <span class="w-3 h-3 rounded-full bg-green-600 flex-none"></span>
            <span class="text-sm">{$text.PRODUCT_CATALOG_STOCK_HOME}</span>
        </div>

    </div>

</div>
    
{if $variantSize gt 0}
    
    {*** Include product actions; buy and amount ***}
    {if $product->Type!=='discontinued'}
        {include file="modules/product/partials/entity-actions.tpl" product=$product inputName="product[{$product->Id}][amount]" inputValue=$product->MinAmount data="data-variant='amount'" disabled=true buttonText=$text.PRODUCT_CATALOG_PRODUCT_CHOOSE_VARIANT buttonTextDefault=$text.PRODUCT_CATALOG_PRODUCT_ADD_TO_CART}
    {/if}
    
{/if}