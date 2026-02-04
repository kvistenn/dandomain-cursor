{literal}
    <script data-addresses="selectmarkup" type="text/x-jsrender">
        {{if addresses.length === 0}}
            <option value='' disabled>{{:~text('NO_ADDRESSES')}}</option>
        {{else}}
            <option value='' default>{{:~text('CHOOSE_ADDRESS_FOR_DELIVERY')}}</option>
            {{for addresses}}
                <option value='{{:~jsonEncode(#data)}}'>{{:name}}</option>
            {{/for}}
        {{/if}}
    </script>
{/literal}

<select data-addresses="select" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm appearance-none arrow {if $page.isCheckout}mb-5{/if}">
</select>