<a href="/" title="{$contactdata.name|escape:'html'}" class="flex items-center h-full">
    {if $template.settings.LOGO_TYPE eq 'PICTURE' and !empty($template.settings.LOGO_SOURCE)}
        <img src="{$template.settings.LOGO_SOURCE|solutionPath}" width="260" height="32" alt="{$contactdata.company}" class="flex-none max-w-full h-auto w-[200px] lg:w-[300px]">
    {else}
        <span class="text-lg lg:text-2xl font-bold block">{$contactdata.name}</span>
    {/if}
</a>