{*

# Description
Template partial for Checkout step 2 of the checkout process. Part of Checkout page type.
Consisting mostly of a [jsRender Template](http://www.jsviews.com/#jsrender).


## Date last modified
2022-05-19


## Resource
+ [jsRender Template](http://www.jsviews.com/#jsrender)


## Primary variables


## Partials (templates)
No extra templates required for this template

*}

<input type="hidden" name="post_delivery_method" value="{$returnPostData.delivery_method}">
{if $returnPostData.delivery_multi}
	{foreach $returnPostData.delivery_multi as $key => $deliveryFixed}
		<input type="hidden" class="post_delivery_method_fixed" name="post_{$key}" value="{$deliveryFixed}">
	{/foreach}
{/if}

{literal}
<script id="deliveryMethodTemplate" type="text/x-jsrender">
{{if groupHeader}}
<div class="py-5">
	<div class="block mb-3">
		<h3 class="text-lg">{{:groupHeader}}</h3>
	</div>
	<div class="flex flex-col border border-gray-300 rounded overflow-hidden">
{{/if}}
{{if fixed}}
    <div class="deliveryMethodGroupProducts">
	    {{for products}}
	        {{:#data}}<br />
	    {{/for}}
    </div>
{{/if}}
<div class="deliveryMethodContainer">

<label class="deliveryMethodSelector flex items-center gap-4 text-sm bg-white w-full p-4 cursor-pointer border-b border-gray-300{{if lastInGroup}} border-b-0{{/if}}">
	<input type="radio" name="{{:name}}" id="{{:id}}" value="{{:value}}" class="w-4 h-4 deliveryMethodRadio{{if isGls}} gls{{/if}}{{if isPostDK}} postdk{{/if}}{{if isBringPP}} bringpp{{/if}}{{if isDao}} dao{{/if}}{{if isDropPoint}} droppoint{{/if}}{{if groupHeader}} header{{/if}} {{if messageField}}messageField{{/if}}" required />
	<span class="text-gray-500 flex-auto">{{:title}}</span>
	<span><strong>{{:priceText}}</strong></span>
</label>
{{if isGls}}
<div id="glsContainer" class="locationContainer flex flex-col gap-4 p-4 border-b border-gray-300" style="display:none;">
	{/literal}{include file='modules/checkout/partials/checkout-step2-droppoint.tpl'}{literal}
	<div class="glsTitle text-gray-500">
		<div class="panel panel-warning">
			<div class="panel-body">
				{/literal}{$Text.CHECKOUT_STEP_TWO_GLS_HEADER}{literal}
			</div>
		</div>
	</div>
	<div class="targetContainer">
		<ul class="glsLocationTarget target list-unstyled flex flex-col gap-2" style="padding: 0 0 0 1.5em;"></ul>
	</div>
</div>
{{/if}}
{{if isPostDK}}
<div id="postdkContainer" class="locationContainer" style="display:none;">
	{/literal}{include file='modules/checkout/partials/checkout-step2-droppoint.tpl'}{literal}
	<div class="postdkTitle">
		<div class="panel panel-warning">
			<div class="panel-body">
				{/literal}{$Text.CHECKOUT_STEP_TWO_POSTDK_HEADER}{literal}
			</div>
		</div>
	</div>
	<div class="targetContainer">
		<ul class="postdkLocationTarget target list-unstyled" style="padding: 0 0 0 1.5em;"></ul>
	</div>
</div>
{{/if}}
{{if isBringPP}}
<div id="bringppContainer" class="locationContainer" style="display:none;">
	{/literal}{include file='modules/checkout/partials/checkout-step2-droppoint.tpl'}{literal}
	<div class="bringppTitle">
		<div class="panel panel-warning">
			<div class="panel-body">
				{/literal}{$Text.CHECKOUT_STEP_TWO_BRINGPP_HEADER}{literal}
			</div>
		</div>
	</div>
	<div class="targetContainer">
		<ul class="bringppLocationTarget target list-unstyled" style="padding: 0 0 0 1.5em;"></ul>
	</div>
</div>
{{/if}}
{{if isDao}}
<div id="daoContainer" class="locationContainer" style="display:none;">
	{/literal}{include file='modules/checkout/partials/checkout-step2-droppoint.tpl'}{literal}
	<div class="daoTitle">
		<div class="panel panel-warning">
			<div class="panel-body">
				{/literal}{$Text.CHECKOUT_STEP_TWO_DAO_HEADER}{literal}
			</div>
		</div>
	</div>
	<div class="targetContainer">
		<ul class="daoLocationTarget target list-unstyled" style="padding: 0 0 0 1.5em;"></ul>
	</div>
</div>
{{/if}}
</div>
{{if lastInGroup}}
	</div>
</div>
{{/if}}
</script>
<script id="glsLocationTemplate" type="text/x-jsrender">
	<li class="radio">
		<fieldset class="form-group">
			<div class="input-group flex gap-2 items-center">
				<span class="input-group-addon">
					<input id="gls_location{{:#index}}" type="radio" name="gls_location" class="radiobtn" value="{{:Number}}">
				</span>
				<label for="gls_location{{:#index}}" class="form-label input-group-main">
					<span class="droppointTextHeader block">{{:CompanyName}} </span>
					<span class="droppointTextLine block">{{:Streetname}}, {{:ZipCode}} {{:CityName}}</span>
				</label>
			</div>
		</fieldset>
	</li>
</script>
<script id="postdkLocationTemplate" type="text/x-jsrender">
	<li class="radio">
		<fieldset class="form-group">
			<div class="input-group flex gap-2 items-center">
				<span class="input-group-addon">
					<input id="postdk_location{{:#index}}" type="radio" name="postdk_location" class="radiobtn" value="{{:number}}" />
				</span>
				<label for="postdk_location{{:#index}}" class="form-label input-group-main">
					<span class="droppointTextHeader block">{{:name}}</span>
					<span class="droppointTextLine block">{{:streetName}} {{:streetNumber}}</span>
					<span class="droppointTextLine block">{{:postalCode}} {{:city}}</span>
					<span class="droppointTextLine block"><i>{{:openingHours}}</i></span>
				</label>
			</div>
		</fieldset>
	</li>
</script>
<script id="bringppLocationTemplate" type="text/x-jsrender">
	<li class="radio">
		<fieldset class="form-group">
			<div class="input-group flex gap-2 items-center">
				<span class="input-group-addon">
					<input id="bringpp_location{{:#index}}" type="radio" name="bringpp_location" class="radiobtn" value="{{:id}}">
				</span>
				<label for="bringpp_location{{:#index}}" class="form-label input-group-main">
					<span class="droppointTextHeader block">{{:name}} </span>
					<span class="droppointTextLine block">{{:visitingAddress}}, {{:visitingPostalCode}} {{:visitingCity}}</span>
				</label>
			</div>
		</fieldset>
	</li>
</script>
<script id="daoLocationTemplate" type="text/x-jsrender">
	<li class="radio">
		<fieldset class="form-group">
			<div class="input-group flex gap-2 items-center">
				<span class="input-group-addon">
					<input id="dao_location{{:#index}}" type="radio" name="dao_location" class="radiobtn" value="{{:id}}">
				</span>
				<label for="dao_location{{:#index}}" class="form-label input-group-main">
					<span class="droppointTextHeader block">{{:name}} </span>
					<span class="droppointTextLine block">{{:visitingAddress}}, {{:visitingPostalCode}} {{:visitingCity}}</span>
				</label>
			</div>
		</fieldset>
	</li>
</script>
<script id="emptyLocationTemplate" type="text/x-jsrender">
	{{if ~hasDefault }}
	<li style="margin-left: -1.5em;">
		<div class="emptyTitle">
			<div class="panel panel-warning">
				<div class="panel-body">
					{/literal}{$Text.CHECKOUT_STEP_TWO_DROPPOINT_NONE}{literal}
				</div>
			</div>
		</div>
	</li>
	<li class="radio">
		<fieldset class="form-group">
			<div class="input-group flex gap-2 items-center">
				<span class="input-group-addon">
					<input id="{{:input}}_random" type="radio" name="{{:input}}" class="radiobtn" value="" checked="checked" />
				</span>
				<label for="{{:input}}_random" class="form-label input-group-main">
					<span class="block">{{:text}}</span>
				</label>
			</div>
		</fieldset>
	</li>
	{{else}}
	<li style="margin-left: -1.5em;">
		<div class="emptyTitle">
			<div class="panel panel-warning">
				<div class="panel-body">
					{/literal}{$Text.CHECKOUT_STEP_TWO_DROPPOINT_NONE}{literal}
				</div>
			</div>
		</div>
	</li>
	{{/if}}
</script>
{/literal}
<div class="deliveryMethodNotFound">{$Text.CHECKOUT_STEP_TWO_METHODS_NONE}</div>
<div class="deliveryMethodContainerMain"></div>

{if $settings.checkout_delivery_datetime}
{addScript src='modules/checkout/includes/js/cleave.min.js'}
<div class="deliveryTimeContainer py-5">
	<div class="flex items-center justify-between mb-3">
		<h2 class="text-lg">{$text.CHECKOUT_STEP_TWO_TIME_OF_DELIVERY}</h2>
	</div>
	<div class="flex flex-col gap-4">
		<div class="grid grid-cols-2 gap-4">
			<input type="date" id="deliveryDate" class="bg-white border border-gray-300 rounded w-full px-3 h-12 text-sm" name="deliveryDate" value="{$returnPostData.deliveryDate}" min="{$now|date_format:"%Y-%m-%d"}">
			<input type="time" id="deliveryTime" class="bg-white border border-gray-300 rounded w-full px-3 h-12 text-sm" name="deliveryTime" value="{$returnPostData.deliveryTime}" placeholder="{$Text.CHECKOUT_STEP_TWO_DELIVERY_TIME}">
		</div>
	</div>
</div>
{/if}

<div class="py-5 deliveryMethodNote">
	<div class="block mb-3">
		<h4 class="text-lg">{$Text.CHECKOUT_STEP_TWO_COMMENT}</h4>
	</div>
	<textarea class="bg-white border border-gray-300 rounded w-full p-3 h-12 text-sm" name="customerNotice" id="customerNotice" placeholder="{$Text.CHECKOUT_STEP_TWO_COMMENT}" style="min-height: 140px;">{$returnPostData.customerNotice}</textarea>
</div>

<div class="py-5 deliveryMethodNote is-hidden">
	<div class="block mb-3">
		<h4 class="text-lg">{$Text.CHECKOUT_STEP_TWO_COMMENT}</h4>
	</div>
	<textarea class="bg-white border border-gray-300 rounded w-full p-3 h-12 text-sm" maxlength="50" name="customerNoticeDelivery" id="customerNoticeDelivery" placeholder="{$Text.CHECKOUT_STEP_TWO_COMMENT_DELIVERY}" style="min-height: 55px;">{$returnPostData.customerNoticeDelivery}</textarea>
</div>

<div class="flex md:items-center md:justify-between gap-5 mt-5 flex-col md:flex-row">
    <div>
        <span data-checkout="stepper" data-target="1" class="text-brand-2 text-sm flex items-center gap-1 cursor-pointer justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" />
            </svg>
            {$text.CHECKOUT_BACK_TO} {$text.CHECKOUT_STEP_ONE|lower}
        </span>
    </div>
    <div>
        <button class="px-6 h-14 rounded bg-black text-white text-sm w-full md:w-fit" data-checkout="stepper" data-target="4">{$text.PRODUCT_CATALOG_GOTO} {$text.CHECKOUT_STEP_FOUR|lower}</button>
    </div>
</div>