{literal}
    <div>
        <div class="flex justify-between items-center gap-4 text-sm mb-4" data-ng-hide="empty || (orderOptions.length < 2 && (!limitOptions.length || amount < limitOptions[0].amount) && !settings.module_shop_productlist_allow_switch && maxPage < 2)">
            <div>
                <strong data-ng-bind-html="amountText() || text.PRODUCT_CATALOG_PRODUCTS +': '+ amount"></strong>
            </div>
            <div>
                <label class="flex items-center gap-2 py-2 pl-3 cursor-pointer hover:bg-gray-100 rounded transition-colors" for="toggle-sorting">
                    <strong data-ng-bind-html="text.PRODUCT_CATALOG_SORTING + ':'"></strong>
                    <select data-sorting="select" class="pointer-events-none appearance-none arrow pr-8 bg-transparent" data-ng-change="changeOrder()" data-ng-model="orderProp" data-ng-options="option.id as option.title for option in orderOptions"></select>
                </label>
            </div>
        </div>

        <input type="checkbox" class="hidden peer" id="toggle-sorting" />
        <label for="toggle-sorting" class="opacity-0 pointer-events-none fixed top-0 right-0 w-full h-full bg-black/50 z-50 peer-checked:opacity-100 peer-checked:pointer-events-auto transition-opacity"></label>
        <div class="w-full max-w-md h-full flex flex-col bg-white z-50 fixed top-0 right-0 translate-x-full peer-checked:translate-x-0 transition-transform duration-300 ease-in-out">
            <header class="p-6 flex items-center justify-between">
                <strong class="text-xl" data-ng-bind-html="text.PRODUCT_CATALOG_SORTING"></strong>
                <label for="toggle-sorting" class="w-6 h-6 cursor-pointer">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </label>
            </header>
            <div class="p-6">
                <div class="flex flex-col gap-6">
                    <label data-ng-repeat="option in orderOptions" class="flex items-center gap-4 cursor-pointer justify-between">
                        <span class="text-lg" data-ng-bind-html="option.title"></span>
                        <input type="radio" name="option-orderby" class="hidden peer" data-ng-model="orderProp" data-ng-value="option.id" />
                        <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                    </label>
                </div>
            </div>
            <div class="p-6 bg-gray-100 border-t border-gray-200 mt-auto">
                <label for="toggle-sorting" class="flex items-center gap-2 leading-none text-sm p-4 text-center justify-center font-bold rounded-md bg-black hover:bg-gray-900 text-white cursor-pointer transition-all" data-ng-bind-html="text.SHOW_RESULTS"></label>
            </div>
        </div>
    </div>
{/literal}