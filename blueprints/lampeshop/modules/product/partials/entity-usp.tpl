{controller type=files assign=controller}
{collection assign=items controller=$controller pageSize=$pageSize id=$id}

<div class="flex flex-col lg:flex-row w-full border border-gray-200 rounded">
    {foreach $items->getData() as $item key=i}

        {$itemSrc = $item->getRelativeFile()}
        {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
        {$itemText = $controller->getTranslation($item->Id, "text")|strip}
        {$itemLink = $item->Link}
        {$itemLinkText = $controller->getTranslation($item->Id, "linktext")|strip}
        {$itemAlt = $itemTitle}

        <a href="{$itemLink}" class="flex-1 flex flex-col items-center p-6 xl:px-8 xl:py-6 border-b lg:border-r border-gray-200 lg:border-b-0 last:border-0">
            <div class="w-full flex-auto flex items-center justify-center">
                <img src="{$itemSrc}" alt="{$itemAlt}" class="w-auto max-h-12" loading="lazy" />
            </div>
            <span class="text-center text-sm block mt-3 xl:mt-4">{$itemTitle}</span>
        </a>
    {/foreach}
</div>