{includeScript file='partials/body.js.tpl'}

{*** Languages collection ***}
{collection controller=language assign=languages}

{*** Get all shop currencies ***}
{collection controller=currency assign=currencies}

{if $template.settings.SETTINGS_SHOW_SEARCH or $currencies and $currencies->getActualSize() gt 1 or $languages->getActualSize() gt 1}
<div class="site-corporate">
    <div class="container with-xlarge">
        <div class="row">
            <div class="col-s-4 col-m-12 col-l-12 col-xl-24">
                <div class="row">

                    {if $languages->getActualSize() gt 1 || $currencies and $currencies->getActualSize() gt 1}

                    <div class="col-s-2 col-m-4 col-l-4 col-xl-6 dropdown-pickers">

                        {if $languages->getActualSize() gt 1}
                            <div class="w-language-picker is-inline-block">
                                {$showFlag = true}
                                {$showText = true}
                                {if $template.settings.SETTINGS_TYPE_LANGUAGE eq 'FLAG'}
                                    {$showText = false}
                                {elseif $template.settings.SETTINGS_TYPE_LANGUAGE eq 'TEXT'}
                                    {$showFlag = false}
                                {/if}

                                {include file="modules/widgets/language/language.tpl" collection=$languages type="dropdown" showFlag=$showFlag showText=$showText}
                            </div>
                        {/if}

                        {if $currencies and $currencies->getActualSize() gt 1}

                            <div class="w-currency-picker is-inline-block">
                                {include file="modules/widgets/currency/currency.tpl" collection=$currencies type="dropdown"}
                            </div>
                        {/if}

                    </div>

                    {/if}

                    {if $template.settings.SETTINGS_SHOW_SEARCH}
                        <div class="col-s-2 col-m-4 col-l-3 col-xl-6 search-module pull-right">
                            <form class="top-search-form" method="get" action="/{if $general.isShop}{page id=$page.productPageId print=Link}{else}{$Text.SEARCH_LINK}{/if}/">
                                <div class="input-group xsmall">
                                    <input type="text" class="form-input input-group-main" placeholder="{$Text.SEARCH_TEXT}" name="search" required>
                                    <span class="input-group-button"><button class="button" type="submit">{$text.SEARCH}</button></span>
                                </div>
                            </form>
                        </div>
                    {/if}

                </div>
            </div>
        </div>
    </div>
</div>
{/if}
<header class="site-header" itemscope itemtype="http://schema.org/WPHeader">
    <div class="container with-xlarge">
        <div class="row">
            <div class="col-s-4 col-m-12 col-l-12 col-xl-24">
                {include file='modules/widgets/logo/logo.tpl'}
            </div>
        </div>
    </div>
</header>
<div class="site-navigation">
    <div class="container with-xlarge">
        <div class="row">
            <div class="col-s-4 col-m-12 col-l-12 col-xl-24">
                <nav class="navbar w-widget widget">

                    <div class="navbar-header">
                        {if $general.isShop && $template.settings.SETTINGS_SHOW_CART && $page.type != 'cart' && $page.type != 'checkout'}
                            {* Cart controller *}
                            {collection controller=cart assign=cart}
                            {$cartList = $cart->groupByClass()}
                            <a href="/{$text.CART_LINK}/" title="{$text.CART_MENU}" class="button-primary navbar-toggle"><i class="fa fa-shopping-cart fa-fw"></i>
                                {if isset($cartList.CartProductLine)}
                                    {$cart->getActualSize()}
                                {/if}
                            </a>
                        {/if}

                        <button type="button" title="{$text.WHERE_AM_I_NAVIGATION}" class="button-primary navbar-toggle pull-left" data-toggle="collapse" data-target="main-navbar"><i class="fa fa-bars fa-fw"></i></button>
                    </div>

                    <div class="navbar-collapse is-collapsed" data-group="main-navbar">
                        <div class="row w-menu-row">

                            <div class="{if $general.isShop && $template.settings.SETTINGS_SHOW_CART}col-s-4 col-m-12 col-l-9 col-xl-20{else}col-s-4 col-m-12 col-l-12 col-xl-24{/if} w-menu-col-links" itemscope itemtype="http://schema.org/SiteNavigationElement">

                                {$static = false}
                                {if $template.settings.SETTINGS_SHOW_MY_ACCOUNT}
                                    {$static = true}
                                {/if}

                                {menu assign=primaryMenu static=$static}

                                {include
                                    file='modules/widgets/menu/menu.tpl'
                                    items=$primaryMenu
                                    classes='nav nav-default'
                                }
                            </div>
                            {if $page.type != 'cart' && $page.type != 'checkout'}
                                {if $general.isShop && $template.settings.SETTINGS_SHOW_CART}
                                    <div class="col-s-4 col-m-3 col-l-3 col-xl-4 is-hidden-s is-hidden-m w-menu-col-cart">
                                        {include file='modules/widgets/cart/cart.tpl' cart=$cart}
                                    </div>
                                {/if}
                            {/if}

                        </div>
                    </div>
                </nav>
            </div>
        </div>
    </div>
</div>
