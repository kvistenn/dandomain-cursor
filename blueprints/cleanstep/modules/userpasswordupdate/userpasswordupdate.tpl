<div class="flex flex-col lg:flex-row border border-gray-200 rounded-xl mt-6">

    {include file="modules/userlayout/sidebar.tpl" active=7}

    <div class="flex-auto p-6 lg:p-12 border-t lg:border-l lg:border-t-0 border-gray-200">
        <h1 class="text-xl lg:text-2xl mb-6">{$text.USER_UPDATE_PASSWORD_MENU}</h1>

        <form class="max-w-[600px] flex flex-col gap-6" method="post" action="/actions/user/edit">

            {csrf type="input"}
            
            <div class="flex flex-col lg:grid gap-6 lg:grid-cols-2">

                <label class="flex flex-col gap-1 col-span-2">
                    <span class="text-xs">{$text.USER_UPDATE_PASSWORD_PRESENT}</span>
                    <input name="passwordOld" type="password" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$text.USER_UPDATE_PASSWORD_PRESENT}" required>
                </label>

                <label class="flex flex-col gap-1">
                    <span class="text-xs">{$text.USER_UPDATE_PASSWORD_NEW}</span>
                    <input name="passwordNew" type="password" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$text.USER_UPDATE_PASSWORD_NEW}" required>
                </label>

                <label class="flex flex-col gap-1">
                    <span class="text-xs">{$text.USER_UPDATE_PASSWORD_NEW_CONFIRM}</span>
                    <input name="passwordNewConfirm" type="password" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$text.USER_UPDATE_PASSWORD_NEW_CONFIRM}" required>
                </label>

            </div>

            <div class="mt-4">
                <button type="submit" class="px-4 h-10 flex items-center gap-2 rounded bg-primary text-white text-sm w-fit">
                    {$text.SAVE}
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                    </svg>

                </button>
            </div>

        </form>
    </div>

</div>