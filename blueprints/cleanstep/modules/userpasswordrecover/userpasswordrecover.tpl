{*

# Description
Controller and template for the User password recovery page type.


## Date last modified
2017-09-15


## Primary variables
+ $page                                                                 - Global scope variable containing all information about the page type
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/widgets/recaptcha/recaptcha.tpl"                			- Recaptcha widget

*}

{*** Meta tag - no noindex,follow ***}
{addMeta name="robots" content="noindex,follow"}

<header class="text-center mb-6 sm:mb-10 md:mb-14">
    <h1 class="text-lg sm:text-xl md:text-2xl">{$text.SEND_PASSWORD_HEADLINE}</h1>
</header>

<form id="cuForm" method="post" action="/actions/user/passwordsend" class="w-[600px] mx-auto max-w-full p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col gap-5">
    {csrf type="input"}

    <label>
        <span class="block mb-2 text-sm font-bold">{$text.LOGIN_USER}</span>
        <input id="m-userpasswordrecover-email" name="email" type="email" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.LOGIN_USER}" required>
    </label>

    {if $settings.spam_check}
        {include file="modules/widgets/recaptcha/recaptcha.tpl" lazyload=false}
    {/if}

    <div class="gap-4 mt-3 hidden lg:flex">
        <button name="submit" type="submit" class="px-5 h-10 rounded bg-black text-white text-sm w-fit">{$text.SEND}</button>
    </div>

</form>