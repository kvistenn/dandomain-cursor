{*
# Description
Template for a slider element with configurations. Uses Swiper JS.
Handles both page (picture element) and product (and news, blog, event) sliders.

## Supplied variables
+ $widgetSettings  - Array of widgetSettings (theme, speed, pagination, nav, width, height, crop, random, etc.)
+ $type            - page, product, news, blog, event
+ $id               - Entity id for the type
+ $alt              - Alt text for images (optional)
+ $microdata        - Boolean for microdata (optional)
+ $placeholderSelector - Selector for placeholder styling (optional)

## Data attributes (data-swiper-*)
+ data-swiper="slider"        - init Swiper
+ data-swiper-speed           - autoplay delay (from widgetSettings speed)
+ data-swiper-pagination      - true/false
+ data-swiper-nav             - true/false
+ data-swiper-autoplay        - true/false
*}

{$useMicrodata = $microdata|default:false}
{if !isset($widgetSettings)}
    {$widgetSettings = ['theme' => 'slider-theme']}
{/if}

{if isset($type) && isset($id)}
    {controller type=files assign=controller}
    {if $type eq "product"}
        {collection assign=items controller=$controller type=$type productId=$id}
    {else}
        {collection assign=items controller=$controller type=$type id=$id}
    {/if}
{/if}

{$itemWidth = null}
{$itemHeight = null}
{$crop = false}
{if isset($widgetSettings['width'])} {$itemWidth = $widgetSettings['width']} {/if}
{if isset($widgetSettings['height'])} {$itemHeight = $widgetSettings['height']} {/if}
{if isset($widgetSettings['crop'])} {$crop = $widgetSettings['crop']} {/if}

{$speed = 5000}
{if !empty($widgetSettings['speed'])}
    {$speed = $widgetSettings['speed']}
{/if}
{$showPagination = true}
{if isset($widgetSettings['pagination'])}
    {$showPagination = $widgetSettings['pagination']}
{/if}
{$showNav = true}
{if isset($widgetSettings['nav'])}
    {$showNav = $widgetSettings['nav']}
{/if}
{$autoplay = true}
{if isset($widgetSettings['autoplay'])}
    {$autoplay = $widgetSettings['autoplay']}
{/if}

