{*

# Description
Partial template for product navigation (next, previous, pdf, send to friend). Part of the Product page type.


## Date last modified
2017-05-19


## Primary variables
+ $product                                                              - Entity of productController (the current product)
+ $productController                                                    - Instance of productController
+ $links                                                                - Array with next and prev (previous) product ids (inherited from product.tpl)
+ $prev                                                                 - String containing the URL to the previous product (inherited from product.tpl)
+ $next                                                                 - String containing the URL to the next product (inherited from product.tpl)


## Partials (templates)
No extra templates required for this template

*}

{* Product navigation and links *}
<div class="m-product-nav is-hidden-print">
    <div class="row">
        <div class="col-s-4 col-m-6 col-l-6 col-xl-12 m-product-nav-cycle">
            {* Pager navigation for products *}
            {if $settings.product_browse and (isset($links['prev']) or isset($links['next']))}
            <div class="pager-group xsmall trailing-db-mobile">
                {if isset($links['prev'])}
                    <a role="button" href="{$prev}" class="button-icon button left m-product-nav-prev"><i class="fa fa-arrow-left"></i>{$text.LAST}</a>
                {/if}

                {if isset($links['next'])}
                    <a role="button" href="{$next}" class="button-icon button right m-product-nav-next">{$text.NEXT}<i class="fa fa-arrow-right"></i></a>
                {/if}
            </div>
            {/if}
        </div>
        <div class="col-s-4 col-m-6 col-l-6 col-xl-12 text-right m-product-nav-share">
            {* Links for product *}
            {if $settings.product_send_to_a_friend}<a rel="nofollow" href="/{$text.SEND_TO_A_FRIEND_LINK}/?link={urlencode($page.request)}" role="button" title="{$text.SEND_TO_A_FRIEND_MENU}" class="button xsmall is-inline-block m-product-nav-tellafriend trailing-db-mobile"><i class="fa fa-envelope-o fa-fw"></i></a>{/if}
            {if !empty($product->Url)}<a rel="nofollow" role="button" title="{$text.PRODUCT_CATALOG_PRODUCT_WEBPAGE}" href="{$product->Url}" target="_blank" rel="noopener" class="button xsmall is-inline-block trailing-db-mobile"><i class="fa fa-link fa-fw"></i></a>{/if}
            {if $settings.product_pdf_export}<a title="{$text.SHOP_PDF_GENERATE}" target="_blank" rel="noopener nofollow" href="/framework/pdf/product/{$product->Id}" role="button" class="button xsmall is-inline-block m-product-nav-pdf trailing-db-mobile"><i class="fa fa-download fa-fw"></i></a>{/if}

        </div>

        {if $settings.product_browse or $settings.product_send_to_a_friend or !empty($product->Url) or $settings.product_pdf_export}
        <div class="col-s-4 col-m-12 col-l-12 col-xl-24">
            <hr/>
        </div>
        {/if}
    </div>
</div>
