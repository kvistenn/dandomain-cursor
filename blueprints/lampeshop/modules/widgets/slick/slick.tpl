{*

# Description
Widget for a slick slider.

## Date last modified
2022-10-17

*}

{if !$id}
    {$id = $page.id}
{/if}

{controller type=page assign=pageController}
{controller type=files assign=controller}
{collection assign=items controller=$controller type=page id=$id}

{$peSettings = $pageController->pictureElementSettings($id)}

{* Default width (from highest to lowest size) *}
{$imageSizes = [
    ['width' => 2560],
    ['width' => 1920],
    ['width' => 1600],
    ['width' => 1024],
    ['width' => 768],
    ['width' => 480]
]}

{* Default height *}
{$maxHeight = 920}
{* Aspect ratio *}
{$maxWidth = $imageSizes[0].width}
{$aspectHeight = 100 / ($maxWidth / $maxHeight)}


{* Define heights *}
{foreach $imageSizes as $size}
    {* To determine the aspect ratio, the height should be equal to the width divided by (aspect-ratio-width * aspect-ratio-height) *}
    {$imageSizes[$size@index].height = $size.width / 12 * 5}
{/foreach}

{* Default time between slides *}
{$cycleSpeed = 5000}
{if !empty($peSettings["cycleSpeed"])}
    {$cycleSpeed = $peSettings["cycleSpeed"]}
{/if}

{$itemsAmount = $items->getActualSize()}

{if $itemsAmount gt 0}
    <div data-cyclespeed="{$cycleSpeed}">
        <div data-slick="slider">
            {foreach $items->getData() as $item}

                {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
                {$itemText = $controller->getTranslation($item->Id, "text")|strip}
                {$itemLink = $item->Link}
                {$itemLinkText = $controller->getTranslation($item->Id, "linktext")|strip}
                {$itemAlt = $itemTitle}
                {$hasCaptionButton = !empty($itemLink) and !empty($itemLinkText)}

                <figure class="relative">
                    <a href="{$itemLink}">
                        <picture>
                            {$img = ""}
                            {foreach $imageSizes as $size}
                                {$nextSize = $imageSizes[$size@index+1]}
                                {$src = $item->thumbnail($size.width, $size.height)|solutionPath}
                                {if $size@first}
                                    {$img = "<img class=\"w-full h-[600px] object-cover\" src=\"{$src}\" alt=\"{$itemAlt}\" width=\"{$size.width}\" height=\"{$size.height}\" />"}
                                {/if}
                                {if $size@last}
                                    {$src = $item->thumbnail($size.width * 2, $size.height * 2)|solutionPath}
                                    <source media="(max-width: {$size.width}px)" srcset="{$src}">
                                {else}
                                    {$src = $item->thumbnail($size.width * 2, $size.height * 2)|solutionPath}
                                    <source media="(min-width: {$nextSize.width+1}px)" srcset="{$src}">
                                {/if}
                            {/foreach}
                            {$img}
                        </picture>
                        {if !empty($itemTitle) || !empty($itemText)}
                            <figcaption class="mb-[50px] md:absolute md:top-0 md:left-1/2 md:-translate-x-1/2 h-full flex flex-col justify-center container">
                                <div class="py-6 md:p-6 bg-white md:w-[500px] w-max-full">
                                    {if !empty($itemTitle)}
                                        <h2 class="text-2xl lg:text-3xl font-bold{if !empty($itemText)} mb-3{/if}">{$itemTitle}</h2>
                                    {/if}
                                    {if !empty($itemText)}
                                        <p>{$itemText}</p>
                                    {/if}
                                </div>
                            </figcaption>
                        {/if}
                    </a>
                </figure>
            {/foreach}
        </div>
    </div>
{/if}