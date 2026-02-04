{$field = null}
{if isset($request.verb)}
	{$field = $request.verb}
{elseif isset($request.input['field'])}
	{$field = $request.input.field}
{/if}

{$value = null}
{if isset($request.args[0])}
	{$value = $request.args.0}
{elseif isset($request.input['id'])}
	{$value = $request.input.id}
{/if}

{$output = []}
{$filterMap = null}
{$amount = 0}

{if $field}
	{controller assign=controller type=product}
	{controller assign=categoryController type=productCategory}
	{controller assign=reviewController type=productReview}

	{$products = null}

	{if $field eq 'id'}
		{if $value}
			{$value = explode(',', $value)}
			{collection assign=products controller=$controller productId=$value}
			{$amount = $products->getActualSize()}
			{$productIds = $products->getCollectionIds()}
		{/if}

	{** If no field is recognised in the URI segment for VERB, assign the VERB value as a parameter to ProductListController **}
	{else}

		{$options = []}

		{*** For internal reference purpose, make sure the controller is using a static categoryMap to look up categories ***}
		{$options['categoryMap'] = true}

		{*** If a 'tag' was included we need to prepare the value ***}
		{if $field eq 'tag'}
			{$argOptions = explode(';', $value)}
			{if $argOptions|count gt 1}
				{$options['tagType'] = $argOptions[1]}
			{/if}
			{$value = $argOptions[0]}
		{/if}

		{*** Special case for 'orderBy' field, which needs a second parameter if $arg is 'OnSale' ***}
		{if $field eq 'orderBy' and $value eq 'OnSale'}

			{*** Set $arg to -Sold to order by most sold products ***}
			{$value = 'Age'}

			{*** Set extra option to make sure only products on sale are displayed ***}
			{$options['sale'] = true}

		{/if}

		{if $field eq 'sale' or $field eq 'new'}
		    {$value = 1}
		{/if}

		{$options[$field] = $value}

		{$options['filter'] = $request.input.filter|stripslashes|utf8_encode|json_decode:true}

		{if isset($request.input['page'])}
			{$options['page'] = $request.input.page}
		{/if}

		{if isset($request.input['limit'])}
			{$options['pageSize'] = $request.input.limit}
		{/if}

		{if isset($request.input['orderBy'])}
			{$options['orderBy'] = $request.input.orderBy}
		{/if}

		{if isset($request.input['lastUpdated'])}
			{$options['lastUpdated'] = $request.input.lastUpdated}
		{/if}

		{if isset($request.input['filterGenerate'])}
			{$filterGenerate = $request.input['filterGenerate']}
		{else}
			{$filterGenerate = false}
		{/if}

		{$options['filterGenerate'] = $filterGenerate}

		{if isset($request.input['forTopList'])}
			{$options['forTopList'] = $request.input['forTopList']}
		{/if}

		{controller assign=productListController type=productList}
		{collection assign=productlist controller=$productListController options=$options}

		{if $productlist->getActualSize() gt 0}

			{*** Get actual amount of products before overwriting the collection with product data ***}
			{$amount = $productlist->getActualSize()}
			{$productIds = $productlist->getCollectionIds()}

			{*** Fetch filtered and final product list ***}
			{collection assign=products controller=$controller productId=$productlist->pluck('Id')}
		{/if}
		{$filterMap = $productListController->getFilterMap()}
	{/if}

	{if $products and $products->getActualSize() gt 0}

		{$imageWidth = 320}
		{if isset($request.input['imageWidth'])}
			{$imageWidth = $request.input.imageWidth}
		{/if}

		{$imageHeight = 320}
		{if isset($request.input['imageHeight'])}
			{$imageHeight = $request.input.imageHeight}
		{/if}

		{$imageCrop = 'fill'}
		{if isset($request.input['imageCrop'])}
			{$imageCrop = $request.input.imageCrop}
		{elseif !empty($template.settings.DESIGN_IMAGE_BACKGROUND_COLOR)}
			{$imageCrop = $template.settings.DESIGN_IMAGE_BACKGROUND_COLOR}
		{/if}

		{$pageLink = PageController::link($page.productPageId)}

		{* Preload related product entities to optimize load times *}
		{include file='modules/json/products-preload.tpl' scope=parent}

		{foreach $products->getData() as $k => $product}

			{$product = (array)$product}

			{$product['Handle'] = ProductController::link($product.Id, false, $product)}

			{* If the Handle is null this means the product is not available on this site due to blank title of either parent category or page *}
			{if $product['Handle'] === null}
				{continue}
			{/if}

			{* Stock reservation calculation *}
			{$product['StockWithoutReservation'] = $product['Stock']}
			{$product['Stock'] = $product['Stock'] - $product['StockReservation']}

			{$product['BuyingPrice'] = false}

			{if $access.reviews}
				{$product['AverageRating'] = $reviewController->getAverageRating($product.Id)}
			{else}
				{$product['AverageRating'] = false}
			{/if}

			{$categoryTitle = null}
			{if !empty($product.CategoryId)}
				{entity assign=category controller=$categoryController categoryId=$product.CategoryId}
				{if $category}
					{$categoryTitle = $category->Title}
				{/if}
			{/if}
			{$product['CategoryTitle'] = $categoryTitle}

			{$brandTitle = null}
			{$brandLink = null}
			{$brandImage = null}
			{if !empty($product.ProducerId)}
				{entity assign=brand controller=$brandController id=$product.ProducerId}
				{if $brand}
					{entity assign=brandImage controller=files type=brand id=$brand->Id}
					{if $brandImage}
						{$brandImage = $brandImage->thumbnail(100,100)|solutionPath}
					{/if}
					{$brandTitle = $brand->Title}
					{$brandTitleLink = $brandTitle|formatLink}
					{$brandLink = $pageLink|cat:'?brand='|cat:$brand->Id|cat:'-'|cat:$brandTitleLink}
				{/if}
			{/if}
			{$product['ProducerTitle'] = $brandTitle}
			{$product['ProducerHandle'] = $brandLink}
			{$product['ProducerImage'] = $brandImage}

			{$product['Images'] = []}
			{collection assign=images controller=$filesController type=product productId=$product.Id}
			{if $images->getActualSize() gt 0}
				{foreach $images->getData() as $image}
					{$product['Images'][] = $image->thumbnail($imageWidth, $imageHeight, $imageCrop, null)}
				{/foreach}
			{else}
				{placeholdImage assign=placeholder width=$imageWidth height=$imageHeight background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}
				{$product['Images'][] = $placeholder->getRelativeFile()}
			{/if}

			{$product['UnitTitle'] = $controller->getUnitTitle($product.UnitId)}

			{$product['DescriptionList'] = $controller->getDescriptionList($product.Id)|htmlentities|replace:'class="responsive"':''}

			{$stocktext = null}
			{$stocktextSoldout = null}
			{if $product.DeliveryTimeId gt 0}
				{$stocktextSoldout = $controller->getDeliveryTime($product.DeliveryTimeId, false)}
				{$stocktext = $controller->getDeliveryTime($product.DeliveryTimeId)}
			{else}
				{$stocktextSoldout = $text.PRODUCT_CATALOG_STOCK_NOT_HOME}
				{$stocktext = $text.PRODUCT_CATALOG_STOCK_HOME}
			{/if}
			
			{$product['DeliveryTimeTexts'] = [
				'inStock' => $stocktext,
				'notInStock' => $stocktextSoldout
			]}

			{if $product.Soldout}
				{$product['DeliveryTimeText'] = $stocktextSoldout}
			{else}
				{$product['DeliveryTimeText'] = $stocktext}
			{/if}

			{$variantTypeArray = []}
			{collection assign=variantTypes controller=$variantTypeController productId=$product.Id}
			{$product['HasMultipleVariants'] = $variantTypes->getActualSize() gt 1}
			{if $variantTypes->getActualSize() > 0}
				{foreach $variantTypes->getData() as $variantType}
					{if $variantType->Id == 1 || $variantType->Id == 8}
						{collection assign=variantData controller=productVariantData typeId=$variantType->Id productId=$product.Id}
						{$variantDataArray = []}
						{if $variantData->getActualSize() gt 0}
							{foreach $variantData->getData() as $variantData}

								{entity assign=productVariant controller=productVariant productId=$product.Id dataIds=$variantData->Id}
								{$variantData['VariantData'] = $productVariant}
								{$fileId = $productVariant->FileId}
								{$variantData['FileId'] = $fileId}
								{entity assign=productVariantImage controller=files productId=$product.Id type=variant id=$fileId}

								{if !$productVariantImage}
									{placeholdImage assign=placeholder width=60 height=60 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}
									{$variantData['Image'] = $placeholder->getRelativeFile()}
								{else}
									{$variantData['Image'] = $productVariantImage->thumbnail(60,60)|solutionPath}
								{/if}

								{$variantDataArray[] = $variantData}
							{/foreach}
						{/if}

						{$variantTypeArray[] = ['Id' => $variantType->Id, 'Title' => $variantType->Title, 'Data' => $variantDataArray]}
					{/if}
				{/foreach}
			{/if}
			{$product['VariantTypes'] = $variantTypeArray}

			{collection assign=additionals controller=$productAdditionalTypeController productId=$product.Id}
			{$product['AdditionalTypes'] = $additionals->getData()}

			{* Visible price *}
			{setting assign=priceSetting key=shop_b2b_hidden_prices}

			{$showPrices = true}
			{if $product.CallForPrice or ($priceSetting === true and empty($user))}
				{$showPrices = false}
			{/if}

			{$product['ShowPrices'] = $showPrices}

			{$product['VariantDisplayMode'] = "buttons"}

			{* Extra fields *}
			{$customDataTypes = []}
			{collection assign=productCustomDataTypes controller=productCustomDataType productId=$product.Id}
			{foreach $productCustomDataTypes->getData() as $type}
				{$customData = []}
				{collection assign=productCustomDatas controller=productCustomData typeId=$type->Id productId=$product.Id}
				{foreach $productCustomDatas->getData() as $data}
					{$dataTitle = $data->Title}
					{if $type->Id == 7}
						{$dataTitle = ' ('|explode:$data->Title}
						{$dataTitle = $dataTitle[0]}
					{/if}
					{$customData[] = $dataTitle}
				{/foreach}
				{$customDataTypes[$type->Id] = ['Title' => $type->Title, 'Data' => $customData]}
			{/foreach}
			{$product['CustomTypes'] = $customDataTypes}

			{* Badges *}
			{$badges = []}
			{if $customDataTypes[8].Data[0]}
				{$badgesArray = '::'|explode:$customDataTypes[8].Data[0]}
				{foreach $badgesArray as $badge}
					{$badgeEntities = ':'|explode:$badge}
					{$badges[] = [
						'Title' => $badgeEntities[0],
						'Background' => $badgeEntities[1]|trim,
						'Color' => $badgeEntities[2]|trim
					]}
				{/foreach}
			{/if}
			{$product['Badges'] = $badges}

			{* Buyable *}
			{$buyable = $product.ShowPrices}

			{if $buyable}
				{if $product.Type != 'normal' and $product.Type != 'variant' and $product.Type != 'filesale'}
					{$buyable = false}

				{elseif !empty($product.AdditionalTypes)}
					{$buyable = false}

				{elseif !$product.AllowOutOfStockPurchase and $product.Soldout}
					{$buyable = false}

				{elseif $priceSetting === 'partly' and empty($user)}
					{$buyable = false}

				{elseif $product.CallForPrice}
					{$buyable = false}

				{elseif $product.Type eq 'variant' and $product.VariantDisplayMode == 'orderlist'}
					{$buyable = false}
				{/if}
			{/if}

			{$product['Buyable'] = $buyable}

			{* Savings percentage *}
			{if $product.Prices[0]->FullPriceMin - $product.Prices[0]->PriceMin !== 0}
				{$savingsPercentage = ($product.Prices[0]->FullPriceMin - $product.Prices[0]->PriceMin) / $product.Prices[0]->FullPriceMin * 100}
				{$product['Savings'] = $savingsPercentage|number_format:0}
			{/if}
			
			{$output[] = $product}

		{/foreach}
	{/if}
{/if}

{$output = ['amount' => $amount, 'productIds' => $productIds, 'products' => $output, 'filterMap' => $filterMap]}

{$output|jsonify}
