{*

# Description
Template partial for product actions (buy amount and buy button). Part of the Product page type.


## Date last modified
2021-03-17


## Primary variables
+ $product                                      - Entity of productController (single shop product)
+ $inputName                                    - Name of amount inputfield (its varies for different views)
+ $inputValue                                   - Value of amount inputfield (its varies for different views)
+ $justBuy                                      - Tells to hide or show amount
+ $data                                         - String with data-attributes for amount inputfield
+ $User                                         - Global scope variable containing user data
+ $settings                                     - Global scope variable containing platform settings

*}

{$showBuy = true}
{if !in_array($product->Type, ["variant","packet"]) and ($product->Soldout and !$product->AllowOutOfStockPurchase)}
    {$showBuy = false}
{elseif in_array($product->Type, ["variant","packet"])}
    {$showBuy = true}
{/if}

<div class="mt-4 xl:mt-6">
    {if !$product->CallForPrice and ($user or !$settings.shop_b2b_hidden_prices) and $showBuy}
        <div class="flex gap-4 xl:gap-6">
            {if !$justBuy}

                <div class="flex bg-[#f9f9f9] h-14 xl:h-[70px] rounded">
                    <span class="hidden sm:flex px-3 xl:px-5 items-center h-full cursor-pointer" data-product="subtract">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 xl:w-6 xl:h-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                        </svg>                  
                    </span>
                    <input type="text" pattern="[0-9]*" name="{$inputName}" max="{$item->Stock}" data-controller="amount" value="{$inputValue}" {$data} title="{$text.INSERT_AMOUNT}" data-product="count" class="w-12 xl:w-16 bg-transparent outline-none text-center md:text-lg xl:text-xl">
                    <span class="hidden sm:flex px-3 xl:px-5 items-center h-full cursor-pointer" data-product="add">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 xl:w-6 xl:h-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                        </svg>                  
                    </span>
                </div>
                <button type="submit" name="cartadd" data-product="buyButton" data-controller="buy" role="button" class="flex-auto tracking-wider px-4 xl:px-8 md:text-lg xl:text-xl rounded bg-black text-white">{$text.PRODUCT_CATALOG_PRODUCT_ADD_TO_CART}</button>

                {if $user && $settings.module_shop_wishlist}
                    <button class="h-14 xl:h-[70px] aspect-square bg-[#f9f9f9] text-black flex items-center justify-center rounded" data-wishlist="toggle" data-id="{$item->Id}">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                        </svg>
                    </button>
                {elseif !$user && $settings.module_shop_wishlist}
                    <a class="h-14 xl:h-[70px] aspect-square bg-[#f9f9f9] text-black flex items-center justify-center rounded" data-fancybox data-src="#login" href="#">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                        </svg>
                    </a>
                {/if}

            {else}

                <button type="submit" name="cartadd" data-product="buyButton" data-controller="buy" role="button" class="flex-auto tracking-wider px-4 xl:px-8 md:text-lg xl:text-xl rounded bg-black text-white">{$text.PRODUCT_CATALOG_PRODUCT_BUY}</button>

            {/if}

            {include file='modules/widgets/checkout/checkout.tpl' displayOnly=buttons}
        </div>

    {elseif $product->CallForPrice}
        <input type="hidden" name="{$inputName}" value="{$inputValue}">
    {/if} 
</div>