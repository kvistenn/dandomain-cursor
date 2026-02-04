{**

    Explanation:

    Make a get request to json/cart
    example:
    $.get('/json/cart', function (res) {
    var template = $.templates("#render-cart");
    var htmlOutput = template.render(res, {
        currency: platform.currency_format
    });
    $("#ajaxcart").html(htmlOutput);
    });

    Make sure to re-render the cart after adding an item to the cart. (/actions/cart/add)
    All data can be modified in modules/json/cart.tpl


**}

{* Jsrender cart *}
{literal}
    <script id="render-cart" type="text/x-jsrender">
        <div class="fixed w-full h-full bg-black/80 top-0 left-0 opacity-0 pointer-events-none transition-all z-50 [&.show]:opacity-100 [&.show]:pointer-events-auto {{:~cartClass()}}" data-cart="overlay"></div>
        <form class="fixed z-50 w-[24rem] max-w-full h-full bg-white right-0 top-0 translate-x-full transition-all [&.show]:translate-x-0 {{:~cartClass()}}" data-cart="cart" method="post" action="/actions/cart/update" data-form="ajax">
            <div class="h-full flex flex-col gap-8 sm:gap-6 overflow-y-auto p-6 sm:p-8" data-cart="scroll">
                
                <div class="flex justify-between">
                    <strong class="font-normal">{{:~text('CART_HEADLINE')}}</strong>
                    <span data-cart="close" class="w-6 h-6 cursor-pointer">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </span>
                </div>
    
                <div class="flex flex-col gap-6">
                    {{if CartProduct.length > 0}}
                        {{for CartProduct}}
                            <div class="flex leading-none" method="post" action="/actions/cart/update" data-product-id="{{:ProductId}}" data-variant-id="{{:VariantId}}">
                                <figure class="w-16	flex-none">
                                    <img src="{{:CartImage}}" width="64" height="64" alt="{{:Title}}" loading="lazy" class="w-full h-auto aspect-square object-scale-down" />
                                </figure>
                                <div class="flex flex-col flex-auto w-64 px-4">
                                    <a href="{{:Url}}" class="text-xs line-clamp-2 font-bold">{{:Title}}{{:VariantTitle}}</a>
                                    <label class="flex shadow-sm w-fit rounded px-1 py-0.5 mt-auto transition-shadow hover:shadow-md">
                                        <a data-cart="decrease" class="flex flex-none items-center justify-center w-5 h-5" href="/actions/cart/minus?id={{:Key}}">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M18 12H6" />
                                            </svg>
                                        </a>
                                        <input type="text" class="w-5 h-5 flex-none text-xs text-center" name="cart[{{:Key}}][amount]" pattern="[0-9]*" value="{{:Amount}}" />
                                        <a data-cart="increase" class="flex flex-none items-center justify-center w-5 h-5" href="/actions/cart/plus?id={{:Key}}">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                                            </svg>
                                        </a>
                                    </label>
                                </div>
                                <div class="flex-auto w-32 flex flex-col items-end">
                                    <a data-cart="delete" class="block mb-3" href="/actions/cart/remove?id={{:Key}}" title="{{:~text('DELETE')}}">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                                            <path fill-rule="evenodd" d="M8.75 1A2.75 2.75 0 006 3.75v.443c-.795.077-1.584.176-2.365.298a.75.75 0 10.23 1.482l.149-.022.841 10.518A2.75 2.75 0 007.596 19h4.807a2.75 2.75 0 002.742-2.53l.841-10.52.149.023a.75.75 0 00.23-1.482A41.03 41.03 0 0014 4.193V3.75A2.75 2.75 0 0011.25 1h-2.5zM10 4c.84 0 1.673.025 2.5.075V3.75c0-.69-.56-1.25-1.25-1.25h-2.5c-.69 0-1.25.56-1.25 1.25v.325C8.327 4.025 9.16 4 10 4zM8.58 7.72a.75.75 0 00-1.5.06l.3 7.5a.75.75 0 101.5-.06l-.3-7.5zm4.34.06a.75.75 0 10-1.5-.06l-.3 7.5a.75.75 0 101.5.06l.3-7.5z" clip-rule="evenodd" />
                                        </svg>
                                    </a>
                                    {{if FullPrice != Price}}
                                        <strike class="text-xs whitespace-nowrap">{{:~currency(FullPrice)}}</strike>
                                    {{/if}}
                                    <strong class="text-sm whitespace-nowrap">{{:~currency(Price * Amount)}}</strong>
                                </div>
                            </div>
                        {{/for}}
                    {{else}}
                        <div>
                            <span>
                                {{:~text('CART_IS_EMPTY')}}
                            </span>
                        </div>
                    {{/if}}
    
                </div>
    
                <div class="flex flex-col mt-auto gap-2">
    
                    {{if CartEstimatedDelivery}}
                        <div class="flex justify-between">
                            <span class="text-sm">{{:~text('CART_DELIVERY_FROM')}}</span>
                            <span class="text-sm">{{:~currency(CartEstimatedDelivery)}}</span>
                        </div>
                    {{/if}}
                    {{if CartSubTotalPrice}}
                        <div class="flex justify-between">
                            <span class="text-sm">{{:~text('CART_PRICE_SUM')}}</span>
                            <span class="text-sm">{{:~currency(CartSubTotalPrice)}}</span>
                        </div>
                    {{/if}}
    
                    {{if CartVatPrice}}
                        <div class="flex justify-between font-weight">
                            <span class="text-sm">
                                {{if ~platformcurrency('hasVat')}}
                                    {{:~text('CART_VAT_INCLUSIVE')}}
                                {{else}}
                                    {{:~text('CART_VAT_EXCLUSIVE')}}
                                {{/if}}
                            </span>
                            <span class="text-sm">{{:~currency(CartVatPrice)}}</span>
                        </div>
                    {{/if}}
    
                    {{if CartTotalLinePrice}}
                        <div class="flex justify-between">
                            <span class="text-lg">{{:~text('CART_TOTAL')}}</span>
                            <span class="text-lg">{{:~currency(CartTotalLinePrice)}}</span>
                        </div>
                    {{/if}}
                </div>
                
                <div class="flex flex-col gap-4">
                    <a class="block w-full bg-black text-white px-6 py-4 rounded text-center" href="/{{:~text('CART_LINK')}}/">{{:~text('CART_GO_TO')}}</a>
                </div>
    
                <input type="submit" hidden tabindex="-1" aria-hidden="true" />
            </div>
        </form>
    </script>
    {/literal}
    
    <div id="ajaxcart"></div>
    