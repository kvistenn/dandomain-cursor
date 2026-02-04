<!-- Topbar -->
<div class="bg-white text-black text-xs border-b border-black/10">
    <div class="container mx-auto flex py-3 gap-10 justify-between">
        <div class="flex items-center">
            {include file="modules/widgets/usp/usp.tpl" id=68}
        </div>
        <div class="hidden md:flex flex-none w-fit justify-end items-center gap-4">
            <a href="https://dk.trustpilot.com/review/www.lampeshop.dk">
                {* <img src="{$template.path}/assets/images/icon-trustpilot-stars.svg" width="24" height="24" alt="Trustpilot" class="w-auto h-[18px]"> *}
                {$text.TRUSTPILOT}
            </a>
            {if $general.languageIso639 === 'da'}
                <a href="https://certifikat.emaerket.dk/lampeshop.dk">
                    <img src="{$template.path}/assets/images/icon-emaerket.svg" width="24" height="24" alt="E-mærket" class="w-8 h-8">
                </a>
                {/if}
        </div>
    </div>
</div>

<!-- Header -->
<header class="bg-white">
    <div class="container mx-auto">
        <div class="flex h-14 sm:h-16 md:h-20 lg:h-28 2xl:h-32 gap-4 justify-between md:justify-start md:gap-10 relative">

            <div class="h-full flex flex-auto md:w-20% md:flex-none items-center">
                {include file='modules/widgets/logo/logo.tpl'}
            </div>

            <div class="flex-auto hidden items-center justify-center md:flex">
                {if $template.settings.SETTINGS_SHOW_SEARCH}
                    {include file='modules/widgets/search/search.tpl' mobile=false}
                {/if}
            </div>

            <div class="flex justify-end w-fit md:w-20% flex-none items-center gap-3 md:gap-6">

                {if $user}
                    <div class="group relative flex flex-col items-center gap-2"
                        title="{$text.ACCOUNT_LOGGEDIN_MENU}">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6 flex-none">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                        <small class="text-xs hidden xl:block">{$text.ACCOUNT_LOGGEDIN_MENU}</small>
                        <div
                            class="w-48 absolute scale-y-0 origin-top top-full pointer-events-none -right-4 px-4 py-3 bg-white text-black shadow-md rounded flex flex-col gap-2 transition-transform z-40 group-hover:pointer-events-auto group-hover:scale-y-100">
                            <ul class="flex flex-col gap-3 text-sm">
                                <li><a href="{$text.USER_UPDATE_LINK|formatUrl}"
                                        class="block transition-colors text-gray-400 hover:text-black">{$text.USER_UPDATE_MENU}</a>
                                </li>
                                <li><a href="{$text.MY_ORDERS_LINK|formatUrl}"
                                        class="block transition-colors text-gray-400 hover:text-black">{$text.MY_ORDERS_MENU}</a>
                                </li>
                                <li><a href="#" data-action="logout"
                                        class="block transition-colors text-gray-400 hover:text-black">{$text.LOGOUT_HEADLINE}</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                {else}
                    <a data-fancybox data-src="#login" href="#" class="flex flex-col items-center gap-2" title="{$text.ACCOUNT_MENU}">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6 flex-none">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                        <small class="text-xs hidden xl:block">{$text.ACCOUNT_MENU}</small>
                    </a>
                {/if}

                {entity assign=storePage controller=page id=26}
                <a href="{$storePage->Handle|formatUrl}" class="flex flex-col items-center gap-2">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6 flex-none">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" />
                    </svg>
                    <small class="text-xs hidden xl:block">{$text.FIND_STORE}</small>
                </a>

                {if $settings.module_shop_wishlist}
                    {if $user}
                        <div data-wishlist="open" class="flex flex-col items-center gap-2 cursor-pointer relative" title="{$text.FAVORITES_MENU}">
                            <span data-wishlist="count" class="w-4 h-4 rounded-full bg-white border border-black text-black text-xs flex items-center justify-center absolute -top-1 right-0 empty:hidden"></span>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6 flex-none">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                            </svg>
                            <small class="text-xs hidden xl:block">{$text.FAVORITES_MENU}</small>
                        </div>
                    {else}
                        <a data-fancybox data-src="#login" href="#" class="flex flex-col items-center gap-2 cursor-pointer relative" title="{$text.FAVORITES_MENU}">
                            <span data-wishlist="count" class="w-4 h-4 rounded-full bg-white border border-black text-black text-xs flex items-center justify-center absolute -top-1 right-0 empty:hidden"></span>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6 flex-none">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                            </svg>
                            <small class="text-xs hidden xl:block">{$text.FAVORITES_MENU}</small>
                        </a>
                    {/if}
                {/if}

                {if $user}
                    <a href="{$text.MY_ORDERS_LINK|formatUrl}" class="flex flex-col items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6 flex-none">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99" />
                        </svg>
                        <small class="text-xs hidden xl:block">{$text.BUY_MENU}</small>
                    </a>
                {/if}

                {if $general.isShop && $template.settings.SETTINGS_SHOW_CART && $page.type != 'cart' && $page.type != 'checkout'}

                    {collection controller=cart assign=cart}
                    {$cartList = $cart->groupByClass()}

                    {$cartCount = null}
                    {if $cart->getActualSize() neq 0}
                        {$cartCount = $cart->getActualSize()}
                    {/if}

                    <div data-cart="open" class="cursor-pointer flex flex-col items-center gap-2 relative">
                        <span data-cart="count" class="w-4 h-4 rounded-full bg-white border border-black text-black text-xs flex items-center justify-center absolute -top-1 -right-1 empty:hidden">{$cartCount}</span>
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6 flex-none">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.12-1.243l1.264-12A1.125 1.125 0 015.513 7.5h12.974c.576 0 1.059.435 1.119 1.007zM8.625 10.5a.375.375 0 11-.75 0 .375.375 0 01.75 0zm7.5 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                        </svg>
                        <small class="text-xs hidden xl:block">{$text.CART_MENU_CUSTOM}</small>
                    </div>
                {/if}

            </div>

        </div>

    </div>
</header>

<div class="flex xl:hidden border-y border-gray-200">
    <div class="flex items-center justify-center w-12 h-12 border-r border-gray-200 flex-none" data-sidebar="open">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6 flex-none">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
        </svg>
    </div>
    {include file='modules/widgets/search/search.tpl' mobile=true}
</div>

{include file='modules/widgets/productmenu/productmenu.tpl'}