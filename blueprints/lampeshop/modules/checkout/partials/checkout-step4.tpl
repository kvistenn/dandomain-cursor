{*

# Description
Template partial for Checkout step 4 of the checkout process. Part of Checkout page type.
Consisting mostly of a [jsRender Template](http://www.jsviews.com/#jsrender).


## Date last modified
2022-05-24


## Resource
+ [jsRender Template](http://www.jsviews.com/#jsrender)


## Primary variables


## Partials (templates)
No extra templates required for this template

*}
<input type="hidden" name="post_paymentType" value="{$returnPostData.paymentType}">
<input type="hidden" name="post_onlinePaymentType" value="{$returnPostData.onlinePaymentType}">

{literal}
<script id="paymentMethodTemplate" type="text/x-jsrender">
	{{if id != 9 || (id == 9 && payment_type != 'klarnaKCO')}}

		<div class="paymentMethodContainer border-b border-gray-300 last:border-b-0">
			<label class="flex flex-col gap-4 text-sm bg-white w-full p-4 cursor-pointer" id="paymentMethodContainer_{{:id}}{{if id == 9 && payment_type && payment_type === 'klarnaKP'}}_{{:klarna.group}}{{/if}}"{{if id == 9 && payment_type && payment_type === 'klarnaKP'}} style='display:none'{{/if}}>
				<div class="flex items-center gap-4">
					<input id="payment_type_{{:id}}{{if id == 9}}_klarna_{{:klarna.group}}{{/if}}" type="radio" name="paymentType" value="{{:id}}" class="w-4 h-4 paymentMethodRadio" data-show-on-active=".payment_details_{{:id}}{{if id == 9}}_{{:klarna.group}}{{/if}}" data-show-active-group="payment"
									{{if id == 9 && payment_type && payment_type === 'klarnaKP'}} data-klarna='{{:klarna.group}}'{{/if}}>
					<span class="text-gray-500 flex-auto">{{:title}}</span>
					<span>
						<div class="flex gap-1">
							{{:subtitle}}
						</div>
					</span>
				</div>
				{{if description}}
					<span class="text-xs" style="padding-left:30px;">{{:description}}</span>
				{{/if}}
			</label>

			{{if id == 8}}
				{{if paybybill.showValidation}}
					<div id="paybybillcontainer" class="payment_details_{{:id}}" style="display:none;">
						<div class="border-l-8 border-t border-gray-300">
							<input class="bg-white w-full px-3 h-12 text-sm" type="text" id="cprPayByBill" name="cprPayBybill" placeholder="{{:paybybill.info.fieldText}}" disabled required autocomplete="off">
						</div>
					</div>
				{{/if}}
			{{else id == 9 && payment_type !== 'klarnaKP'}}

				<div class="m-klarna-container payment_details_{{:id}}_{{:klarna.group}}" style="display:none;">
					{{if klarna.paymentMethods}}
						{{if klarna.paymentMethods.length == 1}}
							<div class="m-klarna-payment-methods">
								<input type="hidden" name="klarna_pclass" value="{{:klarna.paymentMethods[0].pclass}}" disabled>
								{{if klarna.paymentMethods[0].details}}
								<table class="table-h-striped">
									<tbody>
										{{for klarna.paymentMethods[0].details}}
										<tr>
											<td>{{:label}}</td>
											<td>{{:value}} {{:symbol}}</td>
										</tr>
										{{/for}}
									</tbody>
								</table>
								{{/if}}

								{{if klarna.paymentMethods[0].exampleText || klarna.paymentMethods[0].terms}}
								<p class="klarna_example">
									<span class="m-klarna-exampletext is-block">{{:klarna.paymentMethods[0].exampleText}}</span>
									<a class="m-klarna-terms-button is-block fancybox fancybox.iframe" href="{{:klarna.paymentMethods[0].terms}}">{{:~text('PRODUCT_CATALOG_READ_MORE')}}</a>
								</p>
								{{/if}}
							</div>
						{{else}}
						<ul class="m-klarna-payment-methods list-unstyled">
							{{for klarna.paymentMethods}}
							<li>
								<fieldset class="form-group">
									<div class="input-group" style="width:100%;">
										<span class="input-group-addon">
											<input id="klarna_type_{{:group}}_{{:#index}}" class="m-klarna-payment-methods-choice" type="radio" name="klarna_pclass" value="{{:pclass}}" required disabled data-show-on-active="#klarna_details_{{:group}}_{{:#index}}" data-show-active-group="klarna">
										</span>
										<div class="form-label input-group-main">
											<label for="klarna_type_{{:group}}_{{:#index}}" class="paymentMethodTitle">{{:title}}</label>

											<div id="klarna_details_{{:group}}_{{:#index}}" class="klarnaShowOnClick" style="display:none;">
												{{if details}}
												<table class="table-h-striped">
													<tbody>
														{{for details}}
														<tr>
															<td>{{:label}}</td>
															<td>{{:value}} {{:symbol}}</td>
														</tr>
														{{/for}}
													</tbody>
												</table>
												{{/if}}

												{{if exampleText || terms}}
												<p class="klarna_example">
													<span class="m-klarna-exampletext is-block">{{:exampleText}}</span>
													<a class="m-klarna-terms-button is-block fancybox fancybox.iframe" href="{{:terms}}">{{:~text('PRODUCT_CATALOG_READ_MORE')}}</a>
												</p>
												{{/if}}
											</div>
										</div>
									</div>
								</fieldset>
							</li>
							{{/for}}
						</ul>
						{{/if}}
					{{/if}}

					{{if !~isKlarnaCompany}}
						{{if klarna.fields}}
						<ul class="m-klarna-payment-methods list-unstyled">
							{{for klarna.fields}}
							<li>
								<fieldset class="form-group m-klarna-label">
									<label class="form-label" for="{{:name}}_{{:group}}">
										{{:label}} <span class="form-required">*</span>
									</label>
									{{if values}}
										<select class="form-input form-select" id="{{:name}}_{{:group}}" name="{{:name}}" disabled required>
										{{for values}}
											<option value="{{:value}}">{{:label}}</option>
										{{/for}}
										</select>
									{{else}}
										<input class="form-input" type="text" id="{{:name}}_{{:group}}" name="{{:name}}" placeholder="{{:text}}" disabled required autocomplete="off">
									{{/if}}
								</fieldset>
							</li>
							{{/for}}
						</ul>
						{{else}}
						<fieldset class="form-group m-klarna-label">
							<label class="form-label" for="cpr_{{:group}}">
								{{:klarna.fieldLabel}} <span class="form-required">*</span>
							</label>
							<input class="form-input" type="text" id="cpr_{{:group}}" name="cpr" placeholder="{{:klarna.fieldText}}" disabled required autocomplete="off">
						</fieldset>
						{{/if}}
					{{/if}}
					{{if klarna.extraText}}
						<div class="m-klarna-extra-text">
							{{:klarna.extraText}}
						</div>
					{{/if}}
				</div>

			{{/if}}

			{{if id == 9 && payment_type == 'klarnaKP'}}
				<div class="m-klarna-container payment_details_{{:id}}_{{:klarna.group}}" style="display:none;margin-bottom: 0.5em;overflow: auto;">
					<input type="hidden" name="klarnakp_payment_method_category" value={{:klarna.group}} disabled>
					<input type="hidden" name="klarnakp_authorization_token" value="" disabled>
					<div data-klarna-id="{{:id}}"
						data-klarna-group="{{:klarna.group}}"
						class="m-klarna-iframe payment_iframe_{{:id}}_{{:klarna.group}}"></div>
				</div>
			{{/if}}

			{{if onlineMethods}}
				<div class="paymentMethodOnlineContainerMain" style="display:none">
					<div class="border-l-8 border-t border-gray-300">
						{{for onlineMethods}}
							<label class="flex items-center gap-4 text-xs bg-white w-full p-3 border-b border-gray-300 cursor-pointer last:border-b-0">
								<input type="radio" name="onlinePaymentType" id="pbs_type_{{:id}}" value="{{:id}}" class="paymentMethodOnlineRadio w-3 h-3 flex-none" disabled>
								<span class="text-gray-500 flex-auto">{{:title}}</span>
								<span class="flex gap-1 flex-none">{{:~paymentGraphic(logo)}}</span>
							</label>
						{{/for}}
					</div>
				</div>
			{{/if}}
		</div>
		
	{{/if}}
</script>
{/literal}

<div class="py-5">
	<div class="block mb-3">
		<h3 class="text-lg">{$text.CHECKOUT_STEP_FIVE_ORDER_PAYMENT_METHOD}</h3>
	</div>
	<div class="paymentMethodContainerMain flex flex-col border border-gray-300 rounded overflow-hidden">
	</div>
</div>

<div class="hidden lg:flex lg:items-center lg:justify-between gap-5 mt-5 flex-col lg:flex-row">
    <div>
        <span data-checkout="stepper" data-target="2" class="text-brand-2 text-sm flex items-center gap-1 cursor-pointer justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" />
            </svg>
            {$text.CHECKOUT_BACK_TO} {$text.CHECKOUT_STEP_TWO|lower}
        </span>
    </div>
    <div>
        <button class="px-6 h-14 rounded bg-black text-white text-sm w-full md:w-fit" type="submit">{$text.CHECKOUT_PAYMENT_FORM_PROCEED}</button>
    </div>
</div>