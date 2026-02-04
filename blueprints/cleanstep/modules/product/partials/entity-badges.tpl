{if $settings.show_product_icons && $product->Type ne 'discontinued'}
    <div class="absolute z-10 top-0 left-0 w-full flex flex-wrap justify-end gap-1 xl:gap-2 p-2 xl:p-4">
        {*** NEW icon if newer than 30 days ***}
        {if $product->Age lt 2592000}
            <span class="p-1 xl:py-2 xl:px-3 leading-none rounded bg-black-600 text-white text-xs xl:text-sm">{$text.NEWS}</span>
        {/if}

        {*** DISCOUNT icon if discount it active ***}
        {if !$product->CallForPrice and $priceInterval->PriceMin < $priceInterval->FullPriceMin}
            {$savingsPercentage = ($priceInterval->FullPriceMin - $priceInterval->PriceMin) / $priceInterval->FullPriceMin * 100}
            {$savingsPercentage = $savingsPercentage|number_format:0}
            <span class="p-1 xl:py-2 xl:px-3 leading-none rounded bg-orange-600 text-white text-xs xl:text-sm">Spar {$savingsPercentage}%</span>
        {/if}

        {*** SOLD OUT icon if not in stock ***}
        {if ($product->Soldout || $variant && $variant->Soldout) and !$product->AllowOutOfStockPurchase}
            <span class="p-1 xl:py-2 xl:px-3 leading-none rounded bg-orange-600 text-white text-xs xl:text-sm">{$text.SOLD_OUT}</span>
        {/if}
    </div>
{/if}
