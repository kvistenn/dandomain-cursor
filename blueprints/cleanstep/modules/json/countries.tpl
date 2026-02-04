{$output = []}
{collection controller=deliveryCountry assign=deliveryCountries access=true}

{if $deliveryCountries->getActualSize() gt 0}

    {foreach $deliveryCountries->getData() as $country}
        {$output[] = ['iso' => $country->Iso, 'title' => $country->Title]}
    {/foreach}

{/if}

{$output|jsonify}