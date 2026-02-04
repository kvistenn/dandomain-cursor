{* Product prices *}
<div itemscope itemprop="offers" itemtype="http://schema.org/Offer" class="print:hidden">

    {*** General check if "Sold out" text should be shown ***}
    {$showSoldOut = ($item->Soldout and !$item->AllowOutOfStockPurchase)}

    {*** SEO Microdata ( has to be inside http://schema.org/Offer ) ***}
    <link itemprop="url" href="{$page.url}" />
    <meta itemprop="itemCondition" content="NewCondition">
    <meta itemprop="name" content="{$title}">

    {*** Check that the general setting of delivery_time is honored for microdata ***}
    {if $settings.shop_product_delivery_time}
        {if in_array($item->Type, ["giftcard","codegiftcard","filesale"])}
            <link itemprop="availability" href="http://schema.org/OnlineOnly" />
        {elseif $item->Type === "discontinued"}
            <link itemprop="availability" href="http://schema.org/Discontinued" />
        {elseif $showSoldOut}
            <link itemprop="availability" href="http://schema.org/OutOfStock" />
        {else}
            <link itemprop="availability" href="http://schema.org/InStock" />
        {/if}
    {/if}

    {if in_array($item->Type, ["giftcard","codegiftcard"]) && (((!$settings.shop_b2b_hidden_prices or $user) or $settings.shop_b2b_hidden_prices === "partly") and $item->Type !== 'discontinued')}
        <meta itemprop="priceCurrency" content="{$general.currencyIso}">
        {addMeta property="product:price:currency" content=$general.currencyIso}

        <meta itemprop="price" content="100">
        {addMeta property="product:price:amount" content='100'}
    {/if}

    {*** Product is discontinued ***}
    {if $item->Type === "discontinued" or $showSoldOut}
        <div class="mb-5 flex items-center gap-2 text-red-500">
            <span>
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                    stroke="currentColor" class="w-6 h-6">
                    <path stroke-linecap="round" stroke-linejoin="round"
                        d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
                </svg>
            </span>
            <span>
                {if $item->Type === "discontinued"}
                    {$text.CART_PRODUCT_DEAD_NOTE}
                {/if}
                {if $showSoldOut}
                    {$text.PRODUCT_CATALOG_PRODUCT_SOLDOUT}
                {/if}
            </span>
        </div>
    {/if}

    {* Display 'log in to order' if B2B login is not required for Product price display but required for purchace and a B2B user is not logged in *}
    {if $item->Type !== 'discontinued' and (($settings.shop_b2b_hidden_prices === 'partly' and !$user) or ($settings.shop_b2b_hidden_prices and !$user) or $item->CallForPrice)}
        <div>
            {if !$user}
                {if $settings.shop_b2b_hidden_prices === 'partly'}
                    <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_B2B_PARTLY}</span>
                {/if}

                {if $settings.shop_b2b_hidden_prices === true}
                    <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_B2B_PARTLY}</span>
                {/if}
            {/if}

            {if $item->CallForPrice}
                <span>{$text.PRODUCT_CATALOG_CALL_FOR_PRICE}</span>
            {/if}
        </div>
    {/if}

    {* Display price for product except for types giftcard and codegiftcard, taking into account user settings for b2b *}
    {if !in_array($item->Type, ["giftcard", "codegiftcard"]) and (((!$settings.shop_b2b_hidden_prices or $user) or $settings.shop_b2b_hidden_prices === "partly") and $item->Type !== 'discontinued')}

        <meta itemprop="priceCurrency" content="{$general.currencyIso}">
        {addMeta property="product:price:currency" content=$general.currencyIso}

        {if !$item->CallForPrice}

            <div class="flex flex-col" data-product="prices">

                {$hasVat = $currency.hasVat}
                {$hasVatIncludedLabel = false}

                {foreach $priceData as $priceDataInterval}

                    {if $priceDataInterval@iteration === 1}
                        {$hasVatIncludedLabel = $currency.hasVat and ($settings.vat_label_advanced eq false or $priceDataInterval->PriceMinWithVat gt $priceDataInterval->PriceMinWithoutVat)}
                        <meta itemprop="price" content="{$priceDataInterval->PriceMin|formatPriceMeta}">
                        {addMeta property="product:price:amount" content=$priceDataInterval->PriceMin|formatPriceMeta}
                    {/if}

                    {if $priceDataInterval@iteration === 1}

                        <div data-amount="{$priceDataInterval->Amount}">
                            {if $priceDataInterval->PriceMin lt $priceDataInterval->FullPriceMin}
                                <span data-price="discountpercentage" class="block w-fit px-2 py-1 text-xs uppercase tracking-wider bg-orange-500 text-white rounded mb-2">
                                    -{100 - (($priceDataInterval->PriceMin / $priceDataInterval->FullPriceMin) * 100)|round:0}%
                                </span>
                            {/if}
                            <div>
                                <strong data-price="price" class="text-base md:text-lg lg:text-xl xl:text-2xl 2xl:text-3xl">
                                    {if $priceDataInterval->PriceMin !== $priceDataInterval->PriceMax}
                                        <span class="text-sm font-normal block">{$text.PRODUCT_CATALOG_PRICE_FROM}</span>
                                    {/if}
                                    {$priceDataInterval->PriceMin|formatPrice}
                                </strong>
                                {* VAT *}
                                {if $settings.shop_product_tax_after_price}
                                    {if $hasVatIncludedLabel}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                                    {else}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                                    {/if}
                                {/if}
                            </div>
                            {if !$hasVat}
                                <div>
                                    <span data-price="price">
                                        {$priceDataInterval->PriceMinWithVat|formatPrice} <small>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</small>
                                    </span>
                                </div>
                            {/if}
                            {if $priceDataInterval->PriceMin < $priceDataInterval->FullPriceMin}
                                <s data-price="discount" class="text-xs md:text-base">
                                    {$priceDataInterval->FullPriceMin|formatPrice}
                                </s>
                            {/if}
                        </div>

                    {else}

                        <div data-amount="{$priceDataInterval->Amount}">
                            <div>
                                {if $prices->getActualSize() gt 1 or $priceDataInterval->Amount gt 1}
                                    <span>{$text.PRODUCT_CATALOG_PRICE_FOR} {$priceDataInterval->Amount}
                                        {$controller->getUnitTitle($item->UnitId)}</span>
                                {/if}
                            </div>
                            <div>
                                <span data-price="price">{$priceDataInterval->PriceMin|formatPrice}</span>
                                {if $priceDataInterval->PriceMin lt $priceDataInterval->FullPriceMin}
                                    <s>{$priceDataInterval->FullPriceMin|formatPrice}</s>
                                {/if}
                            </div>
                        </div>

                    {/if}

                {/foreach}

                {* Viabill price tag *}
                {include file="modules/widgets/integrations/viabill_pricetag.tpl" type="product" price=$priceDataInterval->PriceMin}

            </div>

            {* Suggested retail price *}
            {if $item->GuidelinePrice gt 0}
                <div>
                    <span>{$text.PRODUCT_CATALOG_PRICE_LIST} {$item->GuidelinePrice|formatPrice}</span>
                    {if $settings.shop_product_tax_after_price or (!$currency.hasVat and $settings.shop_product_lineprice_vat)}
                        {if $hasVatIncludedLabel or $settings.shop_product_lineprice_vat}
                            <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                        {else}
                            <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                        {/if}
                    {/if}
                </div>
            {/if}
        {/if}

    {/if}

</div>