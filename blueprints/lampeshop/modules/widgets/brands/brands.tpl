{* {$pagelink = {page id=$page.productPageId print=Link}}
{collection assign=items controller=productCategory parentId=484}
{entity assign=brandPage controller=productCategory id=484} *}

{$pagelink = {page id=$page.productPageId print=Link}}
{controller type=files assign=controller}
{collection assign=items controller=files type=page id=82}
{entity assign=brandPage controller=productCategory id=484}

{if $items->getActualSize() gt 0}
    <div class="py-6 md:py-16 2xl:py-20">
        <h3 class="text-lg md:text-xl lg:text-2xl tracking-wide text-center mb-6 md:mb-10">{$text.POPULAR_BRANDS}</h3>
        <div data-brands="slider">
            {foreach $items->getData() as $item}

                {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
                {$itemLink = $item->Link}
                {$itemSrc = $item->thumbnail(210, 210)|solutionPath}

                <a href="{$itemLink}" class="block" title="{$itemTitle}">
                    <img src="{$itemSrc}" alt="{$itemTitle}" width="210" height="210" class="w-full h-auto aspect-square object-cover rounded" />
                </a>
            {/foreach}
        </div>
        <div class="mt-6 flex justify-center">
            <a href="/{$pagelink}/{$brandPage->Handle}/" class="w-fit py-3 px-5 rounded text-black text-center text-sm uppercase border border-gray-200">{$text.SEE_ALL_BRANDS}</a>
        </div>
    </div>
{/if}