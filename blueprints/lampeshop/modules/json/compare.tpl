{$output = []}

{$compareIds = []}
{if $smarty.cookies.compare}
    {$compareIds = ','|explode:($smarty.cookies.compare|escape:'html':'UTF-8')}
{/if}

{if $compareIds|count > 0}

    {placeholdImage assign=placeholder width=320 height=320}
    {$pageLink = PageController::link($page.productPageId)}
    
    {foreach $compareIds as $k => $compareId}

        {$compareProduct = (array)[]}

        {entity assign=product controller=product id=$compareId}
        {if $product}
        {$compareProduct['Title'] = $product->Title}
        {$compareProduct['ItemNumber'] = $product->ItemNumber}
        {$compareProduct['Id'] = $product->Id}
        
        {$compareProduct['Price'] = $product->Prices[0]->PriceMax}
        {$compareProduct['FullPrice'] = $product->Prices[0]->FullPriceMax}

        {entity assign=productImage controller=files type=product productId=$product->Id}

        {if $productImage}
            {$compareProduct['Image'] = $productImage->thumbnail(320, 320)|solutionPath}
        {else}
            {$compareProduct['Image'] = $placeholdImage->thumbnail(320, 320)|solutionPath}
        {/if}

        {$brandTitle = null}
        {$brandLink = null}
        {if !empty($product->ProducerId)}
            {entity assign=brand controller=brand id=$product->ProducerId}
            {if $brand}
                {$brandTitle = $brand->Title}
                {$brandTitleLink = $brandTitle|formatLink}
                {$brandLink = $pageLink|cat:'?brand='|cat:$brand->Id|cat:'-'|cat:$brandTitleLink}
            {/if}
        {/if}
        {$compareProduct['ProducerTitle'] = $brandTitle}
        {$compareProduct['ProducerHandle'] = $brandLink}

        {$categoryTitle = null}
        {$categoryLink = null}
        {if !empty($product->CategoryId)}
            {entity assign=category controller=productCategory id=$product->CategoryId}
            {if $category}
                {$categoryTitle = $category->Title}
                {$categoryLink = $pageLink|cat:$category->Handle|cat:'/'}
            {/if}
        {/if}
        {$compareProduct['CategoryTitle'] = $categoryTitle}
        {$compareProduct['CategoryHandle'] = $categoryLink}

        {collection assign=productCustomDatas controller=productCustomData productId=$product->Id typeId=17}			
        {if $productCustomDatas && $productCustomDatas->getActualSize() gt 0}
                {foreach $productCustomDatas->getData() as $productCustomData}
                        {$compareProduct['remoteStock'] = (int)$productCustomData->Title}
                {/foreach}
            {else}
            {$compareProduct['remoteStock'] = 0}
        {/if}

        {if $product->Stock == 0}
            {$compareProduct['StockText'] = $text.PRODUCT_CATALOG_STOCK_NOT_HOME}
            {elseif $compareProduct['remoteStock'] gt 0}
            {$compareProduct['StockText'] = $text.PRODUCT_REMOTE_INSTOCK}
            {else}
            {$compareProduct['StockText'] = $text.PRODUCT_CATALOG_STOCK_HOME}
        {/if}

        
        {collection assign=variantTypes controller=productVariantType productId=$product->Id}
        {$compareProduct['VariantTypes'] = $variantTypes->getData()}

        {collection assign=additionals controller=productAdditionalType productId=$product->Id}
        {$compareProduct['AdditionalTypes'] = $additionals->getData()}

        {* Variant data *}
        {if $compareProduct['VariantTypes']|@count > 0}
            
            {controller assign=variantCtrl type=productVariant}
            {collection assign=customVariantOptions controller=$variantCtrl productId=$product->Id}
            {if $customVariantOptions->getActualSize() gt 0}
                {foreach $customVariantOptions->getData() as $option}
                    {$option['ShortDescription'] = $variantCtrl->getDescriptionShort({$option->Id})}
                    {entity assign=variantDatasFromId controller=productVariantData productId=$product->Id variantId=$option->Id}
                    {$option['data'] = $variantDatasFromId}
                    {$compareProduct['VariantData'][] = $option}
                {/foreach}
            {/if}
        {/if}

        {$typeExceptions = [17,16,15,19,20,23,24]}
        
        {collection assign=productCustomDataTypes controller=productCustomDataType productId=$product->Id}
        {foreach $productCustomDataTypes->getData() as $productCustomDataType}
            {collection assign=productCustomDatas controller=productCustomData productId=$product->Id typeId=$productCustomDataType->Id}
            {if $productCustomDatas->getActualSize() gt 0}
                {foreach $productCustomDatas->getData() as $productCustomData}
                   {if $productCustomData->Title == 'null'}
                        {$typeExceptions[] = $productCustomDataType->Id}
                   {/if}
                {/foreach}
            {/if}
        {/foreach}
        
        {foreach $productCustomDataTypes->getData() as $productCustomDataType key=$k}
                {collection assign=productCustomDatas controller=productCustomData productId=$product->Id typeId=$productCustomDataType->Id}
                {if $productCustomDatas->getActualSize() gt 0 and !in_array($productCustomDataType->Id, $typeExceptions)}
                {$compareProduct['CustomDatas'][$k]['title'] = $productCustomDataType->Title}
                {foreach $productCustomDatas->getData() as $productCustomData}
                    {$compareProduct['CustomDatas'][$k]['data'][] = $productCustomData->Title}
                {/foreach}
                {else}
                    {$compareProduct['CustomDatas'][$k]['title'] = null}
                    {$compareProduct['CustomDatas'][$k]['data'] = null}

                {/if}
        {/foreach}

        {$compareProduct['Handle'] = $categoryLink|cat:$product->Handle|cat:'/'}

        {if $access.reviews}
            {controller assign=reviewController type=productReview}
            {$compareProduct['AverageRating'] = $reviewController->getAverageRating($product->Id)}

            {$AverageRatingArray = []}
            {for $i = 0 to 4}
                {if $i < $compareProduct['AverageRating']}
                    {$AverageRatingArray[] = ['fill' => 'true', 'index' => $i]}
                {else}
                    {$AverageRatingArray[] = ['fill' => 'false', 'index' => $i]}
                {/if}
            {/for}
            {$compareProduct['AverageRatingArray'] = $AverageRatingArray}
        {else}
            {$compareProduct['AverageRating'] = false}
            {$compareProduct['AverageRatingArray'] = []}
        {/if}

  
        {$output[] = $compareProduct}

        {/if}

    {/foreach}
{/if}

{$output = [
    'CompareIds' => $compareIds,
    'CompareProduct' => $output
]}

{$output|jsonify}