{* Master title *}
{$title = $item->Title}

{* Has preselected variant *}
{$hasVariant = false}

{* Pricerunner ID *}
{$pricerunnerID = $item->Id}

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

    {$pricerunnerID = $pricerunnerID + "+" + $smarty.get.variantId}
{else}
    {* Product price data *}
    {collection assign=prices controller=productPrice productId=$item->Id}
{/if}

{* Priceintervals *}
{$priceData = $prices->getData()}
{$priceInterval = $priceData[0]}

{* Meta: product link *}
{addMeta property="product:product_link" content=$page.url}

{* Product additionals *}
{collection assign=additionals controller=productAdditionalType productId=$item->Id}

{* Has additionals *}
{$hasAdditionals = false}
{if $additionals->getActualSize() > 0}
    {$hasAdditionals = true}
{/if}

{* Custom fields *}
{collection assign=productCustomDataTypes controller=productCustomDataType productId=$item->Id}
{$customDataTypes = []}
{foreach $productCustomDataTypes->getData() as $customType}
    {$customData = []}
    {collection assign=productCustomData controller=productCustomData productId=$item->Id typeId=$customType->Id}
    {foreach $productCustomData->getData() as $customDataItem}
        {$customData[] = $customDataItem->Title}
    {/foreach}
    {$customDataTypes[$customType->Id] = ['Title' => $customType->Title, 'Data' => $customData]}
{/foreach}

