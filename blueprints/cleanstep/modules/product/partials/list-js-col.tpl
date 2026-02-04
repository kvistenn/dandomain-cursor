{*

# Description
AngularJS template for product column display mode. Part of the Product page type.
The template uses [Select2](http://ivaynberg.github.io/select2/) to generate the dropdowns.


## Date last modified
2021-02-09


## Resource
+ [AngularJS](https://angularjs.org/)
+ [Select2](http://ivaynberg.github.io/select2/)


## Primary variables
+ product                                            		- Single product entity
+ text                                                      - Javascript version of Smarty $text with an array of translations


## Partials (templates)
No extra templates required for this template

*}

{literal}

    <article class="product h-full" data-id="{{product.Id}}" data-buyable="{{product.Buyable}}">
    
        <form method="post" action="/actions/cart/add" class="h-full flex flex-col gap-2" data-form="ajax">
    
            <input type="hidden" name="returnUrl" data-ng-value="returnUrl">
            <input type="hidden" name="product[{{product.Id}}][variant]" data-ng-if="product.Type == 'variant'" data-variant="variantid">
    
            <figure class="block relative">
    
                <!-- Product splashes, news, discount and sold out -->
                <div class="absolute z-10 top-0 left-0 w-full flex flex-wrap gap-1 p-2" data-ng-show="::settings.show_product_icons">
                    <span class="p-1 leading-none rounded bg-black-600 text-white text-xs" data-ng-if="::isNew" data-ng-bind-html="::text.NEWS"></span>
                    <span class="p-1 leading-none rounded bg-orange-600 text-white text-xs" data-ng-if="onSale" data-ng-bind-html="'Spar ' + product.Savings + '%'"></span>
                    <span class="p-1 leading-none rounded bg-red-600 text-white text-xs" data-ng-if="soldout" data-ng-bind-html="::text.SOLD_OUT"></span>
                </div>

                <!-- Product labels -->
                <div class="absolute z-10 bottom-0 left-0 w-full flex flex-wrap gap-2 p-2" data-ng-if="product.Labels.length > 0">
                    <img class="lazyload w-8 h-8 lg:w-10 lg:h-10 xl:w-12 xl:h-12" data-ng-src="{{label.Image}}" data-src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" width="30" height="30" alt="{{label.Title}}" title="{{label.Title}}" data-ng-repeat="label in product.Labels">
                </div>

                <div class="flex flex-col gap-2 absolute top-0 right-0 p-2 z-10">
                    <!-- Compare button -->
                    <div data-compare="toggle" data-id="{{product.Id}}" class="bg-white rounded-full w-8 h-8 flex items-center justify-center hover:bg-black hover:text-white transition-all [&.active]:bg-black [&.active]:text-white cursor-pointer">
                        <svg xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 24 24" width="24" height="24" class="w-4 h-4 fill-current">
                            <path d="M24,5c0-2.206-1.794-4-4-4s-4,1.794-4,4c0,1.86,1.277,3.428,3,3.873v8.127c0,.551-.449,1-1,1h-4.996l2.203-2.203-1.414-1.414-3.256,3.256c-.774,.775-.774,2.037,0,2.812l3.256,3.256,1.414-1.414-2.304-2.293h5.097c1.654,0,3-1.346,3-3V8.873c1.723-.445,3-2.013,3-3.873Zm-4,2c-1.103,0-2-.897-2-2s.897-2,2-2,2,.897,2,2-.897,2-2,2Zm-9.838,2.662l3.256-3.255c.775-.775,.775-2.037,0-2.812L10.162,.338l-1.414,1.414,2.259,2.248H6c-1.654,0-3,1.346-3,3V15.127c-1.723,.445-3,2.013-3,3.873,0,2.206,1.794,4,4,4s4-1.794,4-4c0-1.86-1.277-3.428-3-3.873V7c0-.551,.449-1,1-1h4.995l-2.248,2.248,1.414,1.414Zm-4.162,9.338c0,1.103-.897,2-2,2s-2-.897-2-2,.897-2,2-2,2,.897,2,2Z"></path>
                        </svg>
                    </div>
                    <!-- Personal shop button -->
                    <label for="shopPopup" data-id="{{product.Id}}" data-ng-if="user" class="bg-white rounded-full w-8 h-8 flex items-center justify-center hover:bg-black hover:text-white transition-all [&.active]:rotate-45 [&.active]:bg-black [&.active]:text-white cursor-pointer [&.disabled]:opacity-30 [&.disabled]:pointer-events-none" data-ng-class="{ 'disabled': product.Type == 'variant' }">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                        </svg>
                    </label>
                </div>
    
                <!-- Product image -->
                <a data-ng-href="{{product.Handle}}" class="block px-4 pb-4 pt-12 bg-gray-100 rounded">
                    <img class="lazyload mix-blend-multiply" data-variant="image" data-ng-src="{{image}}" data-src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" alt="{{product.Title}}">
                </a>
            </figure>
    
            <div class="flex flex-col flex-auto">
    
                <!-- Product title and brand -->
                <header class="flex flex-col gap-1">
                    
                    <!-- Variants -->
                    <div class="my-2">
                        <div data-ng-repeat="variantType in product.VariantTypes" data-ng-if="product.VariantTypes.length > 0" data-index="{{$index}}" class="flex flex-wrap gap-1" data-variant="variant">
                            <div class="text-xs rounded border border-gray-200 hover:bg-black hover:text-white hover:border-black [&.active]:bg-black [&.active]:text-white [&.active]:border-black py-1 px-1.5 transition-colors cursor-pointer" data-ng-repeat="Data in variantType.Data" data-value="{{Data.Id}}" data-ng-bind-html="Data.Title">
                            </div>
                        </div>
                    </div>

                    <!-- Product brand -->
                    <a class="text-xs font-bold" data-ng-if="::product.ProducerHandle" data-ng-href="{{::product.ProducerHandle}}" data-ng-bind-html="::product.ProducerTitle"></a>

                    <!-- Product title -->
                    <a data-ng-href="{{product.Handle}}" class="block">
                        <h4 class="text-sm text-gray-600 line-clamp-2 min-h-10" data-ng-bind-html="::product.Title"></h4>
                    </a>

                    <!-- Product number -->
                    <small class="text-gray-600" data-ng-bind-html="text.PRODUCT_CATALOG_ORDER_BY_NUMBER + ': ' + product.ItemNumber"></small>

                    <!-- Show pricelines text -->
                    <button type="button" class="text-xs text-gray-500 appearance-none w-full flex justify-start" data-productlist="togglepricelines" data-ng-if="product.Prices.length > 1">
                        <span class="underline" data-ng-bind-html="text.VIEW_PRICES"></span>
                    </button>

                    <!-- Pricelines -->
                    <div class="flex flex-col my-2 justify-start" style="display:none;" data-productlist="pricelines">
                        <div data-ng-repeat="priceline in product.Prices" data-ng-if="product.Prices.length > 1" class="text-[10px] flex items-center justify-between py-1 border-t border-gray-200 last:border-b">
                            <div data-ng-bind-html="priceline.Amount + ' ' + product.UnitTitle"></div>
                            <div>
                                <s data-ng-if="priceline.PriceMin < priceline.FullPriceMin" data-ng-bind-html="priceline.FullPriceMin | currency_format" class="text-gray-500"></s>
                                <span data-ng-bind-html="priceline.PriceMin | currency_format"></span>
                            </div>
                        </div>
                    </div>
                </header>
                    
                <div class="flex justify-between mt-auto pt-2">
                    
                    <!-- Price -->
                    <div class="flex flex-col gap-1" data-ng-if="::showPrices">

                        <!-- Price -->
                        <span class="text-sm font-bold text-orange-700" data-ng-bind-html="price"></span>

                        <!-- Discount price -->
                        <s class="text-xs text-gray-500" data-ng-if="discount" data-ng-bind-html="discount | currency_format"></s>

                        <!-- VAT -->
                        <span data-ng-if="::settings.shop_product_tax_after_price" class="text-xs text-gray-500" data-ng-bind-html="::vatText"></span>

                    </div>

                    <!-- Amount -->
                    <input type="text" pattern="[0-9]*" class="hidden" name="product[{{product.Id}}][amount]" value="{{minAmount}}" placeholder="{{::text.CART_COUNT}}" title="{{::text.CART_ADD_ERROR_EMPTY}}" required data-ng-disabled="buttonMode != 1">

                    <!-- Buttons -->
                    <div class="flex items-end">
                        <!-- Special price -->
                        <span data-ng-if="product.SpecialPrice" class="w-6 h-6 flex items-center justify-center rounded-full bg-primary mb-2 mr-2">
                            <img src="{{template.path}}/assets/images/hand-shake.png" width="20" height="20" />
                        </span>

                        <a data-ng-show="buttonMode != '1'" data-ng-href="{{product.Handle}}" data-product="link" class="w-10 h-10 rounded bg-black flex items-center justify-center ng-hide" title="::text.PRODUCT_CATALOG_PRODUCT_SHOW">
                            <svg xmlns="http://www.w3.org/2000/svg" id="Outline" viewBox="0 0 24 24" width="16" height="16" class="fill-white"><path d="M23.271,9.419C21.72,6.893,18.192,2.655,12,2.655S2.28,6.893.729,9.419a4.908,4.908,0,0,0,0,5.162C2.28,17.107,5.808,21.345,12,21.345s9.72-4.238,11.271-6.764A4.908,4.908,0,0,0,23.271,9.419Zm-1.705,4.115C20.234,15.7,17.219,19.345,12,19.345S3.766,15.7,2.434,13.534a2.918,2.918,0,0,1,0-3.068C3.766,8.3,6.781,4.655,12,4.655s8.234,3.641,9.566,5.811A2.918,2.918,0,0,1,21.566,13.534Z"/><path d="M12,7a5,5,0,1,0,5,5A5.006,5.006,0,0,0,12,7Zm0,8a3,3,0,1,1,3-3A3,3,0,0,1,12,15Z"/></svg>
                        </a>

                        <button data-ng-show="buttonMode == '1'" type="submit" name="cartadd" data-product="buy" class="w-10 h-10 rounded bg-primary flex items-center justify-center ng-hide" data-ng-click="processProductSubmit()" title="::text.PRODUCT_CATALOG_PRODUCT_BUY">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" class="fill-white"><path d="M23,19H21V17a1,1,0,0,0-2,0v2H17a1,1,0,0,0,0,2h2v2a1,1,0,0,0,2,0V21h2a1,1,0,0,0,0-2Z"/><path d="M21,6H18A6,6,0,0,0,6,6H3A3,3,0,0,0,0,9V19a5.006,5.006,0,0,0,5,5h9a1,1,0,0,0,0-2H5a3,3,0,0,1-3-3V9A1,1,0,0,1,3,8H6v2a1,1,0,0,0,2,0V8h8v2a1,1,0,0,0,2,0V8h3a1,1,0,0,1,1,1v5a1,1,0,0,0,2,0V9A3,3,0,0,0,21,6ZM8,6a4,4,0,0,1,8,0Z"/></svg>
                        </button>
                    </div>
                </div>
            </div>
    
        </form>
    
    </article>

{/literal}