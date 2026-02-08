{strip}
{*** Library CSS ***}
{addLink href='assets/css/libs.css'}

{*** Template CSS ***}
{addLink href='assets/css/template.css'}

{*** Print CSS ***}
{addLink href='assets/css/print.css' media='print'}

{*** Framework JS ***}
{$bundleVersion = $template.settings.BUNDLE_VERSION}
{if isset($bundleVersion) && $bundleVersion !== "1.0.0"}
    {addScript src="assets/js/{$bundleVersion}/app.js"}
{else}
    {addScript src='assets/js/app.js'}
{/if}

{*** Scripts JS ***}
{addScript src='assets/js/template.js'}

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
        {* Modules will be added here as they are redesigned *}

        <div id="site-wrapper">
            {* CONTENT *}
            <main id="site-content">

                {* HEADER *}
                {include file='partials/top.tpl'}

                {if !$page.isFrontPage and ($template.settings.SETTINGS_SHOW_BREADCRUMB or $template.settings.SETTINGS_SHOW_PRINT)}
                    <div class="container toolbar">
                        {if $template.settings.SETTINGS_SHOW_BREADCRUMB}
                            {* Breadcrumbs / navigation of the entire site *}
                            {breadcrumbs}
                        {/if}
                    </div>
                {/if}

                <div class="container page-content">
                    <div class="row">

                        {if !empty($boxes.left) && !$isProductListPage}
                            {* Left column will be added when modules are redesigned *}
                        {/if}

                        <div class="{$columnClass}">
                            {* Notification *}
                            {* Modules will be added here as they are redesigned *}

                            {if $page.isFrontPage}
                                <section class="section">
                                    {pageTypeInclude}
                                </section>
                            {else}
                                {pageTypeInclude}
                            {/if}

                        </div>

                        {if !empty($boxes.right)}
                            {* Right column will be added when modules are redesigned *}
                        {/if}
                    </div>
                </div>

                {* FOOTER *}
                {include file='partials/bottom.tpl'}
            </main>
        </div>

        {body_include}
    </body>
</html>
