{if $additionals->getActualSize() gt 0}

    {foreach $additionals->getData() as $additional}

        {if $additional->Id eq 44 || $additional->Id eq 45}

            {collection assign=additionalDatas controller=productAdditional typeId=$additional->Id}

            <div class="my-6 py-6 border-y border-gray-200">
                <span class="block mb-4">{$text.CHOOSE_LIGHT_SOURCE}</span>
                <div class="flex items-center gap-6">
                    <div class="hidden lg:block w-20 flex-none py-4">
                        <img src="{$template.path}/assets/images/lightbulb.svg" alt="{$text.CHOOSE_LIGHT_SOURCE}" width="56" height="56" class="w-32 h-auto max-w-full mx-auto" />
                    </div>
                    <ul class="flex-auto flex flex-col gap-4">
                        {foreach $additionalDatas->getData() as $additionalData key=key}
                        
                            <li>
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <div class="flex overflow-hidden rounded w-fit">
                                        <input type="radio" class="w-4 h-4 rounded" name="product[{$product->Id}][additional][{$additional->Id}][]" value="{$additionalData->Id}"{if $key == 0} checked="checked"{/if}>
                                    </div>
                                    <div class="flex items-center justify-between flex-auto gap-2 xs:gap-1">
                                        <span class="text-xs flex flex-col flex-auto">{$additionalData->Title}</span>
                                        <div class="flex flex-col flex-none whitespace-nowrap">
                                            <span class="text-xs text-right">
                                                {if $additionalData->Price != 0}
                                                    (+ {$additionalData->Price|formatPrice})
                                                {else}
                                                    (+ {$text.FREE})
                                                {/if}
                                            </span>
                                        </div>
                                    </div>
                                </label>
                            </li>
                                
                        {/foreach}
                    </ul>
                </div>
            </div>

        {/if}

    {/foreach}

{/if}