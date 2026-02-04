<header data-component="header" class="bg-white border-b border-gray-200 sticky top-0 left-0 w-full z-50 [&.hide]:-translate-y-full transition-transform">
    <div class="container">
        <div class="grid grid-cols-2 lg:flex py-4 gap-3 sm:gap-4 lg:gap-8">
            <div class="col-span-1 w-fit xl:w-auto xl:flex-1 xl:max-w-1/2 flex items-center gap-3 sm:gap-4 lg:gap-8 order-1">

                <button class="flex items-center gap-2 leading-none text-sm sm:p-3 rounded-md sm:bg-gray-200 sm:hover:bg-gray-300 transition-all" data-sidebar="open" aria-label="Menu" type="button">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor" class="w-5 h-5 sm:w-4 sm:h-4">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
                    </svg>
                    <strong class="hidden md:block">{$text.MENU}</strong>
                </button>

                <div class="flex-none">
                {include file='modules/widgets/logo/logo.tpl' classes="h-8 md:h-10 lg:h-14 w-auto"}
                </div>

            </div>

            <div class="col-span-2 w-full flex-[2] flex justify-center items-center order-2 lg:order-1">
                {include file='modules/widgets/search/search.tpl'}
            </div>

            <div class="col-span-1 flex-auto xl:w-auto xl:flex-1 xl:max-w-1/2 flex justify-end items-center gap-3 sm:gap-4 lg:gap-8 order-1">

                {if $general.languageIso == 'DK26'}
                    {include file='modules/widgets/togglevat/togglevat.tpl' type="small"}
                {/if}

                {if $general.languageIso == 'DK26'}
                    <a href="https://certifikat.emaerket.dk/cleanstep.dk" target="_blank" class="flex flex-col items-center gap-1" title="E-m&aelig;rket">
                        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 32 24" width="32" height="24" class="h-5 lg:h-6 w-auto">
                            <path d="M4.9,11.3H1.5c-.2,0-.3-.1-.3-.3s0-.1,0-.2c.5-.8,1.7-2.5,4-4.2h0c0,0,2.5-2.2,6.9-3.1,0,0,6-1.4,11.8,1.3,0,0,4.8,2.4,6.9,6.1,0,.2,0,.4-.1.4,0,0-.1,0-.2,0h-1.5c-.5,0-.9-.3-1.1-.7-.4-.8-1.4-2-3.3-3.4,0,0-3.5-2.6-8.9-2,0,0-3.1.2-5.7,1.8h0c0,0-1.6.8-3.9,3.7-.3.4-.7.6-1.1.6h0Z"/>
                            <path d="M27.1,12.7h3.4c.2,0,.3.1.3.3s0,.1,0,.2c-.5.8-1.7,2.5-4,4.2,0,0,0,0,0,0,0,0-2.5,2.2-6.8,3.1,0,0-6,1.4-11.8-1.3,0,0-4.8-2.4-6.9-6.1,0-.2,0-.4.1-.4,0,0,.1,0,.2,0h1.4c.5,0,.9.3,1.1.7.4.8,1.4,2,3.3,3.4,0,0,3.5,2.6,8.9,2,0,0,3.1-.2,5.7-1.8h0c0,0,1.7-.8,3.9-3.7.3-.4.7-.6,1.1-.6h0Z"/>
                            <path d="M19.5,13.4c-.4,0-.7.2-1,.5-.3.4-.8.9-1.5,1.1,0,0-1.9.7-3.2-.9l7.1-3.2c.3-.1.4-.5.3-.7-.8-2.1-2.9-3.5-5.2-3.5-2.8,0-5.1,2.4-5.2,5.2,0,3,2.3,5.4,5.2,5.5,2.4,0,4.5-1.5,5.3-3.8,0-.2,0-.3-.2-.4,0,0,0,0,0,0h-1.5s0,0,0,0ZM13,12.2c0-1.7,1.4-3,3-3s1.8.4,2.3,1.1l-5.3,2.4c0-.2,0-.3,0-.5h0Z"/>
                        </svg>
                        <span class="hidden sm:block text-[10px] lg:text-xs whitespace-nowrap">E-m&aelig;rket</span>
                    </a>
                {/if}

                {if $settings.module_shop_wishlist}
                    {if $user}
                        <div data-wishlist="open" class="relative cursor-pointer flex flex-col items-center text-center gap-1" title="{$text.WISHLIST_MENU}">
                            <span data-wishlist="count" class="w-4 h-4 rounded-full bg-black text-white text-xs flex items-center justify-center absolute -top-2 -right-2 empty:hidden"></span>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="h-5 lg:h-6 w-auto">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                            </svg>
                            <span class="hidden sm:block text-[10px] lg:text-xs whitespace-nowrap">{$text.WISHLIST_MENU}</span>
                        </div>
                    {/if}
                {/if}

                <a href="{$text.COMPARE_LINK}" class="relative hidden sm:flex flex-col items-center gap-1" title="{$text.COMPARE_MENU}">
                    <span data-compare="count" class="w-4 h-4 rounded-full bg-black text-white text-xs flex items-center justify-center absolute -top-2 -right-2 empty:hidden">1</span>
                    <svg xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 24 24" width="24" height="24" class="h-5 lg:h-6 w-auto">
                        <path d="M24,5c0-2.206-1.794-4-4-4s-4,1.794-4,4c0,1.86,1.277,3.428,3,3.873v8.127c0,.551-.449,1-1,1h-4.996l2.203-2.203-1.414-1.414-3.256,3.256c-.774,.775-.774,2.037,0,2.812l3.256,3.256,1.414-1.414-2.304-2.293h5.097c1.654,0,3-1.346,3-3V8.873c1.723-.445,3-2.013,3-3.873Zm-4,2c-1.103,0-2-.897-2-2s.897-2,2-2,2,.897,2,2-.897,2-2,2Zm-9.838,2.662l3.256-3.255c.775-.775,.775-2.037,0-2.812L10.162,.338l-1.414,1.414,2.259,2.248H6c-1.654,0-3,1.346-3,3V15.127c-1.723,.445-3,2.013-3,3.873,0,2.206,1.794,4,4,4s4-1.794,4-4c0-1.86-1.277-3.428-3-3.873V7c0-.551,.449-1,1-1h4.995l-2.248,2.248,1.414,1.414Zm-4.162,9.338c0,1.103-.897,2-2,2s-2-.897-2-2,.897-2,2-2,2,.897,2,2Z"/>
                    </svg>
                    <span class="hidden sm:block text-[10px] lg:text-xs whitespace-nowrap">{$text.COMPARE_MENU}</span>
                </a>

                {if !$user}
                    <a data-fancybox data-src="#login" href="#" class="flex flex-col items-center gap-1" title="{$text.ACCOUNT}">
                        <svg id="Layer_1" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" data-name="Layer 1" width="24" height="24" class="h-5 lg:h-6 w-auto">
                            <path d="m12 1c-7.71 0-11 3.29-11 11s3.29 11 11 11 11-3.29 11-11-3.29-11-11-11zm-4.293 19.475c.377-1.544 1.37-2.475 4.293-2.475s3.917.931 4.293 2.475c-1.176.357-2.594.525-4.293.525s-3.117-.168-4.293-.525zm10.413-.845c-1.012-3.217-3.916-3.631-6.119-3.631s-5.107.413-6.119 3.631c-2.028-1.35-2.881-3.774-2.881-7.631-.001-6.56 2.438-8.999 8.999-8.999s9 2.439 9 9c0 3.857-.853 6.281-2.881 7.631zm-6.12-13.63c-2.691 0-4 1.309-4 4s1.309 4 4 4 4-1.309 4-4-1.309-4-4-4zm0 6c-1.589 0-2-.411-2-2s.411-2 2-2 2 .411 2 2-.411 2-2 2z"/>
                        </svg>
                        <span class="hidden sm:block text-[10px] lg:text-xs whitespace-nowrap">{$text.ACCOUNT}</span>
                    </a>
                {else}
                    <a href="/{$text.USER_UPDATE_LINK}/" class="flex flex-col items-center gap-1" title="{$text.ACCOUNT}">
                        <svg id="Layer_1" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" data-name="Layer 1" width="24" height="24" class="h-5 lg:h-6 w-auto">
                            <path d="m12 1c-7.71 0-11 3.29-11 11s3.29 11 11 11 11-3.29 11-11-3.29-11-11-11zm-4.293 19.475c.377-1.544 1.37-2.475 4.293-2.475s3.917.931 4.293 2.475c-1.176.357-2.594.525-4.293.525s-3.117-.168-4.293-.525zm10.413-.845c-1.012-3.217-3.916-3.631-6.119-3.631s-5.107.413-6.119 3.631c-2.028-1.35-2.881-3.774-2.881-7.631-.001-6.56 2.438-8.999 8.999-8.999s9 2.439 9 9c0 3.857-.853 6.281-2.881 7.631zm-6.12-13.63c-2.691 0-4 1.309-4 4s1.309 4 4 4 4-1.309 4-4-1.309-4-4-4zm0 6c-1.589 0-2-.411-2-2s.411-2 2-2 2 .411 2 2-.411 2-2 2z"/>
                        </svg>
                        <span class="hidden sm:block text-[10px] lg:text-xs whitespace-nowrap">{$text.ACCOUNT}</span>
                    </a>
                {/if}

                {collection controller=cart assign=cart}
                {$cartList = $cart->groupByClass()}

                {$cartCount = null}
                {if $cart->getActualSize() neq 0}
                    {$cartCount = $cart->getActualSize()}
                {/if}

                <button data-cart="open" type="button" class="relative cursor-pointer flex flex-col items-center gap-1" title="{$text.CART_MENU}">
                    <span data-cart="count" class="w-4 h-4 rounded-full bg-black text-white text-xs flex items-center justify-center absolute -top-2 -right-2 empty:hidden">{$cartCount}</span>
                    <svg xmlns="http://www.w3.org/2000/svg" id="Outline" viewBox="0 0 24 24" width="24" height="24" class="h-5 lg:h-6 w-auto">
                        <path d="M22.713,4.077A2.993,2.993,0,0,0,20.41,3H4.242L4.2,2.649A3,3,0,0,0,1.222,0H1A1,1,0,0,0,1,2h.222a1,1,0,0,1,.993.883l1.376,11.7A5,5,0,0,0,8.557,19H19a1,1,0,0,0,0-2H8.557a3,3,0,0,1-2.82-2h11.92a5,5,0,0,0,4.921-4.113l.785-4.354A2.994,2.994,0,0,0,22.713,4.077ZM21.4,6.178l-.786,4.354A3,3,0,0,1,17.657,13H5.419L4.478,5H20.41A1,1,0,0,1,21.4,6.178Z"/>
                        <circle cx="7" cy="22" r="2"/>
                        <circle cx="17" cy="22" r="2"/>
                    </svg>
                    <span class="hidden sm:block text-[10px] lg:text-xs whitespace-nowrap">{$text.CART_MENU}</span>
                </button>

            </div>
        </div>
    </div>        
</header>