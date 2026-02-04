{*

# Description
Template partial for Checkout step 3 of the checkout process. Part of Checkout page type.


## Date last modified
2015-01-05


## Primary variables


## Partials (templates)
No extra templates required for this template

*}

<input type="hidden" name="post_packingType" value="{$returnPostData.packingType}">

{literal}
<script id="giftWrappingTemplate" type="text/x-jsrender">
	<div class="giftWrappingOption border-b border-gray-300 last:border-b-0">
		<label class="flex gap-4 text-sm p-4 cursor-pointer">
			<input id="packing_id{{:id}}" type="radio" name="packingType" value="{{:id}}">
			<div class="flex flex-col gap-0.5">
				<strong class="block">{{:title}}</strong>
				{{if description}}
					<span class="text-xs">{{:description}}</span>
				{{/if}}
			</div>
			{{if price}}
				<div class="ml-auto whitespace-nowrap font-bold">{{:price}}</div>
			{{/if}}
		</label>
	</div>
</script>
{/literal}

<div class="giftWrappingLeftContainer bg-white rounded border border-gray-300 mt-5">
</div>
<!--<div class="giftWrappingRightContainer p-4 bg-white border border-gray-300 border-t-0 rounded-b space-y-4" {{if $returnPostData.packing_type == 0}} style="display:none;" {{else}} style="display:block;" {{/if}}>
	<label id="m-checkout-giftwrapping-message" class="flex flex-col gap-2">
		<strong class="text-sm">{$Text.CHECKOUT_STEP_THREE_NOTE_ADD}</strong>
		<textarea name="packingMessage" id="packingMessage" class="bg-white border border-gray-300 rounded w-full p-3 text-xs md:text-sm" placeholder="{$Text.CHECKOUT_STEP_THREE_NOTE_ADD}" style="min-height: 140px;">{$returnPostData.packingMessage}</textarea>
	</label>
	<label id="m-checkout-giftwrapping-from" class="flex flex-col gap-2">
		<strong class="text-sm">{$Text.CHECKOUT_STEP_THREE_NOTE_FROM}</strong>
		<input type="text" name="packingFrom" id="packingFrom" class="bg-white border border-gray-300 rounded w-full px-3 h-10 md:h-12 text-xs md:text-sm" value="{$returnPostData.packingFrom}" placeholder="{$Text.CHECKOUT_STEP_THREE_NOTE_FROM}">
	</fieldset>
</div>-->