{* Preload related entities to optimize load times *}
{include file='modules/product/product-entity-preload.tpl' scope=parent}

{*** Setup some collections and controllers we need later ***}

{* Variant controller *}
{controller assign=variantController type=productVariant}

{* Master title *}
{$title = $item->Title}

{* Has preselected variant *}
{$hasVariant = false}

{if isset($smarty.get.variantId)}

    {* Get the variant based on GET param *}
    {entity assign=variant controller=productVariant productId=$item->Id variantId=(int)$smarty.get.variantId}

    {* Get the variant price *}
    {collection assign=prices controller=productPrice productId=$item->Id variantId=(int)$smarty.get.variantId}

    {if $variant}
        {$hasVariant = true}

        {collection assign=variantTypes controller=productVariantType productId=$item->Id}

        {foreach $variantTypes->getData() as $variantType}
            {entity assign=variantData controller=productVariantData productId=$item->Id variantId=$variant->Id typeId=$variantType->Id}
            {$title = "$title `$variantData->Title`"}
        {/foreach}
    {/if}
{else}
    {* Product price data *}
    {collection assign=prices controller=productPrice productId=$item->Id}
{/if}

{* Priceintervals *}
{$priceData = $prices->getData()}
{$priceInterval = $priceData[0]}

{addMeta property="product:product_link" content=$page.url}

{* Product additionals *}
{collection assign=additionals controller=productAdditionalType productId=$item->Id}

{* Has additionals *}
{$hasAdditionals = false}
{if $additionals->getActualSize() > 0}
    {$hasAdditionals = true}
{/if}

