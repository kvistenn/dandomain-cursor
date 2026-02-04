
{* Fetch delivery countrys *}
{collection controller=deliveryCountry assign=deliveryCountries access=true}

{* Phone code *}
{$phonecode = $user->CountryCode}

{if $phonecode == 0}
	{$phonecode = $general.deliveryCountryCode}
{/if}


{$currentPage = $smarty.get.page}
{$currentId = $smarty.get.id}

<div class="flex flex-col lg:flex-row border border-gray-200 rounded-xl mt-6">

    {$activeId = 1}

    {if $currentPage == 'shop'}
        {$activeId = 4}
    {elseif $currentPage == 'addresses'}
        {$activeId = 6}
    {elseif $currentPage == 'mostSold'}
        {$activeId = 3}
    {elseif $currentPage == 'reorder'}
        {$activeId = 5}
    {/if}

    {include file="modules/userlayout/sidebar.tpl" active=$activeId}

    <div class="flex-auto p-6 lg:p-12 border-t lg:border-l lg:border-t-0 border-gray-200">

        {if $currentPage == "shop"}
            <h1 class="text-xl lg:text-2xl mb-6">{$text.PERSONAL_SHOP}</h1>
        {elseif $currentPage == "addresses"}
            <h1 class="text-xl lg:text-2xl mb-6">{$text.MY_ORDERS_ADDRESSES}</h1>
        {elseif $currentPage == "mostSold"}

            {$mostSoldSort = [
                [
                    'title' => "Mest k&oslash;bte",
                    'value' => 'most_sold'
                ],
                [
                    'title' => "Pris: (Faldende)",
                    'value' => 'price_desc'
                ]
            ]}

            <div class="flex justify-between items-center gap-4 mb-6">
                <h1 class="text-xl lg:text-2xl">{$text.MY_ORDERS_POPULAR}</h1>
                <label class="flex items-center gap-2 py-2 pl-3 cursor-pointer hover:bg-gray-100 rounded text-sm transition-colors" for="toggle-sorting">
                    <strong>Sortering: </strong>
                    <select data-mostsold="select" class="pointer-events-none appearance-none arrow pr-8 bg-transparent">
                        {foreach $mostSoldSort as $sort}
                            <option value="{$sort.value}">{$sort.title}</option>
                        {/foreach}
                    </select>
                </label>
                <input type="checkbox" class="hidden peer" id="toggle-sorting" />
                <label for="toggle-sorting" class="opacity-0 pointer-events-none fixed top-0 right-0 w-full h-full bg-black/50 z-50 peer-checked:opacity-100 peer-checked:pointer-events-auto transition-opacity"></label>
                <div class="w-full max-w-md h-full flex flex-col bg-white z-50 fixed top-0 right-0 translate-x-full peer-checked:translate-x-0 transition-transform duration-300 ease-in-out">
                    <header class="p-6 flex items-center justify-between">
                        <strong class="text-xl">{$text.PRODUCT_CATALOG_SORTING}</strong>
                        <label for="toggle-sorting" class="w-6 h-6 cursor-pointer">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </label>
                    </header>
                    <div class="p-6">
                        <div class="flex flex-col gap-6">
                            {foreach $mostSoldSort as $sort key=i}
                                <label class="flex items-center gap-4 cursor-pointer justify-between">
                                    <span class="text-lg">{$sort.title}</span>
                                    <input type="radio" name="mostsold-orderby" class="hidden peer" {if $i == 0}checked="checked"{/if} value="{$sort.value}" />
                                    <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                </label>
                            {/foreach}
                        </div>
                    </div>
                    <div class="p-6 bg-gray-100 border-t border-gray-200 mt-auto">
                        <label for="toggle-sorting" class="flex items-center gap-2 leading-none text-sm p-4 text-center justify-center font-bold rounded-md bg-black hover:bg-gray-900 text-white cursor-pointer transition-all">{$text.SHOW_RESULTS}</label>
                    </div>
                </div>
            </div>
        {elseif $currentPage == "reorder"}
            <h1 class="text-xl lg:text-2xl mb-6">{$text.REORDER}</h1>
        {else}
            <h1 class="text-xl lg:text-2xl mb-6">{$text.USER_UPDATE_HEADLINE}</h1>
        {/if}

        {if $currentPage == 'shop'}
            {include file='modules/widgets/shop/shop.tpl'}
        {elseif $currentPage == 'addresses'}
            {include file='modules/widgets/addresses/addresses.tpl'}
        {elseif $currentPage == 'mostSold'}
            {include file='modules/userorders/userorders-mostsold.tpl'}
        {elseif $currentPage == 'reorder'}
            {include file='modules/widgets/reorder/reorder.tpl'}
        {else}
            <form class="max-w-[600px] flex flex-col gap-6" method="post" action="/actions/user/edit">

                {csrf type="input"}
                
                <div class="flex flex-col lg:grid gap-6 lg:grid-cols-2">

                    {include
                        file="modules/widgets/customertypeinput/customertypeinput.tpl"
                        classes="col-span-2"
                        companyName=$user->Company
                        vatNumber=$user->VatNumber
                        eanNumber=$user->Ean
                    }

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.FIRSTNAME}</span>
                        <input type="text" name="firstname" value="{$user->Firstname}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.LASTNAME}</span>
                        <input type="text" name="lastname" value="{$user->Lastname}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                    </label>

                    {if $settings.shop_customer_birthdate}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{$text.BIRTHDATE}</span>
                            <input type="text" name="lastname" value="{$user->Lastname}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                            <input name="birthday" type="date" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" value="{$user->DateOfBirth|date_format:'%Y-%m-%d'}">
                        </label>
                    {/if}

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.ADDRESS}</span>
                        <input type="text" name="address" value="{$user->Address}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                    </label>

                    {if $settings.shop_customer_address2}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{$text.ADDRESS2}</span>
                            <input type="text" name="address2" value="{$user->Address2}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                        </label>
                    {/if}

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.POSTCODE}</span>
                        <input type="text" name="zipcode" value="{$user->Zipcode}" data-smartform="zipcode" data-target="#userCity" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{$text.CITY}</span>
                        <input type="text" name="city" value="{$user->City}" id="userCity" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                    </label>

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

                    <input type="hidden" name="state" value="">
                    {foreach $deliveryCountries->getData() as $country}
                        {if count($country->CountryStates) gt 0}
                            <label class="flex flex-col gap-1 {if $user->Country != $country->Iso}hidden{/if}">
                                <span class="text-xs">{$text.STATE}</span>
                                <select class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none arrow" name="state">
                                    {foreach $country->CountryStates as $state}
                                        <option value="{$state}" {if $user->State == $state}selected{/if}>{$state}</option>
                                    {/foreach}
                                </select>
                            </label>
                        {/if}
                    {/foreach}

                    <input class="countryCode" type="hidden" name="countryCode" value="{$phonecode}">

                    {if $settings.shop_customer_phone}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{$text.TELEPHONE}</span>
                            <div class="flex">
                                <span class="flex items-center justify-center text-xs h-10 px-3 border border-gray-200 rounded-l flex-none">+{$phonecode}</span>
                                <input name="phone" type="text" class="flex-auto bg-white border-y border-r border-gray-200 rounded-r w-full px-3 h-10 text-sm" placeholder="{$text.TELEPHONE}" value="{$user->Phone}" {if $settings.shop_customer_phone_validation}required{/if}>
                            </div>
                        </label>
                    {/if}

                    {if $settings.shop_customer_mobile}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{$text.MOBILE}</span>
                            <div class="flex">
                                <span class="flex items-center justify-center text-xs h-10 px-3 border border-gray-200 rounded-l flex-none">+{$phonecode}</span>
                                <input name="mobilephone" type="text" class="flex-auto bg-white border-y border-r border-gray-200 rounded-r w-full px-3 h-10 text-sm" placeholder="{$text.MOBILE}" value="{$user->Mobile}" {if $settings.shop_customer_mobile_validation}required{/if}>
                            </div>
                        </label>
                    {/if}

                </div>

                {include file="modules/widgets/customdata/customdata.tpl" entityType='customer' entityId=$user->Id context='user'}

                <label class="flex gap-3 p-3 border-gray-200 border rounded">
                    <input type="checkbox" name="deliveryActive" data-user="deliveryActive" {if $user->ShippingFirstname || $returnPostData.deliveryActive}checked{/if} />
                    <span class="text-sm">{$text.USER_ADD_SAVE_DELIVERY_ADDRESS}</span>
                </label>

                {if $settings.checkout_show_delivery_address && $general.isShop}
                    <div class="flex flex-col gap-6 mt-4" data-user="delivery" style="display: none;">
                        
                        <span class="text-lg lg:text-xl">{$text.DELIVERY_ADDRESS}</span>
                        
                        <div class="flex flex-col lg:grid gap-6 lg:grid-cols-2">

                            <label class="flex flex-col gap-1">
                                <span class="text-xs">{$text.FIRSTNAME}</span>
                                <input type="text" name="deliveryFirstname" value="{$user->ShippingFirstname}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.FIRSTNAME}" disabled required>
                            </label>

                            <label class="flex flex-col gap-1">
                                <span class="text-xs">{$text.LASTNAME}</span>
                                <input type="text" name="deliveryLastname" value="{$user->ShippingLastname}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.LASTNAME}" disabled required>
                            </label>

                            {if $settings.shop_customer_company}
                                <label class="flex flex-col gap-1">
                                    <span class="text-xs">{$text.COMPANY} {$text.USER_ONLY_FOR_COMPANIES}</span>
                                    <input type="text" name="deliveryCompany" value="{$user->ShippingCompany}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.COMPANY}">
                                </label>
                            {/if}

                            <label class="flex flex-col gap-1">
                                <span class="text-xs">{$text.ADDRESS}</span>
                                <input type="text" name="deliveryAddress" value="{$user->ShippingAddress}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.ADDRESS}" disabled required>
                            </label>

                            {if $settings.shop_customer_address2}
                                <label class="flex flex-col gap-1">
                                    <span class="text-xs">{$text.ADDRESS2}</span>
                                    <input type="text" name="deliveryAddress2" value="{$user->ShippingAddress2}" id="deliveryAddress2" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.ADDRESS2}" disabled>
                                </label>
                            {/if}

                            <label class="flex flex-col gap-1">
                                <span class="text-xs">{$text.POSTCODE}</span>
                                <input type="text" name="deliveryZipcode" value="{$user->ShippingZipcode}" data-smartform="zipcode" data-target="#deliveryCity" placeholder="{$Text.POSTCODE}" autocomplete="off" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" disabled required>
                            </label>

                            <label class="flex flex-col gap-1">
                                <span class="text-xs">{$text.CITY}</span>
                                <input type="text" name="deliveryCity" value="{$user->ShippingCity}" id="deliveryCity" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.CITY}" disabled required>
                            </label>

                            {if $deliveryCountries->getActualSize() gt 1}
                                <label class="flex flex-col gap-1">
                                    <span class="text-xs">{$text.COUNTRY}</span>
                                    <select class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none arrow" name="deliveryCountry">
                                        {foreach $deliveryCountries->getData() as $country}
                                            <option data-has-states="{count($country->CountryStates)}" value="{$country->Iso}" {if $user->Country == $country->Iso}selected{/if}>{$country->Title}</option>
                                        {/foreach}
                                    </select>
                                </label>
                            {else}
                                {foreach $deliveryCountries->getData() as $country}
                                    <input id="m-useredit-country" type="hidden" name="deliveryCountry" value="{$general.deliveryCountryIso}" data-has-states="{count($country->CountryStates)}">
                                {/foreach}
                            {/if}

                            <input type="hidden" name="deliveryState" value="">
                            {foreach $deliveryCountries->getData() as $country}
                                {if count($country->CountryStates) gt 0}
                                    <label class="flex flex-col gap-1 {if $user->Country != $country->Iso}hidden{/if}">
                                        <span class="text-xs">{$text.STATE}</span>
                                        <select class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none arrow" name="deliveryState">
                                            {foreach $country->CountryStates as $state}
                                                <option value="{$state}" {if $user->State == $state}selected{/if}>{$state}</option>
                                            {/foreach}
                                        </select>
                                    </label>
                                {/if}
                            {/foreach}

                            <input class="countryCode" type="hidden" name="deliveryCountryCode" value="{$phonecode}">

                            {if $settings.shop_customer_phone}
                                <label class="flex flex-col gap-1">
                                    <span class="text-xs">{$text.TELEPHONE}</span>
                                    <div class="flex">
                                        <span class="flex items-center justify-center text-xs h-10 px-3 border border-gray-200 rounded-l flex-none">+{$phonecode}</span>
                                        <input name="deliveryPhone" type="text" class="flex-auto bg-white border-y border-r border-gray-200 rounded-r w-full px-3 h-10 text-sm" placeholder="{$text.TELEPHONE}" value="{$user->ShippingPhone}">
                                    </div>
                                </label>
                            {/if}

                            {if $settings.shop_customer_mobile}
                                <label class="flex flex-col gap-1">
                                    <span class="text-xs">{$text.MOBILE}</span>
                                    <div class="flex">
                                        <span class="flex items-center justify-center text-xs h-10 px-3 border border-gray-200 rounded-l flex-none">+{$phonecode}</span>
                                        <input name="deliveryMobile" type="text" class="flex-auto bg-white border-y border-r border-gray-200 rounded-r w-full px-3 h-10 text-sm" placeholder="{$text.MOBILE}" value="{$user->ShippingMobile}">
                                    </div>
                                </label>
                            {/if}

                        </div>
                    </div>
                {/if}

                {if $settings.news_signup}
                    <div class="mt-4">
                        {include file="modules/widgets/newsletter/type.tpl" description=true newsletterRequired=false}
                    </div>
                {/if}

                {if $settings.privacy_policy_user}
                    <div class="row">
                        <div class="col-s-4 col-m-6 col-l-6 col-xl-12">
                            <div class="m-useredit-consent">
                                {include file="modules/widgets/consent/consent.tpl"}
                            </div>
                        </div>
                    </div>
                {/if}

                <div class="mt-4">
                    <button type="submit" class="px-4 h-10 flex items-center gap-2 rounded bg-primary text-white text-sm w-fit">
                        {$text.SAVE}
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                        </svg>

                    </button>
                </div>

            </form>
        {/if}
    </div>

</div>