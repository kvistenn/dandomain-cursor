<div class="DroppointAddressContainer panel panel-border" style="display:none;">
	<div class="panel-heading">
		<a class="DroppointAddressToggle flex items-center justify-center px-3 md:px-6 h-10 md:h-12 rounded bg-gray-500 text-white text-xs md:text-sm" href="#" data-target=".DroppointAddressContent">{$Text.CHECKOUT_STEP_TWO_DROPPOINT_SEARCH}</a>
	</div>
	<div class="DroppointAddressContent" style="display:none;">
		<div class="panel-body">
			<fieldset class="form-group mt-4 flex flex-col gap-4 md:grid md:grid-cols-2">
				<input class="m-address form-input bg-white border border-gray-300 rounded flex-auto px-3 h-10 md:h-12 text-xs md:text-sm" type="text" name="droppoint_address" value="" placeholder="{$Text.ADDRESS}">
				<input class="m-zipcode form-input bg-white border border-gray-300 rounded flex-auto px-3 h-10 md:h-12 text-xs md:text-sm" type="text" name="droppoint_zipcode" value="" placeholder="{$Text.POSTCODE}">
			</fieldset>
		</div>
		<div class="panel-footer mt-4">
			<fieldset class="form-group form-action">
				<button class="SearchDroppointAddress m-search button-primary form-submit px-3 md:px-6 h-10 md:h-12 rounded bg-gray-500 text-white text-xs md:text-sm" type="button">{$Text.SEARCH}</button>
			</fieldset>
		</div>
	</div>
</div>