{*

# Description
Smarty with AngularJS template for product lists. Part of the Product page type.


## Date last modified
2021-09-28


## Resource
+ [AngularJS](https://angularjs.org/)


## Primary variables
+ $item 													- The product id of the product to generate
+ $controller 												- Instance of productController
+ $product 													- Entity of productController (a single shop product)
+ $category 												- Entity of productCategoryController (a single shop product category)
+ $priceInterval 											- Entity of productPriceController (price lines for selected product)
+ $reviewcontroller 										- Instance of productReviewController
+ $image 													- Entity of filesController with type product (the first image for a product)
+ $brand 													- Entity of brandController


## Partials (templates)
+ "/modules/product/partials/list-js-filter.tpl"			- AngularJS partial template for AJAX filtering of products
+ "/modules/product/partials/list-js-sortbar.tpl"			- AngularJS partial template for Javascript sorting of products
+ "/modules/product/partials/list-js-row.tpl"				- AngularJS partial template for product row display mode
+ "/modules/product/partials/list-js-col.tpl"				- AngularJS partial template for product column display mode
+ "/modules/product/partials/list-js-pager.tpl"				- AngularJS partial template for Javascript pager element
+ "/modules/widgets/pagination/pagination.tpl"              - Pagination widget, for pagination generation
+ "/modules/product/partials/category-description.tpl"      - Category description

*}

<div class="angular-productlist">
    <div
        class="ng-cloak"
        data-ng-cloak
        data-ng-controller="productlist-ctrl"
        data-ng-init="hasLeftColumns = {if $hasLeftColumns && $isProductListPage}1{else}0{/if}"
        data-field="{if isset($field)}{$field}{/if}"
        data-item-id="{$itemId}"
        data-viewmode="{$viewmode}"
        data-sorting="{$order}"
        data-order-by="{$orderBy}"
        data-session="{$session}"
        data-filter="{if !empty($filter)}1{else}0{/if}"
        data-image-width="385"
        data-image-height="385"
        data-show-empty="{$showEmpty}"
        data-product-id="{$productId}">
        

        {if $slider}
            <div data-productslider="slider">
                <div data-ng-hide="loadingProducts" class="h-full" data-ng-repeat="product in productlist track by product.Id" data-ng-controller="product-ctrl" data-repeat-done="loaded.productlist">
                    {include file='modules/product/partials/list-js-col.tpl'}
                </div>
            </div>
        {else}
            <div data-ng-hide="loaded">
                <div class="flex">
                    <div class="hidden xl:block w-[24rem] flex-none border-r border-gray-200 p-5">
                    </div>
                    <div class="flex-auto grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 bg-gray-200 gap-[1px]">
                        <div class="h-full" data-ng-repeat="item in [1,2,3,4,5,6,7,8,9,10,11,12]">
                            {include file='modules/product/partials/list-col-placeholder.tpl'}
                        </div>
                    </div>
                </div>
            </div>
            <div class="ng-hide" data-ng-show="loaded && (productlist.length || showEmpty)" data-ng-hide="empty">
                <div class="flex flex-col xl:flex-row ng-hide" data-ng-show="loaded">
                    <div data-filter="overlay" class="fixed inset-0 z-10 bg-black/80 xl:hidden"></div>
                    <div data-filter="filter" class="bg-white z-20 fixed top-0 left-0 h-full xl:h-auto xl:left-auto xl:top-auto xl:static w-[24rem] max-w-full flex-none border-r border-gray-200 p-5">
                        <div class="flex items-center justify-between xl:hidden mb-5">
                            <strong class="text-lg">{$text.PRODUCT_CATALOG_FILTER}</strong>
                            <span data-filter="close" class="cursor-pointer">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </span>
                        </div>
                        <div class="hidden xl:block">
                            {include file='modules/product/partials/list-js-sortbar.tpl'}
                        </div>
                        <div class="h-full overflow-y-auto pb-12">
                            {include file='modules/product/partials/list-js-filter.tpl'}
                        </div>
                    </div>
                    <div class="border-b border-gray-200 p-5 gap-5 flex justify-between items-center xl:hidden">
                        <span data-filter="open" class="px-5 h-10 bg-black text-white hover:text-white rounded flex items-center gap-2 w-fit cursor-pointer flex-none">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 13.5V3.75m0 9.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 3.75V16.5m12-3V3.75m0 9.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 3.75V16.5m-6-9V3.75m0 3.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 9.75V10.5" />
                            </svg>
                            {$text.PRODUCT_CATALOG_FILTER}
                        </span>
                        <div class="flex-auto">
                            {include file='modules/product/partials/list-js-sortbar.tpl'}
                        </div>
                    </div>
                    <div class="flex-auto grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 bg-gray-200 gap-[1px] h-fit">
                        <div data-ng-hide="loadingProducts" data-ng-repeat="product in productlist track by product.Id" data-ng-controller="product-ctrl" data-repeat-done="loaded.productlist" >
                            {include file='modules/product/partials/list-js-col.tpl'}
                        </div>
                    </div>
                </div>
            </div>
            <div class="ng-hide" data-ng-show="loadingProducts">
                <div class="flex">
                    <div class="hidden xl:block w-[24rem] flex-none border-r border-gray-200 p-5">
                    </div>
                    <div class="flex-auto grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 bg-gray-200 gap-[1px]">
                        <div class="h-full" data-ng-repeat="item in [1,2,3,4,5,6,7,8,9,10,11,12]">
                            {include file='modules/product/partials/list-col-placeholder.tpl'}
                        </div>
                    </div>
                </div>
            </div>
            {include file='modules/product/partials/list-js-pager.tpl'}
            <div class="ng-hide text-center w-full flex flex-col items-center justify-center p-5 h-[400px]" data-ng-show="empty">
                <img src="{$template.path}/assets/images/desk-lamp.svg" width="120" height="120" class="mb-5" />
                <span data-ng-bind-html="::text.PRODUCT_CATALOG_CATEGORY_EMPTY_CUSTOM"></span>
            </div>
        {/if}

    </div>
</div>