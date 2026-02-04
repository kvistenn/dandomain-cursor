{literal}
    <script id="reorderitem" type="text/x-jsrender">
        
        <div class="flex flex-col gap-6 mt-6 max-w-[600px]">

            <div class="flex flex-col gap-2">
                <div class="flex flex-col lg:grid gap-6 lg:grid-cols-2">

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{{:~text('FIRSTNAME')}}</span>
                        <input type="text" name="reorderFirstname" value="{{:deliveryInformation.firstName}}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.FIRSTNAME}">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{{:~text('LASTNAME')}}</span>
                        <input type="text" name="reorderLastname" value="{{:deliveryInformation.lastName}}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.LASTNAME}">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{{:~text('ADDRESS')}}</span>
                        <input type="text" name="reorderAddress" value="{{:deliveryInformation.address}}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.ADDRESS}">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{{:~text('POSTCODE')}}</span>
                        <input type="text" name="reorderZipcode" value="{{:deliveryInformation.zip}}" data-smartform="zipcode" data-target="#reorderCity" placeholder="{$Text.POSTCODE}" autocomplete="off" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm">
                    </label>

                    <label class="flex flex-col gap-1">
                        <span class="text-xs">{{:~text('CITY')}}</span>
                        <input type="text" name="reorderCity" value="{{:deliveryInformation.city}}" id="reorderCity" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.CITY}" disabled required>
                    </label>

                    <input class="countryCode" type="hidden" name="countryCode" value="{{~:phonecode}}">

                    {{if ~countries.length > 1}}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{{:~text('COUNTRY')}}</span>
                            <select class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none arrow" name="reorderCountry">
                                {{for ~countries ~deliveryInfo=deliveryInformation}}
                                    <option data-has-states="{{:countryStates.length}}" value="{{:iso}}" {{if ~deliveryInfo.country == iso}}selected{{/if}}>{{:title}}</option>
                                {{/for}}
                            </select>
                        </label>
                    {{else}}

                        {{for ~countries}}
                            <input id="m-useredit-country" type="hidden" name="reorderCountry" value="{{:~general.deliveryCountryIso}}" data-has-states="{{:countryStates.length}}">
                        {{/for}}

                    {{/if}}

                    {{if ~settings.shop_customer_phone}}
                        <label class="flex flex-col gap-1">
                            <span class="text-xs">{{:~text('TELEPHONE')}}</span>
                            <div class="flex">
                                <span class="flex items-center justify-center text-xs h-10 px-3 border border-gray-200 rounded-l flex-none">+{{:~phonecode}}</span>
                                <input name="reorderPhone" type="text" class="flex-auto bg-white border-y border-r border-gray-200 rounded-r w-full px-3 h-10 text-sm" placeholder="{{:~text('TELEPHONE')}}" value="{{:deliveryInformation.phone}}">
                            </div>
                        </label>
                    {{/if}}
                </div>
            </div>

            <div class="w-full flex flex-wrap gap-4">
               <button type="button" data-addresses="save" class="px-4 h-10 flex items-center gap-2 rounded bg-primary text-white text-sm w-fit" data-id="{{:id}}">
                    {{:~text('SAVE')}}
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"></path>
                    </svg>
                </button>
                <button type="button" data-addresses="delete" class="px-4 h-10 flex items-center gap-2 rounded bg-red-600 text-white text-sm w-fit" data-id="{{:id}}">
                    {{:~text('DELETE')}}
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                    </svg>
                </button>
            </div>

        </div>

    </script>
{/literal}

<div id="ajaxreorderitem"></div>