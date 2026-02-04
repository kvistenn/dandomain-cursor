{literal}

<script data-shop="listmarkup" type="text/x-jsrender">
    <li class="border-b border-gray-200 last:border-b-0 flex flex-col" data-shop="listitem" data-id="{{:id}}" data-products='{{:~jsonEncode(autoOrderProducts)}}'>
        <div class="grid grid-cols-10 text-sm items-center">
            <div class="p-2 col-span-2 flex items-center gap-2">
                <input type="checkbox" data-shop="list-select-checkbox" value="{{:id}}" class="w-4 h-4 rounded border-gray-300 text-black focus:ring-black">
                <label class="flex-1">
                    <input type="text" name="name" value="{{:name}}" class="w-full p-1 border border-gray-200 rounded" />
                </label>
            </div>
            <label class="p-2 col-span-2">
                <input type="text" name="comment" value="{{:orderComment}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2 col-span-2">
                <input type="text" name="address" value="{{if deliveryInformation}}{{:deliveryInformation.address}}{{else}}{{:~user.Address}}{{/if}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2">
                <input type="text" name="zipCode" value="{{if deliveryInformation}}{{:deliveryInformation.zip}}{{else}}{{:~user.Zipcode}}{{/if}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2">
                <input type="text" name="city" value="{{if deliveryInformation}}{{:deliveryInformation.city}}{{else}}{{:~user.City}}{{/if}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <span class="p-2">
                <button title="{{:~text('SHOW_ALL')}}" type="button" class="p-1.5 leading-none text-xs rounded bg-black text-white" data-shop="viewproducts">
                    {{:~text('SHOW_ALL')}}
                </button>
            </span>
            <span class="p-2 pr-4 flex gap-2 justify-end items-center">
                <button title="{{:~text('SAVE')}}" type="button" class="p-1.5 leading-none text-xs rounded bg-green-600 text-white" data-shop="save">
                    {{:~text('SAVE')}}
                </button>
                <label title="Upload CSV" class="text-gray-400 hover:text-black transition-colors underline cursor-pointer">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m6.75 12-3-3m0 0-3 3m3-3v6m-1.5-15H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
                    </svg>
                    <input type="file" class="hidden" accept=".csv" data-shop="uploadcsv">
                </label>
                <button title="{{:~text('DELETE')}}" type="button" class="text-gray-400 hover:text-black transition-colors underline" data-shop="delete">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                    </svg>
                </button>
            </span>
        </div>
        <ul class="flex flex-col gap-2 px-2 pb-2" data-shop="productslist" style="display:none;">
            {{include tmpl="[data-shop='productsmarkup']"/}}
        </ul>
    </li>
</script>

<script data-shop="productsmarkup" type="text/x-jsrender">
    {{for products}}
        <li class="flex items-center gap-2 text-sm p-2 bg-gray-50 rounded" data-shop="productitem" data-productid="{{:Id}}" data-variantid="{{:variantId}}">
            <div class="drag-handle cursor-move text-gray-400 hover:text-gray-600">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 15L12 18.75 15.75 15m-7.5-6L12 5.25 15.75 9" />
                </svg>
            </div>
            <div class="w-10 flex-none">
                {{if variantData}}
                    {{if variantData.Picture}}
                        <img src="{{:variantData.Picture}}" alt="{{:Title}}" class="w-10 h-10 object-cover rounded">
                    {{else}}
                        <img src="{{:Images[0]}}" alt="{{:Title}}" class="w-10 h-10 object-cover rounded">
                    {{/if}}
                {{else}}
                    <img src="{{:Images[0]}}" alt="{{:Title}}" class="w-10 h-10 object-cover rounded">
                {{/if}}
            </div>
            <div class="flex-auto flex flex-col gap-0.5">
                {{if variantData}}
                    <a href="{{:Handle}}"><strong>{{:Title}} {{:variantData.Title}}</strong></a>
                    <span class="text-xs text-gray-500">{{:variantData.ItemNumber}}</span>
                {{else}}
                    <a href="{{:Handle}}"><strong>{{:Title}}</strong></a>
                    <span class="text-xs text-gray-500">{{:ItemNumber}}</span>
                {{/if}}
            </div>
            {{if SpecialPrice}}
                <span class="flex-none w-6 h-6 flex items-center justify-center rounded-full bg-primary">
                    <img src="{{:~template.path}}/assets/images/hand-shake.png" width="20" height="20" />
                </span>
            {{/if}}
            <div class="flex-none w-fit flex flex-col justify-center items-end">
                {{if Prices[0].FullPriceMin > Prices[0].PriceMin}}
                    <s class="text-xs text-gray-500">{{:~currency(Prices[0].FullPriceMin)}}</s>
                {{/if}}
                <strong>{{:~currency(Prices[0].PriceMin)}}</strong>
            </div>
            {{if Kolli}}
                <div class="w-14 flex-none">
                    <select name="kolli" class="text-center w-full p-2 border border-gray-200 rounded">
                        <option value="1">1</option>
                        <option value="{{:Kolli}}">{{:Kolli}}</option>
                    </select>
                </div>
            {{/if}}
            <div class="w-10 flex-none">
                <input type="number" name="quantity" value="0" class="text-center w-full p-2 border border-gray-200 rounded" min="1" />
            </div>
            <div class="flex-none flex items-center gap-2">
                <button title="{{:~text('DELETE')}}" type="button" class="text-gray-400 hover:text-black transition-colors underline" data-shop="deleteproduct">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                    </svg>
                </button>
                <button title="{{:~text('PRODUCT_CATALOG_PRODUCT_BUY')}}" type="button" class="p-1.5 leading-none text-xs rounded bg-green-600 text-white" data-shop="buyproduct">
                    {{:~text('PRODUCT_CATALOG_PRODUCT_BUY')}}
                </button>
            </div>
        </li>
    {{/for}}
    <li class="flex justify-end">
        <button title="{{:~text('PRODUCT_CATALOG_PRODUCT_BUY_ALL')}}" type="button" class="p-3 leading-none text-sm rounded bg-green-600 text-white" data-shop="buyallproducts">
            {{:~text('PRODUCT_CATALOG_PRODUCT_BUY_ALL')}}
        </button>
    </li>
