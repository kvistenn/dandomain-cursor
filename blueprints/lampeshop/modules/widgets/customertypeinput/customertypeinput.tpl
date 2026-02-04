{*

# Description
Customer input widget. A widget that allows the user form to handle different user types in a more elegant manner.

## Date last modified
2021-08-05

*}

{addScript src='modules/widgets/customertypeinput/include/customertypeinput.js'}

{* Parameters *}
{$inputFieldPrefix = $inputFieldPrefix|default:'w'}
{$showPrivateOption = $showPrivateOption|default:true}
{$requireCompanyFields = $requireCompanyFields|default:false}
{$companyName = $companyName|default:null}
{$vatNumber = $vatNumber|default:null}
{$eanNumber = $eanNumber|default:null}

{* Logic *}
{$amountOfCustomerTypeOption = 0}
{if $showPrivateOption}
    {$amountOfCustomerTypeOption = $amountOfCustomerTypeOption + 1}
{/if}

{if $settings.shop_customer_company || $requireCompanyFields}
    {$amountOfCustomerTypeOption = $amountOfCustomerTypeOption + 1}
{/if}

{if $settings.shop_customer_institution}
    {$amountOfCustomerTypeOption = $amountOfCustomerTypeOption + 1}
{/if}

{* Markup *}

<div {if $amountOfCustomerTypeOption < 2}style="display:none;"{/if}>
    <strong class="block mb-2 text-sm">{$text.CUSTOMER_TYPE}</strong>
    <div class="flex flex-col gap-4">
        <div class="flex bg-white border border-gray-300 rounded w-full overflow-hidden">
            {if $showPrivateOption}
            <label class="flex-1 flex items-center justify-center gap-2 sm:gap-3 text-xs sm:text-sm p-2 xs:p-3 border-r border-gray-300 cursor-pointer text-gray-500 transition-colors">
                <input type="radio" name="customer-type" class="hidden sm:block w-3 h-3 sm:w-4 sm:h-4 flex-none" value="private" checked>
                <span>{$text.CUSTOMER_TYPE_PRIVATE}</span>
            </label>
            {/if}
            {if $settings.shop_customer_company || $requireCompanyFields}
                <label class="flex-1 flex items-center justify-center gap-2 sm:gap-3 text-xs sm:text-sm p-2 xs:p-3 border-r border-gray-300 cursor-pointer text-gray-500 transition-colors">
                    <input type="radio" name="customer-type" class="hidden sm:block w-3 h-3 sm:w-4 sm:h-4 flex-none" value="company">
                    <span>{$text.CUSTOMER_TYPE_COMPANY}</span>
                </label>
            {/if}
            {if $settings.shop_customer_institution}
                <label class="flex-1 flex items-center justify-center gap-2 sm:gap-3 text-xs sm:text-sm p-2 xs:p-3 cursor-pointer text-gray-500 transition-colors">
                    <input type="radio" name="customer-type" class="hidden sm:block w-3 h-3 sm:w-4 sm:h-4 flex-none" value="institution">
                    <span>{$text.CUSTOMER_TYPE_INSTITUTION}</span>
                </label>
            {/if}
        </div>
    </div>
</div>

{if $settings.shop_customer_company || $requireCompanyFields}
    <label data-active-on-customer-type="company" style="display: none;">
        <span class="block mb-2 text-sm font-bold">{$text.COMPANY}</span>
        <input type="text" name="company" autocomplete="organization" {if $companyName}value="{$companyName}"{/if} id="company" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.COMPANY}" data-is-required disabled>
    </label>
    <div class="grid grid-cols-2 gap-4">
        <label data-active-on-customer-type="company" style="display: none;">
            <span class="block mb-2 text-sm font-bold">{$text.VAT_NR}</span>
            <input type="text" name="vatNumber" autocomplete="disable" {if $vatNumber}value="{$vatNumber}"{/if} id="vatNumber" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.VAT_NR}" data-is-required disabled>
        </label>
        <label data-active-on-customer-type="company" style="display: none;">
            <span class="block mb-2 text-sm font-bold">{$text.EAN}</span>
            <input type="text" name="eanNumber" autocomplete="disable" {if $eanNumber}value="{$eanNumber}"{/if} id="eanNumber" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.EAN}" disabled>
        </label>
    </div>
{/if}

{if $settings.shop_customer_institution}
    <div class="grid grid-cols-2 gap-4">
        <label data-active-on-customer-type="institution" style="display: none;">
            <span class="block mb-2 text-sm font-bold">{$text.COMPANY_OR_INSTITUTION}</span>
            <input type="text" name="company" autocomplete="organization" {if $companyName}value="{$companyName}"{/if} id="company" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.COMPANY_OR_INSTITUTION}" data-is-required disabled>
        </label>
        <label data-active-on-customer-type="institution" style="display: none;">
            <span class="block mb-2 text-sm font-bold">{$text.EAN}</span>
            <input type="text" name="eanNumber" autocomplete="disable" {if $eanNumber}value="{$eanNumber}"{/if} id="eanNumber" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.EAN}" data-is-required disabled>
        </label>
    </div>
{/if}