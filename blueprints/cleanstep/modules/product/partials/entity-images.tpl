{*** Fetch the filesController and save it for later ***}
{controller type=files assign=imageController}

{if isset($smarty.get.variantId)}
    {collection assign=variantImages controller=$imageController type=variant variantId=(int)$smarty.get.variantId}
    {entity assign=firstItem controller=$imageController type=variant variantId=(int)$smarty.get.variantId}
{/if}

{if isset($variantImages) and $variantImages->getActualSize() gt 0}
    {$items = $variantImages}
{else}
    {collection assign=items controller=$imageController type=product productId=$item->Id}
    {entity assign=firstItem controller=$imageController type=product productId=$item->Id}
{/if}

{if $firstItem}
    <img src="{$firstItem->thumbnail(590,590)}" width="1000" height="1000" class="w-full h-auto hidden print:block">
{/if}

{$product = $item}

{* Placeholder image *}
{placeholdImage assign=placeholder width=590 height=590 background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}
{$defaultImage = $placeholder->thumbnail(null, null, false, $template.watermark)|solutionPath}

{if $items->getActualSize() gt 0}

    <div class="flex flex-col-reverse md:flex-row gap-4">

        {if $items->getActualSize() gt 1}
            <div class="w-full flex-auto md:w-28 md:flex-none">
                <div class="swiper h-auto" data-product="thumbs">
                    <div class="swiper-wrapper">
                        {foreach $items->getData() as $item}
                            {$imageSrc = $item->thumbnail(96, 96)|solutionPath}
                            <div class="swiper-slide h-auto group cursor-pointer">
                                <img src="{$imageSrc}" width="96" height="96" alt="{$product->Title}" class="w-full h-auto object-scale-down aspect-square border border-gray-200 p-1 lg:p-2 rounded md:mb-4 md:group-last:mb-0">
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        {/if}

        <div class="flex-auto min-w-0 relative">
            
            {* Labels *}
            {include file='modules/product/partials/entity-labels.tpl'}

            <div class="swiper" data-product="images">
                <div class="swiper-wrapper">
                    {foreach $items->getData() as $item}
                        {$imageSrc = $item->thumbnail(590, 590)|solutionPath}
                        <div class="swiper-slide">
                            <img src="{$imageSrc}" width="590" height="590" alt="{$product->Title}" class="w-full h-auto object-scale-down aspect-square" itemprop="image">
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>

    </div>

{elseif isset($defaultImage)}
    <div class="w-full relative">
        
        {* Labels *}
        {include file='modules/product/partials/entity-labels.tpl'}

        <img src="{$defaultImage}" width="590" height="590" alt="{$product->Title}" class="w-full h-auto" itemprop="image">
    </div>
{/if}