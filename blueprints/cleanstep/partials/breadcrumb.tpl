<ul class="flex items-center gap-2 text-sm py-4" itemscope itemtype="http://schema.org/BreadcrumbList">
    {foreach $page.breadcrumbs as $key => $breadcrumb}
        {if !$breadcrumb@last && $key != 0 && $key != 1}
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <a href="{$breadcrumb->path}" itemtype="http://schema.org/Thing" itemprop="item" class="text-xs text-gray-400 underline hover:text-black transition-colors">
                    <span itemprop="name">{$breadcrumb->title}</span>
                </a>
                <meta itemprop="position" content="{$breadcrumb@iteration}">
            </li>
            {if !$breadcrumb@last}
                <li class="last:hidden text-xs text-gray-400">/</li>
            {/if}
        {/if}
    {/foreach}
</ul>