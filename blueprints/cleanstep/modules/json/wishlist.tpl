{$output = []}

	{entity assign=wishlist user=$user controller=wishlist}
	{$wishlistLines = $wishlist->WishlistLines}

	{placeholdImage assign=placeholder width=64 height=64}

	{if $wishlistLines|@count > 0}

		{$pageLink = PageController::link($page.productPageId)}

	    {foreach $wishlistLines as $k => $wishlistProduct}

			{$wishlistProduct = (array)$wishlistProduct}

	        {entity assign=product controller=product type=product id=$wishlistProduct.ProductId}
			
			{if $product}
				
			{entity assign=productImage controller=files type=product productId=$wishlistProduct.ProductId}
	        {$wishlistProduct['Title'] = $product->Title}

			{$wishlistProduct['Price'] = $product->Prices[0]->PriceMax}
			{$wishlistProduct['FullPrice'] = $product->Prices[0]->FullPriceMax}

			{collection assign=productCustomDatas controller=productCustomData productId=$wishlistProduct.ProductId typeId=17}			
			{if $productCustomDatas && $productCustomDatas->getActualSize() gt 0}
					{foreach $productCustomDatas->getData() as $productCustomData}
							{$compareProduct['remoteStock'] = (int)$productCustomData->Title}
					{/foreach}
				{else}
				{$compareProduct['remoteStock'] = 0}
			{/if}

			{if $product->Stock == 0}
				{$wishlistProduct['StockText'] = $text.PRODUCT_CATALOG_STOCK_NOT_HOME}
			{else}
				{$wishlistProduct['StockText'] = $text.PRODUCT_CATALOG_STOCK_HOME}
			{/if}

	        {if $wishlistProduct.VariantId && $variantImage}
	        	{$wishlistProduct['Image'] = $variantImage->thumbnail(64, 64)|solutionPath}
	        {elseif $productImage}
	        	{$wishlistProduct['Image'] = $productImage->thumbnail(64, 64)|solutionPath}
	        {else}
	            {$wishlistProduct['Image'] = $placeholdImage->thumbnail(64, 64)|solutionPath}
	        {/if}

			{if $wishlistProduct['VariantId']}
				{controller assign=variantCtrl type=productVariant}
				{$variantShortDescription = $variantCtrl->getDescriptionShort($wishlistProduct['VariantId'])}
				{$wishlistProduct['Title'] = $variantShortDescription}
			{/if}

			{$output[] = $wishlistProduct}

			{/if}
		{/foreach}

	{/if}

{$output = [
	'WishlistProduct' => $output
]}

{$output|jsonify}
