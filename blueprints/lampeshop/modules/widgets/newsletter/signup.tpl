{*** Check if spam check is enabled ***}
{$displaySpamCheck = $settings.spam_check}

<div class="flex justify-between gap-12">
  <div class="w-full flex flex-col gap-4">
    <h2 class="text-xs font-bold uppercase tracking-widest">{$text.NEWSLETTER_TITLE}</h2>
    {if !$user || $user && !$user->Newsletter}
      <form method="post" action="/actions/newsletter/regmail" accept-charset="UTF-8" data-newsletter="form" role="form" target="_self">
        {csrf type="input"}
        {if !$displaySpamCheck}
            <input type="hidden" name="form" value="quick">
        {/if}
        <input type="hidden" name="type" value="1">
        <div class="relative flex flex-wrap w-full sm:min-w-[500px] p-1 border border-light-gray rounded items-center">
          <span class="text-black/70 flex items-center py-1 px-3">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
            </svg>        
          </span>
          <input name="name"
            class="relative flex-1 min-w-0 w-1% block px-4 leading-normal text-black bg-transparent text-sm placeholder:text-black/40 appearance-none pl-0 border-none outline-none"
            type="text" value="" autocomplete="email" placeholder="{$text.FIRSTNAME}">
          <span class="text-black/70 flex items-center py-1 px-3">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
              stroke="currentColor" class="w-5 h-5">
              <path stroke-linecap="round" stroke-linejoin="round"
                d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75" />
            </svg>
          </span>          
          <input name="email"
            class="relative flex-1 min-w-0 w-1% block px-4 leading-normal text-black bg-transparent text-sm placeholder:text-black/40 appearance-none pl-0 border-none outline-none"
            type="text" value="" autocomplete="email" placeholder="{$text.LOGIN_USER}">

          <button
            class="py-2 px-4 bg-black text-white font-bold rounded w-fit text-center text-xs tracking-widest uppercase h-fit"
            type="submit">{$text.NEWSLETTER_SIGNIN}</button>
        </div>

        {if $displaySpamCheck}
            <div class="overflow-hidden relative">
                <div class="absolute left-[100000px]">
                    {include file="modules/widgets/recaptcha/recaptcha.tpl" lazyload=$lazyloadRecaptcha|default:false}
                </div>
            </div>
        {/if}

      </form>
    {else}
      <p>{$text.USER_NEWSLETTER_REGISTER_CONFIRMATION_HEADER_SUBSCRIBE}</p>
    {/if}
  </div>
</div>