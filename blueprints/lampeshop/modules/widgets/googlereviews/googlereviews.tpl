{* Get the order and order lines *}
{entity controller=order assign=order id=$page.orderId}
{collection controller=orderLine assign=orderLine orderId=$page.orderId}
{$orderList = $orderLine->groupByClass()}

{* Get the GTINs of the products in the order *}
{if $orderLine->getActualSize() gt 0}
    {if isset($orderList['CollectionOrderLine'])}
        {$GTIN['products'] = []}
        {foreach $orderList.CollectionOrderLine as $line}
            {if $line->ItemNumber}
                {$GTIN['products'][] = ['gtin' => $line->ItemNumber]}
            {/if}
        {/foreach}
    {/if}
{/if}

<!-- BEGIN GCR Opt-in Module Code -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderOptIn" async defer></script>

<script>

    let emailCopy = $('.w-email').clone();
    emailCopy.find('.w-text').remove();
    emailCopy.find('.w-colon').remove();

    let email = emailCopy.text().trim();
    let country = $('.w-country').text().trim();
    let estimatedDeliveryTime = new Date();
    let nowDate = new Date();
    let sendDate = new Date();

    // Make date YYYY-MM-DD in jquery
    estimatedDeliveryTime = estimatedDeliveryTime.toISOString().split('T')[0];

    sendDate.setDate(nowDate.getDate() + googleReviews.delayInStock);

    // Convert sendDate to YYYY-MM-DD
    sendDate = sendDate.toISOString().split('T')[0];

    window.renderOptIn = function() {
        window.gapi.load('surveyoptin', function() {
            window.gapi.surveyoptin.render({
                "merchant_id": googleReviews.googleMerchantId,
                "order_id": platform.page.orderId,
                "email": email,
                "delivery_country": country,
                "estimated_delivery_date": sendDate,
                "products":{$GTIN['products']|json_encode}
            });
        });
    }
</script>
<script>
    window.___gcfg = {
        lang: '{$general.languageIso639}'
    };
</script>