<div class="slider-wrap w-slider widget {$widgetSettings['theme']|default:''}">
{if $items->getActualSize() gt 0}

    {$watermark = null}
    {if !empty($widgetSettings['watermark']) && !empty($template.watermark)}
        {$watermark = $template.watermark}
    {/if}

    {$files = $items->getData()}
    {if !empty($widgetSettings['random'])}
        {$sr = shuffle($files)}
    {/if}

    <div class="swiper" data-swiper="slider" data-swiper-speed="{$speed}" data-swiper-pagination="{$showPagination|replace:true:'true'|replace:false:'false'}" data-swiper-nav="{$showNav|replace:true:'true'|replace:false:'false'}" data-swiper-autoplay="{$autoplay|replace:true:'true'|replace:false:'false'}">
        <div class="swiper-wrapper">

            {foreach $files as $item key=key}
                {$itemSrc = $item->thumbnail($itemWidth, $itemHeight, $crop, $watermark)|solutionPath}
                {$itemAlt = $alt|default:''}
                {if $type eq 'page'}
                    {$itemTitle = $controller->getTranslation($item->Id, "title")|strip}
                    {$itemText = $controller->getTranslation($item->Id, "text")|strip}
                    {$itemLink = $item->Link}
                    {$itemLinkText = $controller->getTranslation($item->Id, "linktext")|strip}
                    {$itemAlt = $itemTitle}
                {/if}
                {if $item->AltText}
                    {$itemAlt = $item->AltText}
                {/if}

                {$isVideo = false}
                {$rawFile = $item->getRelativeFile()|solutionPath}
                {if $rawFile|strstr:".mp4"}
                    {$isVideo = true}
                {/if}

                <div class="swiper-slide h-auto">
                    {if isset($useFancyBox) && $useFancyBox}
                        <a data-fancybox="" data-fancybox-group="{$type}" href="{$item->thumbnail(null, null, false, $watermark)|solutionPath}" class="block relative">
                    {elseif $item->Link}
                        <a href="{$item->Link}" class="block relative">
                    {/if}

                    {if $isVideo && $type eq 'page'}
                        <video class="w-full block object-cover" loop="true" muted="true" playsinline="true" preload="none" loading="lazy">
                            <source src="{$rawFile}" type="video/mp4">
                        </video>
                    {else}
                        {if $itemWidth && $itemHeight}
                            {$itemSrcs = [
                                '1600' => $item->thumbnail(1600, 720, $crop, $watermark)|solutionPath,
                                '1024' => $item->thumbnail(1024, 420, $crop, $watermark)|solutionPath,
                                '768'  => $item->thumbnail(768, 480, $crop, $watermark)|solutionPath,
                                '640'  => $item->thumbnail(640, 360, $crop, $watermark)|solutionPath,
                                '480'  => $item->thumbnail(480, 480, $crop, $watermark)|solutionPath,
                                '320'  => $item->thumbnail(320, 320, $crop, $watermark)|solutionPath
                            ]}
                            <picture class="w-full block">
                                {foreach $itemSrcs as $w => $src}
                                    <source srcset="{$src}" media="(min-width: {$w}px)">
                                {/foreach}
                                <img src="{$itemSrcs.320}" alt="{$itemAlt}" width="320" height="320" class="w-full block object-cover" loading="{if $key == 0}eager{else}lazy{/if}">
                            </picture>
                            {if $key == 0}
                                <link rel="preload" as="image" href="{$itemSrcs.320}">
                            {/if}
                        {else}
                            <img src="{$itemSrc}" alt="{$itemAlt}" class="w-full block object-cover" loading="{if $key == 0}eager{else}lazy{/if}">
                        {/if}
                    {/if}

                    {if $type eq 'page' && (!empty($itemText) || !empty($itemTitle) || !empty($itemLinkText))}
                        <div class="absolute inset-0 w-full h-full flex items-center pointer-events-none">
                            <div class="container">
                                <div class="max-w-xl">
                                    {if !empty($itemTitle)}
                                        <div class="item-title">
                                            <p class="h2 text-2xl sm:text-3xl md:text-4xl font-bold" {if $useMicrodata}itemprop="headline"{/if}>{$itemTitle}</p>
                                        </div>
                                    {/if}
                                    {if !empty($itemText)}
                                        <div class="item-text">
                                            <p class="h4 mt-1">{$itemText}</p>
                                        </div>
                                    {/if}
                                    {if !empty($itemLinkText)}
                                        <div class="item-link pointer-events-auto mt-4">
                                            <span class="button-text large">{$itemLinkText}</span>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    {/if}

                    {if isset($useFancyBox) && $useFancyBox}
                        </a>
                    {elseif $item->Link}
                        </a>
                    {/if}
                </div>
            {/foreach}
        </div>

        {if $showNav}
            <div class="swiper-button-next w-6 h-6 xl:w-8 xl:h-8 hidden xl:block">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-6 !h-6 xl:!w-8 xl:!h-8"><path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" /></svg>
            </div>
            <div class="swiper-button-prev w-6 h-6 xl:w-8 xl:h-8 hidden xl:block">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-6 !h-6 xl:!w-8 xl:!h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" /></svg>
            </div>
        {/if}

        {if $showPagination}
            <div class="swiper-pagination !bottom-4 [&_span]:w-[6px] [&_span]:h-[6px] [&_span]:bg-white [&_span]:rounded-lg [&_span]:transition-all [&_span.swiper-pagination-bullet-active]:w-6"></div>
        {/if}
    </div>{* end .swiper *}

{elseif isset($defaultImage)}
    <img class="w-slider-img w-img-default responsive" src="{$defaultImage}" alt="">
{/if}
</div>
