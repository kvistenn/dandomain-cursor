{$output = []}
{$items = []}
{$reorderIds = []}

{if $smarty.cookies.reorder}
    
    {$reorderData = ','|explode:($smarty.cookies.reorder|escape:'html':'UTF-8')}
    
    {foreach $reorderData as $reorderItem}

        {$data = ":"|explode:$reorderItem}
        {$reorderId = $data[0]|trim}
        {$reorderAmount = $data[1]|trim}

        {$reorderIds[] = (int)$reorderId}
        
        {$items[] = [
            'Id' => $reorderId,
            'Amount' => $reorderAmount
        ]}
        
    {/foreach}
{/if}

{if $items|count > 0}

    {placeholdImage assign=placeholder width=320 height=320}
    {$pageLink = PageController::link($page.productPageId)}
    
    {foreach $items as $k => $item}

        {$reorderProduct = (array)[]}

        {controller assign=controller type=product}
        {entity assign=product controller=$controller id=$item.Id}

        {if !$product}
            {continue}
        {/if}

        {* Link *}
        {$reorderProduct['Handle'] = ProductController::link($item.Id, false, $product)}

        {* General *}
        {$reorderProduct['Title'] = $product->Title}
        {$reorderProduct['ItemNumber'] = $product->ItemNumber}
        {$reorderProduct['Id'] = $product->Id}
        
        {* Price *}
        {$reorderProduct['Price'] = $product->Prices[0]->PriceMax}
        {$reorderProduct['FullPrice'] = $product->Prices[0]->FullPriceMax}

        {* Image *}
        {entity assign=productImage controller=files type=product productId=$product->Id}
        {if $productImage}
            {$reorderProduct['Image'] = $productImage->thumbnail(320, 320)|solutionPath}
        {else}
            {$reorderProduct['Image'] = $placeholder->getRelativeFile()|solutionPath}
        {/if}

        {* Amount *}
        {$reorderProduct['Amount'] = (int)$item.Amount}

        {$output[] = $reorderProduct}

    {/foreach}
{/if}

{$output = [
    'ReorderIds' => $reorderIds,
    'ReorderProduct' => $output
]}

{$output|jsonify}