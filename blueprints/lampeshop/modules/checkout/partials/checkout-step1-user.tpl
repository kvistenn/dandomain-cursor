{*

# Description
Checkout template partial for step 1, if the customer is a known user. Part of Checkout page type.


## Date last modified
2021-10-28


## Primary variables
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

<input type="hidden" name="user" id="user" value="1" />
<input type="hidden" name="userId" id="userId" value="{$user->Id}" />
<input type="hidden" name="firstname" autocomplete="given-name" id="firstname" value="{$user->Firstname}" />
<input type="hidden" name="lastname" autocomplete="family-name" id="lastname" value="{$user->Lastname}" />
<input type="hidden" name="company" autocomplete="organization" id="company" value="{$user->Company}" />
<input type="hidden" name="vatNumber" autocomplete="on" id="vatNumber" value="{$user->VatNumber}" />
<input type="hidden" name="eanNumber" autocomplete="on" id="eanNumber" value="{$user->Ean}" />
<input type="hidden" name="birthday" autocomplete="bday" id="birthday" value="{$user->DateOfBirth}" />
<input type="hidden" name="address" autocomplete="address-line1" id="address" value="{$user->Address}" />
<input type="hidden" name="address2" autocomplete="address-line2" id="address2" value="{$user->Address2}" />
<input type="hidden" name="zipcode" autocomplete="postal-code" id="zipcode" value="{$user->Zipcode}" />
<input type="hidden" name="city" autocomplete="address-level2" id="city" value="{$user->City}" />
<input type="hidden" name="country" autocomplete="country-name" id="country" value="{$user->Country}" />
<input type="hidden" name="countryCode" autocomplete="country" id="countryCode" value="{$user->CountryCode}" />
<input type="hidden" name="state" autocomplete="address-level1" id="state" value="{$user->State}" />
<input type="hidden" name="phone" autocomplete="tel" id="phone" value="{$user->Phone}" />
<input type="hidden" name="mobile" autocomplete="mobile tel" id="mobile" value="{$user->Mobile}" />
<input type="hidden" name="email" autocomplete="email" id="email" value="{$user->Email}" />

<div class="pb-5">
    <div class="flex items-center gap-4 mb-3">
        <h3 class="text-lg flex-auto">{$text.CHECKOUT_CUSTOMER}</h3>
        <a class="text-gray-500 text-xs cursor-pointer flex items-center gap-1.5" href="/{$Text.USER_UPDATE_LINK}/?lastPage={($page.isCheckoutKlarna) ? 'checkoutklarna' : 'checkout'}">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                <path d="M5.433 13.917l1.262-3.155A4 4 0 017.58 9.42l6.92-6.918a2.121 2.121 0 013 3l-6.92 6.918c-.383.383-.84.685-1.343.886l-3.154 1.262a.5.5 0 01-.65-.65z" />
                <path d="M3.5 5.75c0-.69.56-1.25 1.25-1.25H10A.75.75 0 0010 3H4.75A2.75 2.75 0 002 5.75v9.5A2.75 2.75 0 004.75 18h9.5A2.75 2.75 0 0017 15.25V10a.75.75 0 00-1.5 0v5.25c0 .69-.56 1.25-1.25 1.25h-9.5c-.69 0-1.25-.56-1.25-1.25v-9.5z" />
            </svg>
            {$Text.EDIT}
        </a>
        <a class="text-brand-2 text-xs cursor-pointer flex items-center gap-1.5" href="#" data-action="logout">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                <path fill-rule="evenodd" d="M3 4.25A2.25 2.25 0 015.25 2h5.5A2.25 2.25 0 0113 4.25v2a.75.75 0 01-1.5 0v-2a.75.75 0 00-.75-.75h-5.5a.75.75 0 00-.75.75v11.5c0 .414.336.75.75.75h5.5a.75.75 0 00.75-.75v-2a.75.75 0 011.5 0v2A2.25 2.25 0 0110.75 18h-5.5A2.25 2.25 0 013 15.75V4.25z" clip-rule="evenodd" />
                <path fill-rule="evenodd" d="M19 10a.75.75 0 00-.75-.75H8.704l1.048-.943a.75.75 0 10-1.004-1.114l-2.5 2.25a.75.75 0 000 1.114l2.5 2.25a.75.75 0 101.004-1.114l-1.048-.943h9.546A.75.75 0 0019 10z" clip-rule="evenodd" />
            </svg>
            {$Text.LOGOUT_HEADLINE}
        </a>
    </div>
    <div class="border border-gray-300 rounded flex flex-col py-1 px-4 text-xs md:text-sm">
        <div class="flex gap-4 py-3 border-b border-gray-300 last:border-b-0">
            <span class="w-24 flex-none text-gray-400">{$Text.MAIL}</span>
            <span class="flex-auto">{$user->Email}</span>
        </div>
        <div class="flex gap-4 py-3 border-b border-gray-300 last:border-b-0">
            <span class="w-24 flex-none text-gray-400">{$Text.CHECKOUT_CUSTOMER}</span>
            <span class="flex-auto">{$user->Firstname} {$user->Lastname}</span>
        </div>
        {entity assign=userCountry controller=deliveryCountry iso=$user->Country}
        <div class="flex gap-4 py-3 border-b border-gray-300 last:border-b-0">
            <span class="w-24 flex-none text-gray-400">{$Text.ADDRESS}</span>
            <span class="flex-auto">{$user->Address}, {$user->Zipcode}{if $user->State and $userCountry} {$userCountry->CountryStates[$user->State]}{/if} {$user->City}{if $userCountry}, {$userCountry->Title}{/if}</span>
        </div>
        {if $user->Address2}
        <div class="flex gap-4 py-3 border-b border-gray-300 last:border-b-0">
            <span class="w-24 flex-none text-gray-400">{$Text.ADDRESS2}</span>
            <span class="flex-auto">{$user->Address2}, {$user->Zipcode}{if $user->State and $userCountry} {$userCountry->CountryStates[$user->State]}{/if} {$user->City}{if $userCountry}, {$userCountry->Title}{/if}</span>
        </div>
        {/if}
        {if $user->Company}
        <div class="flex gap-4 py-3 border-b border-gray-300 last:border-b-0">
            <span class="w-24 flex-none text-gray-400">{$Text.ADDRESS}</span>
            <span class="flex-auto">{$user->Company}{if $user->VatNumber} ({$user->VatNumber}){/if}</span>
        </div>
        {/if}
        {if $user->Phone}
        <div class="flex gap-4 py-3 border-b border-gray-300 last:border-b-0">
            <span class="w-24 flex-none text-gray-400">{$Text.TELEPHONE}</span>
            <span class="flex-auto">{$user->Phone}</span>
        </div>
        {/if}
        {if $user->Mobile}
        <div class="flex gap-4 py-3 border-b border-gray-300 last:border-b-0">
            <span class="w-24 flex-none text-gray-400">{$Text.MOBILE}</span>
            <span class="flex-auto">{$user->Mobile}</span>
        </div>
        {/if}
    </div>
</div>