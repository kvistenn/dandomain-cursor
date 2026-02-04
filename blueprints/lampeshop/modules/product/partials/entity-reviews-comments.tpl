{*

# Description
Template partial for the product reviews. Part of the Product page type.


## Date last modified
2020-01-03


## Primary variables
+ $productController                                                    - Instance of productController
+ $product                                                              - Entity of productController (the current product)
+ $productReviewscontroller                                             - Instance of productReviewController
+ $productReviews                                                       - Collection of productReviewController
+ $image                                                                - Entity of fileController with type user
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/product/partials/entity-reviews-stars.tpl"                  - Partial template for product views as stars
+ "/modules/widgets/gravatar/gravatar.tpl"                              - Gravatar image widget, for blog comment author picture
+ "/modules/widgets/recaptcha/recaptcha.tpl"                            - Recaptcha widget, for blog comments
+ "/modules/widgets/login/login.tpl"                                    - Login widget, for log in

*}

{*** Reviews controller ***}
{controller assign=productReviewscontroller type=productReview primary=true}

{*** Collection entity of the reviews controller ***}
{collection assign=productReviews controller=productReview productId=$product->Id}

{*** Rating visually made with FontAwesome ***}
{$avgRating = $productReviewscontroller->getAverageRating($product->Id)}
{$bestRating = $productReviewscontroller->getAverageRating($product->Id, null, false)}

<div class="flex flex-col lg:flex-row gap-6 lg:gap-16">

    <div class="flex-auto">

        <div class="flex gap-2 items-end">
            <strong class="text-5xl">{$avgRating}</strong>
            <span class="text-2xl">/ 5</span>
        </div>

        <div class="py-4 lg:py-6">
            {include file="modules/product/partials/entity-reviews-stars.tpl" product=$product type="quick-rating" reviewBtn=false readonly=true}
        </div>

        <div class="flex flex-col gap-3">

            {$ratings = [ 5 => 0, 4 => 0, 3 => 0, 2 => 0, 1 => 0 ]}
            {foreach $productReviews->getData() as $review}
                {$ratings[$review->Rating]++}
            {/foreach}

            {$ratingCount = $productReviews->getActualSize()}

            {for $rating = 5; $rating >= 1; $rating--}
                <div class="flex items-center gap-3">
                    <span>{$rating}</span>
                    <div class="w-full h-3 bg-gray-200 rounded-full">
                        {if $ratingCount !== 0}
                            <div class="h-full bg-orange-500 rounded-full" style="width: {($ratings[$rating] / $ratingCount) * 100}%"></div>
                        {/if}
                    </div>
                    <span>{$ratings[$rating]}</span>
                </div>
            {/for}

        </div>

    </div>

    <div class="flex-1">
        <strong class="md:text-lg lg:text-xl xl:text-2xl 2xl:text-3xl block mb-3 lg:mb-4 2xl:mb-6">{$text.PRODUCT_CATALOG_REVIEW_ADD_REVIEWS}</strong>
        <div class="flex flex-col gap-4">
            {if $productReviews->getActualSize() gt 0}
                {foreach $productReviews->getData() as $review}
                    <div class="bg-black p-5 rounded-md flex flex-col gap-2" itemprop="review" itemscope itemtype="http://schema.org/Review">
                        {if $review->Title}
                            <strong class="text-sm" itemprop="name">{$review->Title}</strong>
                        {/if}
                        {if $settings.module_shop_review_products_type==="full"}
                            {*** Reviews stars ***}
                            {include file="modules/product/partials/entity-reviews-stars.tpl" type="comment-show" rating=$review->Rating product=$product}
                        {/if}
                        <div class="text-xs text-gray-400">
                            {if $review->UserName}
                                <span>{$text.PRODUCT_CATALOG_REVIEW_CREATED_BY}</span>
                                <strong itemprop="author" itemscope itemtype="http://schema.org/Person">
                                    <span itemprop="name">{$review->UserName}</span>
                                </strong>
                            {else}
                                <span itemprop="author" itemscope itemtype="http://schema.org/Person"><meta itemprop="name" content="Unknown" /></span>
                            {/if}
                            <time datetime="{$review->DateCreated}">{$review->DateCreated|date_format:$general.dateTimeFormat}</time>
                        </div>

                        <meta itemprop="datePublished" content="{$review->DateCreated}">

                        {*** Review text ***}
                        {if $review->Text}
                            <p class="text-sm" itemprop="reviewBody">{$review->Text}</p>
                        {/if}
                    </div>
                {/foreach}
            {else}
                <p class="text-sm">{$text.PRODUCT_CATALOG_REVIEW_NONE}</p>
            {/if}

            {if !$user}
                <a data-fancybox data-src="#login" href="#" class="px-5 h-10 bg-black text-white text-sm rounded flex items-center gap-2 w-fit">{$text.ACCOUNT_MENU}</a>
            {elseif $user and $settings.module_shop_review_products === true}
                <a data-fancybox data-src="#review" href="#" class="px-5 h-10 bg-black text-white text-sm rounded flex items-center gap-2 w-fit">{$text.PRODUCT_CATALOG_REVIEW_ADD_HEADLINE}</a>
            {/if}
        </div>
    </div>

</div>

{* Review form *}
<div id="review" style="display: none; width: 600px; max-width: 100%" tabindex="-1" role="dialog" aria-hidden="true">
    <form action="/actions/review/product" data-blog="form" method="post" class="flex flex-col gap-6">
        {csrf type="input"}
        <input type="hidden" name="score" value="0">
        <input type="hidden" name="product_id" value="{$product->Id}">

        {if $settings.module_shop_review_products_type==="full"}
            {include file="modules/product/partials/entity-reviews-stars.tpl" product=$product type="comment-rate"}
        {/if}

        <div class="flex flex-col gap-3">
            {if $user}
                <input type="hidden" name="name" value="{$user->Firstname} {$user->Lastname}" >
            {else}
                <input type="text" id="review-name" class="w-full rounded border border-gray-200 px-3 py-2 outline-none" name="name" placeholder="{$text.NAME}" required="">
            {/if}

            <input type="text" id="review-headline" class="w-full rounded border border-gray-200 px-3 py-2 outline-none" name="headline" placeholder="{$text.PRODUCT_CATALOG_REVIEW_ADD_HEADER}" required="">

            <textarea id="review-text" name="text" class="w-full rounded border border-gray-200 px-3 py-2 outline-none h-20" required="" placeholder="{$text.PRODUCT_CATALOG_REVIEW_ADD_REVIEW}"></textarea>
        </div>

        {if $settings.spam_check}
            {include file="modules/widgets/recaptcha/recaptcha.tpl"}
        {/if}

        {if !$user && $settings.privacy_policy_product_review}
            {include file="modules/widgets/consent/consent.tpl"}
        {/if}

        <button type="submit" class="px-6 h-12 bg-black text-white rounded flex items-center gap-2 w-fit">{$text.PRODUCT_CATALOG_COMMENT_ADD_HEADLINE}</button>
    </form>
</div>