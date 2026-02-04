{controller type=page assign=pageController}
{controller type=files assign=controller}
{collection assign=items controller=$controller type=page id=1}

{$peSettings = $pageController->pictureElementSettings(1)}

{$cycleSpeed = 5000}
{if !empty($peSettings["cycleSpeed"])}
    {$cycleSpeed = $peSettings["cycleSpeed"]}
{/if}

{if $items->getActualSize() gt 0}

    <div data-swiper="hero" class="swiper">
        <div class="swiper-wrapper">

            {foreach $items->getData() as $item key=key}

                {$itemSrc = $item->getRelativeFile()|solutionPath}
                {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
                {$itemText = $controller->getTranslation($item->Id, "text")|strip}
                {$itemLinkText = $controller->getTranslation($item->Id, "linktext")|strip}
                {$itemLink = $item->Link}
                {$isVideo = false}

                {if $itemSrc|strstr:".mp4"}
                    {$isVideo = true}
                {else}
                    {$itemSrc = $item->thumbnail(0)|solutionPath}
                {/if}

                <div class="swiper-slide !h-auto">
                    <a href="{$itemLink}" class="relative block">
                        {if !$isVideo}

                            {$itemSrcs = [

                                '1600' => $item->thumbnail(1600, 720, true)|solutionPath,
                                '1024' => $item->thumbnail(1024, 420, true)|solutionPath,
                                '768' => $item->thumbnail(768, 480, true)|solutionPath,
                                '640' => $item->thumbnail(640, 360, true)|solutionPath,
                                '480' => $item->thumbnail(480, 480, true)|solutionPath,
                                '320' => $item->thumbnail(320, 320, true)|solutionPath
                            ]}

                            <picture class="w-full aspect-square sm:aspect-auto">
                                {foreach $itemSrcs as $width => $src}
                                    <source srcset="{$src}" media="(min-width: {$width}px)">
                                {/foreach}
                                <img src="{$itemSrcs.320}" alt="{$itemTitle}" width="320" height="320" class="w-full block object-cover">
                            </picture>

                            {if $key == 0}
                                <link rel="preload" as="image" href="{$itemSrcs.320}">
                            {/if}
                        {else}
                            <video class="w-full block object-cover" loop="true" muted="true" playsinline="true" preload="none" loading="lazy">
                                <source src="{$itemSrc}" type="video/mp4">
                            </video>
                        {/if}
                        <div class="absolute inset-0 w-full h-full flex items-center">
                            <div class="container">
                                <div class="max-w-xl">
                                    {if !empty($itemTitle)}
                                        {if $key == 0}
                                            <h1 class="text-2xl sm:text-3xl md:text-4xl lg:text-5xl block mb-2 lg:mb-4 font-bold">{$itemTitle}</h1>
                                        {else}
                                            <strong class="text-2xl sm:text-3xl md:text-4xl lg:text-5xl block mb-2 lg:mb-4 font-bold">{$itemTitle}</strong>
                                        {/if}
                                    {/if}
                                    {if !empty($itemText)}
                                        <p class="mt-1 sm:text-lg md:text-xl lg:text-2xl">{$itemText}</p>
                                    {/if}
                                    {if !empty($itemLink) && !empty($itemLinkText)}
                                        <span class="mt-4 lg:mt-8 px-6 h-12 rounded-lg border-black lg:text-xl border-2 font-bold text-black flex items-center gap-2 flex-auto justify-center w-fit hover:bg-black hover:text-white transition-colors">
                                            {$itemLinkText}
                                        </span>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            {/foreach}
        </div>

        <div class="swiper-button-next w-6 h-6 xl:w-8 xl:h-8 hidden xl:block">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-6 !h-6 xl:!w-8 xl:!h-8">
                <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
            </svg>
        </div>
        <div class="swiper-button-prev w-6 h-6 xl:w-8 xl:h-8 hidden xl:block">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-6 !h-6 xl:!w-8 xl:!h-8">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
            </svg>
        </div>

        <div class="swiper-pagination !bottom-4 [&_span]:w-[6px] [&_span]:h-[6px] [&_span]:bg-white [&_span]:rounded-lg [&_span]:transition-all [&_span.swiper-pagination-bullet-active]:w-6"></div>
    </div>

{/if}