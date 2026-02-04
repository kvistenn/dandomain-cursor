<div class="container mx-auto">
    <div class="overflow-x-auto pb-2">
        <ul class="flex gap-2 justify-center text-xs md:flex-wrap whitespace-nowrap md:whitespace-normal" itemscope itemtype="http://schema.org/BreadcrumbList">
            {foreach $page.breadcrumbs as $key => $breadcrumb}
                <li class="text-gray-600 whitespace-nowrap flex-none{if $breadcrumb@last} text-black pointer-events-none{/if}" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                    <a href="{$breadcrumb->path}" itemtype="http://schema.org/Thing" itemprop="item">
                        <span itemprop="name">{$breadcrumb->title|lower|ucfirst}</span>
                    </a>
                    <meta itemprop="position" content="{$breadcrumb@iteration}">
                </li>
                {if !$breadcrumb@last}
                    <li class="text-gray-300 whitespace-nowrap flex-none">/</li>
                {/if}
            {/foreach}
        </ul>
    </div>
</div>