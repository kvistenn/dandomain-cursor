{$pagelink = {page id=$page.productPageId print=Link}}

<div data-sidebar="overlay" class="fixed w-full h-full bg-black/80 top-0 left-0 opacity-0 pointer-events-none transition-all z-40 min-h-[100dvh]"></div>
<aside data-sidebar="sidebar" class="fixed z-50 w-[24rem] max-w-full h-full bg-white left-0 top-0 -translate-x-full transition-all min-h-[100dvh]">
    <div class="h-full overflow-y-auto">
        
        <div class="flex justify-between p-6">
            <strong>{$text.CATEGORYS}</strong>
            <span class="w-6 h-6 cursor-pointer" data-sidebar="close">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </span>
        </div>

        <div class="flex flex-col gap-6">
            
            {collection assign=categories controller=productCategory}

            <ul class="flex flex-col" data-sidebar="menu">
                
                {foreach $categories->getData() as $category key=i}

                    {collection assign=children controller=productCategory parentId=$category->Id}
                    {$hasChildren = $children->getActualSize() gt 0}

                    <li class="flex-none">
                         <span class="text-sm tracking-wide border-b border-black/10 flex gap-2 items-center justify-between transition-colors{if $i == 0} border-y{/if}">
                            <a href="/{$pagelink}/{$category->Handle}/" class="px-6 py-4 flex-auto">{$category->Title}</a>
                            {if $hasChildren}
                                <span class="px-6 py-4" data-sidebar="toggle">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4 transition-transform">
                                        <path d="M10.75 4.75a.75.75 0 00-1.5 0v4.5h-4.5a.75.75 0 000 1.5h4.5v4.5a.75.75 0 001.5 0v-4.5h4.5a.75.75 0 000-1.5h-4.5v-4.5z" />
                                    </svg>
                                </span>
                            {/if}
                        </span>
                        {if $hasChildren}
                            <div class="hidden">
                                <ul class="flex flex-col p-6 w-full bg-white text-black border-b border-black/10">
                                    {foreach $children->getData() as $child}

                                        {collection assign=grandchildren controller=productCategory parentId=$child->Id}
                                        {$hasGrandchildren = $grandchildren->getActualSize() gt 0}

                                        <li class="mb-6 last:mb-0">
                                    <a href="/{$pagelink}/{$child->Handle}/" class="{if $hasGrandchildren}font-bold text-sm uppercase tracking-wider mb-2 text-gray{else}text-xs text-gray-600 transition-colors hover:text-black{/if} tracking-wide block">{$child->Title}</a>
                                            {if $hasGrandchildren}
                                                <ul class="flex flex-col gap-2">
                                                    {foreach $grandchildren->getData() as $grandchild}
                                                        <li><a href="/{$pagelink}/{$grandchild->Handle}/" class="block text-xs tracking-wider text-gray-600 transition-colors hover:text-black">{$grandchild->Title}</a></li>
                                                    {/foreach}
                                                </ul>
                                            {/if}
                                        </li>
                                    {/foreach}
                                </ul>
                            </div>
                        {/if}
                    </li>

                {/foreach}

            </ul>
        </div>

        <div class="flex justify-between p-6 border-b border-black/10">
            <strong>{$text.PAGES}</strong>
        </div>

        <div class="flex flex-col gap-6">

            {menu assign=items}

            <ul data-sidebar="menu">
                {foreach $items as $item key=i}

                    {$hasChildren = isset($item['children']) and count($item['children']) gt 0}

                    <li>
                        <span class="text-sm tracking-wide border-b justify-between border-black/10 flex{if $i == 0} border-y{/if}">
                            <a href="{if $hasChildren}#{else}{$item.handle|formatUrl}{/if}" class="px-6 py-4 flex-auto">{$item.title}</a>
                            {if $hasChildren}
                                <span class="px-6 py-4" data-sidebar="toggle">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4 transition-transform">
                                        <path d="M10.75 4.75a.75.75 0 00-1.5 0v4.5h-4.5a.75.75 0 000 1.5h4.5v4.5a.75.75 0 001.5 0v-4.5h4.5a.75.75 0 000-1.5h-4.5v-4.5z" />
                                    </svg>
                                </span>
                            {/if}
                        </span>
                        {if $hasChildren}
                            <div class="hidden">
                                <ul class="flex flex-col gap-4 p-5">
                                    {foreach $item['children'] as $child}
                                        <li class="group/child"><a href="{$child.handle|formatUrl}" class="text-xs tracking-wide">{$child.title}</a></li>
                                    {/foreach}
                                </ul>
                            </div>
                        {/if}
                    </li>
                {/foreach}
            </ul>
        </div>

    </div>
</aside>