<div itemscope itemtype="http://schema.org/Product" data-controller="{$item->Id}">
    <div class="flex flex-col lg:flex-row gap-6 lg:gap-16 my-6 md:my-10 lg:my-16 container mx-auto">

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

        <div class="flex-1 relative">

            {* Badges *}
            {include file='modules/product/partials/entity-badges.tpl'}

            {* Images *}
            {include file='modules/product/partials/entity-image.tpl'}
            
        </div>

        <form action="/actions/cart/add" method="post" name="cartadd" data-form="ajax" class="flex-1">

            <div class="lg:sticky lg:top-10 xl:top-12">

                {* Title *}
                <h1 class="font-bold text-[22px]" itemprop="name">{$title}</h1>

                {* Review stars *}
                {* {if $settings.module_shop_review_products_type !== "comment" and $settings.module_shop_review_products and $access.reviews} *}
                    <div class="mt-2">
                        {include file="modules/product/partials/entity-reviews-stars.tpl" product=$product type="quick-rating" reviewBtn=false}
                    </div>
                {* {/if} *}

                {* Prices *}
                <div class="mt-4 xl:mt-6">
                    {include file='modules/product/partials/entity-prices.tpl'}
                </div>

                {* Variants *}
                {if in_array($item->Type, ["variant"])}
                    <div class="mt-4 xl:mt-6">
                        {include file='modules/product/partials/entity-variants.tpl'}
                    </div>
                {/if}

                {* Addon *}
                {if !in_array($item->Type, ["variant"])}
                    {include file='modules/product/partials/entity-addon.tpl' product=$product}
                {/if}

                {* Stock *}
                {if !in_array($item->Type, ["variant"])}
                    <div class="mt-4 xl:mt-6">
                        {include file='modules/product/partials/entity-stock.tpl'}
                    </div>
                {/if}

                {if in_array($item->Type, ["giftcard","codegiftcard"])}
                    {include file="modules/product/partials/entity-giftcard.tpl" productController=$controller variantController=$variantController product=$item hasAdditionals=$hasAdditionals}
                {/if}

                {* Add to cart *}
                {if !in_array($item->Type, ["variant"])}
                    <div class="mt-4 xl:mt-6">
                        {include file="modules/product/partials/entity-actions.tpl" product=$product inputName="product[{$product->Id}][amount]" inputValue=$product->MinAmount data="data-variant='amount'" disabled=true buttonText=$text.PRODUCT_CATALOG_PRODUCT_CHOOSE_VARIANT buttonTextDefault=$text.PRODUCT_CATALOG_PRODUCT_ADD_TO_CART}
                    </div>
                {/if}

                {* Videos *}
                {include file='modules/product/partials/entity-videos.tpl'}

                {* Product extra buy *}
                {include file="modules/product/partials/entity-extra-buy.tpl" product=$product productController=$controller}

                {* Description link *}
                <div class="py-6 text-center">
                    <a href="#description" class="text-sm underline">{$text.PRODUCT_READ_MORE}</a>
                </div>

                {* USP *}
                {include file='modules/product/partials/entity-usp.tpl' id=76 pageSize=3}

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
            <div class="bg-gray-50 pb-6 lg:pb-10 xl:pb-16">
                <div class="container mx-auto">
                    {include file='modules/widgets/productslider/productslider.tpl' class="bg-white" items=$relatedProducts->filter('Sorting,-Sold,Title') title=$text.PRODUCT_CATALOG_RELATED_HEADLINE}
                </div>
            </div>
        {/if}
    {/if}

    {* Description *}
    {$description = $controller->getDescription($item->Id)}
    <div class="container mx-auto" id="description">
        <div class="flex flex-col lg:flex-row gap-6 lg:gap-16 my-6 md:my-10 lg:my-16">

            <div class="flex-1">
                {if !empty($description)}
                    <strong class="md:text-lg lg:text-xl xl:text-2xl 2xl:text-3xl block mb-3 lg:mb-4 2xl:mb-6">{$text.DESCRIPTION}</strong>
                    <div class="prose max-w-full text-sm" style="line-height: 1.4em;">
                        {$description}
                    </div>
                {else}
                    {$text.NO_DATA}
                {/if}
            </div>

            <div class="flex-none w-[400px] max-w-full" data-product="custom-data">
                <strong class="md:text-lg lg:text-xl xl:text-2xl 2xl:text-3xl block mb-3 lg:mb-4 2xl:mb-6">{$text.SPECIFICATIONS}</strong>
                <div class="flex flex-col text-sm" data-product="custom-data-list">

                    {* Brand for the product *}
                    {if $item->ProducerId}
                        {entity assign=brand controller=brand id=$item->ProducerId}
                        {if !empty($brand)}
                            {addMeta property="product:brand" content=$brand->Title}
                            {$brandLink = "/{$page.paths.0}/?brand={$brand->Id}-{$brand->Title|formatLink}"}
                            <div itemprop="brand" itemscope itemtype="http://schema.org/Brand" class="flex items-center justify-between gap-2 border-b border-gray-200 last:border-b-0 py-3">
                                <span>{$text.MANUFACTUERER}:</span>
                                <span>
                                    <a itemprop="url" class="block" href="{$brandLink}" title="{$text.PRODUCT_CATALOG_BRAND}: {$brand->Title}">
                                        <span itemprop="name">{$brand->Title}</span>
                                    </a>
                                </span>
                            </div>
                        {/if}
                    {/if}

                    {if !in_array($item->Type, ['variant','discontinued'])}
                        {if $settings.shop_product_weight and !empty($item->Weight) and $item->Weight !== 0}
                            {addMeta property="product:weight:value" content=$item->Weight}
                            {addMeta property="product:weight:units" content="kg"}
                        {/if}
                
                        {if ($settings.shop_product_weight or !empty($item->Weight) and $item->Weight !== 0)}
                            {* if the product number / model number is defined print it *}
                            {if !empty($item->ItemNumber) and $settings.shop_product_number}
                                <div class="flex items-center justify-between gap-2 border-b border-gray-200 last:border-b-0 py-3">
                                    <span>{$text.PRODUCT_CATALOG_PRODUCT_NUMBER}</span>
                                    <span>{$item->ItemNumber}</span>
                                </div>
                            {/if}
                
                            {*** Product weight ***}
                            {if $settings.shop_product_weight and !empty($item->Weight) and $item->Weight !== 0}
                                <div class="flex items-center justify-between gap-2 border-b border-gray-200 last:border-b-0 py-3">
                                    <span>{$text.PRODUCT_CATALOG_PRODUCT_WEIGHT}:</span>
                                    <span>{$item->Weight|formatNumber} {$text.PRODUCT_CATALOG_PRODUCT_WEIGHT_UNIT}</span>
                                </div>
                            {/if}
                        {/if}  
                    {/if}

                    {if !empty($item->Ean)}
                        <div class="flex items-center justify-between gap-2 border-b border-gray-200 last:border-b-0 py-3">
                            <span>{$text.EAN}:</span>
                            <span>{$item->Ean}</span>
                        </div>
                    {/if}
                    
                    {foreach $productCustomDataTypes->getData() as $productCustomDataType}
                        {collection assign=productCustomDatas controller=productCustomData productId=$product->Id typeId=$productCustomDataType->Id}
                
                        {if $productCustomDatas->getActualSize() gt 0 and $productCustomDataType->Display == "1"}
                            <div class="flex items-center justify-between gap-2 border-b border-gray-200 last:border-b-0 py-3">
                                <span>{$productCustomDataType->Title}</span>
                                <span>
                                    {foreach $productCustomDatas->getData() as $productCustomData}
                                        <span id="m-product-customdata-data-{$productCustomData->DataId}">{$productCustomData->Title}{if !$productCustomData@last}, {else} {/if}</span>
                                    {/foreach}
                                </span>
                            </div>
                        {/if}
                    {/foreach}

                    {*** Collection entity of the files controller ***}
                    {collection assign=productPdfs controller=files type=productPdf id=$product->Id}
                    
                    {if $productPdfs->getActualSize() gt 0}
                        <div class="flex flex-col gap-2 mt-5 first:mt-0 print:hidden">
                            <strong class="md:text-lg">{$text.FILES}:</strong>
                            {foreach $productPdfs->getData() as $productPdf}
                                <a href="{$productPdf->getRelativeFile()}" target="_blank" rel="noopener" class="flex items-center gap-1">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="flex-none w-6 h-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m2.25 0H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
                                    </svg>
                                    <p class="truncate text-ellipsis">{$productPdf->Filename}</p>
                                </a>
                            {/foreach}
                        </div>
                    {/if}

                </div>
            </div>

        </div>
    </div>

    {* Product also bought *}
    {if $settings.product_also_bought}
        {collection assign=alsoboughtProducts controller=productAlsoBought productId=$item->Id pageSize=10}
        {if $alsoboughtProducts->getActualSize() gt 0}
            <div class="bg-gray-50 pb-6 lg:pb-10 xl:pb-16">
                <div class="container mx-auto">
                    {include file='modules/widgets/productslider/productslider.tpl' class="bg-white" items=$alsoboughtProducts->filter('Sorting,-Sold,Title') title=$text.PRODUCT_CATALOG_ALSO_BOUGHT_HEADLINE}
                </div>
            </div>
        {/if}
    {/if}

    {* Product reviews *}
    {* {if $settings.module_shop_review_products_type!=="stars" and $settings.module_shop_review_products and $access.reviews} *}
        <div class="border-t border-gray-200">
            <div class="container mx-auto py-6 lg:py-10 xl:py-16 2xl:py-20">
                {include file='modules/product/partials/entity-reviews-comments.tpl' product=$item}
            </div>
        </div>
    {* {/if} *}

    {* Checkout widget: Modal *}
    {include file='modules/widgets/checkout/checkout.tpl' displayOnly=modal}
</div>