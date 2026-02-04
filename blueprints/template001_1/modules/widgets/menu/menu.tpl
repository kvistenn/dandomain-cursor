{*

# Description
Menu widget. A widget is a small helper template, with some functionality.


## Date last modified
2021-02-01


## Primary variables
+ $items                            - A variable containing the collection sent
+ $classes                          - A string of classes to add to the first set of parents
+ $subclasses                       - A string of classes to add to children specificly


## Partials (templates)
No extra templates required for this template

*}

{*

# Description
Function to recursively generate any menu.

## Resource
+ [Smarty functions](http://www.smarty.net/docs/en/language.function.function.tpl)

 *}

{function name=printMenu}
<ul class="w-menu w-menu-list{if $classes} {$classes}{/if}">
    {foreach $items as $item}

        {if $item.id === 'myaccount' && !$settings.shop_b2b_customer_approval && !$settings.user_add}
            {continue}
        {/if}

        {$hasChildren = isset($item['children']) and count($item['children']) gt 0}
        <li class="w-menu-item item-{$item.id}{if $item.active} active{/if}{if $hasChildren} {if $item.id === $page.id}current{/if} dropdown{/if}">

            {if !isset($nested) && $hasChildren}
                {assign "itemClasses" "parent item-primary"}
            {elseif !isset($nested)}
                {assign "itemClasses" "item-primary"}
            {elseif $hasChildren}
                {assign "itemClasses" "parent"}
            {else}
                {assign "itemClasses" "item-sub"}
            {/if}

            {if $hasChildren}
               <span data-toggle="navigation" class="{$itemClasses} marker"><i class="fa fa-border fa-fw fa-caret-down"></i></span>
            {/if}

            <a href="{$item.handle|formatUrl}" class="{$itemClasses}" aria-haspopup="true" title="{$item.title}"{if !empty($item.target)} target="{$item.target}"{/if}><span>{$item.title}</span></a>

            {if $hasChildren}
                <div class="dropdown-menu">
                    <div class="dropdown-container">
                        {call name=printMenu items=$item.children classes=$subclasses subclasses=$subclasses nested=true}
                    </div>
                </div>
            {/if}
        </li>

    {/foreach}

</ul>
{/function}

{call name=printMenu items=$items classes=$classes subclasses=$subclasses}
