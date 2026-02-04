{*

# Description
Logo widget. A widget is a small helper template, with some functionality.


## Date last modified
2017-05-22


## Primary variables
+ $template                                                             - Array with settings from the template


## Partials (templates)
No extra templates required for this template

*}



{if $template.settings.LOGO_TYPE eq 'PICTURE' and !empty($template.settings.LOGO_SOURCE)}
    <a class="block" href="/" title="{$contactdata.name|escape:'html'}">
        <img src="{$template.settings.LOGO_SOURCE|solutionPath}" width="709" height="208" alt="{$contactdata.name|escape:'html'}" class="{$classes}" />
    </a>
{else}
    <a class="" href="/" title="{$contactdata.name|escape:'html'}">{$contactdata.name}</a>
{/if}