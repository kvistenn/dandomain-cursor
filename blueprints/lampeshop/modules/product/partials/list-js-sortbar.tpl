{*

# Description
AngularJS template for Javascript sorting of products. Part of the Product page type.


## Date last modified
2019-04-29


## Resource
+ [AngularJS](https://angularjs.org/)


## Primary variables
+ orderProp                                                 - AngularJS model with order options (price, most bought ...) based on shop settings
+ limitProp                                                 - AngularJS model with limit options (items pr. page) based on shop settings
+ items                                                     - Collection of products based on: category, filter and sorting
+ text                                                      - Javascript version of Smarty $text with an array of translations


## Partials (templates)
No extra templates required for this template

*}

{literal}
    <div class="xl:mb-5" data-ng-hide="empty || (orderOptions.length < 2 && (!limitOptions.length || amount < limitOptions[0].amount) && !settings.module_shop_productlist_allow_switch && maxPage < 2)">
        <div data-group="panel-sorting" data-ng-hide="loadingProducts" data-repeat-done="loaded.productlist">
            <div data-ng-show="orderOptions.length > 1">
                <select class="h-10 px-4 w-full border border-gray-200 appearance-none arrow rounded xl:rounded-full text-sm" id="option-orderby" name="option-orderby" data-ng-change="changeOrder()" data-ng-model="orderProp" data-ng-options="option.id as option.title for option in orderOptions"></select>
            </div>
        </div>
    </div>
{/literal}
    