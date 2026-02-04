{*

# Description
Controller and template for the User Login page type


## Date last modified
2021-07-12


## Primary variables
+ $deliveryCountries 													- Collection of deliveryCountryController
+ $interestFields 														- Collection of interestFieldController
+ $page                                                                 - Global scope variable containing all information about the page type
+ $settings                                                             - Global scope variable containing platform settings
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/widgets/meta/opengraph.tpl"                                 - Social meta data

*}


{*** Global widgets defaults ***}
{$opengraph_image = null}
{$opengraph_title = $text.LOGIN_HEADLINE}
{$opengraph_description = $text.LOGIN_TEXT}

{*** Meta tag - no noindex,follow ***}
{addMeta name="robots" content="noindex,follow"}

<header class="text-center mb-6 sm:mb-10 md:mb-14">
    <h1 class="text-lg sm:text-xl md:text-2xl">{$text.LOGIN_HEADLINE}</h1>
</header>

<form class="w-[600px] mx-auto max-w-full p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col gap-5" method="post" action="/actions/user/recaptchalogin" autocomplete="off">
    {csrf type="input"}

    {if isset($smarty.get.goto)}
        <input type="hidden" name="goto" value="{$smarty.get.goto|htmlspecialchars}">
    {/if}

    <label>
        <span class="block mb-2 text-sm font-bold">{$text.LOGIN_USER}</span>
        <input name="username" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.LOGIN_USER}" required>
    </label>

    <label>
        <span class="block mb-2 text-sm font-bold">{$text.LOGIN_PASSWORD}</span>
        <input name="password" type="password" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.LOGIN_PASSWORD}" required>
    </label>

    <label class="flex items-center gap-2 text-sm">
        <input name="auto_login" type="checkbox">
        <span class="block text-sm">{$text.USER_REMEMBER_LOGIN}</span>
    </label>

    <ul>
        {if $settings.user_password_resend}
            <li><a class="text-sm underline" href="/{$text.SEND_PASSWORD_LINK}/" title="{$text.SEND_PASSWORD_QUESTION}">{$text.SEND_PASSWORD_QUESTION}</a></li>
        {/if}
        {if $settings.shop_b2b_customer_approval}
            <li><a class="text-sm underline" href="/{$text.USER_ADD_B2B_LINK}/" title="{$text.USER_ADD_B2B_MENU}">{$text.USER_ADD_B2B_MENU}</a></li>
        {/if}
    </ul>

    {if $settings.spam_check}
        {include file="modules/widgets/recaptcha/recaptcha.tpl" lazyload=true}
    {/if}

    <div class="gap-4 mt-3 flex items-center">
        <button class="px-5 h-10 rounded bg-black text-white text-sm w-fit" type="submit">{$text.LOGIN_MENU}</button>
        {if $access.user && $settings.user_add}
            <a class="text-sm underline" href="/{$text.USER_ADD_LINK}/" title="{$text.USER_ADD_MENU}">{$text.USER_ADD_MENU}</a>
        {/if}
    </div>

</form>

{*** Global widgets ***}
{include file="modules/widgets/meta/opengraph.tpl"
	og=["title" => $opengraph_title, "description" => $opengraph_description, "image" => $opengraph_image]
}