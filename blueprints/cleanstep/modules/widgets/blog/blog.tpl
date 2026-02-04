{entity assign=highlight controller=blog pageId=158}
{collection assign=items controller=blog pageId=158 pageSize=11}

{if $items->getActualSize() gt 0}
    <div class="bg-gray-100">
        <div class="container pb-8 lg:pb-16">

            <div class="block -translate-y-4">
                <div class="flex flex-col lg:flex-row mb-6 lg:mb-10 items-center">
                    <div class="w-full lg:w-1/2">
                        {$pageLink = {page id=$highlight->PageId print=Link}}
                        {entity assign=image controller=files type=blog id=$highlight->Id}
                        {if $image}
                            {$itemSrcs = [
                                '1600' => $image->thumbnail(824)|solutionPath,
                                '1400' => $image->thumbnail(684)|solutionPath,
                                '1024' => $image->thumbnail(496)|solutionPath,
                                '768' => $image->thumbnail(736)|solutionPath,
                                '640' => $image->thumbnail(608)|solutionPath,
                                '480' => $image->thumbnail(448)|solutionPath,
                                '320' => $image->thumbnail(288)|solutionPath
                            ]}
                            <a href="/{$pageLink}/{$highlight->Handle}/" class="block">
                                <picture class="w-full aspect-[136/85] mb-4">
                                    {foreach $itemSrcs as $width => $src}
                                        <source srcset="{$src}" media="(min-width: {$width}px)">
                                    {/foreach}
                                    <img src="{$itemSrcs.320}" alt="{$highlight->Title}" width="288" height="144" class="w-full h-auto rounded" loading="lazy">
                                </picture>
                            </a>
                        {/if}
                    </div>
                    <div class="flex flex-col w-full lg:w-1/2 py-4 lg:p-8 xl:p-12">
                        {if $highlight->CategoryIds|@count > 0}
                            <div class="text-gray-500 text-sm mb-2">
                                {foreach $highlight->CategoryIds as $catId}
                                    {entity controller=blogCategory assign=blogCategory id=$catId}
                                    <a href="/{$pageLink}/?cat={$catId}" title="{$blogCategory->Title}">{$blogCategory->Title}</a>{if !$catId@last}, {/if}
                                {/foreach}
                            </div>
                        {/if}
                        <a href="/{$pageLink}/{$highlight->Handle}/" class="text-2xl lg:text-3xl font-bold block mb-6">{$highlight->Title}</a>
                        <a href="/{$pageLink}/{$highlight->Handle}/" class="text-sm lg:text-base underline font-bold">{$text.PRODUCT_CATALOG_READ_MORE}</a>
                    </div>
                </div>
            </div>

            <div data-swiper="blog" class="relative">
                <strong class="text-2xl font-bold block mb-6">{$text.INSPIRATION_HEADLINE}</strong>
                <div class="swiper">
                    <div class="swiper-wrapper">
                        {foreach $items->getData() as $item key=key}

                            {if $key !== 0}

                                {$pageLink = {page id=$item->PageId print=Link}}
                                
                                {entity assign=image controller=files type=blog id=$item->Id}

                                <div class="swiper-slide h-auto flex flex-col bg-white rounded-md overflow-hidden">
                                    {if $image}
                                        {$imageURL = $image->thumbnail(220, 154)|solutionPath}
                                        <a href="/{$pageLink}/{$item->Handle}/" class="block">
                                            <img src="{$imageURL}" alt="{$item->Title}" width="220" height="154" class="w-full h-auto aspect-[220/154] object-cover" loading="lazy" />
                                        </a>
                                    {/if}
                                    <div class="p-4 flex flex-col flex-auto">
                                        {if $item->CategoryIds|@count > 0}
                                            <div class="text-gray-500 text-xs mb-1">
                                                {foreach $item->CategoryIds as $catId}
                                                    {entity controller=blogCategory assign=blogCategory id=$catId}
                                                    <a href="/{$pageLink}/?cat={$catId}" title="{$blogCategory->Title}">{$blogCategory->Title}</a>{if !$catId@last}, {/if}
                                                {/foreach}
                                            </div>
                                        {/if}
                                        <a href="/{$pageLink}/{$item->Handle}/" class="font-bold text-base line-clamp-3 mb-auto">{$item->Title}</a>
                                        <a href="/{$pageLink}/{$item->Handle}/" class="font-bold text-sm mt-2 underline">{$text.PRODUCT_CATALOG_READ_MORE}</a>
                                    </div>
                                </div>

                            {/if}
                        {/foreach}
                    </div>
                </div>
                <div class="swiper-button-next hidden xl:flex w-12 h-12 bg-white rounded-md shadow-lg items-center justify-center border border-gray-400 -right-4">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-5 !h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                    </svg>
                </div>
                <div class="swiper-button-prev hidden xl:flex w-12 h-12 bg-white rounded-md shadow-lg items-center justify-center border border-gray-400 -left-4">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-5 !h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                    </svg>
                </div>
            </div>
        </div>
    </div>
{/if}