{*

# Description
Controller and template for the User Create page type


## Date last modified
2022-03-18


## Primary variables
+ $deliveryCountries 													- Collection of deliveryCountryController
+ $interestFields 														- Collection of interestFieldController
+ $page                                                                 - Global scope variable containing all information about the page type
+ $settings                                                             - Global scope variable containing platform settings
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/widgets/recaptcha/recaptcha.tpl"                			- Recaptcha widget, for blog comments
+ "/modules/widgets/meta/opengraph.tpl"                                 - Social meta data

*}


{*** Global widgets defaults ***}
{$opengraph_image = null}
{$opengraph_title = $text.USER_ADD_HEADLINE}
{$opengraph_description = null}

{*** Meta tag - no noindex,follow ***}
{addMeta name="robots" content="noindex,follow"}

{* Fetch delivery countrys *}
{collection controller=deliveryCountry assign=deliveryCountries access=true}

{* Fetch interest fields *}
{collection controller=interestField assign=interestFields categoryId=1}

{* Phone code *}
{$phonecode = $general.deliveryCountryCode}

{if isset($returnPostData['countryCode'])}
	{$phonecode = $returnPostData['countryCode']}
{/if}

<header class="text-center mb-6 sm:mb-10 md:mb-14">
    <h1 class="text-lg sm:text-xl md:text-2xl">{$text.USER_ADD_HEADLINE}</h1>
</header>

