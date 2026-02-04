{*

# Description
Google Tagsmanager widget. A widget is a small helper template, with some functionality.


## Date last modified
2024-02-12


## Primary variables
+ $settings                                                             - Global scope variable containing platform settings
+ $page                                                                 - Global scope variable containing all information about the page type


## Partials (templates)
No extra templates required for this template

*}

{if isset($settings.google_tag_manager_id) && !empty($settings.google_tag_manager_id)}

    {$scriptAttriubtes = ''}
    {if $template.settings.COOKIE_TYPE === 'IUBENDA'}
        {$scriptAttriubtes = {getIubendaAttributes purposes='4'}}
    {/if}

    {if $page.isCheckout && isset($smarty.get.approved)}
        {strip}
            <script>
                {orderTracking orderId=$page.orderId type="tagmanager"}
            </script>
        {/strip}
    {/if}
    {strip}
        <script id="google-tagmanager" {$scriptAttriubtes}>
        {literal}
        (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
            j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
            '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        {/literal}
        })(window,document,'script','dataLayer','{$settings.google_tag_manager_id}');
        </script>

        {if empty($settings.api_google_analytics)}
            {include file="modules/widgets/integrations/event_handler.tpl"}
        {/if}
    {/strip}
{/if}
