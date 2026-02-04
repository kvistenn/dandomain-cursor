<div class="group">
<input type="checkbox" class="peer" id="toggleLastSeen" hidden />
<div class="fixed top-0 right-0 w-60 h-full z-50 translate-x-100% transition-transform peer-checked:translate-x-0"> 
  <label for="toggleLastSeen" class="absolute bottom-[25dvh] left-0 w-16 h-16 flex flex-col items-center justify-center bg-black -translate-x-100% cursor-pointer rounded-l text-white">
  {if $smarty.cookies.lastseen !== null} 
    <span class="absolute top-0 left-0 bg-black border-2 border-white text-grey flex items-center justify-center text-2xs font-semibold -translate-x-40% -translate-y-40% rounded-full w-5 h-5">{','|explode:$smarty.cookies.lastseen|@count}</span>
{/if}
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" class="flex-none w-6 h-auto">
      <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
      <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
    </svg>
    <small class="uppercase text-2xs text-white font-semibold">{$text.LAST_SEEN}</small>
  </label>

  <div class="w-60 flex-none h-full bg-white pt-5 px-5 text-white overflow-y-auto shadow-lg">
    {if $smarty.cookies.lastseen !== null}

      {$items = ','|explode:$smarty.cookies.lastseen}

      {foreach $items as $itemId}

        {entity assign=item controller=product id=$itemId}
        {entity assign=productImage controller=files type=product productId=$itemId}
        {* {entity assign=priceLine controller=priceLine productId=$itemId} *}
        {placeholdImage assign=placeholder width=170 height=170 background='#F9F6F4' color='#000000' text=$text.IMAGE_PLACEHOLDER_TEXT}

        {$productLink = ProductController::link($item->Id, false, $item)}

        <div class="flex flex-col bg-white border-t border-l border-r border-gray-200 p-4 relative last:border-b">

          {* Picture *}
          {if $productImage}
              {$image = $productImage->thumbnail(170, 170)|solutionPath}
          {else}
              {$image = $placeholder->getRelativeFile()|solutionPath}
          {/if}

          <figure class="w-full aspect-square flex-none rounded mb-2">
            <a href="{$productLink}" title="{$item->Title}">
              <img src="{$image}" width="170" height="170" alt="" loading="lazy" class="w-full h-full object-cover p-3" />
            </a>
          </figure>
            <strong class="block text-sm font-bold line-clamp-2 leading-none text-black mb-1"><a href="{$productLink}">{$item->Title}</a></strong>
            {if $item->Prices[0]->FullPriceMax > $item->Prices[0]->PriceMax}
              <p class="text-xs text-black line-through">{$item->Prices[0]->FullPriceMax|formatPrice}</p>
            {/if}
            <p class="text-sm text-black">{$item->Prices[0]->PriceMax|formatPrice}</p>
        </div>

      {/foreach}

    {else}
      <p style="text-align:center">Produkter vises her</p>
    {/if}
  </div>

</div>
</div>
