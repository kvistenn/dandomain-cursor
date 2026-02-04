{controller assign=controller type=files}
{collection assign=items controller=$controller type=page id=$id}

{if $items->getActualSize() gt 0}
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 lg:gap-8">
        {foreach $items->getData() as $item key=key}

            {$itemSrc = $item->thumbnail(600,400)|solutionPath}
            {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
            {$itemText = $controller->getTranslation($item->Id, "text")|strip}
            {$itemLinkText = $controller->getTranslation($item->Id, "linktext")|strip}
            {$itemLink = $item->Link}
            {$itemSrc = $item->getRelativeFile()|solutionPath}

            {$itemSrcs = [
                '1400' => $item->thumbnail(318, 199, true)|solutionPath,
                '1024' => $item->thumbnail(224, 140, true)|solutionPath,
                '768' => $item->thumbnail(360, 225, true)|solutionPath,
                '640' => $item->thumbnail(296, 185, true)|solutionPath,
                '480' => $item->thumbnail(216, 135, true)|solutionPath,
                '320' => $item->thumbnail(136, 85, true)|solutionPath
            ]}

            <a href="{$item->Link}" {if $item->Link|strstr:'.pdf'}target="_blank"{/if} class="flex flex-col">
                <picture class="w-full aspect-[136/85] mb-4">
                    {foreach $itemSrcs as $width => $src}
                        <source srcset="{$src}" media="(min-width: {$width}px)">
                    {/foreach}
                    <img src="{$itemSrcs.320}" alt="{$itemTitle}" width="136" height="85" class="w-full block rounded" {if $key > 1}loading="lazy"{/if}>
                </picture>
                {if !empty($itemTitle)}
                    <strong class="mb-1">{$itemTitle}</strong>
                {/if}
                {if !empty($itemText)}
                    <p class="text-sm text-gray-500">{$itemText}</p>
                {/if}
            </a>
        {/foreach}
    </div>
{/if}