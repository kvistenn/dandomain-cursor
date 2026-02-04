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
    <img src="{$firstItem->thumbnail(1000,1000)}" width="1000" height="1000" class="w-full h-auto hidden print:block">
{/if}

{* Placeholder image *}
{placeholdImage assign=placeholder width=1000 height=1000 background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}
{$defaultImage = $placeholder->thumbnail(null, null, false, $template.watermark)|solutionPath}

{if $items->getActualSize() gt 0}

    {if $items->getActualSize() gt 1}
        <div class="relative">
            <div data-product="images" class="w-full print:hidden">
                {foreach $items->getData() as $item key=i}
                    {$imageSrc = $item->thumbnail(1000, 1000)|solutionPath}
                    <div data-fileid="{$item->Id}" class="relative">
                        {if $i == 0}
                            {include file='modules/product/partials/entity-badges-custom.tpl'}
                        {/if}
                        <a class="block" href="#" data-fancybox="group1" data-src="{$imageSrc}">
                            <img src="{$imageSrc}" width="1000" height="1000" alt="" class="w-full h-auto rounded" {if $i == 0}itemprop="image"{/if}>
                        </a>
                    </div>
                {/foreach}
            </div>
            
            <!-- Pricerunner -->
            {if $general.languageIso639 === 'da'}
                <img src="https://www.pricerunner.dk/widget/cheapest/image/74059?sku={$pricerunnerID}&width=200" alt="Billigst på PriceRunner" class="absolute bottom-0 left-0 max-w-full h-auto" />
            {/if}
        </div>

        {if $items->getActualSize() lt 6}
            <div data-product="thumbs" class="w-full grid grid-cols-3 md:grid-cols-5 gap-5 mt-5 print:hidden">
                {foreach $items->getData() as $item}
                    {$imageSrc = $item->thumbnail(400, 400)|solutionPath}
                    <div class="border border-gray-200 rounded overflow-hidden cursor-pointer leading-none">
                        <img src="{$imageSrc}" width="400" height="400" alt="" class="w-full aspect-square object-cover">
                    </div>
                {/foreach}
            </div>
        {else}
            <div data-product="thumbs" class="w-full mt-5 print:hidden">
                {foreach $items->getData() as $item}
                    {$imageSrc = $item->thumbnail(400, 400)|solutionPath}
                    <div class="border border-gray-200 rounded overflow-hidden cursor-pointer leading-none">
                        <img src="{$imageSrc}" width="400" height="400" alt="" class="w-full aspect-square object-cover">
                    </div>
                {/foreach}
            </div>
        {/if}

    {else}
        {foreach $items->getData() as $k => $item}
            {if $k eq 0}
                {$imageSrc = $item->thumbnail(1000, 1000)|solutionPath}
                <div class="w-full relative">
                    {include file='modules/product/partials/entity-badges-custom.tpl'}
                    <img src="{$imageSrc}" width="1000" height="1000" alt="" class="w-full h-auto rounded" itemprop="image">

                    <!-- Pricerunner -->
                    {if $general.languageIso639 === 'da'}
                        <img src="https://www.pricerunner.dk/widget/cheapest/image/74059?sku={$pricerunnerID}&width=200" alt="Billigst på PriceRunner" class="absolute bottom-0 left-0 max-w-full h-auto" />
                    {/if}
                </div>
            {/if}
        {/foreach}
    {/if}

{elseif isset($defaultImage)}
    <div class="w-full relative">
        {include file='modules/product/partials/entity-badges-custom.tpl'}
        <img src="{$defaultImage}" width="1000" height="1000" alt="" class="w-full h-auto rounded" itemprop="image">
        
        <!-- Pricerunner -->
        {if $general.languageIso639 === 'da'}
            <img src="https://www.pricerunner.dk/widget/cheapest/image/74059?sku={$pricerunnerID}&width=200" alt="Billigst på PriceRunner" class="absolute bottom-0 left-0 max-w-full h-auto" />
        {/if}
    </div>
{/if}