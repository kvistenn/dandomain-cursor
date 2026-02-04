{*

# Description
Customer input widget. A widget that allows the user form to handle different user types in a more elegant manner.

## Date last modified
2021-08-05

*}

{addScript src='modules/widgets/customertypeinput/include/customertypeinput.js'}

{* Parameters *}
{$showPrivateOption = $showPrivateOption|default:true}
{$requireCompanyFields = $requireCompanyFields|default:false}
{$companyName = $companyName|default:null}
{$vatNumber = $vatNumber|default:null}
{$eanNumber = $eanNumber|default:null}

{* Logic *}
{$companyOnlyLanguage = ($general.languageIso == 'SE26' || $general.languageIso == 'DE26')}
{if $companyOnlyLanguage}
    {$showPrivateOption = false}
{/if}
{$amountOfCustomerTypeOption = 0}
{if $showPrivateOption}
    {$amountOfCustomerTypeOption = $amountOfCustomerTypeOption + 1}
{/if}

{if $settings.shop_customer_company || $requireCompanyFields}
    {$amountOfCustomerTypeOption = $amountOfCustomerTypeOption + 1}
{/if}

{if $settings.shop_customer_institution && !$companyOnlyLanguage}
    {$amountOfCustomerTypeOption = $amountOfCustomerTypeOption + 1}
{/if}

{* Markup *}
<div class="flex flex-col gap-1{if $classes} {$classes}{/if}" {if $amountOfCustomerTypeOption < 2}style="display:none;"{/if}>
    
    <label class="text-xs">{$Text.CUSTOMER_TYPE}</label>

    <div class="flex bg-white border border-gray-200 w-full overflow-hidden rounded">
        {if $showPrivateOption}
            <label class="flex-1 border-r border-gray-200 last:border-r-0">
                <input type="radio" name="customer-type" class="hidden peer" value="private"{if $user && $user->Type eq 'Private'} checked="checked"{/if}>
                <div class="flex items-center justify-center text-sm px-4 h-10 cursor-pointer text-gray-500 peer-checked:bg-black peer-checked:text-white transition-colors">
                    {$text.CUSTOMER_TYPE_PRIVATE}
                </div>
            </label>
        {/if}
        {if $settings.shop_customer_company || $requireCompanyFields}
            <label class="flex-1 border-r border-gray-200 last:border-r-0">
                <input type="radio" name="customer-type" class="hidden peer" value="company"{if ($user && $user->Type eq 'Company') || $companyOnlyLanguage} checked="checked"{/if}>
                <div class="flex items-center justify-center text-sm px-4 h-10 cursor-pointer text-gray-500 peer-checked:bg-black peer-checked:text-white transition-colors">
                    {$text.CUSTOMER_TYPE_COMPANY}
                </div>
            </label>
        {/if}
        {if $settings.shop_customer_institution && !$companyOnlyLanguage}
            <label class="flex-1 border-r border-gray-200 last:border-r-0">
                <input type="radio" name="customer-type" class="hidden peer" value="institution"{if $user && $user->Type eq 'Institution'} checked="checked"{/if}>
                <div class="flex items-center justify-center text-sm px-4 h-10 cursor-pointer text-gray-500 peer-checked:bg-black peer-checked:text-white transition-colors">
                    {$text.CUSTOMER_TYPE_INSTITUTION}
                </div>
            </label>
        {/if}
    </div>
</div>

{if $page.isUserEdit && $showPrivateOption}
    <div data-active-on-customer-type="private" style="display: none;" class="absolute">
        <input type="hidden" name="company" value="" disabled>
    </div>

    <div data-active-on-customer-type="private" style="display: none;" class="absolute">
        <input type="hidden" name="vatNumber" value="" disabled>
    </div>

    <div data-active-on-customer-type="private" style="display: none;" class="absolute">
        <input type="hidden" name="eanNumber" value="" disabled>
    </div>
{/if}

{if $settings.shop_customer_company || $requireCompanyFields}
    <label class="flex flex-col gap-1" data-active-on-customer-type="company" style="display: none;">
        <span class="text-xs">{$text.COMPANY}</span>
        <input type="text" name="company" autocomplete="organization" {if $companyName}value="{$companyName}"{/if} id="company" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.COMPANY}" data-is-required disabled>
    </label>
    
    <label class="flex flex-col gap-1" data-active-on-customer-type="company" style="display: none;">
        <span class="text-xs">{$text.VAT_NR}</span>
        <input type="text" name="vatNumber" autocomplete="disable" {if $vatNumber}value="{$vatNumber}"{/if} id="vatNumber" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.VAT_NR}" data-is-required disabled>
    </label>
    
    <label class="flex flex-col gap-1" data-active-on-customer-type="company" style="display: none;">
        <span class="text-xs">{$text.EAN}</span>
        <input type="text" name="eanNumber" autocomplete="disable" {if $eanNumber}value="{$eanNumber}"{/if} id="eanNumber" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.EAN}" disabled>
    </label>
{/if}

{if $settings.shop_customer_institution}
    
    <label class="flex flex-col gap-1" data-active-on-customer-type="institution" style="display: none;">
        <span class="text-xs">{$text.COMPANY_OR_INSTITUTION}</span>
        <input type="text" name="company" autocomplete="organization" {if $companyName}value="{$companyName}"{/if} id="company" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.COMPANY_OR_INSTITUTION}" data-is-required disabled>
    </label>

    {if $page.isUserEdit}
        <div data-active-on-customer-type="institution" style="display: none;" class="absolute">
            <input type="hidden" name="vatNumber" value="" disabled>
        </div>
    {/if}
    

    <label class="flex flex-col gap-1" data-active-on-customer-type="institution" style="display: none;">
        <span class="text-xs">{$text.EAN}</span>
        <input type="text" name="eanNumber" autocomplete="disable" {if $eanNumber}value="{$eanNumber}"{/if} id="eanNumber" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.EAN}" data-is-required disabled>
    </label>
{/if}
