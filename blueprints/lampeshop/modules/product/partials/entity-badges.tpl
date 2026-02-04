{*

# Description
Template partial for product badges. Part of the Product page type.


## Date last modified
2019-01-14


## Primary variables
+ $product                                                              - Entity of productController (the current product)
+ $variant                                                              - Entity of variantController (the current variant)
+ $priceInterval                                                        - Entity of productPriceController (price lines for selected product)
+ $text                                                                 - Global scope variable containing translations
+ $settings                                                             - Global scope variable containing platform settings


## Partials (templates)
No extra templates required for this template

*}


{* Product splashes, news, discount and sold out *}

{* Badges *}
{$badges = []}
{if $customDataTypes[8].Data[0]}
    {$badgesArray = '::'|explode:$customDataTypes[8].Data[0]}
    {foreach $badgesArray as $badge}
        {$badgeEntities = ':'|explode:$badge}
        {$badges[] = [
            'Title' => $badgeEntities[0],
            'Background' => $badgeEntities[1]|trim,
            'Color' => $badgeEntities[2]|trim
        ]}
    {/foreach}
{/if}

{if $settings.show_product_icons && $product->Type ne 'discontinued'}
    <div class="absolute top-0 right-0 z-20 flex flex-col gap-2 md:gap-4 print:hidden">
        {if $product->Age lt 2592000}
            <span class="h-8 md:h-12 px-3 md:px-6 text-xs md:text-lg flex items-center bg-black text-white rounded justify-center text-center font-bold">{$text.NEWS}</span>
        {/if}
        {if $customDataTypes[7].Data}
            <span class="h-8 md:h-12 px-3 md:px-6 text-xs md:text-lg flex items-center bg-black text-white rounded justify-center text-center font-bold">{$customDataTypes[7].Title}</span>
        {/if}
        {if $badges}
            {foreach $badges as $badge}
                <span class="h-8 md:h-12 px-3 md:px-6 text-xs md:text-lg flex items-center bg-black text-white rounded justify-center text-center font-bold empty:hidden" style="color:{$badge.Color};background-color:{$badge.Background};">
                    {$badge.Title}
                </span>
            {/foreach}
        {/if}
    </div>
{/if}