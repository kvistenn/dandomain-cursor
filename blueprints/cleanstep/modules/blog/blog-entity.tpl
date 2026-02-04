{*

# Description
Template for a single blog post with comments, slider, captcha and gravatar elements.


## Date last modified
2021-05-28


## Primary variables
+ $controller                                                           - Instance of blogController
+ $commentController                                                    - Instance of blogCommentController
+ $categoryController                                                   - Instance of blogCategoryController
+ $imageController                                                      - Instance of filesController
+ $item                                                                 - Entity of blog (a single blog post)


## Partials (templates)
+ "/modules/widgets/slider/slider.tpl"                                  - Image slider widget, for blog post picture
+ "/modules/widgets/gravatar/gravatar.tpl"                              - Gravatar image widget, for blog comment author picture
+ "/modules/widgets/recaptcha/recaptcha.tpl"                            - Recaptcha widget, for blog comments

*}

{*** Calculate the actual size of the comment collection ***}
{$commentCount = $comments->getActualSize()}

{*** Fetch the categoryController and save it for later ***}
{controller type=blogCategory assign=categoryController}

{*** Fetch the filesController and save it for later ***}
{controller type=files assign=imageController}

{*

# Description
Helper functions for printing out comments and their children


## Resource
+ [Smarty functions](http://www.smarty.net/docs/en/language.function.function.tpl)

*}

{placeholdImage assign=placeholder width=1224 height=720 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

{$pageLink = {page id=$item->PageId print=Link}}

<div itemscope itemtype="http://schema.org/BlogPosting">

    <meta itemprop="mainEntityOfPage" content="{$page.url}">

    <header class="text-center mb-6 sm:mb-10 md:mb-14">
        <h1 class="text-lg sm:text-xl md:text-2xl" itemprop="name">{$item->Title}</h1>
    </header>

    <div class="flex flex-col gap-6 lg:flex-row lg:gap-10">

        <div class="flex-auto">
            
            {entity assign=image controller=$imageController type=blog id=$item->Id}

            {if $image}
                {$imgpath = $image->thumbnail(1224, 720)|solutionPath}
            {else}
                {$imgpath = $placeholder->getRelativeFile()|solutionPath}
            {/if}

            <div class="p-6 md:p-12 rounded-xl bg-white shadow-lg">
                <img src="{$imgpath}" alt="{$item->Title}" width="1224" height="720" loading="lazy" class="w-full lg:w-3/5 h-auto" itemprop="image">
                <div class="mt-5 ck-content prose max-w-full" itemprop="articleBody">{$controller->getDescription($item->Id)}</div>
            </div>

        </div>

        {collection assign=children controller=page parentId=$page.id}
        
        {if $children->getActualSize() eq 0}
            {collection assign=children controller=page parentId=$page.parentId}
        {/if}

    </div>

</div>