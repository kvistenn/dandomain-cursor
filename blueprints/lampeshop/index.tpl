{strip}

    {*** Library CSS ***}
    {addLink href='assets/css/libs.css' rel='preload stylesheet' as='style' type='text/css' crossorigin='anonymous'}

    {*** Template CSS ***}
    {addLink href='source/css/template.structure.css' rel='preload stylesheet' as='style' type='text/css' crossorigin='anonymous'}

    {*** Tailwind CSS ***}
    {addLink href='assets/css/tailwind.css'}

    {*** Theme CSS ***}
    {addLink href='assets/css/theme.css'}

    {*** Framework JS ***}
    {$bundleVersion = $template.settings.BUNDLE_VERSION}
    {if isset($bundleVersion) && $bundleVersion !== "1.0.0"}
        {addScript src="assets/js/{$bundleVersion}/app.js"}
    {else}
        {addScript src='assets/js/app.js'}
    {/if}

{/strip}

<!DOCTYPE html>

<html lang="{$general.languageIso639}">

<head prefix="og: http://ogp.me/ns#
                fb: http://ogp.me/ns/fb#
                ng: http://angularjs.org">
    {head_include}
</head>

<body id="ng-app" data-ng-app="platform-app" data-ng-strict-di
    class="type-{$page.name} page{$page.id} {if $page.isFrontPage}frontpage{/if}" itemscope
    itemtype="http://schema.org/WebPage">

    {include file="partials/body.js.tpl"}
    
    {if !$page.isCheckout}
        {include file='partials/top.tpl'}
    {/if}

    {include file='modules/widgets/notification/notification.tpl'}

    {if $page.isFrontPage}
        
        {include file='modules/widgets/responsivebanner/responsivebanner.tpl' id=106}

        <div class="container mx-auto">
            
            {* FORSIDE PRODUKTER *}
            {collection assign=products controller=productList focus=frontpage pageSize=15}
            {if $products->getActualSize() gt 0}
                {include file='modules/widgets/productslider/productslider.tpl' items=$products title=$text.PRODUCT_CATALOG_MOST_POPULAR_FRONTPAGE_HEADLINE}
            {/if}
            {* MEST SOLGTE PRODUKTER *}
            {$ignoreProductIds = [6240, 6239, 6238]}
            {collection assign=productsMostSold controller=productList pageSize=15 orderBy="-Sold,Sorting,Title" primary=true}
            {if $productsMostSold->getActualSize() gt 0}
                {include file='modules/widgets/productslider/productslider.tpl' items=$productsMostSold title=$text.PRODUCT_CATALOG_MOST_SOLD_FRONTPAGE_HEADLINE}
            {/if}

            {* BRANDS *}
            {include file='modules/widgets/brands/brands.tpl'}

            {* TEXT *}
            {controller assign=pageCtrl type=page}
            {entity assign=frontpage controller=$pageCtrl id=81}
            {$frontpageText = $pageCtrl->getText(81)}
            <div class="py-6 px-3 lg:py-20 lg:px-10 relative w-[1200px] max-w-full mx-auto mb-4 lg:mb-10">
                <div class="bg-slate-100 absolute top-0 left-0 w-full lg:w-2/3 h-full z-10 rounded"></div>
                <div class="prose max-w-full frontpagetext relative z-20">
                    {$frontpageText}
                </div>
            </div>
            {entity assign=frontpage controller=$pageCtrl id=86}
            {$frontpageText = $pageCtrl->getText(86)}
            <div class="py-6 px-3 lg:py-20 lg:px-10 relative w-[1200px] max-w-full mx-auto mb-4 lg:mb-10">
                <div class="prose max-w-full frontpagetext relative z-20">
                    {$frontpageText}
                </div>
            </div>
        </div>

    {else}
        {if $page.isCheckout || ($page.isProduct && $page.productId == null) || ($page.isProduct && $page.productId !== null)}

            {if !$page.isCheckout}
                <div class="flex justify-center pt-10 mb-2">
                    {breadcrumbs}
                </div>
            {/if}

            {pageTypeInclude}
        {else}
            <div class="container mx-auto py-6 sm:py-10 md:py-14">
                {pageTypeInclude}
            </div>
        {/if}
    {/if}

    {if !$page.isCheckout}
        {include file='partials/bottom.tpl'}
    {/if}

    <!-- Lastseen -->
    {if !$page.isCheckout}
        {include file="modules/widgets/lastseen/lastseen.tpl"}
    {/if}
    
    <!-- Sidebar -->
    {include file='modules/widgets/sidebar/sidebar.tpl'}

    <!-- Login -->
    <div id="login" style="display: none; width: 600px; max-width: 100%" tabindex="-1" role="dialog" aria-hidden="true">
        {include file='modules/widgets/login/login.tpl'}
    </div>

    <!-- Cart -->
    {include file='modules/widgets/ajaxcart/ajaxcart.tpl'}

    <!-- Wishlist -->
    {if $settings.module_shop_wishlist}
        {include file='modules/widgets/ajaxwishlist/ajaxwishlist.tpl'}
    {/if}

    {* Cookie consent *}
    {include file="modules/widgets/cookie/cookie.tpl"}

    {body_include}

    <script>
        jQuery.event.special.touchstart = {
            setup: function( _, ns, handle ) {
            this.addEventListener("touchstart", handle, { passive: !ns.includes("noPreventDefault") });
            }
        };
        jQuery.event.special.touchmove = {
            setup: function( _, ns, handle ) {
            this.addEventListener("touchmove", handle, { passive: !ns.includes("noPreventDefault") });
            }
        };
    </script>
<script async type="text/javascript" src="https://static.klaviyo.com/onsite/js/klaviyo.js?company_id=TmtcvU"></script>
<script async src="{$template.cdn}{locateFile file="assets/js/klaviyo.tracking.js"}"></script>
</body>

</html>

