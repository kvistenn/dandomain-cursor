<div class="angular-productlist">
    <div
        class="ng-cloak"
        data-ng-cloak
        data-ng-controller="productlist-ctrl"
        data-ng-init="hasLeftColumns = 0"
        data-field="{$field}"
        data-item-id="{$id}"
        data-viewmode="2"
        data-sorting="{$sorting}"
        data-order-by=""
        data-session="1"
        data-filter="0"
        data-image-width="385"
        data-image-height="385"
        data-show-empty=""
        data-product-id="">

        <div data-swiper="productslider" class="relative" data-swiper-slides="{$slides}">
            <div class="swiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide h-auto" data-ng-repeat="product in productlist track by product.Id" data-ng-controller="product-ctrl" data-repeat-done="loaded.productlist">
                        {include file='modules/product/partials/list-js-col.tpl'}
                    </div>
                </div>
            </div>
            <div class="swiper-button-next hidden xl:flex w-12 h-12 bg-white rounded-md shadow-lg items-center justify-center border border-gray-400 -right-4">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-5 !h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                </svg>
            </div>
            <div class="swiper-button-prev hidden xl:flex w-12 h-12 bg-white rounded-md shadow-lg items-center justify-center border border-gray-400 -left-4">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="!w-5 !h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                </svg>
            </div>
        </div>

    </div>
</div>