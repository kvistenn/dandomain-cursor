{*

# Description
Controller and template for the User Edit page type


## Date last modified
2022-06-20


## Primary variables
+ $item 																- Entity of userController (the current user)
+ $deliveryCountries 													- Collection of deliveryCountryController
+ $interestFields 														- Collection of interestFieldController
+ $page                                                                 - Global scope variable containing all information about the page type
+ $settings                                                             - Global scope variable containing platform settings
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

{* Fetch delivery countrys *}
{collection controller=deliveryCountry assign=deliveryCountries access=true}

{* Fetch interest fields *}
{collection controller=interestField assign=interestFields categoryId=$user->CategoryId}

{* Phone code *}
{$phonecode = $user->CountryCode}

{if $phonecode == 0}
	{$phonecode = $general.deliveryCountryCode}
{/if}

{if $settings.privacy_policy_user && !$user->Consent}
    <div class="w-notification">
        <div class="panel panel-danger">
            <div class="panel-body text-center">
                {$text.CONSENT_WARNING_MESSAGE}
            </div>
        </div>
    </div>
{/if}

<header class="text-center mb-6 sm:mb-10 md:mb-14">
    <h1 class="text-lg sm:text-xl md:text-2xl">{$text.USER_UPDATE_HEADLINE}</h1>
</header>

<form method="post" action="/actions/user/edit" id="m-useredit" class="p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col lg:grid lg:grid-cols-2 gap-8">
    
    <div id="m-useredit">
        {csrf type="input"}

        {if $general.isShop}
            <h5 class="font-bold text-xl block mb-5">{$text.BILLING_ADDRESS}</h5>
        {/if}

       <div class="flex flex-col gap-4">
        {* Customer type toggle and dynamic company related inputs *}
            {include
                file="modules/widgets/customertypeinput/customertypeinput.tpl"
                companyName=$user->Company
                vatNumber=$user->VatNumber
                eanNumber=$user->Ean
            }

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.FIRSTNAME}</span>
                    <input name="firstname" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.FIRSTNAME}" value="{$user->Firstname}" required>
                </label>
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.LASTNAME}</span>
                    <input name="lastname" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.LASTNAME}" value="{$user->Lastname}" required>
                </label>
            </div>

            {if $settings.shop_customer_birthdate}
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.BIRTHDATE}</span>
                    <input name="birthday" type="date" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" value="{$user->DateOfBirth|date_format:'%Y-%m-%d'}">
                </label>
            {/if}

            <label>
                <span class="block mb-2 text-sm font-bold">{$text.ADDRESS}</span>
                <input name="address" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.ADDRESS}" value="{$user->Address}" required>
            </label>

            {if $settings.shop_customer_address2}
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.ADDRESS2}</span>
                    <input name="address2" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.ADDRESS2}" value="{$user->Address2}">
                </label>
            {/if}

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.POSTCODE}</span>
                    <input name="zipcode" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.POSTCODE}" value="{$user->Zipcode}" required>
                </label>
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.CITY}</span>
                    <input name="city" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.CITY}" value="{$user->City}" required>
                </label>
            </div>

            {if $deliveryCountries->getActualSize() gt 1}
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.COUNTRY}</span>
                    <select class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm focus:outline-none appearance-none arrow" name="country">
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
                    <label{if $user->Country != $country->Iso} style="display:none"{/if}>
                        <span class="block mb-2 text-sm font-bold">{$text.STATE}</span>
                        <select class="text-sm focus:outline-none appearance-none arrow w-full bg-white border border-gray-300 rounded px-3 h-10" name="state" disabled>
                            {foreach $country->CountryStates as $state}
                                <option value="{$state}" {if $user->State == $state}selected{/if}>{$state}</option>
                            {/foreach}
                        </select>
                    </label>
                {/if}
            {/foreach}

            <input class="countryCode" type="hidden" name="countryCode" value="{$phonecode}">

            {if $settings.shop_customer_phone}
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.TELEPHONE}</span>
                    <div class="flex bg-white border border-gray-300 rounded w-full h-10 text-sm overflow-hidden">
                        <span class="w-12 h-full flex flex-col items-center justify-center flex-none focus:outline-none border-r border-gray-300 px-3">+{$phonecode}</span>
                        <input name="phone" type="text" class="border-none flex-auto px-3" placeholder="{$text.TELEPHONE}" value="{$user->Phone}" {if $settings.shop_customer_phone_validation}required{/if}>
                    </div>
                </label>
            {/if}

            {if $settings.shop_customer_mobile}
                <label>
                    <span class="block mb-2 text-sm font-bold">{$text.MOBILE}</span>
                    <div class="flex bg-white border border-gray-300 rounded w-full h-10 text-sm overflow-hidden">
                        <span class="w-12 h-full flex flex-col items-center justify-center flex-none focus:outline-none border-r border-gray-300 px-3">+{$phonecode}</span>
                        <input name="mobilephone" type="text" class="border-none flex-auto px-3" placeholder="{$text.MOBILE}" value="{$user->Mobile}" {if $settings.shop_customer_mobile_validation}required{/if}>
                    </div>
                </label>
            {/if}

            {include file="modules/widgets/customdata/customdata.tpl" entityType='customer' entityId=$user->Id context='user'}

            {if $settings.privacy_policy_user}
                {include file="modules/widgets/consent/consent.tpl"}
            {/if}
    
            <div class="gap-4 mt-3 hidden lg:flex">
                <button name="submit" type="submit" class="px-5 h-10 rounded bg-black text-white text-sm w-fit">{$text.SAVE}</button>
                {if isset($smarty.get.lastPage)}
                    {$gotoUrl = ($smarty.get.lastPage === 'checkoutklarna') ? 'klarna-checkout' : $text.CHECKOUT_LINK}
                    <button name="goto" type="submit" value='/{$gotoUrl}/' class="button small">{$text.SAVE_GO_BACK}</button>
                {/if}
            </div>

        </div>

    </div>

    <div>
        <div id="deliveryContactInfoContainer" class="deliveryContactInfoContainer hidden">
            {if $settings.checkout_show_delivery_address && $general.isShop}
                <h5 class="font-bold text-xl block mb-5 lg:mb-12">{$text.DELIVERY_ADDRESS}</h5>
                
                <label class="flex items-center border border-gray-300 rounded gap-3 text-sm bg-white w-full p-3">
                    <input type="checkbox" class="w-4 h-4 flex-none" name="deliveryActive" id="deliveryActive" {if $user->ShippingFirstname || $returnPostData.deliveryActive}checked{/if} />
                    <span class="flex-auto">{$Text.USER_ADD_SAVE_DELIVERY_ADDRESS}</span>
                </label>

                <div class="deliveryContactInfo flex flex-col gap-3 mt-5 border border-gray-300 rounded p-5" style="display: none;">

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.FIRSTNAME}</span>
                            <input type="text" name="deliveryFirstname" value="{$user -> ShippingFirstname}"
                            class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.FIRSTNAME}" disabled required>
                        </label>
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.LASTNAME}</span>
                            <input type="text" name="deliveryLastname" value="{$user -> ShippingLastname}"
                            class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.LASTNAME}" disabled required>
                        </label>
                    </div>

                    {if $settings.shop_customer_company}
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.COMPANY} {$Text.USER_ONLY_FOR_COMPANIES}</span>
                            <input type="text" name="deliveryCompany" value="{$user -> ShippingCompany}"
                            class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.COMPANY}">
                        </label>
                    {/if}

                    <label>
                        <span class="block mb-2 text-sm font-bold">{$text.ADDRESS}</span>
                        <input type="text" name="deliveryAddress" value="{$user -> ShippingAddress}"
                        class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.ADDRESS}" disabled required>
                    </label>

                    {if $settings.shop_customer_address2}
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.ADDRESS2}</span>
                            <input type="text" name="deliveryAddress2" value="{$user -> ShippingAddress2}"
                            class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.ADDRESS2}" disabled>
                        </label>
                    {/if}

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.POSTCODE}</span>
                            <input type="text" name="deliveryZipcode" value="{$user -> ShippingZipcode}" placeholder="{$Text.POSTCODE}" autocomplete="off" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" disabled required>
                        </label>
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.CITY}</span>
                            <input type="text" name="deliveryCity" value="{$user -> ShippingCity}"
                            class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.CITY}" disabled required>
                        </label>
                    </div>

                    {if $deliveryCountries->getActualSize() gt 1}
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.COUNTRY}</span>
                            <select class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm focus:outline-none appearance-none arrow" name="deliveryCountry">
                                {foreach $deliveryCountries->getData() as $country}
                                    <option data-has-states="{count($country->CountryStates)}" value="{$country->Iso}"
                                        {if $user->ShippingCountry == $country->Iso}selected{/if}>{$country->Title}</option>
                                {/foreach}
                            </select>
                        </label>
                    {else}
                        {foreach $deliveryCountries->getData() as $country}
                            <input type="hidden" name="deliveryCountry"
                                value="{$general.deliveryCountryIso}" data-has-states="{count($country->CountryStates)}">
                        {/foreach}
                    {/if}

                    <input type="hidden" name="deliveryState" value="">

                    {foreach $deliveryCountries->getData() as $country}
                        {if count($country->CountryStates) gt 0}
                            <label{if $user->ShippingCountry != $country->Iso} style="display:none"{/if}>
                                <span class="block mb-2 text-sm font-bold">{$text.STATE}</span>
                                <select
                                class="text-sm focus:outline-none appearance-none arrow w-full bg-white border border-gray-300 rounded px-3 h-10" name="deliveryState"
                                    disabled>
                                    {foreach $country->CountryStates as $state}
                                        <option value="{$state}" {if $user->ShippingState == $state}selected{/if}>{$state}</option>
                                    {/foreach}
                                </select>
                            </label>
                        {/if}
                    {/foreach}

                    <input class="countryCode" type="hidden" name="deliveryCountryCode" value="{$phonecode}">

                    {if $settings.shop_customer_phone}
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.TELEPHONE}</span>
                            <div class="flex bg-white border border-gray-300 rounded w-full h-10 text-sm overflow-hidden">
                                <span class="w-12 h-full flex flex-col items-center justify-center flex-none focus:outline-none border-r border-gray-300 px-3">+{$phonecode}</span>
                                <input name="deliveryPhone" type="text" class="border-none flex-auto px-3" placeholder="{$text.TELEPHONE}" value="{$user->ShippingPhone}">
                            </div>
                        </label>
                    {/if}

                    {if $settings.shop_customer_mobile}
                        <label>
                            <span class="block mb-2 text-sm font-bold">{$text.MOBILE}</span>
                            <div class="flex bg-white border border-gray-300 rounded w-full h-10 text-sm overflow-hidden">
                                <span class="w-12 h-full flex flex-col items-center justify-center flex-none focus:outline-none border-r border-gray-300 px-3">+{$phonecode}</span>
                                <input name="deliveryMobile" type="text" class="border-none flex-auto px-3" placeholder="{$text.MOBILE}" value="{$user->ShippingMobile}">
                            </div>
                        </label>
                    {/if}

                    <div class="mt-3">
                        <button type="submit" class="px-5 h-10 rounded bg-black text-white text-sm w-fit">{$text.SAVE}</button>
                    </div>

                </div>
            {/if}
        </div>

        <div class="py-5">
            <div class="border border-gray-300 rounded flex flex-col py-1 px-4 text-sm">
                <div class="flex gap-4 py-3 border-b border-gray-300">
                    <span class="w-24 flex-none text-gray-400">{$text.MAIL}</span>
                    <span class="flex-auto">{$user->Email}</span>
                    <a href="/{$text.USER_UPDATE_EMAIL_LINK}/" title="{$text.EDIT}" class="text-brand-2 text-xs cursor-pointer">{$text.EDIT}</a>
                </div>
                <div class="flex gap-4 py-3">
                    <span class="w-24 flex-none text-gray-400">{$text.PASSWORD}</span>
                    <span class="flex-auto">********</span>
                    <a href="/{$text.USER_UPDATE_PASSWORD_LINK}/" title="{$text.EDIT}" class="text-brand-2 text-xs cursor-pointer">{$text.EDIT}</a>
                </div>
            </div>
        </div>

        {if $settings.news_signup}
            {include file="modules/widgets/newsletter/type.tpl" description=true newsletterRequired=false}
        {/if}

        <div class="gap-4 mt-5 flex lg:hidden">
            <button name="submit" type="submit" class="px-5 h-10 rounded bg-black text-white text-sm w-fit">{$text.SAVE}</button>
            {if isset($smarty.get.lastPage)}
                {$gotoUrl = ($smarty.get.lastPage === 'checkoutklarna') ? 'klarna-checkout' : $text.CHECKOUT_LINK}
                <button name="goto" type="submit" value='/{$gotoUrl}/' class="button small">{$text.SAVE_GO_BACK}</button>
            {/if}
        </div>
    </div>
</form>

<div data-userdelete="panel" class="mt-5 lg:mt-8 m-userremove hidden">
    <form id="m-userremove" method="post" action="/actions/user/remove">
        {csrf type="input"}
        <div class="p-5 lg:p-8 shadow-lg rounded-lg bg-red-400 text-white">

            <h5 class="font-bold text-xl block mb-3">{$text.USER_DELETE_FORM_TITLE}</h5>

            <div data-userdelete="description">
                <strong class="block mb-1">{$text.USER_DELETE_FORM_TEXT}</strong>
                <p class="text-sm max-w-[800px]">{if $general.isShop}{$text.ACCOUNT_CONSENT_DELETE_SHOP}{else}{$text.ACCOUNT_CONSENT_DELETE_CMS}{/if}</p>
            </div>

            <div class="flex gap-3 mt-5">
                <div><button data-userdelete="button" name="submit" type="button" class="px-5 h-10 rounded bg-red-500 text-white text-sm">{$text.DELETE}</button></div>
                <div data-userdelete="confirm" class="hidden"><button data-userdelete="cancel" class="px-6 h-10 rounded bg-gray-900 text-white text-sm">Annuler</button></div>
            </div>
        </div>
    </form>
</div>