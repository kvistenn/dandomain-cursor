{*

# Description
Checkout template partial for step 1, if the customer is a new user. Part of Checkout page type.


## Date last modified
2021-08-05


## Primary variables
+ $text                                                     			- Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

<input type="hidden" name="bruger" value="0" />

<div class="flex flex-col">

    <div class="py-5">
        <div class="flex flex-wrap gap-2 items-center justify-between mb-3">
            <h2 class="text-lg">{$text.CHECKOUT_RECIEPT}</h2>
            <span class="text-xs">{$text.USER_ALREADY_REGISTERED} <a href="#" data-fancybox data-src="#login" class="text-brand-2">{$text.LOGIN_MENU}</a></span>
        </div>
        <div class="flex flex-col gap-4">
            <div>
                <input type="email" name="email" autocomplete="email" value="{$returnPostData.email}" data-error="{$text.LOGIN_USER_MISSING}" id="email" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.MAIL}" required>
                <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
            </div>
            {if $settings.shop_customer_email_confirm}
                <div>
                    <input id="m-checkout-emailconf" name="email_confirmation" autocomplete="email" type="email" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$text.MAIL_CONFIRM}" {if $returnPostData.email_confirmation}value="{$returnPostData.email_confirmation}"{/if} required>
                    <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                </div>
            {/if}
            {if $settings.shop_customer_phone || $settings.shop_customer_mobile}
                {$countryCode = $general.deliveryCountryCode}
                {if $returnPostData.countryCode}
                    {$countryCode = $returnPostData.countryCode}
                {/if}
        
                {if $settings.shop_customer_phone}
                    <div>
                        <div class="flex bg-white border border-gray-300 rounded w-full h-10 md:h-12 text-xs md:text-sm overflow-hidden">
                            <input type="text" name="countryCode" autocomplete="tel-country-code" disabled value="{$countryCode}" class="w-10 md:w-12 flex-none focus:outline-none border-r border-gray-300 px-3" />
                            <input type="text" name="phone" autocomplete="tel-national" value="{$returnPostData.phone}" id="phone" class="border-none flex-auto px-3" placeholder="{$Text.TELEPHONE}" {if $settings.shop_customer_phone_validation}required{/if}>
                        </div>
                        <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                    </div>
                {/if}
        
                {if $settings.shop_customer_mobile}
                    <div>
                        <div class="flex bg-white border border-gray-300 rounded w-full h-10 md:h-12 text-xs md:text-sm overflow-hidden">
                            <input type="text" name="countryCode" autocomplete="tel-country-code" disabled value="{$countryCode}" class="w-10 md:w-12 flex-none focus:outline-none border-r border-gray-300 px-3" />
                            <input type="text" name="mobile" autocomplete="mobile tel-national" value="{$returnPostData.mobile}" class="border-none flex-auto px-3" id="mobile" placeholder="{$Text.MOBILE}" {if $settings.shop_customer_mobile_validation}required{/if}>
                        </div>
                        <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                    </div>
                {/if}
            {/if}
        </div>

        {if $access.user && $settings.news_signup}
            <label class="flex gap-3 my-4">
                <input type="checkbox" name="newsletter" id="newsletter" class="w-4 h-4" {if $returnPostData.newsletter}checked{/if} />
                <span class="text-xs md:text-sm text-gray-500">{$Text.NEWSLETTER_TYPE_HEADLINE}</span>
            </label>
        {/if}

    </div>

    {if $settings.shop_customer_company or $settings.shop_customer_institution}
        {$companyOnlyLanguage = ($general.languageIso == 'SE26' || $general.languageIso == 'DE26')}
        <div class="m-checkout-customer-type py-5" style="display:none">
            <div class="block mb-3">
                <h2 class="text-lg">{$text.CUSTOMER_TYPE}</h2>
            </div>
            <div class="flex flex-col gap-4">
                <div class="flex bg-white border border-gray-300 rounded w-full overflow-hidden">
                    {if !$companyOnlyLanguage}
                        <label class="flex-1 flex items-center justify-center gap-3 text-sm p-3 border-r border-gray-300 cursor-pointer text-gray-500 [&.active]:bg-black [&.active]:text-white">
                            <input type="radio" name="customer-type" class="hidden md:block w-4 h-4" value="private" checked>
                            <span class="text-xs md:text-sm">{$text.CUSTOMER_TYPE_PRIVATE}</span>
                        </label>
                    {/if}
                    {if $settings.shop_customer_company}
                        <label class="flex-1 flex items-center justify-center gap-3 text-sm p-3 border-r border-gray-300 cursor-pointer text-gray-500 [&.active]:bg-black [&.active]:text-white">
                            <input type="radio" name="customer-type" class="hidden md:block w-4 h-4" value="company"{if $companyOnlyLanguage} checked{/if}>
                            <span class="text-xs md:text-sm">{$text.CUSTOMER_TYPE_COMPANY}</span>
                        </label>
                    {/if}
                    {if $settings.shop_customer_institution && !$companyOnlyLanguage}
                        <label class="flex-1 flex items-center justify-center gap-3 text-sm p-3 cursor-pointer text-gray-500 [&.active]:bg-black [&.active]:text-white">
                            <input type="radio" name="customer-type" class="hidden md:block w-4 h-4" value="institution">
                            <span class="text-xs md:text-sm">{$text.CUSTOMER_TYPE_INSTITUTION}</span>
                        </label>
                    {/if}
                </div>
            </div>
        </div>
    {/if}

    <div class="py-5">
        <div class="block mb-3">
            <h3 class="text-lg">{$text.CHECKOUT_STEP_ONE}</h3>
        </div>
        <div class="flex flex-col gap-4">
            {if $deliveryCountries->getActualSize() gt 1}
                <select id="country" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm flex-auto focus:outline-none appearance-none arrow" name="country" autocomplete="shipping country">
                    {foreach $deliveryCountries->getData() as $country}
                        <option data-has-states="{count($country->CountryStates)}" value="{$country->Iso}"
                        {if $returnPostData.country}{if $country->Iso eq $returnPostData.country}selected{/if}{elseif $country->Iso eq $general.deliveryCountryIso}selected{/if}>{$country->Title}</option>
                    {/foreach}
                </select>
            {else}
                {foreach $deliveryCountries->getData() as $country}
                    <input id="country" type="hidden" name="country" value="{$general.deliveryCountryIso}" data-has-states="{count($country->CountryStates)}">
                {/foreach}
            {/if}

            {foreach $deliveryCountries->getData() as $country}
                {if count($country->CountryStates) gt 0}
                    <select id="state{$country->Id}" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 appearance-none arrow text-xs md:text-sm focus:outline-none{if $general.deliveryCountryIso != $country->Iso}hidden{/if}" name="state" autocomplete="address-level1" disabled required>
                        {foreach $country->CountryStates as $DeliveryStateAbbr => $DeliveryState}
                            <option value="{$DeliveryStateAbbr}" {if $DeliveryStateAbbr eq $returnPostData.state}selected{/if}>{$DeliveryState}</option>
                        {/foreach}
                    </select>
                {/if}
            {/foreach}

            <div class="flex flex-col gap-4 md:grid md:grid-cols-2">
                <div>
                    <input type="text" name="firstname" autocomplete="given-name" value="{$returnPostData.firstname}" id="firstname" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$text.FIRSTNAME}" required>
                    <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                </div>
                <div>
                    <input type="text" name="lastname" autocomplete="family-name" value="{$returnPostData.lastname}" id="lastname" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$text.LASTNAME}" required>
                    <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                </div>
            </div>
            <div>
                <input type="text" name="address" autocomplete="street-address" value="{$returnPostData.address}" id="address" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.ADDRESS}" required>
                <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
            </div>
            <div class="flex flex-col gap-4 md:grid md:grid-cols-2">
                <div>
                    <input type="text" name="zipcode" autocomplete="postal-code" value="{$returnPostData.zipcode}" id="zipcode" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.POSTCODE}" required>
                    <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                </div>
                <div>
                    <input type="text" name="city" autocomplete="address-level2" value="{$returnPostData.city}" id="city" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.CITY}" required>
                    <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                </div>
            </div>
            {if $settings.shop_customer_company}
                <div class="customer-type-dynamic-fields" data-active-on-customer-type="company" style="display:none">
                    <div class="flex flex-col gap-4">
                        <div>
                            <input type="text" name="company" autocomplete="organization" value="{$returnPostData.company}" id="company" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.COMPANY}" data-is-required disabled data-active-on-customer-type="company" style="display: none;">
                            <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                        </div>
                        <div>
                            <input type="text" name="vatNumber" autocomplete="disable" value="{$returnPostData.vatNumber}" id="vatNumber" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.VAT_NR}" disabled data-active-on-customer-type="company" style="display: none;">
                            <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                        </div>
                        <div>
                            <input type="text" name="eanNumber" autocomplete="disable" value="{$returnPostData.eanNumber}" id="eanNumber" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.EAN}" disabled data-active-on-customer-type="company" style="display: none;">
                            <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                        </div>
                    </div>
                </div>
            {/if}
            {if $settings.shop_customer_institution}
                <div class="customer-type-dynamic-fields" data-active-on-customer-type="institution" style="display:none">
                    <div class="flex flex-col gap-4">
                        <div>
                            <input type="text" name="company" autocomplete="organization" value="{$returnPostData.company}" id="company" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.COMPANY_OR_INSTITUTION}" data-is-required disabled data-active-on-customer-type="institution" style="display: none;">
                            <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                        </div>
                        <div>
                            <input type="text" name="eanNumber" autocomplete="disable" value="{$returnPostData.eanNumber}" id="eanNumber" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" placeholder="{$Text.EAN}" data-is-required disabled data-active-on-customer-type="institution" style="display: none;">
                            <span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </div>

</div>