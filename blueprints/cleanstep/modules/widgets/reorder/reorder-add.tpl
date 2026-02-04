{if $user}

    {literal}
        <script data-reorder="checklistmarkup" type="text/x-jsrender">
            <li class="border-b border-gray-200 last:border-b-0 text-sm border-b">
                <label class="hover:bg-gray-100 transition-colors flex items-center gap-2 p-2 w-full rounded cursor-pointer">
                    <span class="w-5 flex-none leading-none">
                        <input type="checkbox" data-reorder="checkbox" value="{{:id}}" data-ids="{{:~jsonEncodeProducts(autoOrderProducts)}}" />
                    </span>
                    <span>{{:name}}</span>
                </label>
            </li>
        </script>
    {/literal}

    {literal}
        <script data-reorder="itemnumbersmarkup" type="text/x-jsrender">
            <li class="relative">
                <span class="p-1 leading-none text-sm bg-black text-white rounded">{{:number}}</span>
                <button type="button" class="absolute -top-2 -right-2 w-4 h-4 flex rounded-full items-center justify-center bg-red-600 text-white hover:bg-red-700 transition-colors" data-reorder="removeitemnumber" data-itemnumber="{{:#data}}">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-3 h-3">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </li>
        </script>
    {/literal}

    {$isOpen = true}
    {if $smarty.cookies.reorderAdd == '0'}
        {$isOpen = false}
    {/if}

    <div class="fixed bottom-4 right-4 lg:bottom-6 lg:right-6 z-20">
        <input type="checkbox" id="reorderAdd" class="peer hidden" {if $isOpen}checked{/if} />
        <label for="reorderAdd" class="absolute right-0 bottom-0 flex items-center justify-center w-12 h-12 bg-black text-white rounded-full shadow-lg cursor-pointer transition-transform transform hover:scale-110 origin-bottom-right scale-100 peer-checked:scale-0">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0 3.181 3.183a8.25 8.25 0 0 0 13.803-3.7M4.031 9.865a8.25 8.25 0 0 1 13.803-3.7l3.181 3.182m0-4.991v4.99" />
            </svg>
        </label>
        <div class="w-80 p-6 bg-white rounded shadow-xl peer-checked:scale-100 origin-bottom-right scale-0 transition-transform border border-gray-200">
            <div class="flex justify-between items-center gap-4 mb-4">
                <strong class="font-bold">{$text.REORDER_WIDGET_TITLE}</strong>
                <label for="reorderAdd" class="text-gray-500 cursor-pointer hover:text-gray-700">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </label>
            </div>
            <div class="flex">
                <input type="text" name="itemnumber" placeholder="{$text.PRODUCT_CATALOG_ORDER_BY_NUMBER}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" data-reorder="itemnumber">
                <button type="button" class="ml-2 px-4 py-2 bg-black text-white rounded" data-reorder="additemnumber">
                    {$text.ADD}
                </button>
            </div>
            <div class="mt-4" style="display: none;" data-reorder="itemnumberscontainer">
                <ul class="flex flex-wrap gap-2 mb-4" data-reorder="itemnumbers"></ul>
                <label for="reorderPopup" data-id="cookie" class="block w-full px-4 py-3 bg-green-600 text-white rounded text-center cursor-pointer">
                    {$text.REORDER_WIDGET_TITLE}
                </label>
            </div>
        </div>
    </div>

{/if}

<input type="checkbox" id="reorderPopup" class="hidden peer" />
<div class="fixed top-0 left-0 w-full h-full z-50 flex items-center justify-center opacity-0 pointer-events-none transition-opacity duration-300 ease-in-out peer-checked:opacity-100 peer-checked:pointer-events-auto">
    <label for="reorderPopup" class="fixed inset-0 bg-black bg-opacity-50"></label>
    <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md z-10 max-h-[90vh] overflow-y-auto">
        <strong class="block mb-4">{$text.LISTS}</strong>
        <ul data-reorder="checklist" class="border border-gray-200 rounded">
        </ul>
    </div>
</div>