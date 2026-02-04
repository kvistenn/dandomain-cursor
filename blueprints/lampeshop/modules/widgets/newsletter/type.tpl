{*

# Description
Template for Newsletter signup consent


## Date last modified
2022-03-18


## Primary variables
+ $text                                                     - Global scope variable containing translations
+ $description                                              - Variable for storing whether we should display newsletter consent description. Possible values: true, false


## Partials (templates)
No extra templates required for this template

*}

{$box = isset($box)}
{$widget = isset($widget)}
{$showDescription = isset($description)}

{$input = "name='type' value='1'"}
{if $page.isUserEdit || $page.isUserCreate || $page.isUserRequest}
	{$input = "name='newsletter'"}
{/if}

{$checked = "{if isset($returnPostData.newsletter) and $returnPostData.newsletter}checked='true'{/if}"}
{if $page.isUserEdit}
	{$checked = "{if $user->Newsletter}checked='checked'{/if}"}
{/if}

{if !isset($newsletterRequired)}
	{$newsletterRequired = true}
{/if}

{if $page.isNewsletter && !$widget}
	<input type="hidden" name="type" value='1'>		
{else}
	<input type="hidden" name="type" value='0'>	
    {if $showDescription}
        <div class="mb-3">
            <strong class="block mb-1">{$text.NEWSLETTER_TYPE_HEADLINE}</strong>
            <p class="text-xs block">{if $general.isShop}{$text.NEWSLETTER_TYPE_TEXT_SHOP}{else}{$text.NEWSLETTER_TYPE_TEXT_CMS}{/if}</p>
        </div>
    {/if}
    <label class="flex items-center border border-light-gray rounded gap-3 text-sm bg-white w-full p-3">
        <input id="m-newsletter-signup{if $box}-box{/if}{if $widget}-widget{/if}" class="w-4 h-4 flex-none" type="checkbox" {$input} {$checked} {if $newsletterRequired}required{/if}> 
        <span class="flex-auto">{$text.NEWSLETTER_TYPE_LABEL}</span>
        {if $box || $widget}
            <span>
                <div class="relative">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z" />
                    </svg>
                    <span class="absolute bottom-full left-1/2 -translate-x-1/2 py-1 px-2 bg-white ">
                        {if $general.isShop}{$text.NEWSLETTER_TYPE_DESCRIPTION_SHOP}{else}{$text.NEWSLETTER_TYPE_DESCRIPTION_CMS}{/if}
                    </span>
                </div>
            </span>
        {else}
            <div class="relative group cursor-help">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z" />
                </svg>
                <span class="absolute bottom-full w-60 right-0 p-2 bg-white  text-xs opacity-0 pointer-events-none transition-opacity group-hover:opacity-100 group-hover:pointer-events-auto">
                    {if $general.isShop}{$text.NEWSLETTER_TYPE_DESCRIPTION_SHOP}{else}{$text.NEWSLETTER_TYPE_DESCRIPTION_CMS}{/if}
                </span>
            </div>
        {/if}
    </label>
{/if}