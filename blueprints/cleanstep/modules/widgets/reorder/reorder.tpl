{literal}

<script data-reorder="listmarkup" type="text/x-jsrender">
    <li class="border-b border-gray-200 last:border-b-0 flex flex-col" data-reorder="listitem" data-id="{{:id}}" data-products='{{:~jsonEncode(autoOrderProducts)}}'>
        <div class="grid grid-cols-9 text-sm items-center">
            <label class="p-2">
                <input type="text" name="name" value="{{:name}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2">
                <input type="text" name="cronForCreation" value="{{:~cronToDays(cronForCreation)}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2">
                <input type="text" name="comment" value="{{:orderComment}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2">
                <input type="text" name="address" value="{{if deliveryInformation}}{{:deliveryInformation.address}}{{else}}{{:~user.Address}}{{/if}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2">
                <input type="text" name="zipCode" value="{{if deliveryInformation}}{{:deliveryInformation.zip}}{{else}}{{:~user.Zipcode}}{{/if}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2">
                <input type="text" name="city" value="{{if deliveryInformation}}{{:deliveryInformation.city}}{{else}}{{:~user.City}}{{/if}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <label class="p-2">
                <input type="text" name="city" value="{{if deliveryInformation}}{{:deliveryInformation.phone}}{{else}}{{:~user.Phone}}{{/if}}" class="w-full p-1 border border-gray-200 rounded" />
            </label>
            <span class="p-2">
                <button title="{{:~text('SHOW_ALL')}}" type="button" class="p-1.5 leading-none text-xs rounded bg-black text-white" data-reorder="viewproducts">
                    {{:~text('SHOW_ALL')}}
                </button>
            </span>
            <span class="p-2 pr-4 flex gap-2 justify-end items-center">
                <button title="{{:~text('SAVE')}}" type="button" class="p-1.5 leading-none text-xs rounded bg-green-600 text-white" data-reorder="save">
                    {{:~text('SAVE')}}
                </button>
                <button title="{{:~text('DELETE')}}" type="button" class="text-gray-400 hover:text-black transition-colors underline" data-reorder="delete">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                    </svg>
                </button>
            </span>
        </div>
        <ul class="flex flex-col gap-2 px-2 pb-2" data-reorder="productslist" style="display:none;">
            {{include tmpl="[data-reorder='productsmarkup']"/}}
        </ul>
    </li>
</script>

<script data-reorder="productsmarkup" type="text/x-jsrender">
    <li class="flex items-center gap-2 text-sm p-2 bg-gray-50 rounded" data-reorder="productitem" data-productid="{{:Id}}">
        <div class="w-10 flex-none">
            <img src="{{:Images[0]}}" alt="{{:Title}}" class="w-10 h-10 object-cover rounded">
        </div>
        <div class="flex-auto flex flex-col gap-0.5">
            <a href="{{:Handle}}"><strong>{{:Title}}</strong></a>
            <span class="text-xs text-gray-500">{{:ItemNumber}}</span>
        </div>
        <div class="flex-1 flex flex-col justify-center items-end">
            {{if Prices[0].FullPriceMin > Prices[0].PriceMin}}
                <s class="text-xs text-gray-500">{{:~currency(Prices[0].FullPriceMin)}}</s>
            {{/if}}
            <strong>{{:~currency(Prices[0].PriceMin)}}</strong>
        </div>
        <div class="w-10 flex-none">
            <input type="number" name="quantity" value="{{:Quantity}}" class="text-center w-full p-2 border border-gray-200 rounded" min="1" />
        </div>
        <div class="flex-none">
            <button title="{{:~text('DELETE')}}" type="button" class="text-gray-400 hover:text-black transition-colors underline" data-reorder="deleteproduct">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                </svg>
            </button>
            <button title="{{:~text('PRODUCT_CATALOG_PRODUCT_BUY')}}" type="button" class="text-gray-400 hover:text-black transition-colors underline" data-reorder="buyproduct">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 0 0-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 0 0-16.536-1.84M7.5 14.25 5.106 5.272M6 20.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0Zm12.75 0a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0Z" />
                </svg>
            </button>
        </div>
    </li>
</script>

{/literal}


