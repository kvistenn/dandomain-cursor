{strip}
{*** Critical CSS: preload for non-blocking load, apply on load; noscript fallback ***}
{addLink href='assets/css/libs.css' rel='preload' as='style' onload="this.onload=null;this.rel='stylesheet'"}
{addLink href='assets/css/tailwind.css' rel='preload' as='style' onload="this.onload=null;this.rel='stylesheet'"}
<noscript><link rel="stylesheet" href="{$template.cdn}{locateFile file='assets/css/libs.css'}"><link rel="stylesheet" href="{$template.cdn}{locateFile file='assets/css/tailwind.css'}"></noscript>

{*** Framework JS: defer to avoid blocking render ***}
{$bundleVersion = $template.settings.BUNDLE_VERSION}
{if isset($bundleVersion) && $bundleVersion !== "1.0.0"}
    {addScript src="assets/js/{$bundleVersion}/app.js" defer=""}
{else}
    {addScript src='assets/js/app.js' defer=""}
{/if}

{$columnClass = "col-s-4 col-m-12 col-l-12 col-xl-24"}
{collection assign=boxes controller=moduleBox}
{$boxes = $boxes->groupBy('Position')}

{* Calculate number of columns needed *}
{if !empty($boxes.left) and !empty($boxes.right)}
    {$columnClass = "col-s-4 col-m-12 col-l-6 col-xl-14"}
    {$columns = 2}
{elseif !empty($boxes.left) or !empty($boxes.right)}
    {$columnClass = "col-s-4 col-m-12 col-l-9 col-xl-19"}
    {$columns = 1}
{/if}

{$productFilterAcivated =
    $access.productfilter
    && $settings.shop_product_filter_enabled
}

{$isProductListPage =
    $page.type == 'product'
    && (count($page.paths) == 2 || isset($smarty.get['search']) || isset($smarty.get['brand']) || isset($smarty.get['new']) || isset($smarty.get['sale']))
}

{* Act like filter is a column on product lists *}
{if !$columns && $productFilterAcivated && $isProductListPage}
    {$columns = 1}
{/if}

{* Let the productlist take up the left column width *}
{if $isProductListPage}
    {if !empty($boxes.right)}
        {$columnClass = "col-s-4 col-m-12 col-l-9 col-xl-19"}
    {else}
        {$columnClass = "col-s-4 col-m-12 col-l-12 col-xl-24"}
    {/if}
{/if}

{/strip}<!DOCTYPE html>
<!--[if lt IE 7 ]> <html class="ie6 ielt9 no-js" lang="{$general.languageIso639}"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie7 ielt9 no-js" lang="{$general.languageIso639}"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie8 ielt9 no-js" lang="{$general.languageIso639}"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie9 no-js" lang="{$general.languageIso639}"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html class="no-js" lang="{$general.languageIso639}"> <!--<![endif]-->
<head prefix="og: http://ogp.me/ns#
              fb: http://ogp.me/ns/fb#
              ng: http://angularjs.org">
    {head_include}
</head>
    <body id="ng-app" data-ng-app="platform-app" data-ng-strict-di class="type-{$page.name} page{$page.id} {if $page.isFrontPage}frontpage{/if}" itemscope itemtype="http://schema.org/WebPage">

        {* Cookie consent *}
        {include file="modules/widgets/cookie/cookie.tpl"}

        <input type="checkbox" id="toggleSidebar" hidden />
        <div id="site-wrapper">

            {* SIDEBAR *}
            {include file="modules/widgets/sidebar/sidebar.tpl"}

            {* OVERLAY *}
            <label for="toggleSidebar" id="site-overlay"></label>

            {* CONTENT *}
            <main id="site-content">

                {* HEADER *}
                {include file='partials/top.tpl'}

                {* USP *}
                {include file="modules/widgets/usp/usp.tpl"}

                {* SLICK *}
                {include file='modules/widgets/slick/slick.tpl'}

                {if !$page.isFrontPage and ($template.settings.SETTINGS_SHOW_BREADCRUMB or $template.settings.SETTINGS_SHOW_PRINT)}
                    <div class="container with-xlarge toolbar">
                        {if $template.settings.SETTINGS_SHOW_BREADCRUMB}
                            {* Breadcrumbs / navigation of the entire site *}
                            {breadcrumbs}
                        {/if}
                    </div>
                {/if}

                <div class="container with-xlarge page-content">
                    <div class="row">

                        {if !empty($boxes.left) && !$isProductListPage}
                            {include file='modules/column/column.tpl' boxes=$boxes.left}
                        {/if}

                        <div class="{$columnClass}">
                            {* Notification *}
                            {include file="modules/widgets/notification/notification.tpl"}

                            {if $page.isFrontPage}

                                {* CATEGORIES *}
                                {if $general.isShop}
                                    {include file="modules/widgets/categories/categories.tpl"}
                                {/if}

                                <section class="section">
                                    {pageTypeInclude}
                                </section>

                                {* PRODUCTS *}
                                {if $general.isShop}
                                    {collection assign=featured controller=productList focus=frontpage orderBy=Sorting}
                                    {if $featured->getActualSize() gt 0}
                                        <section class="section">
                                            <header class="page-title">
                                                <h3>{$text.PRODUCT_CATALOG_FOCUS_FRONTPAGE_HEADLINE}</h3>
                                            </header>
                                            {include file='modules/product/product-list-combined.tpl' productlist=$featured onlyProducts=true}
                                        </section>
                                    {/if}
                                {/if}
                            {else}
                                {pageTypeInclude}
                            {/if}

                        </div>

                        {if !empty($boxes.right)}
                            {include file='modules/column/column.tpl' boxes=$boxes.right}
                        {/if}
                    </div>
                </div>

                {* FOOTER *}
                {include file='partials/bottom.tpl'}
            </main>
        </div>

        {* General overlays *}
        {if $shop and $shop.priceTerms}
            {include file='modules/widgets/overlay/overlay.tpl' dataId='priceTerms' dataItemId=$shop.priceTerms.id}
        {/if}

        {body_include}
    </body>
</html>
