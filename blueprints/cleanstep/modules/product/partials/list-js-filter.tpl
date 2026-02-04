{literal}
    <div class="w-full" class="ng-hide" data-ng-show="showFilter" data-ng-element-ready="triggerEvent('filterloaded')">

        <!-- Filter: Quick navigation -->
        <div class="w-full overflow-x-auto noscrollbar">
            <div class="mb-4 flex gap-4">

                <!-- General -->
                <label for="toggle-filter" class="w-fit flex gap-2 items-center whitespace-nowrap border border-gray-200 hover:bg-gray-200 transition-colors rounded-md py-3 px-4 cursor-pointer">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 flex-none">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6h9.75M10.5 6a1.5 1.5 0 1 1-3 0m3 0a1.5 1.5 0 1 0-3 0M3.75 6H7.5m3 12h9.75m-9.75 0a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m-3.75 0H7.5m9-6h3.75m-3.75 0a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m-9.75 0h9.75" />
                    </svg>
                    <strong data-ng-bind-html="text.PRODUCT_CATALOG_FILTER"></strong>
                </label>

                <!-- Status -->
                <label for="toggle-filter" data-filter="status" data-ng-show="(filterMap.sale.show && !filterMap.sale.disabled) || (filterMap.new.show && !filterMap.new.disabled)" class="w-fit flex gap-2 items-center whitespace-nowrap border border-gray-200 hover:bg-gray-200 transition-colors rounded-md py-3 px-4 cursor-pointer">
                    <span data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_STATUS"></span>
                </label>

                <!-- Price -->
                <label for="toggle-filter" data-filter="price" data-ng-show="::filterMap.prices.show" class="w-fit flex gap-2 items-center whitespace-nowrap border border-gray-200 hover:bg-gray-200 transition-colors rounded-md py-3 px-4 cursor-pointer">
                    <span data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_PRICE"></span>
                </label>

                <!-- Brands -->
                <label for="toggle-filter" data-filter="brands" data-ng-show="::filterMap.brands.show && filterMap.brands.data.length > 0" class="w-fit flex gap-2 items-center whitespace-nowrap border border-gray-200 hover:bg-gray-200 transition-colors rounded-md py-3 px-4 cursor-pointer">
                    <span data-ng-bind-html="text.PRODUCT_CATALOG_BRANDS"></span>
                </label>

                <!-- Categories -->
                <label for="toggle-filter" data-filter="categories" data-ng-show="::filterMap.categories.show && filterMap.categories.data.length > 0" class="w-fit flex gap-2 items-center whitespace-nowrap border border-gray-200 hover:bg-gray-200 transition-colors rounded-md py-3 px-4 cursor-pointer">
                    <span data-ng-bind-html="text.CATEGORYS"></span>
                </label>

                <!-- Custom data / Variants -->
                <label data-ng-repeat="dataGroup in filterMap.data | orderBy:['sorting','title'] track by dataGroup.id" for="toggle-filter" data-filter="{{dataGroup.id}}" data-ng-show="dataGroup.show && (dataGroup.data.length || (dataGroup.show == 'range' && (dataGroup.data.low || dataGroup.data.high)))" class="w-fit flex gap-2 items-center whitespace-nowrap border border-gray-200 hover:bg-gray-200 transition-colors rounded-md py-3 px-4 cursor-pointer">
                    <span data-ng-bind-html="dataGroup.title"></span>
                </label>

            </div>
        </div>

        <!-- Filter: Selected values -->
        <div class="w-full mb-4" data-ng-show="filterChanged">
            <div class="flex items-center gap-2">

                <!-- Categories -->
                <label class="p-1.5 pl-2 border border-gray-200 hover:bg-gray-100 transition-colors rounded flex items-center gap-1.5 text-xs whitespace-nowrap cursor-pointer" data-ng-repeat="data in filterMap.categories.data | orderBy:'title' track by data.id" data-ng-show="filterMap.categories.show && filterMap.categories.data.length" data-ng-show="filterSelected.categories.indexOf(data.id) > -1">
                    <input type="checkbox" checklist-model="filterSelected.categories" checklist-value="data.id" data-ng-disabled="data.disabled" checklist-change="state('categories')" hidden />
                    <span data-ng-bind-html="data.title"></span>
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </label>

                <!-- Brands -->
                <label class="p-1.5 pl-2 border border-gray-200 hover:bg-gray-100 transition-colors rounded flex items-center gap-1.5 text-xs whitespace-nowrap cursor-pointer" data-ng-repeat="data in filterMap.brands.data | orderBy:'title' track by data.id" data-ng-show="filterMap.brands.show && filterMap.brands.data.length" data-ng-show="filterSelected.brands.indexOf(data.id) > -1">
                    <input type="checkbox" checklist-model="filterSelected.brands" checklist-value="data.id" data-ng-disabled="data.disabled" checklist-change="state('brands')" hidden />
                    <span data-ng-bind-html="data.title"></span>
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </label>
                
                <!-- Custom data / Variants -->
                <div class="flex gap-2" data-ng-repeat="dataGroup in filterMap.data | orderBy:['sorting','title'] track by dataGroup.id" data-ng-show="filterSelected.data[dataGroup.id] && filterSelected.data[dataGroup.id].length">
                    
                    <label data-ng-repeat="valueId in filterSelected.data[dataGroup.id] track by valueId" class="p-1.5 pl-2 border border-gray-200 hover:bg-gray-100 transition-colors rounded flex items-center gap-1.5 text-xs whitespace-nowrap cursor-pointer">
                        <input type="checkbox" checklist-model="filterSelected.data[dataGroup.id]" checklist-value="valueId" checklist-change="state(dataGroup.id)" data-ng-click="filterSelected.data[dataGroup.id] = filterSelected.data[dataGroup.id].filter(function(id){return id !== valueId})" hidden>
                        <span>
                            <span data-ng-bind-html="dataGroup.title"></span>:
                            <span data-ng-bind-html="(dataGroup.data | filter:{id:valueId})[0].title"></span>
                        </span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </label>

                </div>

                <!-- Reset all -->
                <button class="p-1.5 hover:bg-gray-100 transition-colors rounded flex items-center gap-1.5 text-xs whitespace-nowrap cursor-pointer" data-ng-click="clearFilter()" data-ng-bind-html="::text.PRODUCT_CATALOG_FILTER_RESET"></button>

            </div>
        </div>

        <!-- Filter: Sidebar -->
        <input type="checkbox" class="hidden peer" id="toggle-filter" />
        <label for="toggle-filter" class="opacity-0 pointer-events-none fixed top-0 right-0 w-full h-full bg-black/50 z-50 peer-checked:opacity-100 peer-checked:pointer-events-auto transition-opacity"></label>
        <div class="w-full max-w-md h-full flex flex-col bg-white z-50 fixed top-0 right-0 translate-x-full peer-checked:translate-x-0 transition-transform duration-300 ease-in-out">
            <div class="relative flex-auto" data-filter="container">
                <header class="p-6 flex items-center justify-between">
                    <div class="w-6"></div>
                    <strong class="text-xl flex-auto text-center" data-ng-bind-html="text.PRODUCT_CATALOG_FILTER"></strong>
                    <label for="toggle-filter" class="w-6 h-6 cursor-pointer">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </label>
                </header>
                <div class="p-6 flex-auto overflow-y-auto">
                    <div class="flex flex-col gap-6">

                        <ul>

                            <!-- Status -->
                            <li class="border-b" data-ng-show="(filterMap.sale.show && !filterMap.sale.disabled) || (filterMap.new.show && !filterMap.new.disabled)">
                                <label for="toggle-filter-status" class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                    <span data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_STATUS"></span>
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 flex-none">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                                    </svg>
                                </label>
                                
                                <input type="checkbox" class="hidden peer" data-filter="toggler" id="toggle-filter-status" />
                                <div class="top-0 left-0 flex flex-col w-full h-full absolute translate-x-full peer-checked:translate-x-0 transition-transform duration-300 ease-in-out bg-white z-50">
                                    <header class="p-6 flex items-center">
                                        <label for="toggle-filter-status" class="w-6 h-6 cursor-pointer">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                                            </svg>
                                        </label>
                                        <strong class="text-xl flex-auto text-center" data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_STATUS"></strong>
                                        <label for="toggle-filter" class="w-6 h-6 cursor-pointer">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                        </label>
                                    </header>
                                    <ul class="p-6 flex-auto overflow-y-auto">
                                        <li data-ng-show="filterMap.sale.show && !filterMap.sale.disabled">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span data-ng-bind-html="text.SALE"></span>
                                                <input type="checkbox" checklist-model="filterSelected.sale" checklist-value="'sale'" ng-change="state('sale')" ng-disabled="filterMap.sale.disabled" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-show="filterMap.new.show && !filterMap.new.disabled">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span data-ng-bind-html="text.NEWS"></span>
                                                <input type="checkbox" checklist-model="filterSelected.new" checklist-value="'new'" ng-change="state('new')" ng-disabled="filterMap.new.disabled" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            
                            <!-- Price -->
                            <li class="border-b" data-ng-show="::filterMap.prices && filterMap.prices.show && (filterMap.prices.data.low || filterMap.prices.data.high)">
                                <label for="toggle-filter-price" class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                    <span data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_PRICE"></span>
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 flex-none">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                                    </svg>
                                </label>
                                
                                <input type="checkbox" class="hidden peer" data-filter="toggler" id="toggle-filter-price" />
                                <div class="top-0 left-0 flex flex-col w-full h-full absolute translate-x-full peer-checked:translate-x-0 transition-transform duration-300 ease-in-out bg-white z-50">
                                    <div class="flex flex-col">
                                        <header class="p-6 flex items-center">
                                            <label for="toggle-filter-price" class="w-6 h-6 cursor-pointer">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                                                </svg>
                                            </label>
                                            <strong class="text-xl flex-auto text-center" data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_PRICE"></strong>
                                            <label for="toggle-filter" class="w-6 h-6 cursor-pointer">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                                </svg>
                                            </label>
                                        </header>
                                        <div class="grid grid-cols-2 gap-4 p-6">
                                            <div class="flex flex-col gap-2">
                                                <label for="filter-price-low" class="text-sm text-gray-600" data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_PRICE_LOW"></label>
                                                <input type="number" id="filter-price-low" class="border border-gray-300 rounded-md p-2 w-full" placeholder="{{text.PRODUCT_CATALOG_FILTER_PRICE_LOW}}" data-ng-model="filterMap.prices.data.low" data-ng-change="state('prices')" data-filter="price-min" />
                                            </div>
                                            <div class="flex flex-col gap-2">
                                                <label for="filter-price-high" class="text-sm text-gray-600" data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_PRICE_HIGH"></label>
                                                <input type="number" id="filter-price-high" class="border border-gray-300 rounded-md p-2 w-full" placeholder="{{text.PRODUCT_CATALOG_FILTER_PRICE_HIGH}}" data-ng-model="filterMap.prices.data.high" data-ng-change="state('prices')" data-filter="price-max" />
                                            </div>
                                        </div>
                                    </div>
                                    <ul class="p-6 flex-auto overflow-y-auto" style="display:none;">
                                        <li data-ng-if="filterMap.prices.data.max > 0">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>Under 100 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="0" data-max="100" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 200">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>100 - 200 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="100" data-max="200" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 300">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>200 - 300 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="200" data-max="300" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 400">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>300 - 400 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="300" data-max="400" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 500">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>400 - 500 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="400" data-max="500" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 750">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>500 - 750 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="500" data-max="750" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 1000">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>750 - 1.000 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="750" data-max="1000" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 1500">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>1.000 - 1.500 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="1000" data-max="1500" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 2000">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>1.500 - 2.000 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="1500" data-max="2000" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 3000">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>2.000 - 3.000 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="2000" data-max="3000" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 5000">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>3.000 - 5.000 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="3000" data-max="5000" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                        <li data-ng-if="filterMap.prices.data.max > 5000">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span>Over 5.000 {{general.currencyIso}}</span>
                                                <input type="checkbox" name="filterprice" data-min="5000" data-max="{{filterMap.prices.data.high}}" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <!-- Brands -->
                            <li class="border-b" data-ng-show="::filterMap.brands.show && filterMap.brands.data.length > 0">
                                <label for="toggle-filter-brands" class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                    <span data-ng-bind-html="text.PRODUCT_CATALOG_BRANDS"></span>
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 flex-none">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                                    </svg>
                                </label>
                                
                                <input type="checkbox" class="hidden peer" data-filter="toggler" id="toggle-filter-brands" />
                                <div class="top-0 left-0 flex flex-col w-full h-full absolute translate-x-full peer-checked:translate-x-0 transition-transform duration-300 ease-in-out bg-white z-50">
                                    <header class="p-6 flex items-center">
                                        <label for="toggle-filter-brands" class="w-6 h-6 cursor-pointer">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                                            </svg>
                                        </label>
                                        <strong class="text-xl flex-auto text-center" data-ng-bind-html="text.PRODUCT_CATALOG_BRANDS"></strong>
                                        <label for="toggle-filter" class="w-6 h-6 cursor-pointer">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                        </label>
                                    </header>
                                    <ul class="p-6 flex-auto overflow-y-auto">
                                        <li data-ng-repeat="data in filterMap.brands.data | orderBy:'title' track by data.id">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span data-ng-bind-html="data.title"></span>
                                                <input type="checkbox" checklist-model="filterSelected.brands" checklist-value="data.id" data-ng-disabled="data.disabled" checklist-change="state('brands')" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <!-- Categories -->
                            <li class="border-b" data-ng-show="::filterMap.categories.show && filterMap.categories.data.length > 0">
                                <label for="toggle-filter-categories" class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                    <span data-ng-bind-html="text.CATEGORYS"></span>
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 flex-none">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                                    </svg>
                                </label>
                                
                                <input type="checkbox" class="hidden peer" data-filter="toggler" id="toggle-filter-categories" />
                                <div class="top-0 left-0 flex flex-col w-full h-full absolute translate-x-full peer-checked:translate-x-0 transition-transform duration-300 ease-in-out bg-white z-50">
                                    <header class="p-6 flex items-center">
                                        <label for="toggle-filter-categories" class="w-6 h-6 cursor-pointer">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                                            </svg>
                                        </label>
                                        <strong class="text-xl flex-auto text-center" data-ng-bind-html="text.CATEGORYS"></strong>
                                        <label for="toggle-filter" class="w-6 h-6 cursor-pointer">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                        </label>
                                    </header>
                                    <ul class="p-6 flex-auto overflow-y-auto">
                                        <li data-ng-repeat="data in filterMap.categories.data | orderBy:'title' track by data.id">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span data-ng-bind-html="data.title"></span>
                                                <input type="checkbox" checklist-model="filterSelected.categories" checklist-value="data.id" data-ng-disabled="data.disabled" checklist-change="state('categories')" class="hidden peer" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <!-- Custom data / Variants -->
                            <li class="border-b" data-ng-repeat="dataGroup in filterMap.data | orderBy:['sorting','title'] track by dataGroup.id" data-ng-show="dataGroup.show && (dataGroup.data.length || (dataGroup.show == 'range' && (dataGroup.data.low || dataGroup.data.high)))">
                                <label for="toggle-filter-{{dataGroup.id}}" class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                    <span data-ng-bind-html="dataGroup.title"></span>
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 flex-none">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                                    </svg>
                                </label>
                                
                                <input type="checkbox" class="hidden peer" data-filter="toggler" id="toggle-filter-{{dataGroup.id}}" />
                                <div class="top-0 left-0 flex flex-col w-full h-full absolute translate-x-full peer-checked:translate-x-0 transition-transform duration-300 ease-in-out bg-white z-50">
                                    <header class="p-6 flex items-center">
                                        <label for="toggle-filter-{{dataGroup.id}}" class="w-6 h-6 cursor-pointer">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                                            </svg>
                                        </label>
                                        <strong class="text-xl flex-auto text-center" data-ng-bind-html="dataGroup.title"></strong>
                                        <label for="toggle-filter" class="w-6 h-6 cursor-pointer">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                        </label>
                                    </header>
                                    <ul class="p-6 flex-auto overflow-y-auto">
                                        <li data-ng-repeat="value in dataGroup.data | orderBy:['sorting','title'] track by value.id">
                                            <label class="flex justify-between gap-4 items-center py-4 cursor-pointer">
                                                <span data-ng-bind-html="value.title"></span>
                                                <input type="checkbox" checklist-model="filterSelected.data[dataGroup.id]" checklist-value="value.id" data-ng-disabled="value.disabled" checklist-change="state(dataGroup.id)" class="hidden peer" data-ng-checked="value.checked" />
                                                <span class="relative w-6 h-6 border border-gray-300 rounded-full after:content-[''] after:absolute after:top-1/2 after:left-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:w-2 after:h-2 after:bg-white after:rounded-full after:hidden peer-checked:bg-black peer-checked:border-black peer-checked:after:block"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>

                        </ul>

                    </div>
                </div>
            </div>
            <div class="flex flex-col gap-4 p-6 bg-gray-100 border-t border-gray-200 mt-auto ng-hide" data-ng-show="filterChanged">
                <label for="toggle-filter" class="w-full flex items-center gap-2 leading-none text-sm p-4 text-center justify-center font-bold rounded-md bg-black hover:bg-gray-900 text-white cursor-pointer transition-all" data-ng-bind-html="text.SHOW_X_RESULTS.replace('[[AMOUNT]]', amount)"></label>
                <button class="w-full flex items-center gap-2 leading-none text-sm p-4 text-center justify-center font-bold rounded-md bg-gray-200 hover:bg-gray-300 cursor-pointer transition-all" data-ng-click="clearFilter()" data-ng-bind-html="::text.PRODUCT_CATALOG_FILTER_RESET"></button>
            </div>
        </div>

    </div>
{/literal}