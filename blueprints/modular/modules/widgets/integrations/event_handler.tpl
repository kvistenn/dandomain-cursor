{*

# Description
Google Analytics widget for handling the events tracking


## Date last modified
2024-02-12


## Primary variables
+ $settings                                                             - Global scope variable containing platform settings
+ $page                                                                 - Global scope variable containing all information about the page type


## Partials (templates)
No extra templates required for this template

*}

{$cookiesAllowed = isset($cookieConsent.consent) && $cookieConsent.consent['STATISTICS']}

{function convert value=''}{if is_string($value)}{str_replace('"','\"', $value)}{else}{$value}{/if}{/function}

<script>
    {literal}
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        var gtagConfigs = {
            'anonymize_ip': true
        };

        if (sessionStorage.getItem('referrer') !== null) {
            gtagConfigs['page_referrer'] = sessionStorage.getItem('referrer');
            sessionStorage.removeItem('referrer');
        }
    {/literal}

    {if !empty($settings.api_google_analytics_transport_url)}
        gtagConfigs['transport_url'] = '{$settings.api_google_analytics_transport_url}';
    {/if}

    {include file="modules/widgets/integrations/google_consent_mode.tpl"}

    {if !empty($settings.api_google_analytics)}
        gtag('config', '{$settings.api_google_analytics}', gtagConfigs);
    {/if}

    {* Enhanced ecommerce - Track product details view *}
    {if $page.isProduct && isset($page.paths.2)}
        if ( window.platform && window.platform.subscribe ) {
            window.platform.subscribe("/product/ready", function(event, data) {
                var product = data;

                if (product.Type === "variant") {
                    window.platform.subscribe("/product/variant/selected", function(event, data) {
                        trackEvent(product, data[0]);
                    });
                } else {
                    trackEvent(product, false);
                }

                function trackEvent (product, variant) {
                    var item = {
                        'id': String(product.Id),
                        'name': product.Title,
                        "currency": "{$general.currencyIso}",
                        'category': product.CategoryTitle ? product.CategoryTitle : ''
                    };

                    if ( product.Prices && product.Prices.length ) {
                        item.price = product.Prices[0].PriceMin;
                    }

                    if ( variant ) {
                        item.id = (variant.ItemNumber) ? variant.ItemNumber : item.id+ "-" +variant.Id;
                        item.variant = variant.Title;
                        item.price = variant.Price ? variant.Price.PriceMin : '0';
                    } else if ( product.ItemNumber ) {
                        item.id = product.ItemNumber;
                    }

                    if ( product.ProducerTitle ) {
                        item.brand = product.ProducerTitle;
                    }

                    if ( !product.Buyable ) {
                        item.price = '0';
                    } else {
                        item.price = String( variant ? variant.Price.PriceMin : product.Prices[0].PriceMin );
                    }

                    gtag('event', 'view_item', { "items": [ item ] });
                };

            });
        }
    {/if}

    {* Enhanced ecommerce - Track additions to and removals from shopping cart or checkout begin *}
    {$isAddCart = ( $message && in_array($message->type(), ["cart_update_success", "cart_plus_success", "cart_reorder_one_success", "cart_reorder_all_success", "cart_add_variant_success", "cart_add_success"]))}
    {$isCheckoutBegin = ($page.isCheckout and !isset($smarty.get.approved) and !isset($smarty.get.declined))}
    {if $isAddCart OR $isCheckoutBegin}
        {$trackingEvent = 'begin_checkout'}
        {if $isAddCart}
            {$trackingEvent = 'add_to_cart'}
        {/if}

        if ( window.platform && window.platform.subscribe ) {
            window.platform.subscribe("/cart/ready", function(event, data) {
                var items = [],
                    item = {},
                    product = {},
                    cart = data;

                for(var i = 0, length1 = cart.CartProduct.length; i < length1; i++){
                    product = cart.CartProduct[i],
                    item = {
                        'id': String( product.VariantId ? product.VariantId+ "-" +product.ProductId : product.ProductId ),
                        'name': product.Title,
                        'category': product.CategoryTitle,
                        'quantity': product.Amount
                    };

                    if ( product.ItemNumber ) {
                        item.id = product.ItemNumber;
                    }

                    if ( product.VariantId ) {
                        item.variant = product.VariantTitle;
                    }

                    if ( product.ProducerTitle ) {
                        item.brand = product.ProducerTitle;
                    }

                    if ( product.CartBlocker ) {
                        item.price = '0';
                    } else {
                        item.price = String(product.Price);
                    }
                    items.push(item);
                }

                gtag('event', '{$trackingEvent}', { "items": items });

                {if $trackingEvent == 'begin_checkout'}
                    gtag('event', 'checkout_progress', { "items": items });
                {/if}
            });
        }
    {elseif $message && $message->type() == "cart_delete_success"}

        {$cartProduct = $message->ItemId()}

        {*** Product ***}
        {entity assign=product controller=product type=product id=$cartProduct.product}

        {*** Variant ***}
        {$cartVariantTitle = ''}
        {if $cartProduct.variant}
            {entity assign=variant controller=productVariant productId=$cartProduct.product variantId=$cartProduct.variant}

            {collection assign=variantTypes controller=productVariantType productId=$cartProduct.product variantId=$cartProduct.variant}

            {foreach $variantTypes->getData() as $variantType}
                {entity assign=variantData controller=productVariantData productId=$cartProduct.product variantId=$cartProduct.variant typeId=$variantType->Id}

                {$cartVariantTitle = $cartVariantTitle|cat:" "|cat:$variantData->Title}
            {/foreach}
        {/if}

        {*** Category ***}
        {entity assign=category controller=productCategory id=$product->CategoryId}

        {*** Brand ***}
        {if $product->ProducerId}
            {entity assign=brand controller=brand id=$product->ProducerId}
        {/if}

        gtag('event', 'remove_from_cart', {
            "items": [
                {
                    {if $cartProduct.variant}
                        {if $variant->ItemNumber}
                            "id": "{convert value=$variant->ItemNumber}",
                        {else}
                            "id": "{$cartProduct.product}-{$cartProduct.variant}",
                        {/if}
                    {else}
                        {if $product->ItemNumber}
                            "id": "{convert value=$product->ItemNumber}",
                        {else}
                            "id": "{convert value=$cartProduct.product}",
                        {/if}
                    {/if}
                    "name": "{convert value=$product->Title|trim|html_entity_decode}",
                    {if !empty($brand)}
                        "brand": "{convert value=$brand->Title|trim|html_entity_decode}",
                    {/if}
                    "category": "{convert value=$category->Title|trim|html_entity_decode}",
                    {if $cartProduct.variant}
                        "variant": "{convert value=$cartVariantTitle|trim|html_entity_decode}",
                    {/if}
                    "quantity": {$cartProduct.amount}
                }
            ]
        });
    {/if}

    {* Enhanced ecommerce - Track purchases *}
    {if $page.isCheckout && isset($smarty.get.approved) && !empty($page.orderId)}

        {* Order entity *}
        {entity controller=order assign=order id=$page.orderId userId=false statusId=false}

        {* Implementation to avoid double registering of orders *}
        {if !$order->JavascriptConfirmationLoaded}
            {if !isset($repay)}
                {$repay = false}
            {/if}

            {* Order Lines collection *}
            {collection controller=orderLine assign=orderLine orderId=$page.orderId repay=$repay}

            {* Group order collection by class *}
            {$orderList = $orderLine->groupByClass()}

            {* Different calculations with or without vat, with or without payment fee and with or without delivery fee *}
            {if $settings.google_analytics_tracking_type == 'OrderTotalExclVat'
            || $settings.google_analytics_tracking_type == 'OrderTotalExclVatExclFee'}
                {$orderValue = $orderList.CollectionOrderSubTotalLineWithoutVat.0->Price}
                {if $settings.google_analytics_tracking_type == 'OrderTotalExclVatExclFee'}
                    {* Order total excl. VAT, excl. delivery line and payment line *}
                    {$orderValue = $orderValue - $orderList.CollectionOrderDeliveryLine.0->PriceWithoutVat}
                {else}
                    {* Order total excl. VAT, incl. delivery line and payment line *}
                    {$orderValue = $orderValue + $orderList.CollectionOrderPaymentLine.0->PriceWithoutVat}
                {/if}
            {else}
                {$orderValue = $orderList.CollectionOrderSubTotalLineWithVat.0->Price}
                {if $settings.google_analytics_tracking_type == 'OrderTotalInclVatExclFee'}
                    {* Order total incl. VAT, excl. delivery line and payment line *}
                    {$orderValue = $orderValue - $orderList.CollectionOrderDeliveryLine.0->PriceWithVat}
                {else}
                    {* Order total incl. VAT, incl. delivery line and payment line *}
                    {$orderValue = $orderValue + $orderList.CollectionOrderPaymentLine.0->PriceWithVat}
                {/if}
            {/if}

            gtag('event', 'purchase', {
                "transaction_id": "{$order->Id}",
                "affiliation": "{$general.domain}",
                "value": "{number_format((float)$orderValue, 2, '.', '')}",
                "currency": "{$general.currencyIso}",
                "tax": "{$orderList.CollectionOrderVatTotalLine.0->Price}",
                "shipping": "{$orderList.CollectionOrderDeliveryLine.0->Price}",
                "items": {strip}[
                {if $orderLine->getActualSize() gt 0}
                    {if isset($orderList['CollectionOrderLine'])}
                        {foreach $orderList.CollectionOrderLine as $line}
                            {
                                {*** Category ***}
                                {entity assign=category controller=productCategory productId=$line->ProductId}
                                {if !empty($category)}
                                "category": "{convert value=$category->Title|trim|html_entity_decode}",
                                {/if}

                                {*** Brand ***}
                                {entity assign=brand controller=brand productId=$line->ProductId}
                                {if !empty($brand)}
                                    "brand": "{convert value=$brand->Title|trim|html_entity_decode}",
                                {/if}

                                {if $line->ItemNumber}
                                    "id": "{convert value=$line->ItemNumber}",
                                {else}
                                    {if $line->VariantId}
                                        "id": "{$line->ProductId}-{$line->VariantId}",
                                    {else}
                                        "id": "{$line->ProductId}",
                                    {/if}
                                {/if}
                                "name": "{convert value=$line->ProductTitle|html_entity_decode}",
                                {if $line->VariantTitle}
                                    "variant": "{convert value=$line->VariantTitle|trim|html_entity_decode}",
                                {/if}

                                "price": "{$line->Price}",
                                "quantity": "{$line->Amount}"
                            }{if !$line@last}, {/if}
                        {/foreach}
                    {/if}
                {/if}
                ]{/strip}
            });
        {/if}
    {/if}
</script>