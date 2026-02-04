{*

# Description
Smarty with AngularJS template for product lists. Part of the Product page type.


## Date last modified
2017-11-20


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

*}

<div class="modules angular-productlist">
	<div
		class="ng-cloak"
		data-ng-cloak
		data-ng-controller="productlist-ctrl"
		data-field="{if isset($field)}{$field}{/if}"
		data-item-id="{$itemId}"
		data-viewmode="{$viewmode}"
		data-sorting="{$order}"
		data-order-by="{$orderBy}"
		data-session="{$session}"
		data-filter="{if !empty($filter)}1{else}0{/if}"
		data-image-width="293"
		data-image-height="293"
		data-show-empty="{$showEmpty}"
		data-product-id="{$productId}">

		<!-- Spinner -->
		<div class="row" data-ng-hide="loaded">
			<div class="col-s-4 col-m-12 col-l-12 col-xl-24">
				<div class="spinner preloader text-center">
					<img alt="preload spinner" src="{$template.cdn}/_design/common/img/preloader/preloader-black.gif">
				</div>
			</div>
		</div>

		<!-- Main product list -->
		<div class="ng-hide m-productlist-list" data-ng-show="loaded && (productlist.length || showEmpty)">

			{if !empty($filter)}
				<!-- Product filter -->
				{include file='modules/product/partials/list-js-filter.tpl'}
			{/if}

			{if !empty($sortbar)}
				<!-- Sorting bar -->
				{include file='modules/product/partials/list-js-sortbar.tpl'}
			{/if}

			<!-- Products -->
			<div class="row">
				<div class="col-s-4 col-m-12 col-l-12 col-xl-24">

					<div class="modules m-productlist m-productlist-list">

						<div class="row">

							<div class="col-s-4 col-m-12 col-l-12 col-xl-24 ng-hide" data-ng-show="loadingProducts">
								<div class="spinner preloader text-center">
									<img alt="preload spinner" src="{$template.cdn}/_design/common/img/preloader/preloader-black.gif">
								</div>
							</div>

							{if $columns == 2}
								{$colClass = "{ 'col-m-12 col-l-12 col-xl-24': typeId == 1, 'col-m-4 col-l-6 col-xl-8': typeId == 2 }"}
							{elseif $columns == 1}
								{$colClass = "{ 'col-m-12 col-l-12 col-xl-24': typeId == 1, 'col-m-4 col-l-4 col-xl-6': typeId == 2 }"}
							{else}
								{$colClass = "{ 'col-m-12 col-l-12 col-xl-24': typeId == 1, 'col-m-4 col-l-3 col-xl-6': typeId == 2 }"}
							{/if}

							<div class="productItem m-productlist-list-item col-s-4" data-ng-class="{$colClass}" data-ng-hide="loadingProducts" data-ng-repeat="product in productlist track by product.Id" data-ng-controller="product-ctrl" data-repeat-done="loaded.productlist">

								<div class="type-row" data-ng-if="typeId == 1">
									{include file='modules/product/partials/list-js-row.tpl'}
								</div>
								<div class="type-col" data-ng-if="typeId == 2">
									{include file='modules/product/partials/list-js-col.tpl'}
								</div>
							</div>

							<div class="col-s-4 col-m-12 col-l-12 col-xl-24 text-center emptyCategory ng-hide m-productlist-none" data-ng-show="empty">
								<div class="panel panel-warning">
									<div class="panel-body">
										<span class="m-productlist-none-text" data-ng-bind-html="::text.PRODUCT_CATALOG_CATEGORY_EMPTY"></span>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>

			{if !empty($pager)}
				<!-- Pagination -->
				{include file='modules/product/partials/list-js-pager.tpl'}
			{/if}

		</div>

	</div>
</div>
