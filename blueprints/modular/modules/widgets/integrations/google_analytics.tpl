{*

# Description
Google Analytics widget for tracking and enhanced ecommerce. A widget is a small helper template, with some functionality.


## Date last modified
2023-09-04


## Primary variables
+ $settings                                                             - Global scope variable containing platform settings
+ $page                                                                 - Global scope variable containing all information about the page type


## Partials (templates)
No extra templates required for this template

*}

{$cookiesAllowed = isset($cookieConsent.consent) && $cookieConsent.consent['STATISTICS']}

{if !empty($settings.api_google_analytics) && $settings.api_google_analytics !== false}

    {$scriptAttriubtes = ''}
    {if $template.settings.COOKIE_TYPE === 'IUBENDA'}
        {$scriptAttriubtes = {getIubendaAttributes purposes='4'}}
    {/if}

    {if isset($settings.google_analytics_type) && $settings.google_analytics_type === "universal_gtagjs"}
        <script async src="https://www.googletagmanager.com/gtag/js?id={$settings.api_google_analytics}" id="google-analytics" {$scriptAttriubtes}></script>

        {include file="modules/widgets/integrations/event_handler.tpl"}

    {elseif $settings.google_analytics_type === "universal" && $cookiesAllowed}
        <script id="google-analytics" {$scriptAttriubtes}>
            {literal}
                (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
            {/literal}
                ga('create', '{$settings.api_google_analytics}', 'auto');
                {literal}
	                if (sessionStorage.getItem('referrer') !== null) {
	                    ga('set', 'referrer', sessionStorage.getItem('referrer'));
	                    sessionStorage.removeItem('referrer');
	                }
                {/literal}
                ga('set', 'anonymizeIp', true);
                ga('send', 'pageview');

            {* Analytics for e-commerce (transaction) *}
            {if $page.isCheckout && isset($smarty.get.approved) && !empty($page.orderId)}
                {orderTracking orderId=$page.orderId type="analytics"}
            {/if}
        </script>

    {elseif $cookiesAllowed}
        <script id="google-analytics" {$scriptAttriubtes}>
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '{$settings.api_google_analytics}']);
        _gaq.push(['_trackPageview']);
        {* Analytics for e-commerce (transaction)*}
        {if $page.isCheckout && isset($smarty.get.approved) && !empty($page.orderId)}
            {orderTracking orderId=$page.orderId type="analytics"}
        {/if}
        
        {literal}
            (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
        {/literal}
        </script>
    {/if}
{/if}
