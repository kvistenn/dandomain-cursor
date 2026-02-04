{controller type=files assign=controller}
{collection assign=items controller=$controller pageSize=$pageSize id=$id}

<div data-swiper="usp" class="swiper block w-full leading-none">
    <div class="swiper-wrapper">
        {foreach $items->getData() as $item}

            {$itemSrc = $item->getRelativeFile()}
            {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
            {$itemText = $controller->getTranslation($item->Id, "text")|strip}
            {$itemLink = $item->Link}
            {$itemLinkText = $controller->getTranslation($item->Id, "linktext")|strip}
            {$itemAlt = $itemTitle}

            <div class="swiper-slide flex items-center justify-center gap-2">
                <a href="{$itemLink}" class="flex gap-2 justify-center">
                    <div class="flex-none">
                        <img src="{$itemSrc}" alt="{$itemAlt}" class="w-4 h-4" width="24" height="24" loading="lazy" />
                    </div>
                    <div>
                        <span class="text-xs block whitespace-nowrap">{$itemTitle}</span>
                    </div>
                </a>
            </div>
        {/foreach}
    </div>
</div>