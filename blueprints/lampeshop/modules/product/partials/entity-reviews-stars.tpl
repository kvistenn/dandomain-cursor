{*

# Description
Template partial for the product reviews stars. Part of the Product page type.
Based on a modified verion of the jQuery library Raty called [Raty-Fa](http://jacob87.github.io/raty-fa/).


## Date last modified
2014-08-01


## Resource
+ Raty-Fa ( Raty with fontawesome icons) [raty-fa](http://jacob87.github.io/raty-fa/)


## Primary variables
+ $type                                                                 - Either ("comment-show", "comment-rate", "quick-rating")
+ $product                                                              - (Optional) An entity of product
+ $rating                                                               - (Optional) A value that tells the rating to display
+ $text                                                                 - Global scope variable containing translations
+ $User                                                                 - Global scope variable containing user data


## Partials (templates)
No extra templates required for this template

*}


{if $product}
    {controller assign=reviewcontroller type=productReview primary=true}
    {collection assign=reviews controller=$reviewcontroller productId=$product->Id}
    {$ratingAvg = $reviewcontroller->getAverageRating($product->Id)}
{/if}

{$ratingStars = 5}

{if $type and $type==="comment-show" and $rating}
    <div itemprop="reviewRating" class="print:hidden" itemscope itemtype="http://schema.org/Rating"
        class="flex gap-1"
        data-reviews="stars"
        data-reviews-type="commentshow"
        data-score="{if $rating}{$rating}{else}1{/if}"
        data-number="{$ratingStars}"
        data-readOnly="true"
        data-half="true"
        data-hints="{$text.RATING_RATINGS}"
        data-noRatedMsg="{$text.RATING_NO_RATING}">
        <meta itemprop="ratingValue" content="{if $rating}{$rating}{else}1{/if}">
        <meta itemprop="worstRating" content="1">
        <meta itemprop="bestRating" content="{$ratingStars}">
    </div>
{/if}

{if $type and $type==="comment-rate" and $product}
    <div class="print:hidden">
        <strong class="block mb-2 text-sm">{$text.PRODUCT_CATALOG_REVIEW_ADD_STARS}</strong>
        <div class="flex gap-1"
            data-reviews="stars"
            data-reviews-type="commentrate"
            data-number="{$ratingStars}"
            data-hints="{$text.RATING_RATINGS}"
            data-noRatedMsg="{$text.RATING_NO_RATING}"
            data-scoreName="score">
        </div>
    </div>
{/if}

{if $type and $type==="quick-rating" and $product}
    <div class="flex gap-2 items-center print:hidden" {if $reviews->getActualSize() gt 0}itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"{/if}>

        <div class="flex gap-1"
            data-reviews="stars"
            data-reviews-type="quickrating"
            data-score="{$ratingAvg}"
            data-number="{$ratingStars}"
            data-productId="{$product->Id}"
            {if $settings.module_shop_review_products_type==="full" or $reviewcontroller->isProductRated($product->Id) or $readonly}
                data-readOnly="true"
            {/if}
            {if $user}
                data-userId="{$user->Id}"
                data-name="{$user->Firstname} {$user->Lastname}"
            {/if}
            data-hints="{$text.RATING_RATINGS}"
            data-noRatedMsg="{$text.RATING_NO_RATING}"
        ></div>

        {if $reviews->getActualSize() gt 0 and $ratingAvg gt 0}
            {$reviewCount = 0}
            {foreach $reviews->getData() as $item}
                {if $item->Rating}{$reviewCount = $reviewCount+1}{/if}
            {/foreach}
    
            {* Rating meta - average rating for product *}
            <meta itemprop="ratingValue" content="{$ratingAvg}" />
    
            {if $reviewCount > 0}
                {*** Rating total amount of reviews/ratings ***}
                <div>
                    <span class="text-sm">({$reviewCount}{if $reviewCount > 1} {$text.RATING_REVIEWS}{else} {$text.RATING_REVIEW}{/if})</span>
                </div>
            {/if}
            <meta itemprop="ratingCount" content="{$reviews->getActualSize()}" />
        {else}
            {*** No ratings are made yet ***}
            <div>
                <span class="text-sm">0 {$text.RATING_REVIEWS}</span>
            </div>
        {/if}
    
        {*** IF user is logged in or we don't require login ***}
        {if $settings.module_shop_review_products and $settings.module_shop_review_products_type!=="stars" and $reviewBtn}
            <a href="#reviews" class="w-full flex-none text-xs text-gray-500 underline" data-toggle="content">{$text.PRODUCT_CATALOG_REVIEW_ADD_HEADLINE}</a>
        {/if}

    </div>
{/if}