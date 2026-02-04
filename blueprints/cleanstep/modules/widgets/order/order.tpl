{*

# Description
Order widget. A widget is a small helper template, with some functionality.


## Date last modified
2020-10-05


## Primary variables
+ $checkout 															- Toggle for "checkout mode" (ignore user check)
+ $repay 																- Toggle for "repay mode" (ignore transaction lines)
+ $order																- Entity of orderController
+ $orderCustomer														- Entity of orderCustomerController
+ $orderLine															- Collection of orderLineController
+ $productController													- Instance of productController
+ $tracking																- Entity of trackingMethodController
+ $trackingLine															- Entity of trackingMethodController
+ $page                                                                 - Global scope variable containing all information about the page type
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

{if !isset($checkout)}
	{$checkout = false}
{/if}

{* Order entity *}
{if !empty($checkout)}
	{entity controller=order assign=order id=$orderId userId=false statusId=false}
{else}
	{entity controller=order assign=order id=$orderId userId=$user->Id}
{/if}

{if !$order}
	{notfound}
{/if}

{if !isset($repay)}
	{$repay = false}
{/if}

{* Order Customer entity *}
{entity controller=orderCustomer assign=orderCustomer orderId=$orderId}

{* Order Lines collection *}
{collection controller=orderLine assign=orderLine orderId=$orderId repay=$repay}
{controller assign=productController type=product}

{* Group order collection by class *}
{$orderList = $orderLine->groupByClass()}

{if $order->ServiceType}
	{* Service type entity *}
	{entity controller=trackingMethod id=$order->ServiceType orderId=$order->Id assign=tracking}
{/if}

{$imageWidth = 220}
{$imageHeight = 220}
{placeholdImage assign=placeholder width=$imageWidth height=$imageHeight background=$template.settings.DESIGN_BOX_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}


<div class="flex flex-col lg:grid lg:grid-cols-2 gap-6">

    {* Col 1 *}
    <div class="flex flex-col gap-6">

        <div class="px-6 py-5 border border-gray-200 rounded-xl">
            <h3 class="text-lg mb-3">{$text.CHECKOUT_RECIEPT}</h3>
            <div class="flex flex-col text-xs">
                {if $orderCustomer->Company}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.COMPANY}</span>
                        <span>{$orderCustomer->Company}</span>
                    </div>
                {/if}
                <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                    <span>{$text.NAME}</span>
                    <span>{$orderCustomer->Firstname} {$orderCustomer->Lastname}</span>
                </div>
                <div class="flex items-center justify-between py-1 border-b border-dashed border-gray-200 last:border-b-0">
                    <span>{$text.ADDRESS}</span>
                    <span>{$orderCustomer->Address}</span>
                </div>
                {if $orderCustomer->Address2}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.ADDRESS}</span>
                        <span>{$orderCustomer->Address2}</span>
                    </div>
                {/if}
                {if $orderCustomer->State}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.CITY}</span>
                        <span>{$orderCustomer->City}, {$orderCustomer->State} {$orderCustomer->Zip}, {$orderCustomer->Country}</span>
                    </div>
                {else}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.CITY}</span>
                        <span>{$orderCustomer->Zip} {$orderCustomer->City}, {$orderCustomer->Country}</span>
                    </div>
                {/if}
                {if $orderCustomer->Cvr}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.VAT_NR}</span>
                        <span>{$orderCustomer->Cvr}</span>
                    </div>
                {/if}
                {if $orderCustomer->Ean}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.EAN}</span>
                        <span>{$orderCustomer->Ean}</span>
                    </div>
                {/if}
                {if $orderCustomer->Phone}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.TELEPHONE}</span>
                        <span>{if $orderCustomer->CountryCode}+{$orderCustomer->CountryCode}{/if} {$orderCustomer->Phone}</span>
                    </div>
                {/if}
                {if $orderCustomer->Mobile}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.MOBILE}</span>
                        <span>{if $orderCustomer->CountryCode}+{$orderCustomer->CountryCode}{/if} {$orderCustomer->Mobile}</span>
                    </div>
                {/if}
                {if $orderCustomer->Email}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.MAIL}</span>
                        <span>{$orderCustomer->Email}</span>
                    </div>
                {/if}
                {if $orderCustomer->ExtendedDataExternal}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.EXTENDED_DATA}</span>
                        <span>{$orderCustomer->ExtendedDataExternal}</span>
                    </div>
                {/if}
            </div>
        </div>

        {if $orderCustomer->ShippingFirstname}

            <div class="px-6 py-5 border border-gray-200 rounded-xl">
                <h3 class="text-lg mb-3">{$text.CHECKOUT_DELIVERY_ADRESS}</h3>
                <div class="flex flex-col text-xs">
                    {if $orderCustomer->ShippingCompany}
                        <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                            <span>{$text.COMPANY}</span>
                            <span>{$orderCustomer->ShippingCompany}</span>
                        </div>
                    {/if}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.NAME}</span>
                        <span>{$orderCustomer->ShippingFirstname} {$orderCustomer->ShippingLastname}</span>
                    </div>
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.ADDRESS}</span>
                        <span>{$orderCustomer->ShippingAddress}</span>
                    </div>
                    {if $orderCustomer->ShippingAddress2}
                        <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                            <span>{$text.ADDRESS}</span>
                            <span>{$orderCustomer->ShippingAddress2}</span>
                        </div>
                    {/if}
                    {if $orderCustomer->ShippingState}
                        <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                            <span>{$text.CITY}</span>
                            <span>{$orderCustomer->ShippingZip} {$orderCustomer->ShippingCity}, {$orderCustomer->ShippingState} {$orderCustomer->ShippingCountry}</span>
                        </div>
                    {else}
                        <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                            <span>{$text.CITY}</span>
                            <span>{$orderCustomer->ShippingZip} {$orderCustomer->ShippingCity}, {$orderCustomer->ShippingCountry}</span>
                        </div>
                    {/if}
                    {if $orderCustomer->hippingPhone}
                        <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                            <span>{$text.TELEPHONE}</span>
                            <span>{if $orderCustomer->ShippingCountryCode}+{$orderCustomer->ShippingCountryCode}{/if} {$orderCustomer->ShippingPhone}</span>
                        </div>
                    {/if}
                    {if $orderCustomer->ShippingMobile}
                        <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                            <span>{$text.MOBILE}</span>
                            <span>{if $orderCustomer->ShippingCountryCode}+{$orderCustomer->ShippingCountryCode}{/if} {$orderCustomer->ShippingMobile}</span>
                        </div>
                    {/if}
                    {if $orderCustomer->ShippingEmail}
                        <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                            <span>{$text.MAIL}</span>
                            <span>{$orderCustomer->ShippingEmail}</span>
                        </div>
                    {/if}
                </div>
            </div>

        {/if}

        {if $order->ExternalComment or $order->CustomerComment or $order->DeliveryComment}
            <div class="px-6 py-5 border border-gray-200 rounded-xl">
                <h3 class="text-lg mb-3">{$text.COMMENTS}</h3>
                <div class="flex flex-col text-xs">
                    {if $order->ExternalComment}
                        <div>
                            {$order->ExternalComment}
                        </div>
                    {/if}
                    {if $order->CustomerComment}
                        <div>
                            {$order->CustomerComment}
                        </div>
                    {/if}
                    {if $order->DeliveryComment}
                        <div>
                            {$order->DeliveryComment}
                        </div>
                    {/if}
                </div>
            </div>
        {/if}

    </div>

    {* Col 2 *}
    <div class="flex flex-col gap-6">

        <div class="px-6 py-5 border border-gray-200 rounded-xl">
            <h3 class="text-lg mb-3">
                {if isset($invoiceId) && $order->Invoice}
                    {$text.MY_ORDERS_INVOICE}
                {else}
                    {$text.MY_ORDERS_LINES}
                {/if}
            </h3>
            <div class="flex flex-col text-xs">

                {if isset($invoiceId) && $order->Invoice}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.MY_ORDERS_INVOICE_NUMBER}</span>
                        <span>{$order->Invoice->Id}</span>
                    </div>
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.MY_ORDERS_INVOICE_DATE}</span>
                        <span>{$order->Invoice->Date|date_format:$text.DATE_FORMAT}</span>
                    </div>
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.MY_ORDERS_INVOICE_DUE_DATE}</span>
                        <span>{$order->Invoice->DueDate|date_format:$text.DATE_FORMAT}{if $order->Invoice->Paid} {$text.PAID}{/if}</span>
                    </div>
                {/if}

                <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                    <span>{$text.CHECKOUT_STEP_FIVE_ORDER_NUMBER}</span>
                    <span>{$order->Id}</span>
                </div>

                <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                    <span>{$text.CHECKOUT_STEP_FIVE_ORDER_DATE}</span>
                    <span>{$order->Date|date_format:$text.DATE_FORMAT}</span>
                </div>
                
                <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                    <span>{$text.CHECKOUT_STEP_FIVE_ORDER_PAYMENT_METHOD}</span>
                    <span>{$order->PaymentTitle}</span>
                </div>

                {if $order->CardType}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.CHECKOUT_PAYMENT_FORM_CARD_TYPE}</span>
                        <span>{$order->CardType}</span>
                    </div>
                {/if}

                {if !$checkout}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.MY_ORDERS_STATUS}</span>
                        <span>{translation id=$order->Status module='order_status_code' title='title'}</span>
                    </div>
                {/if}

                {if !empty($order->DeliveryTime) and $order->DeliveryTime != '0000-00-00 00:00:00'}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.CHECKOUT_STEP_TWO_TIME_OF_DELIVERY}</span>
                        <span>{$order->DeliveryTime|date_format:$text.DATE_FORMAT_SMARTY}</span>
                    </div>
                {/if}

                {if $order->TrackingCode}
                    {$trackings = explode(';', $order->TrackingCode)}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.MY_ORDERS_TRACKING}{if $order->ServiceType} ({$tracking->Title}){/if}</span>
                        <span class="flex flex-col gap-2">
                            {foreach $trackings as $trackingCode}
                                {if $trackingCode}
                                    <span class="flex gap-2">
                                        {if $order->ServiceType}
                                            <a href="{$tracking->getTrackingUrl($trackingCode)}" target="_blank" rel="noopener">
                                                <img src="/_design/common/img/icons/delivery/{$tracking->Icon->Filename}" alt="{$tracking->Title}" class="w-4">
                                                <span>{$trackingCode} </span>
                                            </a>
                                        {else}
                                            <span>{$trackingCode} </span>
                                        {/if}
                                    </span>
                                {/if}
                            {/foreach}
                        </span>
                    </div>
                {/if}

                {if $order->ReferenceNumber}
                    <div class="flex items-center justify-between py-1.5 border-b border-dashed border-gray-200 last:border-b-0">
                        <span>{$text.MY_ORDERS_REFERENCE_NUMBER}</span>
                        <span>{$order->ReferenceNumber}</span>
                    </div>
                {/if}
            </div>
        </div>

        {if $orderLine->getActualSize() gt 0}
            {if isset($orderList['CollectionOrderLine'])}

                <div class="px-6 py-5 border border-gray-200 rounded-xl">

                    <div class="flex flex-col gap-4">
                        
                        {foreach $orderList.CollectionOrderLine as $line}
                            
                            {$hasVatIncludedLabel = $currency.hasVat and ($settings.vat_label_advanced eq false or $line->Vat gt 0)}
                            {$link = null}
                            {if $line->Type != 'wrapping' and $line->Type != 'sale'}
                                {$link = $productController->link($line->ProductId)}
                            {/if}

                            {$productImage = null}
                            {$variantImage = null}
                            {if $line->ProductId && is_numeric($line->ProductId)}
                                {if $line->ProductId}
                                    {entity assign=productImage controller=files type=product productId=$line->ProductId}
                                {/if}
                                {if $line->VariantId}
                                    {entity assign=variantImage controller=files type=variant variantId=$line->VariantId}
                                {/if}

                                {if $variantImage}
                                    {$productImage = $variantImage->thumbnail($imageWidth, $imageHeight, true)|solutionPath}
                                {elseif $productImage}
                                    {$productImage = $productImage->thumbnail($imageWidth, $imageHeight, true)|solutionPath}
                                {else}
                                    {$productImage = $placeholder->getRelativeFile()|solutionPath}
                                {/if}
                            {/if}

                            <div class="flex items-center gap-4 relative">
                                <span class="absolute top-0 left-0 -translate-x-1/3 -translate-y-1/3 w-5 h-5 rounded-full bg-black text-white flex items-center justify-center font-bold text-[10px]">{$line->Amount}</span>
                                <figure class="w-16 flex-none">
                                    {if $productImage}
                                        <img src="{$productImage}" class="w-full rounded-lg" alt="{$line->ProductTitle}" itemprop="image" />
                                    {else}
                                        <img src="{$placeholder->getRelativeFile()|solutionPath}" class="w-full rounded-lg" alt="{$line->ProductTitle}" itemprop="image"/>
                                    {/if}
                                </figure>
                                <div class="flex-auto flex flex-col gap-1 text-sm">
                                    <strong itemprop="name">
                                        {$line->ProductTitle}
                                    </strong>

                                    {if $line->VariantTitle}
                                        <span class="text-xs">{$line->VariantTitle}</span>
                                    {/if}

                                    {if $line->CouponId}
                                        <div class="flex text-xs">
                                            <span>{$text.MY_ORDERS_NUMBER}: </span>
                                            <span>{$line->CouponId}</span>
                                        </div>
                                    {/if}

                                    {* {if $line->AdditionalTitle}
                                        <span class="text-xs">{$line->AdditionalTitle}</span>
                                    {/if} *}

                                    {if $line->PacketTitle}
                                        <span class="text-xs">{$line->PacketTitle}</span>
                                    {/if}

                                    {if isset($line->CouponTo)}
                                        <div class="flex">
                                            <span>{$text.GIFT_CARD_NAME}: </span>
                                            <span>{$line->CouponTo}</span>
                                        </div>
                                        {if isset($line->CouponCode)}
                                            <div class="flex">
                                                <span>{$text.GIFT_CARD_CODE}: </span>
                                                <span>{$line->CouponCode}</span>
                                            </div>
                                        {/if}
                                    {/if}
                                    {if isset($line->FileDownloadLink)}
                                        <span class="text-xs"><a href="/{$text.FILE_SALE_LINK}/{$line->FileDownloadLink}" target="_blank" rel="noopener">{$text.FILE_SALE_MENU}</a></span>
                                    {/if}

                                    {if $line->ItemNumber && $settings.shop_product_number eq true}
                                        <div class="flex text-xs">
                                            <span>{$text.PRODUCT_CATALOG_PRODUCT_NUMBER}: </span>
                                            <span>{$line->ItemNumber}</span>
                                        </div>
                                    {/if}
                                </div>
                                <div class="w-1/4 flex-none text-right text-xs">
                                    <div>
                                    {if $line->FullPrice == $line->Price}
                                        {($line->Price * $line->Amount)|formatPriceOrder:$orderId}
                                    {else}
                                        <s class="text-[10px]">{($line->FullPrice * $line->Amount)|formatPriceOrder:$orderId}</s><br>
                                        {($line->Price * $line->Amount)|formatPriceOrder:$orderId}
                                    {/if}
                                    </div>
                                </div>
                            </div>

                        {/foreach}

                    </div>
                    
                </div>
            {/if}
        {/if}

    </div>

</div>