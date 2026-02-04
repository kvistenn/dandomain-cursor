<form class="flex items-center lg:max-w-lg w-full h-10 rounded-md overflow-hidden border border-gray-400" method="get" action="/{if $general.isShop}{page id=$page.productPageId print=Link}{else}{$Text.SEARCH_LINK}{/if}/">
    <input type="text" class="w-full flex-auto h-full px-3 text-sm outline-none" placeholder="{$Text.SEARCH_TEXT}" name="search" required>
    <button type="submit" class="w-10 h-full flex items-center justify-center" title="{$text.SEARCH}">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
        </svg>             
    </button>
</form>
