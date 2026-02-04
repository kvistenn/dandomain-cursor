{collection assign=items controller=brand}
{placeholdImage assign=placeholder width=210 height=210 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

{if $items->getActualSize() gt 0}
    <div class="swiper border-y border-gray-200 lg:py-2 mt-6" data-swiper="brands">
        <div class="swiper-wrapper">
            {foreach $items->getData() as $item}

                {$brandLink = "/shop/?brand={$item->Id}-{$item->Title|formatLink}"}

                {entity assign=image controller=files type=user id=$item->Id}
                
                {if $image}
                    
                    {$imgpath = $image->thumbnail(120, 80)|solutionPath}
                    
                    <div class="swiper-slide">
                        <a href="{$brandLink}" class="block" title="{$item->Title}">
                            <img src="{$imgpath}" alt="{$item->Company}" width="120" height="80" class="w-full max-w-[120px] mx-auto block" loading="lazy" />
                        </a>
                    </div>

                {/if}

            {/foreach}
        </div>
    </div>
{/if}