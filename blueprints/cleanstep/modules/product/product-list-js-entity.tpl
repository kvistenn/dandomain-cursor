{$pagelink = {page id=$page.productPageId print=Link}}
{$categoriesArr = []}

{if $categories and $categories->getActualSize() gt 0}

    {* Parent categories *}
    {foreach $categories->getData() as $item}
        {$categoriesArr[] = [
            'id' => $item->Id,
            'title' => $item->Title,
            'link' => "/{$pagelink}/{$item->Handle}/"
        ]}
    {/foreach}
{* {else}
    {if $page.categoryId}

        {entity assign=parentCategory controller=productCategory id=$page.categoryId}
        {if $parentCategory}
            {collection assign=siblingCategories controller=productCategory parentId=$parentCategory->ParentId}
            {if $siblingCategories and $siblingCategories->getActualSize() gt 0}
                {foreach $siblingCategories->getData() as $item}
                    {$categoriesArr[] = [
                        'id' => $item->Id,
                        'title' => $item->Title,
                        'link' => "/{$pagelink}/{$item->Handle}/"
                    ]}
                {/foreach}
            {/if}
        {/if}
    {/if} *}
{/if}

<div class="angular-productlist">
    <div
        class="ng-cloak"
        data-ng-cloak
        data-ng-controller="productlist-ctrl"
        data-ng-init="hasLeftColumns = 0"
        data-field="{$field}"
        data-item-id="{$id}"
        data-viewmode="2"
        data-sorting="{$sorting}"
        data-order-by=""
        data-session="1"
        data-filter="0"
        data-image-width="385"
        data-image-height="385"
        data-show-empty=""
        data-product-id="">

        {placeholdImage assign=placeholder width=293 height=293 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}
        {$crop = "fill"}
        {if !empty($template.settings.DESIGN_IMAGE_BACKGROUND_COLOR)}
            {$crop = $template.settings.DESIGN_IMAGE_BACKGROUND_COLOR}
        {/if}
        {$pagelink = {page id=$page.productPageId print=Link}}

        <div class="flex flex-col gap-6 lg:gap-16">
        
            <div class="w-full mb-6 lg:mb-12 block">
                <h1 class="text-xl lg:text-2xl xl:text-3xl font-bold">{if !$title}{$page.headline}{else}{$title}{/if}</h1>
            </div>

            {if !empty($descriptionTop)}
                <div class="prose">
                    {$descriptionTop}
                </div>
            {/if}

            {if $categoriesArr|count gt 0}
                <div>
                    <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4 md:gap-6">
                        {foreach $categoriesArr as $item}
                            {entity assign=image controller=files type=category id=$item.id}
                            <a href="{$item.link}" title="{$item.title}" class="flex flex-col gap-4 items-center justify-center text-sm text-gray-600 hover:text-black transition-colors">
                                <div class="bg-gray-100 rounded-lg p-4 w-full">
                                    {if $image}
                                        {$imageSrc = $image->thumbnail($imageWidth, $imageHeight)|solutionPath}
                                        <img src="{$imageSrc}" alt="{$text.RATING_RATINGS_SEE_ALL} {$item->Title}" width="293" height="293" class="w-full h-auto mix-blend-multiply aspect-video object-scale-down" loading="lazy">
                                    {else}
                                        <img src="{$placeholder->getRelativeFile()|solutionPath}" alt="{$text.RATING_RATINGS_SEE_ALL} {$item->Title}" width="293" height="293" class="w-full h-auto mix-blend-multiply aspect-video object-scale-down" loading="lazy">
                                    {/if}
                                </div>
                                <strong>{$item.title}</strong>
                            </a>
                        {/foreach}
                    </div>
                </div>
            {/if}

            <div class="flex ng-hide" data-ng-show="loaded && (productlist.length || showEmpty)" data-ng-hide="empty">

                <div class="w-full flex-auto min-w-0">

                    <!-- Categories -->
                    {if $categoriesArr|count gt 0}
                        <div class="mb-4 lg:hidden overflow-x-auto noscrollbar">
                            <ul class="flex gap-2">
                                {foreach $categoriesArr as $item}
                                    {if $item.id neq $page.categoryId}
                                        <li><a href="{$item.link}" title="{$item.title}" class="whitespace-nowrap block py-2 px-4 border border-gray-200 rounded-full text-sm text-gray-600 hover:text-black transition-colors{$activeClass}">{$item.title}</a></li>
                                    {/if}
                                {/foreach}
                            </ul>
                        </div>
                    {/if}

                    <div class="pb-6 lg:pb-12">
                        <div id="hr-recom-k68875a619c99e26ba24b3102"></div>
                    </div>

                    <!-- Filter -->
                    {if !empty($filter)}
                        {include file='modules/product/partials/list-js-filter.tpl'}
                    {/if}

                    <!-- Sortbar -->
                    {if !empty($sortbar)}
                        {include file='modules/product/partials/list-js-sortbar.tpl' sorting=$sorting orderBy=$orderBy}
                    {/if}

                    <!-- Product List -->
                    <div class="grid grid-cols-2 {if $categoriesArr|count gt 0}sm:grid-cols-3 lg:grid-cols-2 xl:grid-cols-5 {else}sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6{/if} gap-6">
                        <div class="productItem" data-ng-class="{$colClass}" data-ng-hide="loadingProducts" data-ng-repeat="product in productlist track by product.Id" data-ng-controller="product-ctrl" data-repeat-done="loaded.productlist">
                            {include file='modules/product/partials/list-js-col.tpl'}
                        </div>
                    </div>

                </div>

            </div>

            {if !empty($descriptionBottom)}
                <div class="prose">
                    {$descriptionBottom}
                </div>
            {/if}

        </div>

    </div>
</div>