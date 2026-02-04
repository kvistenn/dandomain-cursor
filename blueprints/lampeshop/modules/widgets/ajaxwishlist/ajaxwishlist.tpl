{**

    Explanation:

    Make a get request to json/wishlist
    example:
    $.get('/json/wishlist', function (res) {
        var template = $.templates("#render-wishlist");
        var htmlOutput = template.render(res, {
            currency: platform.currency_format
        });
        $("#ajaxwishlist").html(htmlOutput);
    });

    Make sure to re-render the cart after adding an item to the cart. (/actions/cart/add)
    All data can be modified in modules/json/wishlist.tpl


**}

{* Jsrender wishlist *}
{literal}
<script id="render-wishlist" type="text/x-jsrender">
    <div class="fixed w-full h-full bg-black/80 top-0 left-0 opacity-0 pointer-events-none transition-all z-40 {{:~wishlistClass()}}" data-wishlist="overlay"></div>
    <div class="fixed z-50 w-[24rem] max-w-full h-full bg-white right-0 top-0 translate-x-full transition-all {{:~wishlistClass()}}" data-wishlist="wishlist">
        <div class="h-full flex flex-col gap-8 sm:gap-6 overflow-y-auto p-6 sm:p-8" data-cart="scroll">
            
            <div class="flex justify-between">
                <strong class="font-normal">{{:~text('WISHLIST_HEADLINE')}}</strong>
                <span data-wishlist="close" class="w-6 h-6 cursor-pointer">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </span>
            </div>

            <div class="flex flex-col gap-6 mb-6">
                {{if WishlistProduct.length > 0}}
                    {{for WishlistProduct}}
                        <div class="flex leading-none" data-product-id="{{:ProductId}}" data-variant-id="{{:VariantId}}">
                            <figure class="w-16	flex-none">
                                <img src="{{:Image}}" width="64" height="64" alt="{{:Title}}" loading="lazy" class="w-full h-auto" />
                            </figure>
                            <div class="flex flex-col flex-auto w-64 px-4">
                                <strong class="text-xs line-clamp-2">{{:Title}}</strong>
                                <span class="text-xs mt-2">{{:StockText}}</span>
                            </div>
                            <div class="flex-auto w-32 flex flex-col items-end">
                                <a data-wishlist="delete" class="block mb-3"  href="/actions/wishlist/delete?id={{:Id}}" data-id="{{:ProductId}}" title="{{:~text('DELETE')}}">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                                        <path fill-rule="evenodd" d="M8.75 1A2.75 2.75 0 006 3.75v.443c-.795.077-1.584.176-2.365.298a.75.75 0 10.23 1.482l.149-.022.841 10.518A2.75 2.75 0 007.596 19h4.807a2.75 2.75 0 002.742-2.53l.841-10.52.149.023a.75.75 0 00.23-1.482A41.03 41.03 0 0014 4.193V3.75A2.75 2.75 0 0011.25 1h-2.5zM10 4c.84 0 1.673.025 2.5.075V3.75c0-.69-.56-1.25-1.25-1.25h-2.5c-.69 0-1.25.56-1.25 1.25v.325C8.327 4.025 9.16 4 10 4zM8.58 7.72a.75.75 0 00-1.5.06l.3 7.5a.75.75 0 101.5-.06l-.3-7.5zm4.34.06a.75.75 0 10-1.5-.06l-.3 7.5a.75.75 0 101.5.06l.3-7.5z" clip-rule="evenodd" />
                                    </svg>
                                </a>
                                {{if FullPrice != Price}}
                                    <strike class="text-xs whitespace-nowrap">{{:~currency(FullPrice)}}</strike>
                                {{/if}}
                                <strong class="text-sm whitespace-nowrap">{{:~currency(Price)}}</strong>
                            </div>
                        </div>
                    {{/for}}
                {{else}}
                    <div>
                        <span>
                            {{:~text('WISHLIST_EMPTY')}}
                        </span>
                    </div>
                {{/if}}

            </div>

            <button data-wishlist="transfer" type="button" class="mt-auto block w-full bg-black text-white px-6 py-4 rounded-full text-center">{{:~text('CART_TRANSFER_WISHLIST')}}</button>
            
        </div>
    </div>
</script>
{/literal}

<div id="ajaxwishlist"></div>    