<form id="m-usercreate" method="post" action="/actions/user/add" class="p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col lg:grid lg:grid-cols-2 gap-8">
    {csrf type="input"}

    <div class="flex flex-col gap-4">
        {include
            file="modules/widgets/customertypeinput/customertypeinput.tpl"
            inputFieldPrefix="m-usercreate"
            companyName=$returnPostData.company
            vatNumber=$returnPostData.vatNumber
            eanNumber=$returnPostData.eanNumber
        }

        <label>
            <span class="block mb-2 text-sm font-bold">{$text.FIRSTNAME}</span>
            <input id="m-usercreate-firstname" name="firstname" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.FIRSTNAME}" {if $returnPostData.firstname}value="{$returnPostData.firstname}"{/if} required>
        </label>

        <label>
            <span class="block mb-2 text-sm font-bold">{$text.LASTNAME}</span>
            <input id="m-usercreate-lastname" name="lastname" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.LASTNAME}" {if $returnPostData.lastname}value="{$returnPostData.lastname}"{/if} required>
        </label>

        {if $settings.shop_customer_birthdate}
            <label>
                <span class="block mb-2 text-sm font-bold">{$text.BIRTHDATE}</span>
                <input id="m-usercreate-birthday" name="birthday" type="date" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" {if $returnPostData.birth}value="{$returnPostData.birthday}"{/if}>
            </label>
        {/if}

        <label>
            <span class="block mb-2 text-sm font-bold">{$text.ADDRESS}</span>
            <input id="m-usercreate-address" name="address" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.ADDRESS}" {if $returnPostData.address}value="{$returnPostData.address}"{/if} required>
        </label>
        
        {if $settings.shop_customer_address2}
            <label>
                <span class="block mb-2 text-sm font-bold">{$text.ADDRESS2}</span>
                <input id="m-usercreate-address2" name="address2" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.ADDRESS2}" {if $returnPostData.address2}value="{$returnPostData.address2}"{/if}>
            </label>
        {/if}

        <label>
            <span class="block mb-2 text-sm font-bold">{$text.POSTCODE}</span>
            <input id="m-usercreate-zipcode" name="zipcode" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.POSTCODE}" {if $returnPostData.zipcode}value="{$returnPostData.zipcode}"{/if} required>
        </label>

        <label>
            <span class="block mb-2 text-sm font-bold">{$text.CITY}</span>
            <input id="m-usercreate-city" name="city" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.CITY}" {if $returnPostData.city}value="{$returnPostData.city}"{/if} required>
        </label>

        {if $deliveryCountries->getActualSize() gt 1}
            <label>
                <span class="block mb-2 text-sm font-bold">{$text.COUNTRY}</span>
                <select id="m-usercreate-country" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm appearance-none arrow" name="country">
                    {foreach $deliveryCountries->getData() as $country}
                        <option data-has-states="{count($country->CountryStates)}" value="{$country->Iso}" {if $returnPostData.country == $country->Iso}selected{elseif $general.deliveryCountryIso == $country->Iso && !isset($returnPostData.country)}selected{/if}>{$country->Title}</option>
                    {/foreach}
                </select>
            </label>
        {else}
            {foreach $deliveryCountries->getData() as $country}
                <input id="m-usercreate-country" type="hidden" name="country" value="{$general.deliveryCountryIso}" data-has-states="{count($country->CountryStates)}">
            {/foreach}
        {/if}

        <input type="hidden" name="state" value="">

        {foreach $deliveryCountries->getData() as $country}
            {if count($country->CountryStates) gt 0}
                <label id="cuStateWrapper" class="{if (isset($returnPostData.country) and $returnPostData.country != $country->Iso) or $general.deliveryCountryIso != $country->Iso}hidden{/if}">
                    <span class="block mb-2 text-sm font-bold">{$text.STATE}</span>
                    <select id="m-usercreate-state-{$country->Iso}" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm appearance-none arrow" name="state" disabled>
                        {foreach $country->CountryStates as $state}
                            <option value="{$state}" {if $returnPostData.state == $state}selected{/if}>{$state}</option>
                        {/foreach}
                    </select>
                </label>
            {/if}
        {/foreach}

        {include file="modules/widgets/customdata/customdata.tpl" entityType='customer' context='user'}
    </div>

    <div class="flex flex-col gap-4">

        <label>
            <span class="block mb-2 text-sm font-bold">{$text.MAIL}</span>
            <input id="m-usercreate-email" name="email" type="email" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.MAIL}" {if $returnPostData.email}value="{$returnPostData.email}"{/if} required>
        </label>

        {if $settings.shop_customer_email_confirm}
            <label>
                <span class="block mb-2 text-sm font-bold">{$text.MAIL_CONFIRM}</span>
                <input id="m-usercreate-emailconf" name="email_confirmation" type="email" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.MAIL_CONFIRM}" {if $returnPostData.email_confirmation}value="{$returnPostData.email_confirmation}"{/if} required>
            </label>
        {/if}

        <input class="countryCode" type="hidden" name="countryCode" value="{$phonecode}">

        {if $settings.shop_customer_phone}
            <label>
                <span class="block mb-2 text-sm font-bold">{$text.TELEPHONE}</span>
                <input id="m-usercreate-phone" name="phone" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.TELEPHONE}" {if $returnPostData.phone}value="{$returnPostData.phone}"{/if} {if $settings.shop_customer_phone_validation}required{/if}>
            </label>
        {/if}

        {if $settings.shop_customer_mobile}
            <label>
                <span class="block mb-2 text-sm font-bold">{$text.MOBILE}</span>
            <input id="m-usercreate-mobilephone" name="mobilephone" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.MOBILE}" {if $returnPostData.mobilephone}value="{$returnPostData.mobilephone}"{/if} {if $settings.shop_customer_mobile_validation}required{/if}>
            </label>
        {/if}

        <label>
            <span class="block mb-2 text-sm font-bold">{$text.PASSWORD}</span>
            <input id="m-usercreate-password" name="password" type="password" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.PASSWORD}" required>
        </label>

        <label>
            <span class="block mb-2 text-sm font-bold">{$text.PASSWORD_CONFIRM}</span>
            <input id="m-usercreate-passwordconf" name="passwordConfirmation" type="password" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.PASSWORD_CONFIRM}" required>
        </label>

        {if $settings.news_signup}
            <div>
                {include file="modules/widgets/newsletter/type.tpl" description=true newsletterRequired=false}
            </div>
        {/if}

    </div>

    <div class="col-span-2 flex flex-col gap-4">
        
        {if $settings.spam_check}
            {include file="modules/widgets/recaptcha/recaptcha.tpl"}
        {/if}

        {if $settings.privacy_policy_user}
            {include file="modules/widgets/consent/consent.tpl"}
        {/if}

        <button name="submit" type="submit" class="px-5 h-10 rounded bg-black text-white text-sm w-fit">{$text.CONFIRM}</button>

    </div>

</form>

{*** Global widgets ***}
{include file="modules/widgets/meta/opengraph.tpl"
    og=["title" => $opengraph_title, "description" => $opengraph_description, "image" => $opengraph_image]
}