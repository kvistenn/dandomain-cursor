{*

# Description
Controller and template for Text page type.


## Date last modified
2020-08-28


## Primary variables
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
+ "/modules/widgets/meta/opengraph.tpl"                                 - Social meta data

*}

{if $page and $page.id}
    {*** Global widgets defaults ***}
    {$prev = null}
    {$next = null}

    {$opengraph_image = null}
    {$opengraph_description = null}

    {controller type=page assign=controller primary=true}
    {$pageText = $controller->getText($page.id)}

    {$opengraph_description = {translation module=seo_page title=description id=$page.id}}

    {if empty($opengraph_description)}
      {$opengraph_description = $pageText|strip_tags}
    {/if}

    {$opengraph_description = $opengraph_description|truncate:160}

    {entity assign=pageImage controller=files type=page id=$page.id pageSize=1}
    {if $pageImage}
        {$opengraph_image = $pageImage->thumbnail(1200)|solutionPath}
    {/if}

    {if $settings.cookies_link === $page.id}
        {$detailsReplacement = '<div data-inject="cookiedetails"></div>'}
        {$removeReplacement = '<div data-inject="cookieremove"></div>'}
        {$pageText = $pageText|strtr:[
            '<p>#COOKIEDETAILS#</p>' => $detailsReplacement,
            '#COOKIEDETAILS#' => $detailsReplacement,
            '<p>#COOKIEREMOVE#</p>' => $removeReplacement,
            '#COOKIEREMOVE#' => $removeReplacement
        ]}
    {/if}

    {$pageText = $pageText|strtr:[
        '<td>true</td>' => '<td class="text-green"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 mx-auto"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" /></svg></td>',
        '<td>false</td>' => '<td class="text-red"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 mx-auto"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" /></svg></td>'
    ]}

    <article class="pb-12">

        <div>
            {$pageHeadline = trim($page.headline)}

            {if !empty($pageHeadline)}
                <header class="mb-4">
                    <h1 class="font-bold uppercase text-xl tracking-wider">{$page.headline}</h1>
                </header>
            {/if}

            {*** Page content ***}
            <div class="content ck-content prose max-w-full">
                {$pageText}
            </div>
        
        </div>

    </article>

    {$hasChildren = $controller->pageHasChildren($page.id)}

    {if $hasChildren}
    {$faqId = null}
        {menu assign=AllMenuItems}
        {foreach $AllMenuItems as $menuItem}
            {if $menuItem.children|@count gt 0}
            {foreach $menuItem.children as $child}
                {if $child.id == $page.id}
                    {if $child.children|@count gt 0}
                        {foreach $child.children as $subChild}
                            {if $subChild.title eq 'FAQ'}
                                {$faqId = $subChild.id}
                            {/if}
                        {/foreach}
                    {/if}
                {/if}
            {/foreach}
        {/if}
        {/foreach}

        {if $faqId}
            {include file="modules/widgets/faq/faq.tpl" id=$faqId}
        {/if}
    {/if}

    {$hasParent = isset($page.parentId) and $page.parentId neq 0}
    {if $hasParent}
        {$pageIds = $controller->getCompletePath($page.id)}

        {foreach $pageIds as $pageId}
            {entity assign=item controller=page id=$pageId}
            {addBreadCrumb path=$item->Handle title=$item->Title}
        {/foreach}
    {else}
        {addBreadCrumb path=$page.handle title=$page.title}
    {/if}

    {*** Global widgets ***}
    {include file="modules/widgets/meta/opengraph.tpl"
        og=["description" => $opengraph_description, "image" => $opengraph_image]
    }
{else}
    {notfound}
{/if}
