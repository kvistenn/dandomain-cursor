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
{$amount = 0}

{if $field}
	{controller assign=controller type=productCategory}

	{$categories = null}

	{if $field eq 'id'}
		{if $value}
			{$value = explode(',', $value)}
			{collection assign=categories controller=$controller id=$value}
			{$amount = $categories->getActualSize()}
		{/if}

	{** If no field is recognised in the URI segment for VERB, assign the VERB value as a parameter to ProductListController **}
	{else}

		{$options = []}

		{*** If a 'tag' was included we need to prepare the value ***}
		{if $field eq 'tag'}
			{$argOptions = explode(';', $value)}
			{if $argOptions|count gt 1}
				{$options['tagType'] = $argOptions[1]}
			{/if}
			{$value = $argOptions[0]}
		{/if}

		{$options[$field] = $value}

		{if isset($request.input['page'])}
			{$options['page'] = $request.input.page}
		{/if}

		{if isset($request.input['limit'])}
			{$options['pageSize'] = $request.input.limit}
		{/if}

		{collection assign=categories controller=$controller options=$options}

		{if $categories->getActualSize() gt 0}
			{$amount = $categories->getActualSize()}
		{/if}
	{/if}

	{if $categories and $categories->getActualSize() gt 0}

        {$pageLink = PageController::link($page.productPageId)}
        {placeholdImage assign=placeholder width=100 height=100 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}
        
		{foreach $categories->getData() as $k => $category}

			{$category = (array)$category}

            {controller assign=productListController type=productList}
            {collection assign=productlist controller=$productListController categoryId=$category.Id}
            {$amount = $productlist->getActualSize()}
            
            {if $amount == 1}
                {$amountString = $amount|cat:' '|cat:$text.PRODUCT_CATALOG_PRODUCT|lower}
                {else}
                {$amountString = $amount|cat:' '|cat:$text.PRODUCT_CATALOG_PRODUCTS|lower}
            {/if}

            {$category['Amount'] = $amountString}

            {entity assign=image controller=files type=category id=$category.Id}
			{if $image}
				{$imgpath = $image->thumbnail(100, 100)|solutionPath}
			{else}
				{$imgpath = $placeholdImage->thumbnail(100, 100)|solutionPath}
			{/if}

            {$category['Image'] = $imgpath}

            {$category['Link'] = $pageLink|cat:$category['Handle']}


			{$output[] = $category}

		{/foreach}
	{/if}
{/if}

{$output = ['amount' => $amount, 'categories' => $output]}

{$output|jsonify}
