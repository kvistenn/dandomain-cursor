{*

# Description
Template for Custom data fields


## Date last modified
2021-10-28


## Primary variables
+ $entityType                                            - Variable for storing the entity type of the custom data
+ $entityId                                              - Variable for storing the entity id (if any) of the custom data
+ $context                                               - The context the custom data is displayed in (users, checkout)
+ $display                                               - How the custom data is displayed (input, hidden, text)


## Partials (templates)
No extra templates required for this template

*}

{if !isset($entityId)}
    {$entityId = 0}
{/if}

{collection assign=customDataTypes controller=customDataType entityType=$entityType}

{if !empty($context) && $customDataTypes->getActualSize() > 0}
    <div class="pb-5 space-y-3">
        {if $display === 'list'}
            {foreach $customDataTypes->getData() as $customDataType}
                {if ($context === 'user' && $customDataType->DisplayInUserContext) || ($context === 'checkout' && $customDataType->DisplayInCheckoutContext)}
                    {collection assign=customDatas controller=customData typeId=$customDataType->Id entityId=$entityId}

                    <div class="m-checkout-data-custom">
                        {$customDataType->Title}:
                        {foreach $customDatas->getData() as $customData}
                            {if $customDataType->Type === 1 || $customData->Selected}
                                {$customData->Value}<br>
                                <input type="hidden" name="customData[{$customDataType->Type}][{$customDataType->Id}][{if $customDataType->Type === 2}{$customData->Value}{/if}]" value="{$customData->Value}">
                            {/if}
                        {/foreach}
                    </div>

                {/if}
            {/foreach}
        {elseif $display ne 'hidden'}
        {foreach $customDataTypes->getData() as $customDataType}
            {if ($context eq 'user' && $customDataType->DisplayInUserContext) || ($context eq 'checkout' && $customDataType->DisplayInCheckoutContext)}

                {$returnPostCustomData = null}
                {if $returnPostData}
                    {$returnPostCustomData = $returnPostData.customData[{$customDataType->Type}][{$customDataType->Id}]}
                {/if}

                {collection assign=customDatas controller=customData typeId=$customDataType->Id entityId=$entityId}

                <label class="flex flex-col gap-1">
                    <span class="text-xs">{$customDataType->Title}{if $customDataType->Required}<span>*</span>{/if}</span>
                    {if $customDataType->Type eq 1}
                        {foreach $customDatas->getData() as $customData}
                            <input type="text" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" name="customData[{$customDataType->Type}][{$customDataType->Id}][]" value="{if $returnPostCustomData}{$returnPostCustomData[0]}{else}{$customData->Value}{/if}"{if $customDataType->Required} required{/if}>
                        {/foreach}
                    {elseif $customDataType->Type eq 2}
                        {foreach $customDatas->getData() as $customData}

                            {$selected = false}
                            {if $returnPostCustomData and $returnPostCustomData[{$customData->Value}]}
                                {$selected = true}
                            {elseif $customData->Selected}
                                {$selected = true}
                            {/if}

                            <div class="input-group">
                                <span class="input-group-addon">
                                    <input id="m-custom-data-id-{$customDataType->Id}-{$customData->Value}" type="checkbox" name="customData[{$customDataType->Type}][{$customDataType->Id}][{$customData->Value}]" value="{$customData->Value}"{if $selected} checked="checked"{/if}>
                                </span>
                                <label for="m-custom-data-id-{$customDataType->Id}-{$customData->Value}" class="form-label input-group-main">{$customData->Title}</label>
                            </div>
                        {/foreach}

                    {elseif $customDataType->Type eq 3}

                        <select id="m-custom-data-id-{$customDataType->Id}" class="form-input form-select small" name="customData[{$customDataType->Type}][{$customDataType->Id}][]">
                            {foreach $customDatas->getData() as $customData}
                                {$selected = false}
                                {if $returnPostCustomData and $returnPostCustomData[0] eq $customData->Value}
                                    {$selected = true}
                                {elseif $customData->Selected}
                                    {$selected = true}
                                {/if}
                                <option value="{$customData->Value}"{if $selected} selected="selected"{/if}>{$customData->Title}</option>
                            {/foreach}
                        </select>
                    {/if}
                </label>
            {/if}
        {/foreach}
        {else}
            {foreach $customDataTypes->getData() as $customDataType}
                {if ($context === 'user' && $customDataType->DisplayInUserContext) || ($context === 'checkout' && $customDataType->DisplayInCheckoutContext)}
                    {collection assign=customDatas controller=customData typeId=$customDataType->Id entityId=$entityId}

                    {foreach $customDatas->getData() as $customData}
                        {if $customDataType->Type === 1 || $customData->Selected}
                            <input type="hidden" name="customData[{$customDataType->Type}][{$customDataType->Id}][{if $customDataType->Type === 2}{$customData->Value}{/if}]" value="{$customData->Value}">
                        {/if}
                    {/foreach}
                {/if}
            {/foreach}
        {/if}
    </div>
{/if}