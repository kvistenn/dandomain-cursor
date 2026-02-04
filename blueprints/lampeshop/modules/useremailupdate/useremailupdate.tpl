{*

# Description
Controller and template for the User Email Change page type


## Date last modified
2017-05-19


## Primary variables
+ $page                                                                 - Global scope variable containing all information about the page type
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

<header class="text-center mb-6 sm:mb-10 md:mb-14">
    <h1 class="text-lg sm:text-xl md:text-2xl">{$text.USER_UPDATE_EMAIL_HEADLINE}</h1>
</header>

<form class="w-[600px] mx-auto max-w-full p-5 lg:p-8 bg-white rounded-lg shadow-lg flex flex-col gap-5" method="post" action="/actions/user/editemail">
    {csrf type="input"}

    <label>
        <span class="block mb-2 text-sm font-bold">{$text.MAIL}</span>
        <input id="m-useremailupdate-email" name="email" type="text" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.MAIL}" required>
    </label>

    <label>
        <span class="block mb-2 text-sm font-bold">{$text.PASSWORD}</span>
        <input id="m-useremailupdate-password" name="password" type="password" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.PASSWORD}" required>
    </label>

    <label>
        <span class="block mb-2 text-sm font-bold">{$text.PASSWORD_CONFIRM}</span>
        <input id="m-useremailupdate-passwordconf" name="passwordConfirm" type="password" class="bg-white border border-gray-300 rounded w-full px-3 h-10 text-sm" placeholder="{$text.PASSWORD_CONFIRM}" required>
    </label>

    <div class="gap-4 mt-3 hidden lg:flex">
        <button name="submit" type="submit" class="px-5 h-10 rounded bg-black text-white text-sm w-fit">{$text.SAVE}</button>
    </div>

</form>