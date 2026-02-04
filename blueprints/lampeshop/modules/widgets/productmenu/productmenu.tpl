{$pagelink = {page id=$page.productPageId print=Link}}
{collection assign=items controller=productCategory}

<nav class="bg-white border-y border-gray-200 hidden xl:block">
    <div class="container mx-auto">
        <div class="relative flex justify-between">
            <ul class="flex items-center gap-8">
                {foreach $items->getData() as $item}

                    {collection assign=children controller=productCategory parentId=$item->Id}
                    {$hasChildren = $children->getActualSize() gt 0}

                    {$parentId = $item->Id}

                    {$megamenu = false}

                    {foreach $children->getData() as $child}
                        {collection assign=secondChildren controller=productCategory parentId=$child->Id}

                        {if $secondChildren->getActualSize() gt 0}
                            {$megamenu = true}
                        {/if}
                    {/foreach}

                    {if $item->Id == 484 || $item->Id == 596}
                        {$megamenu = true}
                    {/if}

                    <li class="py-4{if $hasChildren} group{/if}{if !$megamenu} relative{/if}">

                        <a href="{if $item->Id == "1076"}/{$pagelink}/?new{else}/{$pagelink}/{$item->Handle}/{/if}" class="flex items-center gap-2 text-xs tracking-wider">
                            <span class="whitespace-nowrap">{$item->Title}</span>
                            {if $hasChildren}
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4 2xl:w-5 2xl:h-5 flex-none">
                                    <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
                                </svg>
                            {/if}
                        </a>

                        {if $hasChildren && $item->Id != 484 && $item->Id != 596}

                            {if $megamenu}

                                <div class="z-50 absolute top-full left-0 w-full bg-white scale-y-0 origin-top pointer-events-none group-hover:scale-y-100 group-hover:pointer-events-auto transition-transform p-10 shadow-xl flex gap-10">

                                    <ul class="grid grid-cols-4 gap-10 flex-auto">
                                        {foreach $children->getData() as $child}

                                            {collection assign=grandchildren controller=productCategory parentId=$child->Id}
                                            {$hasChildren = $grandchildren->getActualSize() gt 0}

                                            <li>
                                                <a href="/{$pagelink}/{$child->Handle}/" class="font-bold block mb-2 text-xs">
                                                    {$child->Title}
                                                </a>

                                                {if $hasChildren}
                                                    <ul class="flex flex-col gap-1">
                                                        {foreach $grandchildren->getData() as $grandchild}
                                                            <li>
                                                                <a href="/{$pagelink}/{$grandchild->Handle}/" class="text-xs">
                                                                    {$grandchild->Title}
                                                                </a>
                                                            </li>
                                                        {/foreach}
                                                    </ul>
                                                {/if}
                                            </li>
                                        {/foreach}
                                    </ul>

                                    {controller assign=controller type=files}
                                    {collection assign=banners controller=$controller id=78}

                                    {if $banners->getActualSize() gt 0}
                                        {foreach $banners->getData() as $banner}
                                            {$bannerTitle = $controller->getTranslation($banner->Id, "title")|strip}
                                            {$bannerLink = $banner->Link}
                                            {$bannerParentId = $controller->getTranslation($banner->Id, "linktext")|strip}
                                            {$bannerAlt = $itemTitle}
                                            {$bannerSrc = $banner->thumbnail(400)|solutionPath}
                                            {if $bannerParentId == $parentId}
                                                <div class="w-[400px] flex-none">
                                                    <a href="{$bannerLink}"><img src="{$bannerSrc}" alt="{$bannerAlt}" loading="lazy" width="400"></a>
                                                </div>
                                            {/if}
                                        {/foreach}
                                    {/if}

                                </div>
                            {else}

                                <ul class="min-w-[160px] py-3 flex flex-col shadow-md z-50 absolute top-full left-0 bg-white scale-y-0 origin-top pointer-events-none group-hover:scale-y-100 group-hover:pointer-events-auto transition-transform">
                                    {foreach $children->getData() as $child}

                                        {collection assign=grandchildren controller=productCategory parentId=$child->Id}
                                        {$hasChildren = $grandchildren->getActualSize() gt 0}

                                        <li>
                                            <a href="/{$pagelink}/{$child->Handle}/" class="block py-2 text-xs px-5">
                                                {$child->Title}
                                            </a>
                                        </li>
                                    {/foreach}
                                </ul>

                            {/if}
                        {/if}

                        {if $item->Id == 484 || $item->Id == 596}
                            {$alphabet = ['a' => [], 'b' => [], 'c' => [], 'd' => [], 'e' => [], 'f' => [], 'g' => [], 'h' => [], 'i' => [], 'j' => [], 'k' => [], 'l' => [], 'm' => [], 'n' => [], 'o' => [], 'p' => [], 'q' => [], 'r' => [], 's' => [], 't' => [], 'u' => [], 'v' => [], 'w' => [], 'x' => [], 'y' => [], 'z' => []]}

                            {foreach $children->getData() as $child}
                                {$alphabet[$child->Title[0]][] = $child}
                            {/foreach}

                            <div class="z-50 absolute top-full left-0 w-full bg-white scale-y-0 origin-top pointer-events-none group-hover:scale-y-100 group-hover:pointer-events-auto transition-transform p-10 shadow-xl">
                                <ul class="columns-5 gap-10">
                                    {foreach $alphabet as $letter => $children}
                                        {if $children|count gt 0}
                                            <li class="mb-5 last:mb-0 break-inside-avoid flex">
                                                <a href="/{$pagelink}/{$children[0]->Handle}/" class="font-bold block mb-2 text-xs w-7 h-full flex-none">
                                                    {$letter|upper}
                                                </a>

                                                <ul class="flex flex-col gap-1 flex-auto border-l border-gray-200 pl-4">
                                                    {foreach $children as $child}
                                                        <li>
                                                            <a href="/{$pagelink}/{$child->Handle}/" class="text-xs">
                                                                {$child->Title}
                                                            </a>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            </li>
                                        {/if}
                                    {/foreach}
                                </ul>
                            </div>
                        {/if}

                    </li>

                {/foreach}
            </ul>

            {entity assign=helpPage controller=page id=77}
            <a href="{$helpPage->Handle|formatUrl}" class="py-4 pl-6 flex items-center gap-2 text-xs tracking-wider border-l border-gray-200">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-4 h-4 2xl:w-5 2xl:h-5 flex-none">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M16.712 4.33a9.027 9.027 0 011.652 1.306c.51.51.944 1.064 1.306 1.652M16.712 4.33l-3.448 4.138m3.448-4.138a9.014 9.014 0 00-9.424 0M19.67 7.288l-4.138 3.448m4.138-3.448a9.014 9.014 0 010 9.424m-4.138-5.976a3.736 3.736 0 00-.88-1.388 3.737 3.737 0 00-1.388-.88m2.268 2.268a3.765 3.765 0 010 2.528m-2.268-4.796a3.765 3.765 0 00-2.528 0m4.796 4.796c-.181.506-.475.982-.88 1.388a3.736 3.736 0 01-1.388.88m2.268-2.268l4.138 3.448m0 0a9.027 9.027 0 01-1.306 1.652c-.51.51-1.064.944-1.652 1.306m0 0l-3.448-4.138m3.448 4.138a9.014 9.014 0 01-9.424 0m5.976-4.138a3.765 3.765 0 01-2.528 0m0 0a3.736 3.736 0 01-1.388-.88 3.737 3.737 0 01-.88-1.388m2.268 2.268L7.288 19.67m0 0a9.024 9.024 0 01-1.652-1.306 9.027 9.027 0 01-1.306-1.652m0 0l4.138-3.448M4.33 16.712a9.014 9.014 0 010-9.424m4.138 5.976a3.765 3.765 0 010-2.528m0 0c.181-.506.475-.982.88-1.388a3.736 3.736 0 011.388-.88m-2.268 2.268L4.33 7.288m6.406 1.18L7.288 4.33m0 0a9.024 9.024 0 00-1.652 1.306A9.025 9.025 0 004.33 7.288" />
                </svg>
                <span class="uppercase">{$helpPage->Title}</span>
            </a>
        </div>
    </div>
</nav>