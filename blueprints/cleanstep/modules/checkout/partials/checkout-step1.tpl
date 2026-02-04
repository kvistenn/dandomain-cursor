{*

# Description
Template partial for Checkout step 1 of the checkout process. Part of Checkout page type.


## Date last modified
2018-11-14


## Primary variables
+ $User                                                    				- Global scope variable containing user data
+ $deliveryCountries													- Collection of the deliveryCountryController (countries we deliver to)


## Partials (templates)
+ "/modules/widgets/order/order.tpl"                        			- Template widget for the User Order Details
+ "/modules/checkout/partials/checkout-step1-user.tpl" 					- Template partial to fetch user data from $User
+ "/modules/checkout/partials/checkout-step1-customer.tpl"  			- Template partial to ask user for data

*}

{* Fetch delivery countrys *}
{collection controller=deliveryCountry assign=deliveryCountries access=true}

{* If the user is logged in, display the users information in step 1 *}
{if $user}
	{include file='modules/checkout/partials/checkout-step1-user.tpl'}
{else}
	{include file='modules/checkout/partials/checkout-step1-customer.tpl'}
{/if}

{if $settings.checkout_show_delivery_address}

	<label class="flex items-center border border-gray-300 rounded gap-4 text-xs md:text-sm bg-white w-full p-4">
		<input type="checkbox" class="radiobtn" name="deliveryActive" id="deliveryActive" {if $returnPostData.deliveryActive || $user->ShippingFirstname}checked{/if} />
		<span class="flex-auto">{$Text.CHECKOUT_DELIVERY_ADDRESS_TEXT}</span>
	</label>

	<div class="deliveryContactInfo flex flex-col gap-4 mt-5 p-5 border border-gray-200 rounded" style="display: none;">
		<div class="flex flex-col gap-4 md:grid md:grid-cols-2">
			<div>
				{if $returnPostData.deliveryFirstname}{$deliveryFirstName = $returnPostData.deliveryFirstname}{else}{$deliveryFirstName = $user->ShippingFirstname}{/if}
				<input type="text" name="deliveryFirstname" autocomplete="given-name" value="{$deliveryFirstName}" data-alternative="true" id="deliveryFirstname" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.FIRSTNAME}" disabled required>
				<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
			</div>
			<div>
				{if $returnPostData.deliveryLastname}{$deliveryLastName = $returnPostData.deliveryLastname}{else}{$deliveryLastName = $user->ShippingLastname}{/if}
				<input type="text" name="deliveryLastname" autocomplete="family-name" value="{$deliveryLastName}" data-alternative="true" id="deliveryLastname" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.LASTNAME}" disabled required>
				<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
			</div>
		</div>
		<div>
			{if $returnPostData.deliveryCompany}{$deliveryCompany = $returnPostData.deliveryCompany}{else}{$deliveryCompany = $user->ShippingCompany}{/if}
			<input type="text" name="deliveryCompany" autocomplete="organization" value="{$deliveryCompany}" data-alternative="true" id="deliveryCompany" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.COMPANY}" disabled>
			<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
		</div>
		<div>
			{if $returnPostData.deliveryAddress}{$deliveryAddress = $returnPostData.deliveryAddress}{else}{$deliveryAddress = $user->ShippingAddress}{/if}
			<input type="text" name="deliveryAddress" autocomplete="address-line1" value="{$deliveryAddress}" data-alternative="true" id="deliveryAddress" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.ADDRESS}" disabled required>
			<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
		</div>
		<div>
			{if $returnPostData.deliveryAddress2}{$deliveryAddress2 = $returnPostData.deliveryAddress2}{else}{$deliveryAddress2 = $user->ShippingAddress2}{/if}
			<input type="text" name="deliveryAddress2" autocomplete="address-line2" value="{$deliveryAddress2}" data-alternative="true" id="deliveryAddress2" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.ADDRESS2}" disabled>
			<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
		</div>
		<div class="flex flex-col gap-4 md:grid md:grid-cols-2">
			<div>
				{if $returnPostData.deliveryZipcode}{$deliveryZipcode = $returnPostData.deliveryZipcode}{else}{$deliveryZipcode = $user->ShippingZipcode}{/if}
				<input type="text" name="deliveryZipcode" autocomplete="postal-code" value="{$deliveryZipcode}" data-alternative="true" id="deliveryZipcode" placeholder="{$Text.POSTCODE}" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" disabled required>
				<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
			</div>
			<div>
				{if $returnPostData.deliveryCity}{$deliveryCity = $returnPostData.deliveryCity}{else}{$deliveryCity = $user->ShippingCity}{/if}
				<input type="text" name="deliveryCity" autocomplete="address-level2" value="{$deliveryCity}" data-alternative="true" id="deliveryCity" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.CITY}" disabled required>
				<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
			</div>
		</div>

		{if $deliveryCountries->getActualSize() gt 1}
			<div>
				<select id="deliveryCountry" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs flex-auto focus:outline-none appearance-none arrow" name="deliveryCountry" autocomplete="shipping country">
					{if $returnPostData.deliveryCountry}{$deliveryCountry = $returnPostData.deliveryCountry}{else}{$deliveryCountry = $user->ShippingCountry}{/if}
					{foreach $deliveryCountries->getData() as $country}
						<option data-has-states="{count($country->CountryStates)}" value="{$country->Iso}"
						{if $deliveryCountry}
							{if $country->Iso eq $deliveryCountry}selected{/if}
						{elseif $country->Iso eq $general.deliveryCountryIso}selected{/if}>{$country->Title}</option>
					{/foreach}
                </select>
			</div>
		{else}
			<input type="hidden" id="deliveryCountry" name="deliveryCountry" autocomplete="shipping country" value="{$general.deliveryCountryIso}">
		{/if}

		{foreach $deliveryCountries->getData() as $country}
			{if count($country->CountryStates) gt 0}
				<fieldset class="form-group deliveryCountry-state-group deliveryCountry-state-group-{$country->Iso} {if $general.deliveryCountryIso != $country->Iso}is-hidden{/if}">
					<label for="deliveryState{$country->Id}" class="form-label">{$Text.STATE} <span class="form-required">*</span></label>
					<select id="deliveryState{$country->Id}" class="deliveryCountry-state-select form-input form-select small" name="deliveryState" autocomplete="address-level1">
						{if $returnPostData.deliveryState}{$deliveryState = $returnPostData.deliveryState}{else}{$deliveryState = $user->ShippingState}{/if}
						{foreach $country->CountryStates as $DeliveryStateAbbr => $DeliveryStateName}
							<option value="{$DeliveryStateAbbr}"
							{if $DeliveryStateAbbr eq $deliveryState}selected{/if}>{$DeliveryStateName}</option>
						{/foreach}
					</select>
				</fieldset>
			{/if}
		{/foreach}

		{if $settings.shop_customer_phone || $settings.shop_customer_mobile}
			{$deliveryCountryCode = $general.deliveryCountryCode}
			{if $returnPostData.deliveryCountryCode}
				{$deliveryCountryCode = $returnPostData.deliveryCountryCode}
			{/if}

			{if $settings.shop_customer_phone}
				<input class="deliveryCountryCode" type="hidden" name="deliveryCountryCode" autocomplete="tel-country-code" value="{$deliveryCountryCode}" />
				<div>
					{if $returnPostData.deliveryPhone}{$deliveryPhone = $returnPostData.deliveryPhone}{else}{$deliveryPhone = $user->ShippingPhone}{/if}
					<input type="text" name="deliveryPhone" autocomplete="tel-national" value="{$deliveryPhone}" data-alternative="true" id="deliveryPhone" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.TELEPHONE}" disabled>
					<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
				</div>
			{/if}

			{if $settings.shop_customer_mobile}
				<input class="deliveryCountryCode" type="hidden" name="deliveryCountryCode" autocomplete="tel-country-code" value="{$deliveryCountryCode}" />
				<div>
					{if $returnPostData.deliveryMobile}{$deliveryMobile = $returnPostData.deliveryMobile}{else}{$deliveryMobile = $user->ShippingMobile}{/if}
					<input type="text" name="deliveryMobile" autocomplete="mobile tel-national" value="{$deliveryMobile}" data-alternative="true" id="deliveryMobile" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.MOBILE}" disabled>
					<span class="error text-red-500 text-xs block mt-2 empty:hidden"></span>
				</div>
			{/if}
		{/if}
		<div>
			<input type="text" name="customCustomerNotice" data-alternative="true" id="customCustomerNotice" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-xs" placeholder="{$Text.CUSTOMER_NOTICE}" value="-" disabled required>
		</div>
	</div>

