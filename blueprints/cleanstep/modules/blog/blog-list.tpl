{*

# Description
Template for a list of blog posts with slider element, part of the Blog page type.


## Date last modified
2020-10-12


## Primary variables
+ $controller                                                           - Instance of blogController
+ $commentController                                                    - Instance of blogCommentController
+ $categoryController                                                   - Instance of blogCategoryController
+ $imageController                                                      - Instance of filesController
+ $pageSize                                                             - Amount of blog posts to show per page. Defaults to 5.
+ $items                                                                - Collection of blog posts
+ $CategoryId (optional)                                                - Show a list based on categori id
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/widgets/pagination/pagination.tpl"                          - Pagination widget, for pagination generation
+ "/modules/column/column.tpl"                                          - Template for column boxes


*}



{*** Fetch the filesController and save it for later ***}
{controller type=files assign=imageController}

{*** Fetch the categoryController and save it for later ***}
{controller type=blogCategory assign=categoryController}

{placeholdImage assign=placeholder width=400 height=280 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

<div itemscope itemtype="http://schema.org/Blog">

    <header class="text-center mb-6 sm:mb-10 md:mb-14">
        <h1 class="text-lg sm:text-xl md:text-2xl">{$page.headline}</h1>
        {if $page.url|strstr:'?cat='}
            {$backUrl = '?cat'|explode:$page.url}
            <a href="{$backUrl[0]}" class="text-sm text-gray-600 mt-4 underline">{$text.CHECKOUT_WIDGET_GO_BACK}</a>
        {/if}
    </header>

    {collection assign=categories controller=$categoryController}

    {if $categories->getActualSize() gt 0}
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-3 sm:gap-6 mb-6 sm:mb-10" data-blog="categories">
            {foreach $categories->getData() as $category}

                {$pageLink = {page id=$category->PageId print=Link}}

                <a href="/{$pageLink}/?cat={$category->Id}" data-id="{$category->Id}" class="shadow-md rounded-full bg-white p-5 text-center flex items-center justify-center text-sm sm:text-base">
                    {$category->Title}
                </a>
            {/foreach}
        </div>
    {/if}

    {controller assign=pageCtrl type=page}
    {$blogDescription = $pageCtrl->getText(67)}

    {if !empty($blogDescription)}
        <div class="prose max-w-full mb-6 sm:mb-10">
            {$blogDescription}
        </div>
    {/if}

    {if $items->getActualSize() gt 0}

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {foreach $items->getData() as $item}

                {$pageLink = {page id=$item->PageId print=Link}}

                {entity assign=image controller=$imageController type=blog id=$item->Id}

                {if $image}
                    {$imgpath = $image->thumbnail(400, 280)|solutionPath}
                {else}
                    {$imgpath = $placeholder->getRelativeFile()|solutionPath}
                {/if}

                <div class="overflow-hidden shadow-md rounded bg-white" itemprop="blogPost" itemscope itemtype="http://schema.org/BlogPosting">
                    <a href="/{$pageLink}/{$item->Handle}/" class="block overflow-hidden">
                        <img src="{$imgpath}" alt="{$item->Title}" width="400" height="280" loading="lazy" class="w-full h-auto duration-500 hover:scale-110" itemprop="image">
                    </a>
                    <div class="p-5 md:px-6 md:py-8 flex flex-col gap-2">
                        <a href="/{$pageLink}/{$item->Handle}/" class="font-bold text-lg line-clamp-1" itemprop="name headline">{$item->Title}</a>
                        {if !empty($controller->getDescriptionList($item->Id))}
                            <div class="text-gray-600 text-sm" itemprop="description">{$controller->getDescriptionList($item->Id)}</div>
                        {/if}
                    </div>
                </div>

            {/foreach}
        </div>

        {*** Pagination for the list if enabled ***}
        {if (!isset($pager) or !!$pager)}
            <div>
                {include file='modules/widgets/pagination/pagination.tpl' pageSize=$pageSize size=$items->getActualSize()}
            </div>
        {/if}

    {else}

        <div class="text-center">
            <span class="text-gray-400">
                {$text.NO_DATA}
            </span>
        </div>

    {/if}

</div>