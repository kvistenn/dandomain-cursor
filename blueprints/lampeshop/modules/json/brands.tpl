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
	{controller assign=controller type=brand}
    
	{$brands = null}

	{if $field eq 'id'}
		{if $value}
			{$value = explode(',', $value)}
			{collection assign=brands controller=$controller id=$value}
			{$amount = $brands->getActualSize()}
		{/if}
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

		{collection assign=brands controller=$controller options=$options}

		{if $brands->getActualSize() gt 0}
			{$amount = $brands->getActualSize()}
		{/if}
	{/if}

	{if $brands and $brands->getActualSize() gt 0}

        {$pageLink = PageController::link($page.productPageId)}
        {placeholdImage assign=placeholder width=210 height=210 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

		{foreach $brands->getData() as $k => $brand}

			{$brand = (array)$brand}

            {entity assign=image controller=files type=user id=$brand.Id}

            {if $image}
                {$imgpath = $image->thumbnail(210, 210)|solutionPath}
            {else}
                {$imgpath = $placeholdImage->thumbnail(210, 210)|solutionPath)}
            {/if}

            {if $imgpath}
                {$brand['Image'] = $imgpath}
                {else}
                {$brand['Image'] = null}
            {/if}

            {$brandTitle = $brand.Title}
            {$brandTitleLink = $brandTitle|formatLink}
            {$brand['Link'] = $pageLink|cat:'?brand='|cat:$brand.Id|cat:'-'|cat:$brandTitleLink}
            
			{$output[] = $brand}

		{/foreach}
	{/if}
{/if}

{$output = ['amount' => $amount, 'brands' => $output]}

{$output|jsonify}
