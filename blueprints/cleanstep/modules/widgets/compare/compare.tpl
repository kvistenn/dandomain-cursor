{* Jsrender compare *}

{literal}
<script id="render-compare" type="text/x-jsrender">
    <div data-compare="list">

        {{if CompareProduct.length > 0}}

            <div class="flex w-full bg-white rounded border border-gray-200">

                <div class="hidden lg:flex flex-col justify-end w-1/5 flex-none">
                    {{for CompareProduct[0]}}
                        <div class="font-bold p-3 border-t border-gray-200"><span class="lg:line-clamp-1 lg:overflow-hidden">{{:~text('CART_PRICE')}}</span></div>
                        <div class="font-bold p-3 border-t border-gray-200"><span class="lg:line-clamp-1 lg:overflow-hidden">{{:~text('PRODUCT_CATALOG_BRAND')}}</span></div>
                        <div class="font-bold p-3 border-t border-gray-200"><span class="lg:line-clamp-1 lg:overflow-hidden">{{:~text('CATEGORY')}}</span></div>
                        <div class="font-bold p-3 border-t border-gray-200"><span class="lg:line-clamp-1 lg:overflow-hidden">{{:~text('PRODUCT_CATALOG_PRODUCT_NUMBER')}}</span></div>
                        <div class="font-bold p-3 border-t border-gray-200"><span class="lg:line-clamp-1 lg:overflow-hidden">{{:~text('CHECKOUT_STEP_TWO_STOCK_STATUS')}}</span></div>
                        {{if CustomTypes.length > 0}}
                            {{for CustomTypes}}
                                <div class="font-bold p-3 border-t border-gray-200"><span class="lg:line-clamp-1 lg:overflow-hidden">{{:Title}}</span></div>
                            {{/for}}
                        {{/if}}
                    {{/for}}  
                </div>

                <div class="flex flex-col gap-5 lg:gap-0 lg:flex-row flex-auto">
                    {{for CompareProduct}}
                        <div class="flex flex-col justify-end flex-1 lg:max-w-[50%] border-b lg:border-b-0 last:border-b-0 lg:border-l border-gray-200">
                            <div class="flex flex-col">
                                <div class="p-6 relative">
                                    <span data-compare="delete" class="absolute top-4 right-4 cursor-pointer" data-id="{{:Id}}">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                        </svg>
                                    </span>
                                    <div class="flex gap-6 rounded">
                                        <a href="{{:Handle}}" class="block aspect-square w-[80px] flex-none">
                                            <img src="{{:Image}}" alt="{{:Title}}" width="80" height="80" class="w-full height-auto aspect-square object-cover">
                                        </a>
                                        <div class="flex-auto flex flex-col">
                                            {{if ~settings('module_shop_review_products') && AverageRatingArray.length > 0}}
                                                <div class="flex gap-0.5 mb-2">
                                                    {{for AverageRatingArray}}
                                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-4 h-4{{if fill == "true"}} text-yellow-500{{else}} text-gray-300{{/if}}">
                                                            <path fill-rule="evenodd" d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z" clip-rule="evenodd" />
                                                        </svg>
                                                    {{/for}}
                                                </div>
                                            {{/if}}
                                            <strong class="text-lg block mb-2 line-clamp-1"><a href="{{:Handle}}">{{:Title}}</a></strong>
                                            <a href="{{:Handle}}" class="underline text-sm block mt-auto">{{:~text('PRODUCT_CATALOG_PRODUCT_SHOW')}}</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-3 border-t border-grey-200" data-equalizer="field">
                                    <strong class="block lg:hidden mb-1 text-xs uppercase">{{:~text('CART_PRICE')}}:</strong>
                                    <span>{{:~currency(Price)}}</span>
                                    {{if FullPrice != Price}}
                                        <strike>{{:~currency(FullPrice)}}</strike>
                                    {{/if}}
                                </div>
                                <div class="p-3 border-t border-gray-200" data-equalizer="field">
                                    <strong class="block lg:hidden mb-1 text-xs uppercase">{{:~text('PRODUCT_CATALOG_BRAND')}}:</strong>
                                    {{if ProducerTitle}}
                                        <a href="{{:ProducerHandle}}" class="underline">{{:ProducerTitle}}</a>
                                    {{else}}
                                        <i class="text-black/50">{{:~text('COOKIES_UNKNOWN')}}</i>
                                    {{/if}}
                                </div>
                                <div class="p-3 border-t border-gray-200" data-equalizer="field">
                                    <strong class="block lg:hidden mb-1 text-xs uppercase">{{:~text('CATEGORY')}}:</strong>
                                    <a href="{{:CategoryHandle}}" class="underline">{{:CategoryTitle}}</a>
                                </div>
                                <div class="p-3 border-t border-gray-200" data-equalizer="field">
                                    <strong class="block lg:hidden mb-1 text-xs uppercase">{{:~text('PRODUCT_CATALOG_PRODUCT_NUMBER')}}:</strong>
                                    {{if ItemNumber}}
                                        {{:ItemNumber}}
                                    {{else}}
                                        <i class="text-black/50">{{:~text('COOKIES_UNKNOWN')}}</i>
                                    {{/if}}
                                </div>
                                <div class="p-3 border-t border-gray-200" data-equalizer="field">
                                    <strong class="block lg:hidden mb-1 text-xs uppercase">{{:~text('CHECKOUT_STEP_TWO_STOCK_STATUS')}}:</strong>
                                    {{:StockText}}
                                </div>
                                {{if CustomTypes.length > 0}}
                                    {{for CustomTypes}}
                                        <div class="p-3 border-t border-gray-200" data-equalizer="field">
                                            <strong class="block lg:hidden mb-1 text-xs uppercase">{{:Title}}:</strong>
                                            {{if Data[0]}}
                                                {{:Data}}
                                            {{else}}
                                                <i class="text-black/50">{{:~text('COOKIES_UNKNOWN')}}</i>
                                            {{/if}}
                                        </div>
                                    {{/for}}
                                {{/if}}
                            </div>
                        </div>
                    {{/for}}
                </div>
            </div>

        {{else}}
            <div class="text-center">
                <span class="text-gray-400">
                    {{:~text('PRODUCT_CATALOG_CATEGORY_EMPTY')}}
                </span>
            </div>
        {{/if}}

    </div>
</script>
{/literal}

<div id="ajaxcompare"></div>