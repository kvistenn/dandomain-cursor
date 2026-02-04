{*

# Description
Controller for the Contact Page page type.


## Date last modified
2021-08-24


## Primary variables
+ $controller 															- Instance of contactController
+ $contactPage 															- Entity of contactController (the contactPage)
+ $text                                                     			- Global scope variable containing translations
+ $page 																- Global scope variable containing all information about the page type


## Partials (templates)
+ "/modules/widgets/recaptcha/recaptcha.tpl"							- Recaptcha widget, for displaying a google recaptcha element
+ "/modules/widgets/meta/opengraph.tpl"                     			- Social meta data

*}


{*** Global widgets defaults ***}
{$opengraph_image = null}
{$opengraph_description = null}

{controller type=contact assign=controller}

{* Fetch settings for Contact page *}
{entity controller=$controller assign=contactPage}

{controller type=page assign=pageCtrl}

{* Fetch translation for Contact page *}
{$contactPageData = $controller->getMeta($contactPage->PageId)}

<div itemscope itemtype="http://schema.org/ContactPage" class="flex flex-col gap-8">

    <div class="flex flex-col gap-8 md:grid md:grid-cols-2 md:gap-12">
        <div class="flex flex-col gap-4 text-sm text-gray-600">
            {if $contactPage->DisplayTitle}
                <strong class="text-2xl mb-2 text-black">{$contactdata.name}</strong>
            {/if}

            {$adressesText = $pageCtrl->getText(186)}
            {if !empty($adressesText)}
                <div class="prose max-w-full mb-4">
                    {$adressesText}
                </div>
            {else}
                {if $contactPage->DisplayAddress}
                    <div class="flex gap-2 items-center">
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" /></svg>
                        </span>
                        <span>
                            {$contactdata.address}{if $contactPage->DisplayZipcode || $contactPage->DisplayCity}, {$contactdata.zipcode} {$contactdata.city}{/if}{if $contactPage->DisplayCountry} {$contactdata.country}{/if}
                        </span>
                    </div>
                {/if}
            {/if}

            {if $contactPage->DisplayContactPerson}
                <div class="flex gap-2 items-center">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" /></svg>
                    </span>
                    <span>
                        {$text.CONTACT_PERSON}: {$contactdata.contactperson}
                    </span>
                </div>
            {/if}

            {if $contactPage->DisplayPhone}
                <div class="flex gap-2 items-center">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 01-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 00-1.091-.852H4.5A2.25 2.25 0 002.25 4.5v2.25z" /></svg>
                    </span>
                    <span>
                        {$contactdata.phone}
                    </span>
                </div>
            {/if}

            {if $contactPage->DisplayMobile}
                <div class="flex gap-2 items-center">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 1.5H8.25A2.25 2.25 0 006 3.75v16.5a2.25 2.25 0 002.25 2.25h7.5A2.25 2.25 0 0018 20.25V3.75a2.25 2.25 0 00-2.25-2.25H13.5m-3 0V3h3V1.5m-3 0h3m-3 18.75h3" /></svg>
                    </span>
                    <span>
                        {$contactdata.mobilephone}
                    </span>
                </div>
            {/if}

            {if $contactPage->DisplayEmail}
                {if $settings.spam_email_block}
                    {$email = $contactdata.email|replace:'@':'---'}
                    {placeholdImage assign=placeholder text=$email color=$template.settings.FONT_COLOR_PRIMARY atreplace='---' transparent=true size=10}
                       <a href="/obfuscated/" onclick="var m = '{$email}'; this.href = 'mailto:' + m.replace('---', '@'); return true;">
                           <span>
                                {img style="margin:0; vertical-align: middle;" alt="" src="{$placeholder->getRelativeFile()}"}
                            </span>
                       </a>
                {else}
                    <div class="flex gap-2 items-center">
                       <span>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75" /></svg>
                       </span>
                       <span>
                           <a href="mailto:{$contactdata.email}">{$contactdata.email}</a>
                       </span>
                   </div>
                {/if}
            {/if}

            {if $contactPage->DisplayTaxnumber}
                <div class="flex gap-2 items-center">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M8.25 21v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21m0 0h4.5V3.545M12.75 21h7.5V10.75M2.25 21h1.5m18 0h-18M2.25 9l4.5-1.636M18.75 3l-1.5.545m0 6.205l3 1m1.5.5l-1.5-.5M6.75 7.364V3h-3v18m3-13.636l10.5-3.819" /></svg>
                    </span>
                    <span>
                        {$contactdata.vatnumber}
                    </span>
                </div>
            {/if}

            {if $contactPage->DisplayWebsite}
                <div class="flex gap-2 items-center">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 008.716-6.747M12 21a9.004 9.004 0 01-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 017.843 4.582M12 3a8.997 8.997 0 00-7.843 4.582m15.686 0A11.953 11.953 0 0112 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0121 12c0 .778-.099 1.533-.284 2.253m0 0A17.919 17.919 0 0112 16.5c-3.162 0-6.133-.815-8.716-2.247m0 0A9.015 9.015 0 013 12c0-1.605.42-3.113 1.157-4.418" /></svg>
                    </span>
                    <span>
                        <a href="{$contactdata.url}">{$contactdata.displayUrl}</a>
                    </span>
                </div>
            {/if}
        </div>
        <form id="m-contact" method="post" action="/actions/contact/send" class="flex flex-col gap-5">
            <h1 class="text-2xl font-bold text-black" itemprop="headline">{$page.headline}</h1>
            {csrf type="input"}
            <input id="m-contact-subject" name="subject" type="text" class="bg-gray-100 appearance-none rounded w-full p-3 text-gray-700 leading-tight text-sm focus:outline-none focus:shadow-outline" placeholder="{$text.SUBJECT}" {if $returnPostData.subject}value="{$returnPostData.subject}"{/if} required>
            <input id="m-contact-name" name="name" type="text" class="bg-gray-100 appearance-none rounded w-full p-3 text-gray-700 leading-tight text-sm focus:outline-none focus:shadow-outline" placeholder="{$text.NAME}" {if $returnPostData.name}value="{$returnPostData.name}"{/if} required>
            <input id="m-contact-email" name="email" type="email" class="bg-gray-100 appearance-none rounded w-full p-3 text-gray-700 leading-tight text-sm focus:outline-none focus:shadow-outline" placeholder="{$text.MAIL}" {if $returnPostData.email}value="{$returnPostData.email}"{/if} required>
            <input id="m-contact-phone" name="phone" type="text" class="bg-gray-100 appearance-none rounded w-full p-3 text-gray-700 leading-tight text-sm focus:outline-none focus:shadow-outline" placeholder="{$text.TELEPHONE}" {if $returnPostData.phone}value="{$returnPostData.phone}"{/if} required>
            <textarea id="m-contact-message" name="message" class="bg-gray-100 appearance-none rounded w-full h-36 p-3 text-gray-700 leading-tight text-sm focus:outline-none focus:shadow-outline" placeholder="{$text.MESSAGE}" required>{if $returnPostData.message}{$returnPostData.message}{/if}</textarea>
            {if $settings.spam_check}
                {include file="modules/widgets/recaptcha/recaptcha.tpl" lazyload=$lazyloadRecaptcha|default:false}
            {/if}
            {if $settings.privacy_policy_contact}
                {include file="modules/widgets/consent/consent.tpl"}
            {/if}
            <button type="submit" class="block w-fit bg-primary text-white px-8 py-3 rounded-full text-center">{$text.SEND}</button>
        </form>
    </div>

</div>