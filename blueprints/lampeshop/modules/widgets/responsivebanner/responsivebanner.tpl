{if !$id}
    {$id = $page.id}
{/if}

{controller type=page assign=pageController}
{controller type=files assign=controller}
{collection assign=items controller=$controller type=page id=$id}

{$itemsAmount = $items->getActualSize()}

{if $itemsAmount gt 0}

    {$images = $items->getData()}
    {$desktopImage = $images[0]}
    {$mobileImage = $images[1]}

    {$bannerLink = $desktopImage->Link}
    {if !$bannerLink && $bannerLink !== ''}
        {$bannerLink = $mobileImage->Link}
    {/if}

    {$bannerAlt = $desktopImage->Alt}
    {if !$bannerAlt && $bannerAlt !== ''}
        {$bannerAlt = $mobileImage->Alt}
    {/if}

    {if !$bannerAlt && $bannerAlt !== ''}
        {$bannerAlt = $page.seoTitle}
    {/if}

    {if $bannerLink && $bannerLink !== ''}
        <a href="{$bannerLink}" class="block w-full h-full">
    {/if}

        <picture>
            <source media="(min-width: 1800px)" srcset="{$desktopImage->thumbnail(2560)} 2560w">
            <source media="(min-width: 1200px) and (max-width: 1799px)" srcset="{$desktopImage->thumbnail(1920)} 1920w">
            <source media="(min-width: 768px) and (max-width: 1199px)" srcset="{$desktopImage->thumbnail(1024)} 1024w, {$desktopImage->thumbnail(1280)} 1280w">
            <source media="(min-width: 480px) and (max-width: 767px)" srcset="{$mobileImage->thumbnail(640)} 640w, {$mobileImage->thumbnail(768)} 768w">
            <source media="(max-width: 479px)" srcset="{$mobileImage->thumbnail(480)} 320w">
            <img src="{$desktopImage->thumbnail(1024)}" class="w-full h-auto" width="1024" height="768" alt="{$bannerAlt}">
        </picture>

    {if $bannerLink && $bannerLink !== ''}
        </a>
    {/if}

{/if}