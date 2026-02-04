{controller type=files assign=controller}
{collection assign=items controller=$controller pageSize=$pageSize id=$id}

<div data-usp="slider" class="block w-full h-fit">
    {foreach $items->getData() as $item}

        {$itemSrc = $item->getRelativeFile()}
        {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
        {$itemText = $controller->getTranslation($item->Id, "text")|strip}
        {$itemLink = $item->Link}
        {$itemLinkText = $controller->getTranslation($item->Id, "linktext")|strip}
        {$itemAlt = $itemTitle}

        <div class="mr-6">
            <a href="{$itemLink}" class="flex gap-2 justify-center md:justify-start">
                <div class="flex-none">
                    <img src="{$itemSrc}" alt="{$itemAlt}" class="w-4 h-4" width="24" height="24" loading="lazy" />
                </div>
                <div class="md:flex-auto">
                    <span class="text-xs block whitespace-nowrap">{$itemTitle}</span>
                </div>
            </a>
        </div>
    {/foreach}
</div>