{collection assign=customLabels controller=productCustomData typeId=1 productId=$product->Id}
{if $customLabels->getActualSize() gt 0}
    <div class="flex flex-wrap gap-2 absolute top-0 right-0 z-10 ">
        {foreach $customLabels->getData() as $label}
            {if $label->DataId eq 1} {* Ecolabel *}
                <img src="{$template.path}/assets/images/labels/ecolabel.webp" alt="Ecolabel" width="50" height="50" class="rounded w-16 h-16 lg:w-20 lg:h-20 xl:w-24 xl:h-24" />
            {else if $label->DataId eq 2} {* FSC *}
                <img src="{$template.path}/assets/images/labels/fsc.webp" alt="FSC" width="50" height="50" class="rounded w-16 h-16 lg:w-20 lg:h-20 xl:w-24 xl:h-24" />
            {else if $label->DataId eq 3} {* Svanemærket *}
                <img src="{$template.path}/assets/images/labels/svanemaerket.webp" alt="Svanem&aelig;rket" width="50" height="50" class="rounded w-16 h-16 lg:w-20 lg:h-20 xl:w-24 xl:h-24" />
            {else if $label->DataId eq 4} {* Plant Based *}
                <img src="{$template.path}/assets/images/labels/plantbased.webp" alt="Plant based" width="50" height="50" class="rounded w-16 h-16 lg:w-20 lg:h-20 xl:w-24 xl:h-24" />
            {else if $label->DataId eq 5} {* Cradle to Cradle *}
                <img src="{$template.path}/assets/images/labels/cradle-to-cradle.webp" alt="Cradle to Cradle" width="50" height="50" class="rounded w-16 h-16 lg:w-20 lg:h-20 xl:w-24 xl:h-24" />
            {/if}
        {/foreach}
    </div>
{/if}