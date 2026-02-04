<div itemscope itemprop="offers" itemtype="http://schema.org/Offer" class="my-6">

    {literal}
        <script id="render-prices" type="text/x-jsrender">
            <li class="border-t border-gray-200 py-2 flex items-center gap-2 text-xs last:border-b leading-none group first:border-t-0 first:items-end first:text-base first:pb-4 first:flex-wrap" data-amount="{{:Amount}}" data-price="{{:PriceMin}}">
                <span class="group-first:hidden">{{:~text('PRODUCT_CATALOG_PRICE_FOR')}} {{:Amount}} {{:~unitTitle}}</span>
                <div class="flex items-center gap-2">
                    <span class="ml-auto group-first:ml-0 group-first:text-2xl group-first:text-primary group-first:font-bold">
                        {{if Amount == 1 && ~calculatedPrice}}
                            {{:~currency(~calculatedPrice)}}
                        {{else}}
                            {{:~currency(PriceMin)}}
                        {{/if}}
                    </span>
                    {{if ~specialPrice && Amount == 1}}
                        <span class="w-6 h-6 flex items-center justify-center rounded-full bg-primary" title="{{:~text('UNIQUE_PRICE_DEAL')}}">
                            <img src="{{:~template.path}}/assets/images/hand-shake.png" width="20" height="20" />
                        </span>
                    {{/if}}
                </div>
                {{if PriceMin < FullPriceMin}}
                    <span><s>{{:~currency(FullPriceMin)}}</s></span>
                {{/if}}
                {{if ~settings.shop_product_tax_after_price}}
                    {{if ~hasVatIncludedLabel}}
                        <span class="text-xs w-full flex-none hidden group-first:block">{{:~text('PRODUCT_CATALOG_PRODUCT_PRICE_TAX')}}</span>
                    {{else}}
                        <span class="text-xs w-full flex-none hidden group-first:block">{{:~text('PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO')}}</span>
                    {{/if}}
                {{/if}}
            </li>
        </script>
    {/literal}

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
        <div class="m-product-offers">
            <meta itemprop="priceCurrency" content="{$general.currencyIso}">
            {addMeta property="product:price:currency" content=$general.currencyIso}

            <meta itemprop="price" content="100">
            {addMeta property="product:price:amount" content='100'}
        </div>
    {/if}

    {*** Product is discontinued ***}
    {if $item->Type === "discontinued" or $showSoldOut}
        {if $item->Type === "discontinued"}
            <div>{$text.CART_PRODUCT_DEAD_NOTE}</div>
        {/if}
        {if $showSoldOut}
            <div>{$text.PRODUCT_CATALOG_PRODUCT_SOLDOUT}</div>
        {/if}
    {/if}

    {* B2B: Login to order *}
    {if $item->Type !== 'discontinued' and (($settings.shop_b2b_hidden_prices === 'partly' and !$user) or ($settings.shop_b2b_hidden_prices and !$user) or $item->CallForPrice)}
        <div>
            {if !$user}
                {if $settings.shop_b2b_hidden_prices === 'partly'}
                    <div>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_B2B_PARTLY}</div>
                {/if}

                {if $settings.shop_b2b_hidden_prices === true}
                    <div>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_B2B_PARTLY}</div>
                {/if}
            {/if}

            {if $item->CallForPrice}
                <div>{$text.PRODUCT_CATALOG_CALL_FOR_PRICE}</div>
            {/if}
        </div>
    {/if}

    {* Prices *}
    {if !in_array($item->Type, ["giftcard", "codegiftcard"]) and (((!$settings.shop_b2b_hidden_prices or $user) or $settings.shop_b2b_hidden_prices === "partly") and $item->Type !== 'discontinued')}
        
        <meta itemprop="priceCurrency" content="{$general.currencyIso}">
        {addMeta property="product:price:currency" content=$general.currencyIso}

        {*** Hide price, if item is a call for price item ***}
        {if !$item->CallForPrice}

            {$hasVatIncludedLabel = false}
            {$pricesCount = $prices->getActualSize()}

            {if $priceInterval}
                {$hasVatIncludedLabel = $currency.hasVat and ($settings.vat_label_advanced eq false or $priceInterval->PriceMinWithVat gt $priceInterval->PriceMinWithoutVat)}
                <meta itemprop="price" content="{$priceInterval->PriceMin|formatPriceMeta}">
                {addMeta property="product:price:amount" content=$priceInterval->PriceMin|formatPriceMeta}
            {/if}

            <div id="prices"></div>

            {* Viabill price tag *}
            {include file="modules/widgets/integrations/viabill_pricetag.tpl" type="product" price=$priceDataInterval->PriceMin}

            {* Suggested retail price *}
            {if $item->GuidelinePrice gt 0}
            <p>
                <span class="m-product-price-suggested">{$text.PRODUCT_CATALOG_PRICE_LIST} {$item->GuidelinePrice|formatPrice}</span>
                {if $settings.shop_product_tax_after_price or (!$currency.hasVat and $settings.shop_product_lineprice_vat)}
                    {if $hasVatIncludedLabel or $settings.shop_product_lineprice_vat}
                        <span class="m-product-price-vat-text has-vat">{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                    {else}
                        <span class="m-product-price-vat-text has-novat">{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                    {/if}
                {/if}
            </p>
            {/if}

            <div class="m-product-extra trailing">
                {*** Fees ***}
                {if $shop.priceTerms}
                    <span class="is-block m-product-price-terms"><a data-fancybox="" href="#overlaypriceTerms">{$text.PRODUCT_CATALOG_SHOW_DELIVERY_LINK}</a></span>
                {/if}

                {*** Payment options ***}
                <span class="m-product-paymentoptions">
                    {include file="modules/product/partials/entity-paymentoptions.tpl" controller=$controller price=$priceData.0->PriceMin}
                </span>
            </div>
        {/if}
    {/if}
</div>