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

    <form class="product group h-full" method="post" action="/actions/cart/add" data-form="ajax" data-id="{{product.Id}}" data-buyable="{{product.Buyable}}" data-instock="{{product.inTotalStock}}">

        <input type="hidden" name="returnUrl" data-ng-value="returnUrl">
        <input type="hidden" name="product[{{product.Id}}][variant]" data-ng-if="product.Type == 'variant'" data-variant="id">

        <div class="px-4 sm:px-5 pt-4 pb-4 lg:pb-24 bg-white relative flex flex-col h-full">

            <div class="w-full flex flex-wrap items-center justify-center gap-2 mb-4" data-equalizer="badges">
                <span class="block w-fit px-2 py-1 text-2xs uppercase tracking-wider bg-orange-500 text-white rounded" data-ng-show="product.Savings > 9" data-ng-bind-html="'-' + product.Savings + '%'"></span>
                <span class="block w-fit px-2 py-1 text-2xs uppercase tracking-wider bg-black text-white rounded" data-ng-if="::isNew" data-ng-bind-html="::text.NEWS"></span>
                <span class="block w-fit px-2 py-1 text-2xs uppercase tracking-wider bg-black text-white rounded" data-ng-if="product.CustomTypes[7].Data" data-ng-bind-html="product.CustomTypes[7].Title"></span>
                <span class="block w-fit px-2 py-1 text-2xs uppercase tracking-wider bg-black text-white rounded empty:hidden" style="color:{{badge.Color}};background-color:{{badge.Background}};" data-ng-repeat="badge in product.Badges" data-ng-bind-html="badge.Title"></span>
            </div>

            <div class="opacity-0 pointer-events-none group-hover:opacity-100 group-hover:pointer-events-auto text-gray-500 hover:text-black absolute top-4 left-0 w-full z-20 hover:text-brand-2 cursor-pointer flex items-center justify-center gap-1 h-6 bg-white transition-all" data-wishlist="toggle" data-id="{{product.Id}}" data-ng-if="user && settings.module_shop_wishlist">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
                </svg>
                <span class="text-xs tracking-wide">{{text.SAVE}}</span>
            </div>

            <div class="text-center pb-4 sm:pb-5 mb-auto">
                <a data-ng-href="{{product.Handle}}" class="block text-sm" title="{{product.Title}}">{{product.Title}}</a>
            </div>

            <div>
                <a data-ng-href="{{product.Handle}}" class="block">
                    <figure class="w-full" data-ng-if="product.Images.length === 1">
                        <img data-ng-src="{{product.Images[0]}}" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" alt="{{product.Title}}" loading="lazy" width="320" height="320" class="aspect-square object-cover w-full">
                    </figure>
                    <figure class="w-full relative overflow-hidden aspect-square" data-ng-if="product.Images.length > 1">
                        <div class="translate-x-full absolute inset-0 w-full h-full bg-white group-hover:translate-x-0 transition-transform duration-300 group-[&.variant]:translate-x-full">
                            <img data-ng-src="{{product.Images[1]}}" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" alt="{{product.Title}}" loading="lazy" width="320" height="320" class="aspect-square object-cover w-full">
                        </div>
                        <img data-ng-src="{{product.Images[0]}}" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" data-variant="image" alt="{{product.Title}}" loading="lazy" width="320" height="320" class="aspect-square object-cover w-full group-hover:-translate-x-full transition-transform duration-300 group-[&.variant]:translate-x-0">
                    </figure>
                </a>
            </div>

            <div data-ng-if="::showPrices" class="mt-5">
                <div class="flex-col flex items-center gap-1">
                    <span class="font-bold" data-ng-bind-html="price"></span>
                    <s class="text-xs text-gray-500" data-ng-if="discount" data-ng-bind-html="discount | currency_format"></s>
                </div>
            </div>

            <div data-equalizer="variants" class="mt-5">
                <div class="relative">
                    <div data-ng-repeat="variantType in product.VariantTypes" data-ng-if="product.VariantTypes.length > 0" data-index="{{$index}}" data-hasmultiplevariants="{{product.HasMultipleVariants}}" class="relative">
                        <div data-variant="variant">
                            <span class="rounded-full block transition-colors cursor-pointer group/variant relative" data-ng-repeat="Data in variantType.Data" data-value="{{Data.Id}}">
                                <img data-ng-src="{{Data.Image}}" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" alt="{{Data.Title}}" class="w-full aspect-square object-cover border border-gray-200 rounded-full transition-colors p-0.5" />
                                <span class="absolute bottom-full pb-1 left-1/2 -translate-x-1/2 -translate-y-3 mb-1 w-fit bg-black opacity-0 pointer-events-none rounded group-hover/variant:opacity-100 group-hover/variant:translate-y-0 transition-all px-1.5 leading-none">
                                    <span class="text-2xs text-white whitespace-nowrap" data-ng-bind-html="Data.Title"></span>
                                </span>
                            </span>
                        </div>
                    </div>
                    <!--<div data-ng-if="product.VariantTypes[0].Data.length > 5" class="absolute top-0 -right-4 h-full w-1/4 bg-gradient-to-r from-transparent to-white pointer-events-none"></div>
                    <span data-ng-if="product.VariantTypes[0].Data.length > 5" data-variant="next" class="absolute top-0 right-0 h-full flex items-center cursor-pointer">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
                        </svg>                  
                    </span>-->
                </div>
            </div>

            <div class="flex gap-2 md:gap-4 pt-4 lg:pt-0 justify-center transition-opacity lg:opacity-0 lg:group-hover:opacity-100 lg:absolute lg:bottom-8 lg:left-0 w-full">
                <div class="relative" data-ng-class="{ 'hidden': product.Type == 'variant' }" data-basket="add">
                    <span class="hidden md:block absolute bottom-full p-1 left-1/2 -translate-x-1/2 text-gray-500 cursor-pointer" data-product="inc">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-3 h-3">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 15.75l7.5-7.5 7.5 7.5" />
                        </svg>
                    </span>
                    <input type="text" data-product="amount" pattern="[0-9]*" class="w-10 h-10 text-sm border border-gray-200 rounded text-center" name="product[{{product.Id}}][amount]" value="{{minAmount}}" placeholder="{{::text.CART_COUNT}}" title="{{::text.CART_ADD_ERROR_EMPTY}}" required>
                    <span class="hidden md:block absolute top-full p-1 left-1/2 -translate-x-1/2 text-gray-500 cursor-pointer" data-product="dec">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-3 h-3">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
                        </svg>                  
                    </span>
                </div>
                <button type="submit" name="cartadd" class="px-5 h-10 bg-black text-white text-xs rounded flex items-center gap-2 flex-auto lg:flex-none justify-center lg:justify-start" data-ng-class="{ 'hidden': product.Type == 'variant' }" data-basket="add">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4 flex-none text-inherit">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.12-1.243l1.264-12A1.125 1.125 0 015.513 7.5h12.974c.576 0 1.059.435 1.119 1.007zM8.625 10.5a.375.375 0 11-.75 0 .375.375 0 01.75 0zm7.5 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z"></path>
                    </svg>
                    <span class="text-inherit" data-ng-bind-html="::text.PRODUCT_CATALOG_PRODUCT_BUY"></span>
                </button>
                <a data-ng-href="{{product.Handle}}" class="px-5 h-10 bg-black text-white hover:text-white text-xs rounded flex items-center gap-2 flex-auto lg:flex-none justify-center lg:justify-start" data-ng-class="{ 'hidden': product.Type != 'variant' }" data-basket="link">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4 text-inherit">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z" />
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    </svg>              
                    <span class="text-inherit" data-varianttext="{{text.PRODUCT_CATALOG_PRODUCT_CHOOSE_VARIANT}}" data-ng-bind-html="::text.PRODUCT_CATALOG_PRODUCT_CHOOSE_VARIANT"></span>
                </a>
            </div>

        </div>

    </form>

{/literal}