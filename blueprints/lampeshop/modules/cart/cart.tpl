{*

# Description
Controller and template for the Cart page type. Uses elements like


## Date last modified
2022-01-24


## Primary variables
+ $cart 																- Collection of cartController (contains all products in cart)
+ $cartProductList														- List of all cart products
+ $cartList 															- List of all cart products
+ $product 																- Entity of a product (item in cart)
+ $productImage 														- Entity of filesController with type product (a product image)
+ $variantData 															- Collection of productVariantDataController (data for variantTypes)
+ $variantImage 														- Entity of filesController with type variant (a variant product image)
+ $additionalTypeData 													- Entity of productAdditionalTypeController (types for additional products)
+ $packetProductData   													- Entity of productController (a packetproduct for a product)
+ $packetVariantData													- Collection of productVariantDataController, but for packetproduct (data for variantTypes)
+ $icons  																- Shop payment icons


## Partials (templates)
+ "/modules/product/product-list-combined.tpl"							- List of related / focus products
+ "/modules/widgets/paymenticons/paymenticons.tpl" 						- Payment icons widget
+ "/modules/widgets/meta/opengraph.tpl"                     			- Social meta data

*}

{*** Global widgets defaults ***}
{$opengraph_image = null}
{$opengraph_title = null}
{$opengraph_description = null}

{*** Meta tag - no noindex,follow ***}
{addMeta name="robots" content="noindex,follow"}

{*** Cart controller ***}
{collection controller=cart assign=cart primary=true}
{$cartProductList = $cart->groupByClass('CartProductLine')}
{$cartList = $cart->groupByClass()}

{*** Eager loading ***}
{include file='modules/cart/cart-preload.tpl' scope=parent}

{*** Picture size ***}
{$imageWidth  = 150}
{$imageHeight = 150}

{placeholdImage assign=placeholder width=$imageWidth height=$imageHeight background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}


