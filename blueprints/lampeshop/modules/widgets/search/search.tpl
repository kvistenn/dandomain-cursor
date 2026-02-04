{if $mobile}

    <div class="w-full block">
        <form class="flex items-center w-full h-12 overflow-hidden" method="get" action="/{if $general.isShop}{page id=$page.productPageId print=Link}{else}{$Text.SEARCH_LINK}{/if}/">
            <input type="text" class="w-full flex-auto h-full px-4 text-sm outline-none" placeholder="{$Text.SEARCH_TEXT}" name="search" required>
            <button type="submit" class="w-14 h-full flex items-center justify-center" title="{$text.SEARCH}">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
                </svg>             
            </button>
        </form>
    </div>
    
{else}

    <form class="flex items-center max-w-[46rem] w-full h-12 rounded overflow-hidden border border-gray-200" method="get" action="/{if $general.isShop}{page id=$page.productPageId print=Link}{else}{$Text.SEARCH_LINK}{/if}/">
        <input type="text" class="w-full flex-auto h-full px-4 text-sm outline-none" placeholder="{$Text.SEARCH_TEXT}" name="search" required>
        <button type="submit" class="w-14 h-full flex items-center justify-center" title="{$text.SEARCH}">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-5 h-5">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
            </svg>             
        </button>
    </form>
    
{/if}