<div class="w-full">

    <div class="flex flex-col gap-4">

        <button type="button" class="px-4 h-10 flex items-center gap-2 rounded bg-black text-white text-sm w-fit" data-reorder="openform">
            {$text.PERSONAL_SHOP_NEW}
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
            </svg>
        </button>

        <div class="flex flex-col gap-6 mt-6" style="display: none;" data-reorder="form">

            <div class="flex flex-col gap-2">
                <strong>{$text.REORDER_NEW}</strong>
                <div class="flex flex-col lg:grid lg:grid-cols-2 gap-4">
                    <label class="flex-col gap-1 flex-1">
                        <span class="text-xs">{$text.TITLE}</span>
                        <input type="text" name="title" value="" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none">
                    </label>
                    <label class="flex flex-col gap-1 flex-1">
                        <span class="text-xs">{$text.FREQUENCY}</span>
                        <div class="relative">
                            <input type="number" name="frequency" value="" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                            <small class="absolute top-1/2 right-3 -translate-y-1/2 text-xs text-gray-500">{$text.DAYS}</small>
                        </div>
                    </label>
                </div>
            </div>

            <div class="flex flex-col gap-2">
                <div class="flex flex-col lg:grid gap-6 lg:grid-cols-2">

                    <label class="flex flex-col gap-1 flex-1">
                        <span class="text-xs">{$text.BLOG_COMMENT}</span>
                        <input type="text" name="comment" value="" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.FIRSTNAME}</span>
                        <input type="text" name="firstname" value="{$user->ShippingFirstname}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.FIRSTNAME}">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.LASTNAME}</span>
                        <input type="text" name="lastname" value="{$user->ShippingLastname}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.LASTNAME}">
                    </label>

                    {if $settings.shop_customer_company}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{$text.COMPANY} {$text.USER_ONLY_FOR_COMPANIES}</span>
                            <input type="text" name="company" value="{$user->ShippingCompany}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.COMPANY}">
                        </label>
                    {/if}

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.ADDRESS}</span>
                        <input type="text" name="address" value="{$user->ShippingAddress}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.ADDRESS}">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.POSTCODE}</span>
                        <input type="text" name="zipcode" value="{$user->ShippingZipcode}" data-smartform="zipcode" data-target="#reorderCity" placeholder="{$Text.POSTCODE}" autocomplete="off" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.CITY}</span>
                        <input type="text" name="city" value="{$user->ShippingCity}" id="reorderCity" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.CITY}" disabled required>
                    </label>

                    <input class="countryCode" type="hidden" name="countryCode" value="{$phonecode}">

                    {if $deliveryCountries->getActualSize() gt 1}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{$text.COUNTRY}</span>
                            <select class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none arrow" name="country">
                                {foreach $deliveryCountries->getData() as $country}
                                    <option data-has-states="{count($country->CountryStates)}" value="{$country->Iso}" {if $user->Country == $country->Iso}selected{/if}>{$country->Title}</option>
                                {/foreach}
                            </select>
                        </label>
                    {else}
                        {foreach $deliveryCountries->getData() as $country}
                            <input id="m-useredit-country" type="hidden" name="country" value="{$general.deliveryCountryIso}" data-has-states="{count($country->CountryStates)}">
                        {/foreach}
                    {/if}

                    {if $settings.shop_customer_phone}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{$text.TELEPHONE}</span>
                            <div class="flex">
                                <span class="flex items-center justify-center text-xs h-10 px-3 border border-gray-200 rounded-l flex-none">+{$phonecode}</span>
                                <input name="phone" type="text" class="flex-auto bg-white border-y border-r border-gray-200 rounded-r w-full px-3 h-10 text-sm" placeholder="{$text.TELEPHONE}" value="{$user->ShippingPhone}">
                            </div>
                        </label>
                    {/if}
                </div>
            </div>

            <div class="w-full">
                <button type="button" class="px-5 h-12 flex items-center gap-4 rounded bg-primary text-white w-fit" data-reorder="submit">
                    {$text.CREATE}
                </button>
            </div>

        </div>

        <div class="flex flex-col gap-2 mt-2">
            <label class="flex flex-col gap-1">
                <input type="text" placeholder="{$text.SEARCH}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" data-reorder="search">
            </label>
        </div>

        <div class="flex flex-col border border-gray-200 rounded">
            <div class="border-b border-gray-200 last:border-b-0 grid grid-cols-9 text-xs font-bold">
                <span class="p-2">{$text.NAME}</span>
                <span class="p-2">{$text.FREQUENCY}</span>
                <span class="p-2">{$text.BLOG_COMMENT}</span>
                <span class="p-2">{$text.ADDRESS}</span>
                <span class="p-2">{$text.POSTCODE}</span>
                <span class="p-2">{$text.CITY}</span>
                <span class="p-2">{$text.TELEPHONE}</span>
                <span class="p-2">{$text.PRODUCT_CATALOG_PRODUCTS}</span>
            </div>
            <ul data-reorder="list">
            </ul>
        </div>
    </div>

</div>