{* Placeholder image *}
{placeholdImage assign=placeholder width=400 height=400 background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

<div class="product" data-id="{$item->Id}" itemscope itemtype="http://schema.org/Product" data-controller="{$item->Id}">

    {if $hasVariant && !empty($variant->Ean)}
        {addMeta property="product:ean" content=$variant->Ean}
        <meta itemtype="http://schema.org/gtin" itemprop="gtin" content="{$variant->Ean}">
    {elseif !empty($item->Ean)}
        {addMeta property="product:ean" content=$item->Ean}
        <meta itemtype="http://schema.org/gtin" itemprop="gtin" content="{$item->Ean}">
    {/if}

    {if $category && $category->Title}
        <meta itemprop="category" content="{$category->Title}">
    {/if}

    {if $googleCategoryId = $controller->googleCategory($product->Id)}
        {addMeta property="product:category" content=$googleCategoryId}
    {/if}

    {* Product number *}
    {if $settings.shop_product_number}
        {$sku = $item->ItemNumber}
        {if $hasVariant && !empty($variant->ItemNumber)}
            {$sku = $variant->ItemNumber}
        {/if}
        {if !empty($sku)}
            <meta itemprop="sku" content="{$sku}">
        {/if}
    {/if}

    {if !in_array($item->Type, ['variant','discontinued'])}
        {if $settings.shop_product_weight and !empty($item->Weight) and $item->Weight !== 0}
            {addMeta property="product:weight:value" content=$item->Weight}
            {addMeta property="product:weight:units" content="kg"}
        {/if}
    {/if}

    <form action="/actions/cart/add" method="post" name="cartadd" data-form="ajax">

        <div class="flex flex-col lg:flex-row gap-4 lg:gap-6">

            <!-- Product image -->
            <div class="w-full lg:w-1/2 lg:flex-none relative">

                {* Badges *}
                {include file='modules/product/partials/entity-badges.tpl'}

                {* Images *}
                {include file='modules/product/partials/entity-images.tpl'}

            </div>

            <!-- Product details -->
            <div class="w-full flex-auto min-w-0">

                {* Brand for the product *}
                {if $item->ProducerId}

                    {entity assign=brand controller=brand id=$item->ProducerId}
                    {if !empty($brand)}
                        
                        {addMeta property="product:brand" content=$brand->Title}
                        {$brandLink = "/{$page.paths.0}/?brand={$brand->Id}-{$brand->Title|formatLink}"}
                        
                        <div class="m-product-brand" itemprop="brand" itemscope itemtype="http://schema.org/Brand">
                            <a itemprop="url" href="{$brandLink}" title="{$text.PRODUCT_CATALOG_BRAND}: {$brand->Title}">
                                <strong class="text-sm tracking-wider" itemprop="name">{$brand->Title}</strong>
                            </a>
                        </div>
                    {/if}
                {/if}

                {* Title *}
                <header class="my-4">
                    <h1 class="text-xl md:text-2xl lg:text-4xl" itemprop="name">{$title}</h1>
                </header>

                {* Quick rating *}
                {if $settings.module_shop_review_products_type !== "comment" and $settings.module_shop_review_products and $access.reviews}
                    {include file="modules/product/partials/entity-reviews-stars.tpl" type="quick-rating" product=$item}
                {/if}

                {* Short description *}
                {$shortDescription = $controller->getDescriptionShort($item->Id)}
                {if !empty($shortDescription)}
                    <div class="prose max-w-full mt-4 text-sm leading-6" data-controller="shortdescription">
                        {$shortDescription}
                    </div>
                {/if}

                {* Prices *}
                {include file='modules/product/partials/entity-prices.tpl' prices=$prices priceInterval=$priceInterval hasVariant=$hasVariant variant=$variant specialPrice=$specialPrice}

                {* Delivery limit *}
                {if $settings.cart_show_delivery_estimate eq true && !$user->IsB2B}
                    <div class="mb-6">
                        {include file='modules/widgets/ajaxcart/ajaxdelivery.tpl'}
                    </div>
                {/if}

                <!-- Countdown timer -->
                <div id="bp_countdown_173"></div>

                <style>
                    .bp_countdown_173.bp_countdown_message_banner {
                        margin: 0 !important;
                    }
                    .bp_countdown_message_banner {
                        border: 1px solid #e6e6e6;
                        border-radius: 0.25rem;
                        padding: 0.75rem 1.5rem !important;
                        justify-content: center;
                        text-align: center;
                    }
                    .bp_countdown_product_countdown_wrapper {
                        justify-content: flex-end;
                    }
                    .bp_countdown_product_prefix_text,
                    .bp_countdown_product_shared_span,
                    .bp_countdown_product_dispatch_shared_unit_span {
                        font-size: 14px !important;
                    }
                    .bp_countdown_product_dispatch_shared_unit_span {
                        text-transform: lowercase;
                    }
                </style>

                {* Actions *}
                {if !$showSoldOut and !in_array($item->Type, ['variant','packet','discontinued']) and !$hasAdditionals}
                    {include file="modules/product/partials/entity-actions.tpl" product=$item inputName="product[{$item->Id}][amount]" inputValue=$item->MinAmount unitTitle=$item->UnitTitle}
                {/if}

                {* Variant *}
                {if !$showSoldOut and in_array($item->Type, ['variant'])}
                    {include file="modules/product/partials/entity-variants.tpl" productController=$controller variantController=$variantController product=$item  hasAdditionals=$hasAdditionals}
                {/if}

                {* Extra buy *}
                {include file="modules/product/partials/entity-extrabuy.tpl" product=$product productController=$controller}

                <div class="flex justify-between items-center my-6">
                    <div>
                        {* Item number *}
                        {if !empty($item->ItemNumber) and $settings.shop_product_number}
                            <div class="flex items-center gap-2 text-sm font-bold">
                                <span>{$text.PRODUCT_CATALOG_PRODUCT_NUMBER}</span>
                                <span data-controller="itemnumber">{$item->ItemNumber}</span>
                            </div>
                        {/if}

                        {* Stock *}
                        {if !in_array($item->Type, ['packet','discontinued'])}
                            <div class="mt-4">
                                {include file="modules/product/partials/entity-stock.tpl"}
                            </div>
                        {/if}
                    </div>

                    <div>

                        {*** Collection entity of the files controller ***}
                        {collection assign=productPdfs controller=files type=productPdf id=$product->Id}
                        
                        {if $productPdfs->getActualSize() gt 0}
                            <div class="flex flex-wrap gap-2 justify-end">
                                {foreach $productPdfs->getData() as $productPdf key=x}
                                    <a href="{$productPdf->getRelativeFile()}" target="_blank" rel="noopener" class="flex items-center gap-1 text-sm border border-gray-200 rounded px-3 py-2 hover:bg-gray-100 hover:border-gray-300 transition-colors">
                                        <svg xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 24 24" width="16" height="16">
                                            <path d="M20.1,5.39l-3.49-3.49c-1.23-1.23-2.86-1.9-4.6-1.9H6.5C4.02,0,2,2.02,2,4.5v15c0,2.48,2.02,4.5,4.5,4.5h11c2.48,0,4.5-2.02,4.5-4.5V9.99c0-1.74-.68-3.37-1.9-4.6Zm-.71,.71c.55,.55,.97,1.2,1.24,1.9h-5.13c-.83,0-1.5-.67-1.5-1.5V1.37c.71,.27,1.35,.69,1.9,1.24l3.49,3.49Zm1.61,13.4c0,1.93-1.57,3.5-3.5,3.5H6.5c-1.93,0-3.5-1.57-3.5-3.5V4.5c0-1.93,1.57-3.5,3.5-3.5h5.51c.33,0,.66,.03,.99,.09V6.5c0,1.38,1.12,2.5,2.5,2.5h5.41c.06,.32,.09,.65,.09,.99v9.51ZM6.97,13h-.97c-.55,0-1,.45-1,1v4.5c0,.28,.22,.5,.5,.5s.5-.22,.5-.5v-1.5h.97c1.11,0,2.01-.92,2.01-2.02s-.9-1.98-2.01-1.98Zm0,3h-.97v-2h.97c.56,0,1.01,.44,1.01,.98s-.46,1.02-1.01,1.02Zm5.03-3h0s-.51,0-1,0c-.55,0-1,.45-1,1v4c0,.55,.45,1,1,1,.48,0,.97,0,1,0h0c1.11,0,2-.89,2-1.98v-2.03c0-1.09-.89-1.98-2-1.98Zm1,4.02c0,.53-.43,.96-.96,.98h-1.04v-4h1.04c.53,.02,.96,.46,.96,.98v2.03Zm6-3.52c0,.28-.22,.5-.5,.5h-2.5v2s1.5,0,1.5,0c.28,0,.5,.22,.5,.5s-.22,.5-.5,.5h-1.5v1.5c0,.28-.22,.5-.5,.5s-.5-.22-.5-.5v-4.5c0-.55,.45-1,1-1h2.5c.28,0,.5,.22,.5,.5Z"/>
                                        </svg>
                                        {if $x eq 0}
                                            <span>{$text.TEC_DOC_TITLE_1}</span>
                                        {elseif $x eq 1}
                                            <span>{$text.TEC_DOC_TITLE_2}</span>
                                        {elseif $x eq 2}
                                            <span>{$text.TEC_DOC_TITLE_3}</span>
                                        {/if}
                                    </a>
                                {/foreach}
                            </div>
                        {/if}
                    </div>
                </div>

                {* Description *}
                {$description = $controller->getDescriptionList($item->Id)}
                {if !empty($description)}
                    <div class="mt-6 border-y border-gray-200" data-accordion="container">
                        <div class="py-4 flex justify-between items-center cursor-pointer group" data-accordion="title">
                            <strong>{$text.DESCRIPTION}</strong>
                            <span>
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 flex-none group-[&.active]:rotate-180 transition-transform duration-200">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                                </svg>              
                            </span>
                        </div>
                        <div class="mb-4" data-accordion="content">
                            <div class="prose max-w-full text-sm [&_h2]:text-lg leading-6" itemprop="description" data-controller="description">
                                {$description}
                            </div>
                        </div>
                    </div>
                {/if}

            </div>

        </div>

    </form>

</div>

{* Product related *}
{if $settings.product_related !== false and $access.relatedProducts}
    {collection assign=relatedProducts controller=productRelated productId=$item->Id orderBy='Sorting,-Sold,Title'}
    {if $settings.product_related !== "chosen" and $relatedProducts->getActualSize() === 0}
        {collection assign=relatedProducts controller=productList categoryId=$item->CategoryId ignoreProductId=$item->Id orderBy='Sorting,-Sold,Title' pageSize=10}
    {/if}
    {if $relatedProducts->getActualSize() gt 0}
        
        {$pageLink = PageController::link($page.productPageId)}

        <div class="mt-6 lg:mt-12">
            <div class="flex items-center justify-between gap-4 mt-6">
                <strong class="text-2xl font-bold block mb-6">{$text.PRODUCT_CATALOG_RELATED_HEADLINE}</strong>
                <a href="{$pageLink}{$item->CategoryId}/" class="text-sm text-gray-500 hover:text-gray-700 flex items-center gap-1">
                    {$text.CART_SHOW_ALL_PRODUCTS}
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4 flex-none">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                    </svg>
                </a>
            </div>
            {include file='modules/product/product-slider.tpl' field="id" id="{","|implode:$relatedProducts->pluck('Id')}" slides=7}
        </div>
    {/if}
{/if}

{* HelloRetail: Related *}
<div class="mt-6 lg:mt-12">
    <div id="hr-recom-k68875a619c99e26ba24b310d"></div>
</div>

{* HelloRetail: Bought together with *}
<div class="mt-6 lg:mt-12">
    <div id="hr-recom-k68875a619c99e26ba24b310a"></div>
</div>