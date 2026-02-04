{*

# Description
Template partial for product page type, to display stock information based on product and product settings.


## Date last modified
2018-03-21


## Primary variables
+ $productController                                                    - Instance of productController
+ $product                                                              - Entity of productController (the current product)
+ $variantController                                                    - Instance of productVariantController
+ $hasAdditionals                                                       - Boolean telling if product has additional products
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ no partials

*}

{if $product->Type == "variant"}

    <div class="flex items-center gap-2" data-controller="nostock" style="display: none;">
        {if $settings.shop_product_delivery_time === "texticon"}
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4 text-red-600">
                <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14ZM8 4a.75.75 0 0 1 .75.75v3a.75.75 0 0 1-1.5 0v-3A.75.75 0 0 1 8 4Zm0 8a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" clip-rule="evenodd" />
            </svg>
        {/if}
        <span class="text-sm" data-controller="stocktext">{$text.PRODUCT_CATALOG_STOCK_NOT_HOME}</span>
    </div>

    <div class="flex items-center gap-2" data-controller="onstock" style="display: none;">
        {if "texticon" === $settings.shop_product_delivery_time}
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4 text-green-600">
                <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14Zm3.844-8.791a.75.75 0 0 0-1.188-.918l-3.7 4.79-1.649-1.833a.75.75 0 1 0-1.114 1.004l2.25 2.5a.75.75 0 0 0 1.15-.043l4.25-5.5Z" clip-rule="evenodd" />
            </svg>
        {/if}
        <span class="text-sm" data-controller="stocktext">{$text.PRODUCT_CATALOG_STOCK_HOME}</span>
    </div>

{else}

    {if $item->Soldout and $settings.shop_product_delivery_time}

        {*** Stock status for the product (NoStock) ***}
        <div class="flex items-center gap-2">
            {if $settings.shop_product_delivery_time === "texticon"}
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4 text-red-600">
                    <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14ZM8 4a.75.75 0 0 1 .75.75v3a.75.75 0 0 1-1.5 0v-3A.75.75 0 0 1 8 4Zm0 8a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" clip-rule="evenodd" />
                </svg>
            {/if}

            <span class="text-sm">
                {if $item->DeliveryTimeId <= 0}
                    {$text.PRODUCT_CATALOG_STOCK_NOT_HOME}
                {else}
                    {translation id=$item->DeliveryTimeId module='delivery_time' title='title_no_stock'}
                {/if}
            </span>
        </div>

    {/if}

    {if !$item->Soldout and $settings.shop_product_delivery_time}
        {*** Stock status for the product (OnStock) ***}
        <div class="flex items-center gap-2">

            {if "texticon" === $settings.shop_product_delivery_time}
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4 text-green-600">
                    <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14Zm3.844-8.791a.75.75 0 0 0-1.188-.918l-3.7 4.79-1.649-1.833a.75.75 0 1 0-1.114 1.004l2.25 2.5a.75.75 0 0 0 1.15-.043l4.25-5.5Z" clip-rule="evenodd" />
                </svg>
            {/if}

            <span class="text-sm">
                {if $item->DeliveryTimeId === 0}
                    {if $item->Type !== "packet"}
                        {$item->Stock - $item->StockReservation} {translation id=$item->UnitId module='unit' title='title'}
                    {/if}
                    {$text.PRODUCT_CATALOG_STOCK_HOME|lower}
                {else if $item->DeliveryTimeId === -1}
                    {$text.PRODUCT_CATALOG_STOCK_HOME}
                {else}
                    {translation id=$item->DeliveryTimeId module='delivery_time' title='title_on_stock'}
                {/if}
            </span>
        </div>
    {/if}

{/if}