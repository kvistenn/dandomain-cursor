{*

# Description
Controller and template for the User Password Recover Submit page type.


## Date last modified
2017-05-19


## Primary variables
+ $page                                                                 - Global scope variable containing all information about the page type
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

<header class="text-center mb-6 sm:mb-10 md:mb-14">
    <h1 class="text-lg sm:text-xl md:text-2xl">{$text.USER_UPDATE_PASSWORD_HEADLINE}</h1>
</header>

<form class="w-[600px] mx-auto max-w-full p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col gap-5" method="post" action="/actions/user/passwordrecoversubmit">
    {csrf type="input"}
    <input type="hidden" name="code" value="{$smarty.get.code|htmlspecialchars}">

    <label>
        <span class="block mb-2 text-sm font-bold">{$text.USER_UPDATE_PASSWORD_NEW}</span>
        <input name="password" type="password" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.USER_UPDATE_PASSWORD_NEW}" required>
    </label>

    <label>
        <span class="block mb-2 text-sm font-bold">{$text.USER_UPDATE_PASSWORD_NEW_CONFIRM}</span>
        <input name="passwordConfirmation" type="password" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.USER_UPDATE_PASSWORD_NEW_CONFIRM}" required>
    </label>

    <div class="gap-4 mt-3 hidden lg:flex">
        <button name="submit" type="submit" class="px-5 h-10 rounded bg-black text-white text-sm w-fit">{$text.SAVE}</button>
    </div>

</form>