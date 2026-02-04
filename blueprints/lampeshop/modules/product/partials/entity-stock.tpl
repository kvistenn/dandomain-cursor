{if $item->Stock <= 0}
    <div class="flex items-center gap-2 font-bold">
        <span class="w-3 h-3 rounded-full bg-red-500 flex-none"></span>
        <span class="text-sm">
            {if $item->DeliveryTimeId <= 0}
                {$text.PRODUCT_CATALOG_STOCK_NOT_HOME}
            {else}
                {translation id=$item->DeliveryTimeId module='delivery_time' title='title_no_stock'}
            {/if}
        </span>
    </div>
{else}
    <div class="flex items-center gap-2 font-bold">
        <span class="w-3 h-3 rounded-full bg-green-600 flex-none"></span>
        <span class="text-sm">
            {if $item->DeliveryTimeId === 0}
                <div class="flex items-center gap-2">
                    {if $item->Type !== "packet"}
                        <div class="flex items-center gap-2">
                            <span>{$item->Stock - $item->StockReservation}</span> <span>{translation id=$item->UnitId module='unit' title='title'}</span>
                        </div>
                    {/if}
                    <span>{$text.PRODUCT_CATALOG_STOCK_HOME|lower}</span>
                </div>
            {else if $item->DeliveryTimeId === -1}
                {$text.PRODUCT_CATALOG_STOCK_HOME}
            {else}
                {translation id=$item->DeliveryTimeId module='delivery_time' title='title_on_stock'}
            {/if}
        </span>
    </div>
{/if}