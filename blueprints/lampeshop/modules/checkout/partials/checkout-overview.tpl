{literal}
<script id="checkoutOverviewTemplate" type="text/x-jsrender">

<div class="pb-5">
    <div class="border border-gray-300 rounded flex flex-col py-1 px-4 text-xs md:text-sm">
        <div class="flex gap-4 py-3 border-b border-gray-300">
            <span class="w-24 flex-none text-gray-400">{/literal}{$Text.CHECKOUT_CUSTOMER}{literal}</span>
            <span class="flex-auto">{{:~customerData().email}}</span>
            <span class="text-brand-2 text-xs cursor-pointer" data-checkout="stepper" data-target="1">{/literal}{$Text.CHECKOUT_CHANGE}{literal}</span>
        </div>
        <div class="flex gap-4 py-3 border-b border-gray-300">
            <span class="w-24 flex-none text-gray-400">{/literal}{$Text.CHECKOUT_SHIP_TO}{literal}</span>
            <span class="flex-auto">{{:~customerData().address}}, {{:~customerData().zip}} {{:~customerData().city}}, {{:~customerData().country}}</span>
            <span class="text-brand-2 text-xs cursor-pointer" data-checkout="stepper" data-target="1">{/literal}{$Text.CHECKOUT_CHANGE}{literal}</span>
        </div>
        <div class="flex gap-4 py-3">
            <span class="w-24 flex-none text-gray-400">{/literal}{$Text.CHECKOUT_STEP_TWO}{literal}</span>
            <span class="flex-auto">{{:delivery.title}}</span>
            <span class="text-brand-2 text-xs cursor-pointer" data-checkout="stepper" data-target="2">{/literal}{$Text.CHECKOUT_CHANGE}{literal}</span>
        </div>
    </div>
</div>

</script>
{/literal}

<div id="checkoutOverview" class="hidden"></div>