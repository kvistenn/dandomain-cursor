{*

# Description
AngularJS template for Javascript filtering of products. Part of the Product page type.


## Date last modified
2022-02-10


## Resource
+ [AngularJS](https://angularjs.org/)


## Primary variables
+ filterSelected                                            - AngularJS model with all selected filter data (price, brand, category ...)
+ text                                                      - Javascript version of Smarty $text with an array of translations


## Partials (templates)
No extra templates required for this template

*}

{literal}

    <div class="flex flex-col gap-8" data-ng-element-ready="triggerEvent('filterloaded')">

        <!-- STATUS -->
        <div data-filter="toggle" class="flex-1 ">
            <strong class="flex gap-2 justify-between text-sm uppercase text-secondary tracking-wider cursor-pointer">
                <span data-ng-bind-html="::text.AVAILABILITY"></span>
                <span>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5 transition-transform" data-filter="arrow">
                        <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
                    </svg>
                </span>
            </strong>
            <div>
                <div class="flex flex-col gap-3 text-sm mt-4">
                    <label class="flex gap-2 justify-between items-center" data-ng-show="filterMap.new.show">
                        <span class="truncate" data-ng-class="{'pointer-events-none opacity-50':filterMap.new.disabled}" data-ng-bind-html="::text.NEWS"></span>
                        <input type="checkbox" id="filter-shownews" data-ng-model="filterSelected.news" data-ng-change="state('news')" data-ng-disabled="filterMap.new.disabled">
                    </label>
                    <label class="flex gap-2 justify-between items-center" data-ng-show="filterMap.new.show">
                        <span class="truncate" data-ng-class="{'pointer-events-none opacity-50':filterMap.sale.disabled}" data-ng-bind-html="::text.SALE"></span>
                        <input type="checkbox" id="filter-showsale" data-ng-model="filterSelected.sale" data-ng-change="state('sale')" data-ng-disabled="filterMap.sale.disabled">
                    </label>
                </div>
            </div>
        </div>

        <!-- PRICE -->
        <div data-filter="toggle" class="flex-1 ">
            <strong class="flex gap-2 justify-between text-sm uppercase text-secondary tracking-wider cursor-pointer">
                <span data-ng-bind-html="::text.PRODUCT_CATALOG_FILTER_PRICE"></span>
                <span>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5 transition-transform" data-filter="arrow">
                        <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
                    </svg>
                </span>
            </strong>
            <div class="mt-4">
                <div class="text-sm flex gap-4 items-center">
                    <div class="flex gap-4 items-center flex-1">
                        <input type="number" min="{{filterMap.prices.data.low}}" max="{{filterSelected.maxPrice}}" data-ng-model="filterSelected.minPrice" class="border border-light-gray px-3 py-2 w-full appearance-none rounded" data-ng-change="state('price')">
                    </div>
                    <div class="w-8 flex-none flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3" />
                        </svg>
                    </div>
                    <div class="flex gap-4 items-center flex-1">
                        <input type="number" max="{{filterMap.prices.data.high}}" min="{{filterSelected.minPrice}}" data-ng-model="filterSelected.maxPrice" class="border border-light-gray px-3 py-2 w-full appearance-none rounded" data-ng-change="state('price')">
                    </div>
                </div>
            </div>
        </div>

        <!-- BRANDS -->
        <div data-filter="toggle" class="flex-1 group" data-ng-show="::filterMap.brands.show && filterMap.brands.data.length > 0" data-on="filterMap.brands.show">
            <strong class="flex gap-2 justify-between text-sm uppercase text-secondary tracking-wider cursor-pointer">
                <span data-ng-bind-html="::text.MANUFACTUERER"></span>
                <span>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5 transition-transform" data-filter="arrow">
                        <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
                    </svg>
                </span>
            </strong>
            <div class="h-[150px] group-[.show]:h-auto mt-4 overflow-hidden" data-ng-show="filterMap.brands.data.length > 5">
                <div class="flex flex-col gap-3 text-sm">
                    <label class="flex gap-2 justify-between items-center" data-ng-repeat="data in filterMap.brands.data | orderBy:'title' track by data.id">
                        <span class="truncate" data-ng-class="{'pointer-events-none opacity-50':data.disabled}" data-ng-bind-html="data.title"></span>
                        <input type="checkbox" checklist-model="filterSelected.brand" checklist-value="data.id" data-ng-disabled="data.disabled" checklist-change="state('brands')">
                    </label>
                </div>
            </div>
            <div class="mt-4" data-ng-hide="filterMap.brands.data.length > 5">
                <div class="flex flex-col gap-3 text-sm">
                    <label class="flex gap-2 justify-between items-center" data-ng-repeat="data in filterMap.brands.data | orderBy:'title' track by data.id">
                        <span class="truncate" data-ng-class="{'pointer-events-none opacity-50':data.disabled}" data-ng-bind-html="data.title"></span>
                        <input type="checkbox" checklist-model="filterSelected.brand" checklist-value="data.id" data-ng-disabled="data.disabled" checklist-change="state('brands')">
                    </label>
                </div>
            </div>
            <div class="group-[.folded]:hidden">
                <span data-filter="more" data-ng-show="filterMap.brands.data.length > 5" class="flex gap-1 text-sm text-gray-600 font-bold items-center mt-2 cursor-pointer group/more">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 group-[.show]/more:hidden">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 hidden group-[.show]/more:block">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                    </svg>
                    <span class="group-[.show]/more:hidden">{{::text.FILTER_MORE}}</span>
                    <span class="hidden group-[.show]/more:block">{{::text.FILTER_LESS}}</span>
                </span>
            </div>
        </div>

        <!-- CATEGORIES -->
        <div data-filter="toggle" class="flex-1 group" data-ng-show="::filterMap.categories.show && filterMap.categories.data.length > 0" data-on="filterMap.categories.show">
            <strong class="flex gap-2 justify-between text-sm uppercase text-secondary tracking-wider cursor-pointer">
                <span data-ng-bind-html="::text.CATEGORYS"></span>
                <span>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5 transition-transform" data-filter="arrow">
                        <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
                    </svg>
                </span>
            </strong>
            <div class="h-[150px] group-[.show]:h-auto mt-4 overflow-hidden" data-ng-show="filterMap.categories.data.length > 5">
                <div class="flex flex-col gap-3 text-sm">
                    <label class="flex gap-2 justify-between items-center" data-ng-repeat="data in filterMap.categories.data | orderBy:'title' track by data.id">
                        <span class="truncate" data-ng-class="{'pointer-events-none opacity-50':data.disabled}" data-ng-bind-html="data.title"></span>
                        <input type="checkbox" checklist-model="filterSelected.categories" checklist-value="data.id" data-ng-disabled="data.disabled" checklist-change="state('categories')">
                    </label>
                </div>
            </div>
            <div class="mt-4" data-ng-hide="filterMap.categories.data.length > 5">
                <div class="flex flex-col gap-3 text-sm">
                    <label class="flex gap-2 justify-between items-center" data-ng-repeat="data in filterMap.categories.data | orderBy:'title' track by data.id">
                        <span class="truncate" data-ng-class="{'pointer-events-none opacity-50':data.disabled}" data-ng-bind-html="data.title"></span>
                        <input type="checkbox" checklist-model="filterSelected.categories" checklist-value="data.id" data-ng-disabled="data.disabled" checklist-change="state('categories')">
                    </label>
                </div>
            </div>
            <div class="group-[.folded]:hidden">
                <span data-filter="more" data-ng-show="filterMap.categories.data.length > 5" class="flex gap-1 text-sm text-gray-600 font-bold items-center mt-2 cursor-pointer group/more">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 group-[.show]/more:hidden">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 hidden group-[.show]/more:block">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                    </svg>
                    <span class="group-[.show]/more:hidden">{{::text.FILTER_MORE}}</span>
                    <span class="hidden group-[.show]/more:block">{{::text.FILTER_LESS}}</span>
                </span>
            </div>
        </div>

        <!-- VARIANTS & CUSTOM DATA -->
        <div data-filter="toggle" class="flex-1 group" data-ng-if="dataGroup.data.length > 0" data-ng-repeat="dataGroup in filterMap.data | orderBy:['sorting','title'] track by dataGroup.id" data-ng-show="dataGroup.show && (dataGroup.data.length || (dataGroup.show == 'range' && (dataGroup.data.low || dataGroup.data.high)))" data-on="dataGroup.show">
            <strong class="flex gap-2 justify-between text-sm uppercase text-secondary tracking-wider cursor-pointer">
                <span data-ng-bind-html="dataGroup.title"></span>
                <span>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5 transition-transform" data-filter="arrow">
                        <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
                    </svg>
                </span>
            </strong>
            <div class="h-[150px] group-[.show]:h-auto mt-4 overflow-hidden" data-ng-show="dataGroup.data.length > 5">
                <div class="flex flex-col gap-3 text-sm">
                    <label class="flex gap-2 items-center justify-between" data-ng-repeat="value in dataGroup.data | orderBy:['sorting','title'] track by value.id">
                        <div class="p-[2px] border border-light-gray peer-checked:border-gray rounded-full transition-colors hover:border-gray" data-ng-if="value.color">
                            <div class="h-4 w-4 rounded-full" style="background-color: #{{value.color}}"></div>
                        </div>
                        <span class="truncate" data-ng-class="{'pointer-events-none opacity-50':value.disabled}" data-ng-bind-html="value.title"></span>
                        <input type="checkbox" data-ng-show="value.color" checklist-model="filterSelected.data[dataGroup.id]" checklist-value="value.id" data-ng-disabled="value.disabled" class="peer hidden" checklist-change="state(dataGroup.id)">
                        <input type="checkbox" data-ng-show="!value.color" checklist-model="filterSelected.data[dataGroup.id]" checklist-value="value.id" data-ng-disabled="value.disabled" checklist-change="state(dataGroup.id)">
                    </label>
                </div>
            </div>
            <div class="mt-4" data-ng-hide="dataGroup.data.length > 5">
                <div class="flex flex-col gap-3 text-sm">
                    <label class="flex gap-2 items-center justify-between" data-ng-repeat="value in dataGroup.data | orderBy:['sorting','title'] track by value.id">
                        <div class="p-[2px] border border-light-gray peer-checked:border-gray rounded-full transition-colors hover:border-gray" data-ng-if="value.color">
                            <div class="h-4 w-4 rounded-full" style="background-color: #{{value.color}}"></div>
                        </div>
                        <span class="truncate" data-ng-class="{'pointer-events-none opacity-50':value.disabled}" data-ng-bind-html="value.title"></span>
                        <input type="checkbox" data-ng-show="value.color" checklist-model="filterSelected.data[dataGroup.id]" checklist-value="value.id" data-ng-disabled="value.disabled" class="peer hidden" checklist-change="state(dataGroup.id)">
                        <input type="checkbox" data-ng-show="!value.color" checklist-model="filterSelected.data[dataGroup.id]" checklist-value="value.id" data-ng-disabled="value.disabled" checklist-change="state(dataGroup.id)">
                    </label>
                </div>
            </div>
            <div class="group-[.folded]:hidden">
                <span data-filter="more" data-ng-show="dataGroup.data.length > 5" class="flex gap-1 text-sm text-gray-600 font-bold items-center mt-2 cursor-pointer group/more">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 group-[.show]/more:hidden">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 hidden group-[.show]/more:block">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                    </svg>
                    <span class="group-[.show]/more:hidden">{{::text.FILTER_MORE}}</span>
                    <span class="hidden group-[.show]/more:block">{{::text.FILTER_LESS}}</span>
                </span>
            </div>
        </div>

        <div class="flex lg:hidden gap-4">
            <button class="bg-black text-white text-sm p-3 w-full rounded-full" data-ng-click="clearFilter()" data-ng-bind-html="text.PRODUCT_CATALOG_FILTER_RESET"></button>
            <button class="bg-black text-white text-sm p-3 w-full rounded-full" data-filter="close" data-ng-bind-html="text.APPLY"></button>
        </div>

    </div>

{/literal}