{*

# Description
Cart widget. A widget is a small helper template, with some functionality.


## Date last modified
2025-06-03


## Primary variables
+ $productController                                                    - Instance of productController
+ $product                                                              - Entity of productController
+ $productImage                                                         - Entity of filesContoller
+ $variantData                                                          - Collection of productVariantDataController
+ $variantImage                                                         - Entity of filesController
+ $page                                                                 - Global scope variable containing all information about the page type
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/column/module-cart.tpl"                                     - Widget for paymenticons
+ "/modules/widgets/paymenticons/paymenticons.tpl"                      - Payment icons widget

*}

{* Initiate Product controller *}
{$cartList = $cart->groupByClass()}

{*** Eager loading ***}
{include file='modules/cart/cart-preload.tpl' scope=parent}

{* Initiate Product controller *}
{controller type=product assign=productController}

{* Max cart lines *}
{$pageSize = 3}

{placeholdImage assign=placeholder width=40 height=40 background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

<div class="m-quick-cart is-hidden-s w-cart">
    <div class="dropdown" style="float:right;">
        {if isset($cartList.CartProductLine)}
            <a href="/{$text.CART_LINK}/" class="quick-cart-link button-primary button-icon right">{$cartList.CartTotalLine.0->Price|formatPrice} <i class="fa fa-shopping-cart"><span class="m-quick-cart__count h6">{$cart->getActualSize()}</span></i></a>
        {else}
            <a href="/{$text.CART_LINK}/" class="quick-cart-link button-primary button-icon right">{$text.CART_IS_EMPTY}<i class="fa fa-shopping-cart"></i></a>
        {/if}

        {if isset($cartList.CartProductLine)}
            <div class="dropdown-menu pull-right w-cart-list" style="width: 308px;">
                <div class="dropdown-container">
                    <header class="dropdown-header w-cart-header"><span class="h5">{$text.CART_HEADLINE}</span></header>
                        {if $cartList.CartProductLine|@count lte $pageSize}
                            {$cartListLoop = $cartList.CartProductLine|@count}
                        {else}
                            {$cartListLoop = $pageSize}
                        {/if}

                        <ul class="t-striped">
                             {section name=cartProductList start=0 loop=$cartListLoop step=1}
                                {$cartProduct = $cartList.CartProductLine[$smarty.section.cartProductList.index]}

                                {* Product *}
                                {entity assign=product controller=product type=product id=$cartProduct->ProductId}
                                {entity assign=productImage controller=files type=product productId=$cartProduct->ProductId}

                                {* Variant *}
                                {$cartVariantTitle = ''}
                                {if $cartProduct->VariantId}
                                    {collection assign=variantDatas controller=productVariantData productId=$cartProduct->ProductId variantId=$cartProduct->VariantId}

                                    {foreach $variantDatas->getData() as $variantData}
                                        {$cartVariantTitle = $cartVariantTitle|cat:" "|cat:$variantData->Title}
                                    {/foreach}

                                    {entity assign=variantImage controller=files type=variant variantId=$cartProduct->VariantId}
                                {/if}

                                {* Picture *}
                                {$cartImageObject = false}
                                {if $cartProduct->VariantId && $variantImage}
                                    {$cartImage = $variantImage->thumbnail(40, 40)|solutionPath}
                                    {$cartImageObject = $variantImage}
                                {elseif $productImage}
                                    {$cartImage = $productImage->thumbnail(40, 40)|solutionPath}
                                    {$cartImageObject = $productImage}
                                {else}
                                    {$cartImage = $placeholder->getRelativeFile()|solutionPath}
                                {/if}

                                {$cartImageAltText = null}
                                {if $cartImageObject && $cartImageObject->AltText}
                                    {$cartImageAltText = $cartImageObject->AltText}
                                {/if}

                                <li id="w-cartProduct-{$cartProduct->ProductId}" class="w-cart-product media">
                                    <div class="media-item">
                                        <a href="{$cartProduct->Url}" title="{$cartProduct->Title} {$cartVariantTitle}">
                                          <span class="media-image placeholder-wrapper" data-placeholder-max-width="40px">
                                            <span class="placeholder"></span>
                                            {img src="{$cartImage}" alt="{$cartImageAltText|default:"{$cartProduct->Title} {$cartVariantTitle}"}"}
                                          </span>
                                        </a>
                                        <div class="media-body">
                                            <span class="is-block w-product-title">
                                                {if $cartProduct->Available}
                                                    <a href="{$cartProduct->Url}" title="{$cartProduct->Title} {$cartVariantTitle}">
                                                        <span>
                                                            {$cartProduct->Title}
                                                            {if $cartProduct->VariantId}
                                                                {if !$cartProduct->UserTitle}{$cartVariantTitle}{/if}
                                                            {/if}
                                                        </span>
                                                    </a>
                                                {else}
                                                    <span>{$text.CART_PRODUCT_DEAD_TITLE}</span>
                                                {/if}
                                            </span>
                                            <span class="is-block w-cart-product-price">
                                                <strong>
                                                    <span class="w-cart-product-amount">{$cartProduct->Amount}</span> <span class="w-cart-product-x">x</span>
                                                    {if $cartProduct->FullPrice != $cartProduct->Price}
                                                        <s class="w-cart-product-price-before-discount">{$cartProduct->FullPrice|formatPrice}</s>
                                                    {/if}
                                                    <span class="w-cart-product-total-price">{$cartProduct->Price|formatPrice}</span>
                                                </strong>
                                            </span>
                                        </div>
                                    </div>
                                </li>
                            {/section}

                            {if isset($cartList.CartSalesLine)}
                                <li class="media w-salesline">
                                    <div class="media-item">
                                        <div class="row">
                                            <div class="col-s-2 col-m-6 col-l-6 col-xl-12 w-cart-salesline sales-title">
                                                <a class="is-block">{$cartList.CartSalesLine.0->Title}</a>
                                            </div>
                                            <div class="col-s-2 col-m-6 col-l-6 col-xl-12 text-right w-cart-salesline sales-price">
                                                <strong>{$cartList.CartSalesLine.0->Price|formatPrice}</strong>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            {/if}

                            {if isset($cartList.CartDiscountCodeLine)}
                                <li class="media w-couponline">
                                    <div class="media-item">
                                        <div class="row">
                                            <div class="col-s-2 col-m-6 col-l-6 col-xl-12 w-cart-coupon coupon-title">
                                                <a class="is-block">{$cartList.CartDiscountCodeLine.0->Title}
                                                    <span class="m-cart-discount-code-title-type">
                                                        {if $cartList.CartDiscountCodeLine.0->Type == 'percentage'}
                                                            ({$cartList.CartDiscountCodeLine.0->Value} <span class="m-percent">%</span>)
                                                        {/if}
                                                    </span>
                                                </a>
                                            </div>
                                            <div class="col-s-2 col-m-6 col-l-6 col-xl-12 text-right w-cart-coupon coupon-title">
                                                <strong>{$cartList.CartDiscountCodeLine.0->DiscountForDisplay|formatPrice}</strong>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            {/if}

                            {foreach $cartList.CartGiftCardLine as $cartGiftCard}
                                <li class="media w-giftcardline">
                                    <div class="media-item">
                                        <div class="row">
                                            <div class="col-s-2 col-m-6 col-l-6 col-xl-12 w-cart-coupon coupon-title">
                                                <a class="is-block">{$text.SHOP_GIFT_CARD}</a>
                                            </div>
                                            <div class="col-s-2 col-m-6 col-l-6 col-xl-12 text-right w-cart-coupon coupon-title">
                                                <strong>{$cartGiftCard->SpentDiscountForDisplay|formatPrice}</strong>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            {/foreach}

                        </ul>

                        {if $cartList.CartProductLine|@count gte $pageSize}
                            <header class="dropdown-body text-center w-cart-header goto-cart">
                                <a href="/{$text.CART_LINK}/" class="button is-block small">{$text.CART_SHOW_ALL_PRODUCTS} ({$cartList.CartProductLine|@count})</a>
                            </header>
                        {/if}

                        <header class="dropdown-body w-cart-header aprox-proces">
                            <div class="quick-cart-expanded-total">
                                {if isset($cartList.CartDeliveryEstimateLine)}
                                    <div class="row w-cart-line w-cart-delivery-line">
                                        <div class="col-s-2 col-m-6 col-l-6 col-xl-12 w-cart-delivery-est-title">
                                            <span>{$text.CART_DELIVERY_FROM}</span>
                                        </div>
                                        <div class="col-s-2 col-m-6 col-l-6 col-xl-12 text-right w-cart-delivery-est-price">
                                            <span>{$cartList.CartDeliveryEstimateLine.0->Price|formatPrice}</span>
                                        </div>
                                    </div>
                                {/if}
                                {if isset($cartList.CartSubTotalLine)}
                                    <div class="row w-cart-line w-cart-price-sub-total">
                                        <div class="col-s-2 col-m-6 col-l-6 col-xl-12 w-cart-price-sub-total-title">
                                            <span>{$text.CART_PRICE_SUM}</span>
                                        </div>
                                        <div class="col-s-2 col-m-6 col-l-6 col-xl-12 text-right w-cart-price-sub-total-price">
                                            <span>{$cartList.CartSubTotalLine.0->Price|formatPrice}</span>
                                        </div>
                                    </div>
                                {/if}
                                {if isset($cartList.CartVatTotalLine)}
                                    <div class="row w-cart-line w-cart-vat-line">
                                        <div class="col-s-2 col-m-6 col-l-6 col-xl-12 w-cart-vat-title">
                                            <span>
                                                {if $currency.hasVat}
                                                    {$text.CART_VAT_INCLUSIVE}
                                                {else}
                                                    {$text.CART_VAT_EXCLUSIVE}
                                                {/if}
                                            </span>
                                        </div>
                                        <div class="col-s-2 col-m-6 col-l-6 col-xl-12 text-right w-cart-vat-price">
                                            <span>{$cartList.CartVatTotalLine.0->Price|formatPrice}</span>
                                        </div>
                                    </div>
                                {/if}
                                <hr>
                                {if isset($cartList.CartTotalLine)}
                                    <div class="row w-cart-line w-cart-total-price-line">
                                        <div class="col-s-2 col-m-6 col-l-6 col-xl-12 w-cart-total-price-title">
                                            <span><strong>{$text.CART_TOTAL}</strong></span>
                                        </div>
                                        <div class="col-s-2 col-m-6 col-l-6 col-xl-12 text-right b-cart-total-price-final">
                                            <span><strong>{$cartList.CartTotalLine.0->Price|formatPrice}</strong></span>
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        </header>

                        <header class="dropdown-body w-cart-payment-icons">
                            {include file='modules/widgets/paymenticons/paymenticons.tpl'}
                        </header>

                    {if $cartList.CartDeliveryEstimateLine.0->PriceUntilFreeDelivery}
                        <div class="dropdown-body w-cart-free-delivery media-item text-center">
                            {$text.CART_PRICE_UNTIL_FREE_DELIVERY|replace:'$1':($cartList.CartDeliveryEstimateLine.0->PriceUntilFreeDelivery|formatPrice)}
                        </div>
                    {/if}

                    <footer class="dropdown-footer w-cart-goto-cart">
                        <a href="/{$text.CART_LINK}/" class="button-primary button-icon is-block default"><i class="fa fa-shopping-cart"></i>{$text.CART_GO_TO}</a>
                    </footer>
                </div>
            </div>
        {/if}
    </div>
</div>