<div itemscope itemtype="http://schema.org/OfferCatalog">

    <header class="text-center mb-6 sm:mb-10 md:mb-14">
        <h1 class="text-lg sm:text-xl md:text-2xl" itemprop="name">{$text.CART_HEADLINE}</h1>
    </header>

    {if isset($cartProductList['CartProductLine'])}

        {* Check for Cart availability  *}
        {$cartblock = false}
        {foreach $cartList.CartProductLine as $cartProduct}
            {if ($cartProduct->Soldout && $cartProduct->AllowOutOfStockPurchase eq false) or !$cartProduct->Available}
                {$cartblock = true}
            {/if}
        {/foreach}

        {* Dynamic link for Checkout if Klarna Checkout is available *}
        {$cartLink = $text.CHECKOUT_LINK}

        {* Get Klarna session *}
        {controller type=checkoutPaymentMethod assign=checkoutPaymentMethodController}
        {$paymentSession = $checkoutPaymentMethodController->getPaymentSession(9, 'klarnaKCO')}

        {if !empty($paymentSession)}
            {$cartLink = $text.CHECKOUT_KLARNA_LINK}
        {/if}

        <form id="m-cart" method="post" action="/actions/cart/update">
            {csrf type="input"}

            {if $cartList.CartDeliveryEstimateLine.0->PriceUntilFreeDelivery}
                <div class="m-cart-free-delivery panel-body text-center">
                    {$text.CART_PRICE_UNTIL_FREE_DELIVERY|replace:'$1':($cartList.CartDeliveryEstimateLine.0->PriceUntilFreeDelivery|formatPrice)}
                </div>
            {/if}

            <div class="p-5 pb-0 lg:p-8 lg:pb-3 bg-white rounded border border-gray-200">

                <div class="hidden xs:grid grid-cols-8 md:grid-cols-10 gap-5 text-xs md:text-sm">
                    <span class="col-span-6 sm:col-span-5 lg:col-span-4"><strong>{$text.CART_PRODUCTS}</strong></span>
                    <span class="hidden md:block col-span-2"><strong>{$text.CART_NOTE}</strong></span>
                    <span class="hidden sm:block"><strong>{$text.CART_PRICE}</strong></span>
                    <span class="col-span-2 hidden lg:block"><strong>{$text.CART_COUNT}</strong></span>
                    <span class="col-span-2 lg:col-span-1 text-right"><strong>{$text.CART_PRICE_ALL}</strong></span>
                </div>

                <div class="mt-5">
                
                    {foreach $cartList.CartProductLine as $cartProduct}

                        {entity assign=product controller=product type=product id=$cartProduct->ProductId}

                        {$hasVatIncludedLabel = $currency.hasVat and ($settings.vat_label_advanced eq false or $cartProduct->Vat gt 0)}
                        
						{*** Product ***}
                        {entity assign=product controller=product type=product id=$cartProduct->ProductId}
                        {entity assign=productImage controller=files type=product productId=$cartProduct->ProductId}

                        {*** Variant ***}
                        {$cartVariantTitle = ''}
                        {if $cartProduct->VariantId}

                            {collection assign=variantDatas controller=productVariantData productId=$cartProduct->ProductId variantId=$cartProduct->VariantId}

                            {foreach $variantDatas->getData() as $variantData}
                                {$cartVariantTitle = $cartVariantTitle|cat:" "|cat:$variantData->Title}
                            {/foreach}

                        	{entity assign=variantImage controller=files type=variant variantId=$cartProduct->VariantId}
                        {/if}

						{*** Picture ***}
						{$imageAspect = "{($imageHeight / $imageWidth) * 100}%"}

						{$crop = "fill"}
						{if !empty($template.settings.DESIGN_IMAGE_BACKGROUND_COLOR)}
							{$crop = $template.settings.DESIGN_IMAGE_BACKGROUND_COLOR}
						{/if}

                        {if $cartProduct->VariantId && $variantImage}
                        	{$cartImage = $variantImage->thumbnail($imageWidth, $imageHeight, $crop)|solutionPath}
                        {elseif $productImage}
                        	{$cartImage = $productImage->thumbnail($imageWidth, $imageHeight, $crop)|solutionPath}
                        {else}
                            {$cartImage = $placeholder->getRelativeFile()|solutionPath}
                        {/if}

                        {collection assign=productCustomDataTypes controller=productCustomDataType productId=$cartProduct->ProductId}
                        {$customDataTypes = []}
                        {foreach $productCustomDataTypes->getData() as $customType}
                            {$customData = []}
                            {collection assign=productCustomData controller=productCustomData productId=$cartProduct->ProductId typeId=$customType->Id}
                            {foreach $productCustomData->getData() as $customDataItem}

                                {$customDataTitle = $customDataItem->Title}

                                {if $customDataItem->Title|strstr:' || '}
                                    {$customDataTitle = ' || '|explode:$customDataItem->Title}
                                {/if}

                                {if $productCustomData->getData()|@count gt 1}
                                    {$customData[] = $customDataTitle}
                                {else}
                                    {$customData = $customDataTitle}
                                {/if}
                            {/foreach}
                            {$customDataTypes[$customType->Id] = ['Title' => $customType->Title, 'Data' => $customData]}
                        {/foreach}

                        <div class="grid grid-cols-8 md:grid-cols-10 gap-5 border-t border-gray-200 py-5 text-sm" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                            <meta itemprop="position" content="{$cartProduct@iteration}">
                            <div class="col-span-6 sm:col-span-5 lg:col-span-4">
                                <div class="flex gap-5">
                                    <figure class="w-16 sm:w-20 max-w-full flex-none border border-gray-200 rounded-md overflow-hidden aspect-square xl:w-[150px]">
                                        <a href="{$cartProduct->Url}" title="{$cartProduct->Title} {$cartVariantTitle}">
                                            {img src="{$cartImage}" alt="{$cartProduct->Title} {$cartVariantTitle}" itemprop="image" class="w-full h-auto"}
                                        </a>
                                    </figure>
                                    <div class="flex-auto flex flex-col gap-2">
                                        {if $cartProduct->Available}
                                            {* Product / Variant *}
                                            <a href="{$cartProduct->Url}" title="{$cartProduct->Title} {$cartVariantTitle}" itemprop="url">
                                                <div itemprop="name" class="font-bold text-xs sm:text-sm">
                                                    <span>{$cartProduct->Title}</span>
                                                    <span>{if !$cartProduct->UserTitle}{$cartVariantTitle}{/if}</span>
                                                </div>
                                            </a>

                                            {entity assign=brand controller=brand id=$product->ProducerId}

                                            {* Additionals *}
                                            {if $cartProduct->Additionals}
                                                {foreach $cartProduct->Additionals as $key => $additionalType}
                                                    {entity assign=additionalTypeData controller=productAdditionalType id=$key}

                                                    <div>
                                                        <span>{$additionalTypeData->Title}</span>
                                                        {foreach $additionalType as $additional}
                                                            <span>{$additional->Title}</span>
                                                            {if $additional->Price}
                                                                <span>({$additional->Price|formatPrice})</span>
                                                            {/if}
                                                        {/foreach}
                                                    </div>
                                                {/foreach}
                                            {/if}

                                            {* Packet product *}
                                            {if $cartProduct->PacketProducts}
                                                <div>{$text.PRODUCT_CATALOG_PRODUCT_PACKET}</div>
                                                {foreach $cartProduct->PacketProducts as $packetProduct}
                                                    {*** Product ***}
                                                    {entity assign=packetProductData controller=product type=product id=$packetProduct->ProductId}

                                                    {*** Variant ***}
                                                    {$packetVariantTitle = ''}
                                                    {if $packetProduct->VariantId}
                                                        {collection assign=packetVariantDatas controller=productVariantData variantId=$packetProduct->VariantId}

                                                        {foreach $packetVariantDatas->getData() as $packetVariantData}

                                                            {$packetVariantTitle = $packetVariantTitle|cat:" "|cat:$packetVariantData->Title}
                                                        {/foreach}
                                                    {/if}

                                                    <div>
                                                        <span>{$packetProduct->Amount}</span>
                                                        <span>x</span>
                                                        {if $packetProductData}
                                                            <span>{$packetProductData->Title} {$packetVariantTitle}</span>
                                                        {else}
                                                            <span>{$text.CART_PRODUCT_DEAD_TITLE}</span>
                                                        {/if}
                                                    </p>
                                                {/foreach}
                                            {/if}

                                            {* Gift Card *}
                                            {if $cartProduct->Giftcard}
                                                <div>
                                                    <span>{$text.GIFT_CARD_NAME}</span>
                                                    <span>{$cartProduct->Giftcard->Name}</span>
                                                </div>
                                            {/if}

                                            {* {if $settings.shop_product_number eq true && $cartProduct->ItemNumber}
                                                <div class="hidden text-xs sm:block">
                                                    <span>{$text.PRODUCT_CATALOG_PRODUCT_NUMBER}</span>
                                                    <span>{$cartProduct->ItemNumber}</span>
                                                </div>
                                            {/if} *}
                                        {else}
                                            <div>{$text.CART_PRODUCT_DEAD_TITLE}</div>
                                        {/if}

                                        <div class="flex gap-2 items-center lg:hidden mt-auto">
                                            {if $cartProduct->Available}
                                                <label class="flex shadow-sm w-fit rounded px-1 py-0.5 mt-auto transition-shadow hover:shadow-md bg-white">
                                                    <a href="/actions/cart/minus?id={$cartProduct->Key}&{csrf type='get'}" class="flex flex-none items-center justify-center w-5 h-5">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M18 12H6" />
                                                        </svg>
                                                    </a>
                                                    <input type="text" name="cart[{$cartProduct->Key}][amount]" pattern="[0-9]*" value="{$cartProduct->Amount}" class="w-5 h-5 flex-none text-xs text-center" />
                                                    <a href="/actions/cart/plus?id={$cartProduct->Key}&{csrf type='get'}" class="flex flex-none items-center justify-center w-5 h-5">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                                                        </svg>
                                                    </a>
                                                </label>
                                            {/if}
                                            <a href="/actions/cart/remove?id={$cartProduct->Key}&{csrf type='get'}" title="{$text.DELETE}" class="hidden sm:block text-gray-400">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                                </svg>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="hidden md:flex col-span-2 flex-col gap-2 text-xs">
                                {* Stock *}
                                {if $settings.shop_product_delivery_time eq true}
                                    <div class="flex items-center gap-2">
                                        {if $cartProduct->Soldout}
                                            <span class="block w-2 h-2 rounded-full bg-red-500"></span>
                                        {else}
                                            <span class="block w-2 h-2 rounded-full bg-green-500"></span>
                                        {/if}
                                        <span>{$cartProduct->DeliveryTimeTitle}</span>
                                    </div>
                                {/if}

                                {* Weight *}
                                {* {if $settings.shop_product_weight eq true && $cartProduct->Weight}
                                    <div>
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_WEIGHT}</span>
                                        <span>{$cartProduct->Weight|formatNumber}</span>
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_WEIGHT_UNIT}</span>
                                    </div>
                                {/if} *}
                            </div>
                            <div class="hidden sm:flex flex-col whitespace-nowrap">
                                {if $cartProduct->FullPrice != $cartProduct->Price}
                                    <s class="text-xs">{$cartProduct->FullPrice|formatPrice}</s>
                                {/if}
                                
                                <strong class="text-xs lg:text-sm">{$cartProduct->Price|formatPrice}</strong>
                                
                                {if $settings.shop_product_tax_after_price eq true}
                                    {if $hasVatIncludedLabel}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                                    {else}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                                    {/if}
                                {/if}
                            </div>
                            <div class="col-span-2 hidden lg:block">
                                <div class="flex gap-3 items-center">
                                    {if $cartProduct->Available}
                                        <div class="flex border border-gray-200 overflow-hidden rounded w-fit bg-white">
                                            <input class="w-10 border-r border-gray-200 text-center" type="text" name="cart[{$cartProduct->Key}][amount]" pattern="[0-9]*" value="{$cartProduct->Amount}">
                                            <div class="flex flex-col cursor-pointer">
                                                <a href="/actions/cart/plus?id={$cartProduct->Key}&{csrf type='get'}" class="px-1 py-0.5 text-xs leading-none flex-1 flex items-center justify-center border-b border-gray-200">+</a>
                                                <a href="/actions/cart/minus?id={$cartProduct->Key}&{csrf type='get'}" class="px-1 py-0.5 text-xs leading-none flex-1 flex items-center justify-center">-</a>
                                            </div>
                                        </div>
                                    {/if}
                                    <a href="/actions/cart/remove?id={$cartProduct->Key}&{csrf type='get'}" title="{$text.DELETE}" class="text-gray-400">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                        </svg>
                                    </a>
                                </div>
                            </div>
                            <div class="col-span-2 lg:col-span-1 flex flex-col items-end text-right whitespace-nowrap">
                                <a href="/actions/cart/remove?id={$cartProduct->Key}&{csrf type='get'}" title="{$text.DELETE}" class="block sm:hidden mb-3">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                                        <path fill-rule="evenodd" d="M8.75 1A2.75 2.75 0 006 3.75v.443c-.795.077-1.584.176-2.365.298a.75.75 0 10.23 1.482l.149-.022.841 10.518A2.75 2.75 0 007.596 19h4.807a2.75 2.75 0 002.742-2.53l.841-10.52.149.023a.75.75 0 00.23-1.482A41.03 41.03 0 0014 4.193V3.75A2.75 2.75 0 0011.25 1h-2.5zM10 4c.84 0 1.673.025 2.5.075V3.75c0-.69-.56-1.25-1.25-1.25h-2.5c-.69 0-1.25.56-1.25 1.25v.325C8.327 4.025 9.16 4 10 4zM8.58 7.72a.75.75 0 00-1.5.06l.3 7.5a.75.75 0 101.5-.06l-.3-7.5zm4.34.06a.75.75 0 10-1.5-.06l-.3 7.5a.75.75 0 101.5.06l.3-7.5z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                {if $cartProduct->FullPrice != $cartProduct->Price}
                                    <s class="text-xs">{($cartProduct->Amount * $cartProduct->FullPrice)|formatPrice}</s>
                                {/if}
                                <strong class="text-sm sm:text-xs md:text-sm lg:text-base">{($cartProduct->Amount * $cartProduct->Price)|formatPrice}</strong>
                                {if $settings.shop_product_tax_after_price eq true}
                                    {if $hasVatIncludedLabel}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                                    {else}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                                    {/if}
                                {/if}
                            </div>
                        </div>
                    {/foreach}

                    {if isset($cartList.CartSalesLine)}
                        <div class="grid grid-cols-8 md:grid-cols-10 gap-5 border-t border-gray-200 py-5 text-sm">
                            <div class="col-span-6 sm:col-span-5 lg:col-span-4">
                                <div class="flex gap-5">
                                    <div class="w-16 sm:w-20 max-w-full flex-none border border-gray-200 rounded-md overflow-hidden aspect-square xl:w-[150px]">
                                    </div>
                                    <div class="flex-auto flex flex-col gap-2">
                                        <span>{$cartList.CartSalesLine.0->Title}</span>
                                        <span>
                                            {if $cartList.CartSalesLine.0->DiscountType == 'percentage'}
                                                ({$cartList.CartSalesLine.0->AmountRaw} %)
                                            {elseif $cartList.CartSalesLine.0->DiscountType == 'fixed'}
                                                ({$cartList.CartSalesLine.0->Price|formatPrice})
                                            {/if}
                                        </span>
                                        {if $settings.shop_product_number eq true && $cartList.CartSalesLine.0->ItemNumber}
                                            <div>
                                                <span>{$text.PRODUCT_CATALOG_PRODUCT_NUMBER}</span>
                                                <span>{$cartList.CartSalesLine.0->ItemNumber}</span>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                            <div class="hidden md:flex col-span-2 flex-col gap-2 text-xs">
                                <span>
                                    {if $cartList.CartSalesLine.0->DiscountMode == 'sale-discount'}
                                        {$text.DISCOUNT}
                                    {elseif $cartList.CartSalesLine.0->DiscountMode == 'sale-fee'}
                                        {$text.FEE}
                                    {/if}
                                </span>
                            </div>
                            <div class="hidden sm:flex flex-col whitespace-nowrap">
                                <span class="m-cart-salesline-price">{$cartList.CartSalesLine.0->Price|formatPrice}</span>
                                {if $settings.shop_product_tax_after_price eq true}
                                    {if $currency.hasVat}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                                    {else}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                                    {/if}
                                {/if}
                            </div>
                            <div class="col-span-2 hidden lg:block">
                                <span class="text-sm">1 {$text.PEACES}</span>
                            </div>
                            <div class="col-span-2 lg:col-span-1 flex flex-col items-end text-right whitespace-nowrap">
                                <strong>{$cartList.CartSalesLine.0->Price|formatPrice}</strong>
                                {if $settings.shop_product_tax_after_price eq true}
                                    {if $currency.hasVat}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                                    {else}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                                    {/if}
                                {/if}
                            </div>
                        </div>
                    {/if}

                    {if isset($cartList.CartCouponLine)}
                        <div class="grid grid-cols-8 md:grid-cols-10 gap-5 border-t border-gray-200 py-5 text-sm">
                            <div class="col-span-6 sm:col-span-5 lg:col-span-4">
                                <div class="flex gap-5">
                                    <div class="w-16 sm:w-20 max-w-full flex-none border border-gray-200 bg-gray-100 rounded-md overflow-hidden xl:w-[150px]">
                                        <div class="w-full aspect-square xl:aspect-auto xl:py-5 h-auto border flex items-center justify-center text-xs">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 14.25l6-6m4.5-3.493V21.75l-3.75-1.5-3.75 1.5-3.75-1.5-3.75 1.5V4.757c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0c1.1.128 1.907 1.077 1.907 2.185zM9.75 9h.008v.008H9.75V9zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm4.125 4.5h.008v.008h-.008V13.5zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                                            </svg>
                                        </div>
                                    </div>
                                    <div class="flex-auto flex flex-col gap-2">
                                        <span class="font-bold text-xs sm:text-sm mb-auto sm:mb-0">{$cartList.CartCouponLine.0->Title}</span>
                                        <span class="hidden lg:block">
                                            {if $cartList.CartCouponLine.0->Type == 'procent'}
                                                <span class="block py-0.5 px-2 rounded text-2xs text-white bg-black w-fit">{$cartList.CartCouponLine.0->Amount}%</span>
                                            {elseif $cartList.CartCouponLine.0->Type == 'amount'}
                                                ({$cartList.CartCouponLine.0->Amount|formatPrice})
                                            {/if}
                                        </span>
                                        <div class="flex gap-2 items-center lg:hidden">
                                            <span>
                                                {if $cartList.CartCouponLine.0->Type == 'procent'}
                                                    <span class="block py-0.5 px-2 rounded text-2xs text-white bg-black w-fit">{$cartList.CartCouponLine.0->Amount}%</span>
                                                {elseif $cartList.CartCouponLine.0->Type == 'amount'}
                                                    ({$cartList.CartCouponLine.0->Amount|formatPrice})
                                                {/if}
                                            </span>
                                            <a href="/actions/cart/couponRemove?{csrf type='get'}" title="{$text.DELETE}" class="hidden sm:block text-gray-400">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                                </svg>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="hidden md:flex col-span-2 flex-col gap-2 text-xs">
                            </div>
                            <div class="hidden sm:flex flex-col whitespace-nowrap">
                                <strong class="text-xs lg:text-sm">{$cartList.CartCouponLine.0->Price|formatPrice}</strong>
                                {if $settings.shop_product_tax_after_price eq true}
                                    {if $currency.hasVat}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                                    {else}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                                    {/if}
                                {/if}
                            </div>
                            <div class="col-span-2 hidden lg:block">
                                <a href="/actions/cart/couponRemove?{csrf type='get'}" title="{$text.DELETE}" class="text-gray-400">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                    </svg>
                                </a>
                            </div>
                            <div class="col-span-2 lg:col-span-1 flex flex-col items-end text-right whitespace-nowrap">
                                <a href="/actions/cart/couponRemove?{csrf type='get'}" title="{$text.DELETE}" class="block sm:hidden mb-auto">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                                        <path fill-rule="evenodd" d="M8.75 1A2.75 2.75 0 006 3.75v.443c-.795.077-1.584.176-2.365.298a.75.75 0 10.23 1.482l.149-.022.841 10.518A2.75 2.75 0 007.596 19h4.807a2.75 2.75 0 002.742-2.53l.841-10.52.149.023a.75.75 0 00.23-1.482A41.03 41.03 0 0014 4.193V3.75A2.75 2.75 0 0011.25 1h-2.5zM10 4c.84 0 1.673.025 2.5.075V3.75c0-.69-.56-1.25-1.25-1.25h-2.5c-.69 0-1.25.56-1.25 1.25v.325C8.327 4.025 9.16 4 10 4zM8.58 7.72a.75.75 0 00-1.5.06l.3 7.5a.75.75 0 101.5-.06l-.3-7.5zm4.34.06a.75.75 0 10-1.5-.06l-.3 7.5a.75.75 0 101.5.06l.3-7.5z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <strong class="text-sm sm:text-xs md:text-sm lg:text-base">{$cartList.CartCouponLine.0->Price|formatPrice}</strong>
                                {if $settings.shop_product_tax_after_price eq true}
                                    {if $currency.hasVat}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX}</span>
                                    {else}
                                        <span>{$text.PRODUCT_CATALOG_PRODUCT_PRICE_TAX_NO}</span>
                                    {/if}
                                {/if}
                            </div>
                        </div>
                    {/if}

                </div>

            </div>

            <div class="pt-5 flex-col md:flex-row flex justify-between gap-5">
                <div>
                    <div class="justify-between sm:justify-start flex flex-wrap sm:flex-nowrap gap-3 lg:gap-5">
                        <a href="{$page.lastPath}" class="text-xs block w-fit lg:text-sm bg-black dark:bg-gray-900 text-white px-4 lg:px-6 py-2 lg:py-3 rounded text-center">{$text.CART_BUY_MORE}</a>
                        {* {if ($access.discountCode or $access.giftCard) and $settings.module_shop_discount_codes and !isset($cartList.CartCouponLine)}
                            <a href="#" data-fancybox data-src="#coupon" class="block w-fit text-xs lg:text-sm bg-gray-700 text-white px-4 lg:px-6 py-2 lg:py-3 rounded text-center">{$text.POS_DISCOUNT_ADD_DISCOUNT}</a>
                        {/if} *}
                        <div class="w-full sm:w-fit h-8 lg:h-11 bg-white rounded border border-gray-200 px-3 lg:px-5 flex gap-3 lg:gap-5 items-center">
                            <button type="submit" title="{$text.CART_UPDATE}" class="flex flex-1 sm:flex-auto justify-center">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 lg:w-5 lg:h-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99" />
                                </svg>
                            </button>
                            <a href="/actions/cart/empty?{csrf type='get'}" title="{$text.CART_EMPTY}" class="flex flex-1 sm:flex-auto justify-center">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 lg:w-5 lg:h-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                </svg>
                            </a>
                            {if $settings.module_shop_wishlist eq true and $access.wishlist}
                                <a href="/actions/wishlist/transferCart?{csrf type='get'}" title="{$text.WISHLIST_TRANSFER_CART}" class="flex flex-1 sm:flex-auto justify-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 lg:w-5 lg:h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                                    </svg>
                                </a>
                            {/if}
                        </div>
                    </div>
                </div>
                <div class="w-full md:w-80 lg:w-[500px] max-w-full">
                    <div class="flex flex-col gap-3 bg-white border border-gray-200 rounded p-5 lg:p-8 text-xs lg:text-sm mb-5">
                        {if isset($cartList.CartDeliveryEstimateLine)}
                            <div class="flex justify-between">
                                <span>{$text.CART_DELIVERY_FROM}</span>
                                <span>{$cartList.CartDeliveryEstimateLine.0->Price|formatPrice}</span>
                            </div>
                        {/if}
                        {if isset($cartList.CartSubTotalLine)}
                            <div class="flex justify-between">
                                <span>{$text.CART_PRICE_SUM}</span>
                                <span>{$cartList.CartSubTotalLine.0->Price|formatPrice}</span>
                            </div>
                        {/if}
                        {if isset($cartList.CartVatTotalLine)}
                            <div class="flex justify-between">
                                <span>
                                    {if $currency.hasVat}
                                        {$text.CART_VAT_INCLUSIVE}
                                    {else}
                                        {$text.CART_VAT_EXCLUSIVE}
                                    {/if}
                                </span>
                                <span itemprop="tax">{$cartList.CartVatTotalLine.0->Price|formatPrice}</span>
                            </div>
                        {/if}
                        {if isset($cartList.CartTotalLine)}
                            <div class="flex justify-between text-base lg:text-lg font-bold">
                                <span>{$text.CART_TOTAL}</span>
                                <div>
                                    <span itemprop="total">{$cartList.CartTotalLine.0->Price|formatPrice}</span>
                                    {* Viabill price tag *}
                                    {include file="modules/widgets/integrations/viabill_pricetag.tpl" type="basket" price=$cartList.CartTotalLine.0->Price}
                                </div>
                            </div>
                        {/if}
                    </div>
                    <div class="flex">
                        <a class="p-4 text-white bg-black transition duration-200 rounded sm:rounded-l-none uppercase text-sm tracking-wider font-bold flex-auto justify-center text-center" href="{if !$cartblock}/{$cartLink}/{else}#{/if}">{$text.CHECKOUT_MENU}</a>
                    </div>
                </div>
            </div>

        </form>

        {if ($access.discountCode or $access.giftCard) and $settings.module_shop_discount_codes and !isset($cartList.CartCouponLine)}
            <div id="coupon" style="display: none; width: 600px; max-width: 100%" tabindex="-1" role="dialog" aria-hidden="true">
                <form method="post" action="/actions/cart/couponAdd" class="flex flex-col gap-2">
                    {csrf type="input"}
                    <strong>{$text.SHOP_DISCOUNT_CODE_HEADLINE}</strong>
                    <span>{$text.SHOP_DISCOUNT_CODE_TEXT}</span>
                    <input type="text" name="coupon" class="bg-gray-100 appearance-none rounded w-full p-3 text-gray-700 leading-tight text-sm focus:outline-none focus:shadow-outline" placeholder="{$text.SHOP_DISCOUNT_CODE_CONFIRM}">
                    <button type="submit" class="block w-fit text-sm bg-black dark:bg-gray-900 text-white px-8 py-3 rounded text-center mt-3">{$text.SHOP_DISCOUNT_CODE_CONFIRM}</button>
                </form>
            </div>
        {/if}

    {else}

        <div class="text-center">
            <span class="text-gray-400">
                {$text.NO_DATA}
            </span>
        </div>

    {/if}
</div>

{if isset($cartProductList['CartProductLine'])}
	{$opengraph_title = $text.CART_HEADLINE}
{else}
	{$opengraph_title = "{$text.CART_HEADLINE} - {$text.CART_HEADLINE}"}
{/if}

{*** Global widgets ***}
{include file="modules/widgets/meta/opengraph.tpl"
    og=["title" => $opengraph_title, "description" => $opengraph_description, "image" => $opengraph_image]
}