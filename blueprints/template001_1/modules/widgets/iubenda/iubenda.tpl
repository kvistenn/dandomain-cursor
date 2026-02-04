{*
    # Description
    Iubenda configuration for manual tagging

    Docs: https://www.iubenda.com/en/help/1229-manual-tagging-blocking-cookies

    ## Date last modified
    2023-09-04

    ## Primary variables
    $settings - Global scope variable containing platform settings

    ## Partials (templates)
    No extra templates required for this template
*}

{$iubendaScript = {getIubendaScriptSnippet}}

{if $template.settings.COOKIE_TYPE === 'IUBENDA' && !empty($iubendaScript)}
    {$iubendaScript}

    {literal}
        <script>
            var _iub = _iub || [];
            _iub.csConfiguration = _iub.csConfiguration || {};

            _iub.csConfiguration = Object.assign(
                _iub.csConfiguration, 
                {
                    localConsentDomain: "{/literal}{$general.domain|replace:'http://':''|replace:'https://':''}{literal}"
                }
            );
        </script>
    {/literal}
{/if}
