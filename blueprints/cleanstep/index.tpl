{strip}

    {*** Library CSS ***}
    {addLink href='assets/css/libs.css' rel='preload stylesheet' as='style' type='text/css' crossorigin='anonymous'}

    {*** Tailwind CSS ***}
    {addLink href='assets/css/tailwind.css'}

    {*** Framework JS ***}
    {$bundleVersion = $template.settings.BUNDLE_VERSION}
    {if isset($bundleVersion) && $bundleVersion !== "1.0.0"}
        {addScript src="assets/js/{$bundleVersion}/app.js" preload=true}
    {else}
        {addScript src='assets/js/app.js' preload=true}
    {/if}

{/strip}

<!DOCTYPE html>
<html lang="{$general.languageIso639}">

<head prefix="og: http://ogp.me/ns#
        fb: http://ogp.me/ns/fb#
        ng: http://angularjs.org">
    {head_include}
</head>

<body id="ng-app" data-ng-app="platform-app" data-ng-strict-di itemscope itemtype="http://schema.org/WebPage">

    <!-- Header -->
    {if !$page.isCheckout}
        {include file='partials/top.tpl'}
    {/if}

    <!-- Breadcrumb -->
    {if !$page.isFrontPage && !$page.isCheckout}
        <div class="container">
            {breadcrumbs}
        </div>
    {/if}

    <!-- Body -->
    {if $page.isFrontPage} {* Frontpage *}

        {if !$page.url|strstr:'?bewise'}
            {include file='modules/widgets/categories/categories.tpl' id=155}
        {/if}

        {include file='modules/widgets/hero/hero.tpl'}

        {include file='modules/widgets/brands/brands.tpl'}

        <div class="container my-6 lg:my-8">
            {include file='modules/widgets/featured/featured.tpl' id=156}
        </div>

        {if $general.languageIso == 'DK26'}
            
            {$sliders = [
                'slider1' => [
                    'title' => $template.settings.FRONTPAGE_SLIDER_1_TITLE,
                    'type' => $template.settings.FRONTPAGE_SLIDER_1_TYPE,
                    'id' => $template.settings.FRONTPAGE_SLIDER_1_ID,
                    'sorting' => $template.settings.FRONTPAGE_SLIDER_1_SORTING,
                    'image' => $template.settings.FRONTPAGE_SLIDER_1_IMAGE,
                    'link' => $template.settings.FRONTPAGE_SLIDER_1_LINK,
                    'div' => $template.settings.FRONTPAGE_SLIDER_1_DIV_ID
                ],
                'slider2' => [
                    'title' => $template.settings.FRONTPAGE_SLIDER_2_TITLE,
                    'type' => $template.settings.FRONTPAGE_SLIDER_2_TYPE,
                    'id' => $template.settings.FRONTPAGE_SLIDER_2_ID,
                    'sorting' => $template.settings.FRONTPAGE_SLIDER_2_SORTING,
                    'image' => $template.settings.FRONTPAGE_SLIDER_2_IMAGE,
                    'link' => $template.settings.FRONTPAGE_SLIDER_2_LINK,
                    'div' => $template.settings.FRONTPAGE_SLIDER_2_DIV_ID
                ],
                'slider3' => [
                    'title' => $template.settings.FRONTPAGE_SLIDER_3_TITLE,
                    'type' => $template.settings.FRONTPAGE_SLIDER_3_TYPE,
                    'id' => $template.settings.FRONTPAGE_SLIDER_3_ID,
                    'sorting' => $template.settings.FRONTPAGE_SLIDER_3_SORTING,
                    'image' => $template.settings.FRONTPAGE_SLIDER_3_IMAGE,
                    'link' => $template.settings.FRONTPAGE_SLIDER_3_LINK,
                    'div' => $template.settings.FRONTPAGE_SLIDER_3_DIV_ID
                ],
                'slider4' => [
                    'title' => $template.settings.FRONTPAGE_SLIDER_4_TITLE,
                    'type' => $template.settings.FRONTPAGE_SLIDER_4_TYPE,
                    'id' => $template.settings.FRONTPAGE_SLIDER_4_ID,
                    'sorting' => $template.settings.FRONTPAGE_SLIDER_4_SORTING,
                    'image' => $template.settings.FRONTPAGE_SLIDER_4_IMAGE,
                    'link' => $template.settings.FRONTPAGE_SLIDER_4_LINK,
                    'div' => $template.settings.FRONTPAGE_SLIDER_4_DIV_ID
                ]
            ]}

        {else}

            {$sliders = [
                'slider1' => [
                    'title' => $text.FRONTPAGE_SLIDER_1_TITLE,
                    'type' => 'all',
                    'id' => null,
                    'sorting' => 'bestseller',
                    'image' => null,
                    'link' => null,
                    'div' => null
                ],
                'slider2' => [
                    'title' => $text.FRONTPAGE_SLIDER_2_TITLE,
                    'type' => 'all',
                    'id' => null,
                    'sorting' => 'sale',
                    'image' => null,
                    'link' => null,
                    'div' => null
                ]
            ]}
            
        {/if}

        <!-- Product slider 1 -->
        <div class="bg-gray-50">
            {call name=handleSlider data=$sliders.slider1}
        </div>

        <!-- Product slider 2 -->
        {call name=handleSlider data=$sliders.slider2}
        
        <!-- Product slider 3 -->
        {* <div class="bg-gray-50">
            {call name=handleSlider data=$sliders.slider3}
        </div> *}

        <!-- Blog -->
        {include file='modules/widgets/blog/blog.tpl' id=158}

        <!-- Product slider 4 -->
        {* {call name=handleSlider data=$sliders.slider4} *}

        <div class="container py-8 lg:py-16">
            {pageTypeInclude}
        </div>

    {else} {* Other pages *}

        {if !$page.isCheckout}
            <div class="container py-6 lg:py-12">
                {pageTypeInclude}
            </div>
        {else}
            {pageTypeInclude}
        {/if}

    {/if}
    
    {if !$page.isCheckout}
        <!-- Newsletter -->
        {include file='modules/widgets/newsletter/newsletter.tpl'}
        
        <!-- Footer -->
        {include file='partials/bottom.tpl'}
    {/if}

    <!-- Notification -->
    {include file='modules/widgets/notification/notification.tpl'}

    <!-- Sidebar -->
    {if $page.url|strstr:'?bewise'}
        {include file='modules/widgets/sidebar/sidebar.new.tpl'}
    {else}
        {include file='modules/widgets/sidebar/sidebar.tpl'}
    {/if}

    <!-- Login -->
    <div id="login" style="display: none; width: 600px; max-width: 100%" tabindex="-1" role="dialog" aria-hidden="true">
        {include file='modules/widgets/login/login.tpl'}
    </div>

    <!-- Cart -->
    {include file='modules/widgets/ajaxcart/ajaxcart.tpl'}

    <!-- Wishlist -->
    {include file='modules/widgets/ajaxwishlist/ajaxwishlist.tpl'}

    <!-- Cookie -->
    {include file='modules/widgets/cookie/cookie.tpl'}

    <!-- Compare -->
    {if !$page.url|strstr:$text.COMPARE_LINK}
        {include file='modules/widgets/compare/compare-toolbar.tpl'}
    {/if}

    <!-- Shop Add Button -->
    {include file='modules/widgets/shop/shop-add.tpl'}

    {body_include}

    {function handleShortcodes content=""}
        {if $content !== null}

            {* COMPARE *}
            {$shortcode = "COMPARE"}
            {if $content|strstr:"#`$shortcode`#"}
                {$blocks = "#`$shortcode`#"|explode:$content}
                {for $i = 1; $i < $blocks|count; $i++}
                    {$shortcodeString = "<p>#`$shortcode`#</p>"}
                    {$shortcode2String = "#`$shortcode`#"}
                    {$content = $content|strtr:[
                        $shortcodeString => {include file='modules/widgets/compare/compare.tpl'},
                        $shortcode2String => {include file='modules/widgets/compare/compare.tpl'}
                    ]}
                {/for}
            {/if}

            {$content}

        {/if}
    {/function}

    {function handleSlider data=[]}

        <div class="bg-gray-50">
            <div class="container py-8 lg:py-16">
                {if $data.image}
                    <div class="flex flex-col gap-4 lg:gap-8 lg:flex-row">
                {/if}
                {if $data.image}
                    <div class="w-full lg:w-2/5">
                        {if $data.link}
                            <a href="{$data.link}" class="block">
                        {/if}
                        <img src="{$data.image}" width="550" height="440" alt="{$data.title}" class="w-full h-auto rounded" />
                        {if $data.link}
                            </a>
                        {/if}
                    </div>
                {/if}
                {if $data.image}
                    <div class="w-full lg:w-3/5">
                {/if}
                {if $data.title}
                    <div class="flex items-center justify-between gap-4">
                        <strong class="text-2xl font-bold block mb-6">{$data.title}</strong>
                        {if $data.link}
                            <a href="{$data.link}" class="text-sm text-gray-500 hover:text-gray-700 flex items-center gap-1">
                                {$text.CART_SHOW_ALL_PRODUCTS}
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4 flex-none">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                                </svg>
                            </a>
                        {/if}
                    </div>
                {/if}
                
                {if $data.type == 'div'}
                    <div id="{$data.div}"></div>
                {else}
                    {include file='modules/product/product-slider.tpl' field="{$data.type}" id="{$data.id}" sorting="{$data.sorting}" slides="{if $data.image}3{/if}"}
                {/if}

                {if $data.image}
                    </div></div>
                {/if}
            </div>
        </div>

    {/function}
</body>

</html>