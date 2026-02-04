{*

# Description
Template for a category. Part of the Product page type.


## Date last modified
2015-04-17


## Primary variables
+ $item 													- Entity of productCategoryController (a single shop product category)
+ $pagelink 												- Link / URL to the product page


## Partials (templates)
No extra templates required for this template

*}

{* Placeholder image *}
{placeholdImage assign=placeholder width=293 height=293 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

{$crop = "fill"}
{if !empty($template.settings.DESIGN_IMAGE_BACKGROUND_COLOR)}
    {$crop = $template.settings.DESIGN_IMAGE_BACKGROUND_COLOR}
{/if}
{$pagelink = {page id=$page.productPageId print=Link}}
<div class="inline-block border-r border-gray-200 last:border-r-0 w-fit" data-mh="category-item">
    <a href="/{$pagelink}/{$item->Handle}/" title="{$item->Title}" class="block py-4 px-5 text-center whitespace-nowrap">{$item->Title}</a>
</div>