</script>

{/literal}


<div class="w-full">

    <div class="flex flex-col gap-4">

        <div class="flex gap-4">
            <button type="button" class="px-4 h-10 flex items-center gap-2 rounded bg-black text-white text-sm w-fit" data-shop="openform">
                {$text.PERSONAL_SHOP_NEW}
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
            </button>

            <label class="px-4 h-10 flex items-center gap-2 rounded bg-white border border-gray-200 text-black text-sm w-fit cursor-pointer hover:bg-gray-50 transition-colors" data-shop="import-csv-multiple-btn">
                {$text.IMPORT_CSV_MULTIPLE}
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m6.75 12-3-3m0 0-3 3m3-3v6m-1.5-15H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
                </svg>
                <input type="file" class="hidden" accept=".csv" data-shop="uploadcsv-multiple">
            </label>
        </div>

        <div class="flex flex-col gap-6 mt-6" style="display: none;" data-shop="form">

            <div class="flex flex-col gap-2">
                <strong>{$text.SHOP_NEW}</strong>
                <div class="flex flex-col lg:grid lg:grid-cols-2 gap-4">
                    <label class="flex-col gap-1 flex-1">
                        <span class="text-xs">{$text.NAME}</span>
                        <input type="text" name="title" value="" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none">
                    </label>
                    <label class="flex flex-col gap-1 flex-1">
                        <span class="text-xs">{$text.BLOG_COMMENT}</span>
                        <input type="text" name="comment" value="" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none">
                    </label>
                </div>
            </div>

            <div class="flex flex-col gap-2">
                <div class="flex flex-col lg:grid gap-6 lg:grid-cols-2">

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.ADDRESS}</span>
                        <input type="text" name="address" value="{$user->ShippingAddress}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.ADDRESS}">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.POSTCODE}</span>
                        <input type="text" name="zipcode" value="{$user->ShippingZipcode}" data-smartform="zipcode" data-target="#shopCity" placeholder="{$Text.POSTCODE}" autocomplete="off" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.CITY}</span>
                        <input type="text" name="city" value="{$user->ShippingCity}" id="shopCity" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.CITY}" disabled required>
                    </label>

                    <input class="countryCode" type="hidden" name="countryCode" value="{$phonecode}">
                </div>
            </div>

            <div class="w-full">
                <button type="button" class="px-5 h-12 flex items-center gap-4 rounded bg-primary text-white w-fit" data-shop="submit">
                    {$text.CREATE}
                </button>
            </div>

        </div>

        <div class="flex flex-col gap-2 mt-2">
            <label class="flex flex-col gap-1">
                <input type="text" placeholder="{$text.SEARCH}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" data-shop="search">
            </label>
        </div>

        <div class="flex flex-col border border-gray-200 rounded">
            <div class="border-b border-gray-200 last:border-b-0 grid grid-cols-10 text-xs font-bold">
                <span class="p-2 col-span-2">{$text.NAME}</span>
                <span class="p-2 col-span-2">{$text.BLOG_COMMENT}</span>
                <span class="p-2 col-span-2">{$text.ADDRESS}</span>
                <span class="p-2">{$text.POSTCODE}</span>
                <span class="p-2">{$text.CITY}</span>
                <span class="p-2">{$text.PRODUCT_CATALOG_PRODUCTS}</span>
            </div>
            <ul data-shop="list">
            </ul>
        </div>
    </div>

</div>