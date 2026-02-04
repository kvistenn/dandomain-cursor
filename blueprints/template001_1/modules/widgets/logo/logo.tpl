{*

# Description
Logo widget. A widget is a small helper template, with some functionality.


## Date last modified
2025-06-24


## Primary variables
+ $template                                                             - Array with settings from the template


## Partials (templates)
No extra templates required for this template

*}


<div class="logo w-logo">

	{* If the template is set to show a picture as logo *}
	{if $template.settings.LOGO_TYPE eq 'PICTURE' and !empty($template.settings.LOGO_SOURCE)}

    <a class="logo-anchor anchor-image" href="/" title="{$contactdata.name|escape:'html'}"><img src="{$template.settings.LOGO_SOURCE|solutionPath}" alt="{$template.settings.LOGO_SOURCE_ALT|default:$contactdata.name|escape:'html'}" class="responsive"/></a>

	{* Else show the solution name as logo *}
	{else}
		<a class="h1 brand logo-anchor anchor-text" href="/" title="{$contactdata.name|escape:'html'}">{$contactdata.name}</a>
	{/if}
</div>
