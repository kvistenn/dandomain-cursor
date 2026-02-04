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

        {controller assign=controller type=product}
        {entity assign=product controller=$controller id=$compareId}

        {if !$product}
            {continue}
        {/if}

        {$compareProduct['Title'] = $product->Title}
        {$compareProduct['ItemNumber'] = $product->ItemNumber}
        {$compareProduct['Id'] = $product->Id}
        
        {$compareProduct['Price'] = $product->Prices[0]->PriceMax}
        {$compareProduct['FullPrice'] = $product->Prices[0]->FullPriceMax}

        {entity assign=productImage controller=files type=product productId=$product->Id}

        {if $productImage}
            {$compareProduct['Image'] = $productImage->thumbnail(320, 320)|solutionPath}
        {else}
            {$compareProduct['Image'] = $placeholder->getRelativeFile()|solutionPath}
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

        {$compareProduct['StockText'] = $text.PRODUCT_CATALOG_STOCK_HOME}
        {if $product->Stock == 0 && $settings.shop_product_out_of_stock_buy == false}
            {$compareProduct['StockText'] = $text.PRODUCT_CATALOG_STOCK_NOT_HOME}
        {/if}

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

        {$customDataTypes = []}
        {$typeExceptions = explode(',', $template.settings.COMPARE_CUSTOM_TYPE_EXCEPTIONS)}
        {collection assign=productCustomDataTypes controller=productCustomDataType}
        {foreach $productCustomDataTypes->getData() as $type}
            
            {if $type->Display == false}
                {continue}
            {/if}

            {$customData = []}

            {if $type->Title|strstr:'|'}
                {$Specs = explode('|', $type->Title)}
                {$typeSection = $Specs[0]}
                {$typeTitle = $Specs[1]}
            {else}
                {$typeTitle = $type->Title}
            {/if}

            {$typeData[] = ['typeId' => $type->Id, 'hasData' => false]}

            {collection assign=productCustomDatas controller=productCustomData typeId=$type->Id productId=$product->Id}
            {foreach $productCustomDatas->getData() as $data}
                {$dataTitle = $data->Title}
                {$customData[] = $dataTitle}
                {if $data->Title}
                    {$typeData[] = ['typeId' => $type->Id, 'hasData' => true]}
                {/if}
            {/foreach}

            {$customDataTypes[] = ['Title' => $typeTitle, 'Section' => $typeSection, 'Data' => $customData, 'Id' => $type->Id]}
        {/foreach}

        {$compareProduct['CustomTypes'] = $customDataTypes}
        {$compareProduct['TypeData'] = $typeData}

        {$shortDescription = ""}
        {$descriptionShort = $controller->getDescriptionShort($product->Id)}
        {if !empty($descriptionShort)}
            {$shortDescription = $descriptionShort|strip_tags|truncate:150}
        {/if}
        {$compareProduct['ShortDescription'] = $shortDescription}

        {$output[] = $compareProduct}

    {/foreach}
{/if}

{* Handle typeData, if one is true output the id *}
{foreach $output as $k => $product}
    {$typeData = $product['TypeData']}
    {$typeDataIds = []}
    {foreach $typeData as $type}
        {if $type['hasData'] == true}
            {$typeDataIds[] = $type['typeId']}
        {/if}
    {/foreach}
    {$activeTypes = $typeDataIds}
{/foreach}

{* Remove the non active from the compareProduct list *}

{foreach $output as $k => $product}
    {$typeData = $product['TypeData']}
    {$newCustomTypes = []}
    {foreach $product['CustomTypes'] as $type}
        {if in_array($type['Id'], $activeTypes) == true}
            {$newCustomTypes[] = $type}
        {/if}
    {/foreach}
    {$output[$k]['CustomTypes'] = $newCustomTypes}
{/foreach}

{$output = [
    'CompareURL' => $compareUrl,
    'CompareIds' => $compareIds,
    'CompareProduct' => $output,
    'ActiveTypes' => $activeTypes
]}

{$output|jsonify}