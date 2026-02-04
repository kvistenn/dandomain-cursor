{$showBuy = true}
{if !in_array($product->Type, ["variant","packet"]) and ($product->Soldout and !$product->AllowOutOfStockPurchase)}
    {$showBuy = false}
{elseif in_array($product->Type, ["variant","packet"])}
    {$showBuy = true}
{/if}

{entity assign=colli controller=productCustomData typeId=2 productId=$product->Id}
{$colliAmount = 1}
{if $colli}
    {$colliAmount = (int)$colli->Title}
{/if}

{if !$product->CallForPrice and ($user or !$settings.shop_b2b_hidden_prices) and $showBuy}
    
    <div class="flex flex-col gap-4 lg:flex-row">
    
        <div class="flex-auto flex gap-4">
            {if !$justBuy}

                <input type="text" pattern="[0-9]*" name="{$inputName}" min="{$inputValue}" max="{$item->Stock}" data-controller="amount" value="{$inputValue}" title="{$text.INSERT_AMOUNT}" data-product="count" class="hidden">

                <div class="flex bg-[#f9f9f9] h-14 rounded">
                    <input type="text" pattern="[0-9]*" min="{$inputValue}" max="{$item->Stock}" value="{$inputValue}" data-product="count-colli" class="w-12 xl:w-16 bg-transparent outline-none text-center md:text-lg xl:text-xl">
                </div>

                {if $colliAmount > 1}
                    <select data-product="colli" class="bg-white border border-gray-200 rounded w-32 px-4 h-14 appearance-none arrow text-lg">
                        <option value="1" selected>{$text.PEACES} (1)</option>
                        <option value="{$colliAmount}">{$text.PRODUCT_CATALOG_PRODUCT_COLLI} ({$colliAmount})</option>
                    </select>
                {else}
                    <input type="hidden" data-product="colli" value="1">
                {/if}

                <button type="submit" name="cartadd" data-product="buyButton" data-controller="buy" role="button" class="flex-auto tracking-wider px-4 xl:px-8 md:text-lg xl:text-xl rounded bg-black text-white disabled:opacity-30 disabled:pointer-events-none" {if $product->Type == 'variant'}disabled{/if}>{$text.PRODUCT_CATALOG_PRODUCT_ADD_TO_CART}</button>

            {else}

                <button type="submit" name="cartadd" data-controller="buy" role="button" class="flex-auto tracking-wider px-4 xl:px-8 md:text-lg xl:text-xl rounded bg-black text-white disabled:opacity-30 disabled:pointer-events-none" {if $product->Type == 'variant'}disabled{/if}>{$text.PRODUCT_CATALOG_PRODUCT_BUY}</button>

            {/if}

        </div>

        <div class="flex gap-4 justify-end lg:justify-start">

            <div data-compare="toggle" data-id="{$product->Id}" class="bg-[#f9f9f9] rounded h-inherit p-4 flex-none flex items-center justify-center hover:bg-black hover:text-white transition-all [&.active]:bg-black cursor-pointer group">
                <svg xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 24 24" width="24" height="24" class="w-6 h-6 group-[&.active]:fill-white">
                    <path d="M24,5c0-2.206-1.794-4-4-4s-4,1.794-4,4c0,1.86,1.277,3.428,3,3.873v8.127c0,.551-.449,1-1,1h-4.996l2.203-2.203-1.414-1.414-3.256,3.256c-.774,.775-.774,2.037,0,2.812l3.256,3.256,1.414-1.414-2.304-2.293h5.097c1.654,0,3-1.346,3-3V8.873c1.723-.445,3-2.013,3-3.873Zm-4,2c-1.103,0-2-.897-2-2s.897-2,2-2,2,.897,2,2-.897,2-2,2Zm-9.838,2.662l3.256-3.255c.775-.775,.775-2.037,0-2.812L10.162,.338l-1.414,1.414,2.259,2.248H6c-1.654,0-3,1.346-3,3V15.127c-1.723,.445-3,2.013-3,3.873,0,2.206,1.794,4,4,4s4-1.794,4-4c0-1.86-1.277-3.428-3-3.873V7c0-.551,.449-1,1-1h4.995l-2.248,2.248,1.414,1.414Zm-4.162,9.338c0,1.103-.897,2-2,2s-2-.897-2-2,.897-2,2-2,2,.897,2,2Z"/>
                </svg>
            </div>

            {if $user}
                <label for="shopPopup" data-id="{$product->Id}" class="bg-[#f9f9f9] rounded h-inherit p-4 flex-none flex items-center justify-center hover:bg-black hover:text-white transition-all [&.active]:bg-black [&.active]:text-white cursor-pointer [&.active]:rotate-45 [&.disabled]:opacity-30 [&.disabled]:pointer-events-none{if $product->Type == 'variant'} disabled{/if}">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                    </svg>
                </label>
            {/if}

        </div>
    
    </div>
     
    {include file='modules/widgets/checkout/checkout.tpl' displayOnly=buttons}

    <div class="hidden mt-4" data-product="colliinfo">{$text.PRODUCT_CATALOG_PRODUCT_COLLI_INFO|replace:"%amount%":$colliAmount}</div>

{elseif $product->CallForPrice}
    <input type="hidden" name="{$inputName}" value="{$inputValue}">
{/if}