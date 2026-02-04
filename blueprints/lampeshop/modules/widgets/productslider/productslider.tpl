<div class="pt-6 md:pt-16 2xl:pt-20">
    <h3 class="text-lg md:text-xl lg:text-2xl tracking-wide text-center mb-6 md:mb-10">{$title}</h3>
    <div data-productslider="productlist" class="border border-gray-200 rounded {$class}">
        {include file='modules/product/product-list-combined.tpl' productlist=$items slider=true}
    </div>
</div>