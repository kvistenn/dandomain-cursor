{$value = null}
{if isset($request.args[0])}
    {$value = $request.args.0}
{elseif isset($request.input['id'])}
    {$value = $request.input.id}
{/if}

{$result = null}
{$variant = null}
{collection assign=results controller=productList search=$value}

{if $results->getActualSize() > 0}

    {foreach $results->getData() as $product key=i}
        {* {if $product->ItemNumber == $value}
            {$result = $product->Id}
            {break}
        {/if}

        {if $i == ($results->getActualSize() - 1) and $result == null}
            {$result = $product->Id}
        {/if} *}

        {collection assign=variants controller=productVariant productId=$product->Id}
        {if $variants->getActualSize() gt 0}
            {foreach $variants->getData() as $v}
                {if $v->ItemNumber == $value}
                    {$variant = $v->Id}
                    {$result = $product->Id}
                    {break}
                {/if}
            {/foreach}

        {else}
            {if $product->ItemNumber == $value}
                {$result = $product->Id}
                {break}
            {/if}
        {/if}
    {/foreach}

{/if}

{$output = [
    'value' => $value,
    'result' => $result,
    'variant' => $variant
]}

{$output|jsonify}