{controller assign=controller type=files}
{collection assign=items controller=$controller id=$id}

{if $items->getActualSize() gt 0}

    <div class="container pr-0 xl:pr-4 h-40">
        <div class="relative h-full" data-swiper="categories">
            <div class="swiper w-full max-w-full max-h-screen min-h-0 min-w-0 h-full relative">
                <div class="swiper-wrapper">

                    {foreach $items->getData() as $item key=i}

                        {$itemImage = $item->thumbnail(96,96)}
                        {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
                        {$itemLink = $item->Link}
                        {$itemLinkText = $controller->getTranslation($item->Id, "linktext")|strip}
                        {$itemText = $controller->getTranslation($item->Id, "text")|strip}
                        {$itemAlt = $itemTitle|default:"item image"}

                        <div class="swiper-slide flex items-center justify-center">
                            <a href="{$itemLink}" class="flex flex-col items-center gap-2 w-full">
                                <img src="{$itemImage}" alt="G&aring; til {$itemAlt|escape}" width="96" height="96" class="max-w-24 w-full h-auto rounded-full" {if $i < 4}loading="lazy"{/if} />
                                <span class="text-sm line-clamp-1 w-full text-center">{$itemTitle}</span>
                            </a>
                        </div>

                    {/foreach}

                </div>

            </div>
            <div class="swiper-button-next hidden xl:block w-5 h-5 -right-4">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-5 !h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                </svg>
            </div>
            <div class="swiper-button-prev hidden xl:block w-5 h-5 -left-4">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-5 !h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                </svg>
            </div>
        </div>
    </div>
{/if}