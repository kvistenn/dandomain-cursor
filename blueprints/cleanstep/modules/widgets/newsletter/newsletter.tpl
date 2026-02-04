<div class="bg-gray-100">
    <div class="border-b border-white/20 py-6 md:py-14">
        <div class="container mx-auto grid grid-cols-1 grid-rows-2 gap-4 md:gap-0 md:grid-cols-2 md:grid-rows-1">
            <div class="flex flex-col gap-2">
                <strong class="md:text-xl">{$text.NEWSLETTER_TYPE_HEADLINE}</strong>
                <p>{$text.NEWSLETTER_TYPE_TEXT_SHOP}</p>
            </div>
            <div class="flex justify-center">
                {* <form class="relative w-[700px] max-w-full flex gap-4 items-center" method="post" action="/actions/newsletter/regmail">
                    <input type="hidden" name="type" value="1">
                    <input type="email" name="email" placeholder="{$text.MAIL}" class="w-full px-4 h-11 rounded text-sm" required />
                    <button type="submit" class="px-4 h-11 text-white bg-gray-900 hover:bg-black transition duration-200 rounded uppercase text-xs font-bold tracking-wider">{$text.NEWSLETTER_SIGNIN}</button>
                </form> *}
                <form action="https://cleanstep.us10.list-manage.com/subscribe/post?u=f614613b1a36021da37fc368e&amp;id=fd12631a6f&amp;f_id=007c93e3f0" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate relative w-[700px] max-w-full flex gap-4 items-center" target="_self" novalidate="">
                    <input type="email" name="EMAIL" placeholder="{$text.MAIL}" class="required email w-full px-4 h-11 rounded text-sm" id="mce-EMAIL" required="" value="">
                    <div id="mce-responses" class="clear">
                        <div class="response" id="mce-error-response" style="display: none;"></div>
                        <div class="response" id="mce-success-response" style="display: none;"></div>
                    </div>
                    <div aria-hidden="true" style="position: absolute; left: -5000px;">
                        <input type="text" name="b_f614613b1a36021da37fc368e_fd12631a6f" tabindex="-1" value="">
                    </div>
                    <input type="submit" name="subscribe" id="mc-embedded-subscribe" class="px-4 h-11 text-white bg-gray-900 hover:bg-black transition duration-200 rounded uppercase text-xs font-bold" value="{$text.NEWSLETTER_SIGNIN}">
                </form>
            </div>
        </div>
    </div>
</div>