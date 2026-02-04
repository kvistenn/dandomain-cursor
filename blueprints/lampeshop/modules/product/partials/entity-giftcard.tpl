{*

# Description
Template partial for the product of type giftcard. Part of the Product page type.


## Date last modified
2019-09-26


## Primary variables
+ $productController                                                    - Instance of productController
+ $product                                                              - Entity of productController (the current product)
+ $variantController                                                    - Instance of productVariantController
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

{$giftcard_default_price = '100'}

{$pricePattern = '[0-9]+([,\.][0-9]{1,2})?'}

<div class="flex flex-col gap-2 p-6 border border-gray-200">
    
    <label class="flex flex-col gap-2">
        <span class="text-sm">{$text.GIFT_CARD_INPUT_AMOUNT}</span>
        <div class="relative flex flex-wrap w-full py-1 px-2 gap-2 border border-gray-200 rounded items-center">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 11.25v8.25a1.5 1.5 0 0 1-1.5 1.5H5.25a1.5 1.5 0 0 1-1.5-1.5v-8.25M12 4.875A2.625 2.625 0 1 0 9.375 7.5H12m0-2.625V7.5m0-2.625A2.625 2.625 0 1 1 14.625 7.5H12m0 0V21m-8.625-9.75h18c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125h-18c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125Z" />
            </svg>      
            <input type="text" pattern="{$pricePattern}" name="product[{$product->Id}][giftcard][price]" required id="gift_price" value="{$giftcard_default_price}" class="text-sm flex-auto appearance-none outline-none border-none">
            <span>{$currency.symbol}</span>
        </div>
    </label>

    <label class="flex flex-col gap-2">
        <span class="text-sm">{$text.GIFT_CARD_INPUT_NAME}</span>
        <div class="relative flex flex-wrap w-full py-1 px-2 gap-2 border border-gray-200 rounded items-center">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
            </svg>          
            <input type="text" name="product[{$product->Id}][giftcard][name]" id="gift_name" required value="" placeholder="{$text.GIFT_CARD_INPUT_NAME}" class="text-sm flex-auto appearance-none outline-none border-none">
        </div>
    </label>

    <label class="flex flex-col gap-2">
        <span class="text-sm">{$text.GIFT_CARD_INPUT_MESSAGE}</span>
        <textarea class="w-full p-2 border border-gray-200 rounded" name="product[{$product->Id}][giftcard][message]" placeholder="{$text.MESSAGE}" id="gift_message" style="height:150px;"></textarea>
    </label>
</div>
