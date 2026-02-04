{literal}
    <script id="render-delivery" type="text/x-jsrender">
        
        {{if CartDeliveryLimit != null}}
            {{if ~progress == 100}}
                <div class="text-sm py-2 px-3 border border-green-600 bg-green-50 rounded flex items-center gap-2 justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                    </svg>
                    {{:~text('DELIVERY_FREE')}}
                </div>
            {{else}}
                <div class="flex flex-col gap-2 text-sm">
                    <strong>{{:~deliveryLimitUntilText}}</strong>
                    <div class="border border-primary p-1 rounded-full w-full relative">
                        <span data-freedelivery="bar" style="width: {{:~progress}}%;" class="w-[0px] bg-primary h-3 block rounded-full transition-all duration-500"></span>
                        <span class="leading-none p-1 bg-primary text-white text-[10px] absolute bottom-full right-2 -translate-y-2 rounded">
                            {{:~currency(~deliveryLimit)}}
                            <span class="w-2 h-1 [clip-path:polygon(100%_0,0_0,51%_100%)] bg-primary absolute top-full left-1/2 -translate-x-1/2"></span>
                        </span>
                    </div>
                </div>
            {{/if}}
        {{else}}
            <div class="flex flex-col gap-2 text-sm">
                <strong>{{:~deliveryLimitText}}</strong>
                <div class="border border-primary p-1 rounded-full w-full relative">
                    <span data-freedelivery="bar" style="width: 0%;" class="w-[0px] bg-primary h-3 block rounded-full transition-all duration-500"></span>
                    <span class="leading-none p-1 bg-primary text-white text-[10px] absolute bottom-full right-2 -translate-y-2 rounded">
                        {{:~currency(~deliveryLimit)}}
                        <span class="w-2 h-1 [clip-path:polygon(100%_0,0_0,51%_100%)] bg-primary absolute top-full left-1/2 -translate-x-1/2"></span>
                    </span>
                </div>
            </div>
        {{/if}}

    </script>
{/literal}
    
<div id="ajaxdelivery" class="h-[50px]"></div>
    