{/if}

{if $settings.checkout_reference_number}
	<div class="referenceNumber">
		<fieldset class="form-group m-checkout-del-reference">
			<label class="form-label" for="m-checkout-del-reference">{$Text.MY_ORDERS_REFERENCE_NUMBER}{if $settings.checkout_reference_number_required} <span class="form-required">*</span>{/if}</label>
			<input type="text" name="referenceNumber" autocomplete="disabled" value="{$returnPostData.referenceNumber}" id="referenceNumber" class="form-input" placeholder="{$Text.MY_ORDERS_REFERENCE_NUMBER}" {if $settings.checkout_reference_number_required}required{/if}>
		</fieldset>
	</div>
{/if}

<div class="flex md:items-center md:justify-between gap-5 mt-5 flex-col md:flex-row">
	<div>
		<a href="{$text.CART_LINK|formatUrl}" class="text-brand-2 text-sm flex items-center gap-1 justify-center">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
				<path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" />
			</svg>
			{$text.CART_GO_TO}
		</a>
	</div>
	<div>
		<button class="px-6 h-14 rounded bg-black text-white text-sm w-full md:w-fit" type="button" data-checkout="stepper" data-target="2">{$text.PRODUCT_CATALOG_GOTO} {$text.CHECKOUT_STEP_TWO|lower}</button>
	</div>
</div>