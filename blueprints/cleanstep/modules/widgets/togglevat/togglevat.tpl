{$vat = $currency.hasVat}

{if $type == "small"}
    <div class="hidden flex-none sm:flex flex-col border border-gray-400 bg-white rounded-md overflow-hidden" data-vat="toggle">
        <button class="px-2 py-1 flex flex-col items-center leading-none gap-1 text-gray-700 hover:underline [&.active]:bg-green-100 [&.active]:pointer-events-none {if !$vat}active{/if} border-b border-gray-400" data-vat="no_vat">
            <span class="text-xs">{$text.CUSTOMER_TYPE_COMPANY}</span>
        </button>
        <button class="px-2 py-1 flex flex-col items-center leading-none gap-1 text-gray-700 hover:underline [&.active]:bg-green-100 [&.active]:pointer-events-none {if $vat}active{/if}" data-vat="vat">
            <span class="text-xs">{$text.CUSTOMER_TYPE_PRIVATE}</span>
        </button>
    </div>
{else}
    <div class="flex border border-gray-400 bg-white rounded-md overflow-hidden" data-vat="toggle">
        <button class="px-2 py-2 flex flex-col items-start leading-none gap-0.5 text-gray-700 hover:underline [&.active]:bg-green-100 [&.active]:pointer-events-none {if !$vat}active{/if} border-r border-gray-400" data-vat="no_vat">
            <span class="text-xs">{$text.CUSTOMER_TYPE_COMPANY}</span>
            <span class="text-[10px] text-gray-500">{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO_CLEAN}</span>
        </button>
        <button class="px-2 py-2 flex flex-col items-start leading-none gap-0.5 text-gray-700 hover:underline [&.active]:bg-green-100 [&.active]:pointer-events-none {if $vat}active{/if}" data-vat="vat">
            <span class="text-xs">{$text.CUSTOMER_TYPE_PRIVATE}</span>
            <span class="text-[10px] text-gray-500">{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_CLEAN}</span>
        </button>
    </div>
{/if}