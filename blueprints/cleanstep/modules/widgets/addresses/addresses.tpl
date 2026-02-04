{literal}

<script data-addresses="listmarkup" type="text/x-jsrender">
    <li class="border-b border-gray-200 last:border-b-0 grid grid-cols-10 text-sm" data-id="{{:id}}">
        <label class="p-2 col-span-2">
            <input type="text" name="name" value="{{:name}}" class="w-full p-1 border border-gray-200 rounded" />
        </label>
        <label class="p-2 col-span-2">
            <input type="text" name="attention" value="{{:attention}}" class="w-full p-1 border border-gray-200 rounded" />
        </label>
        <label class="p-2 col-span-2">
            <input type="text" name="address" value="{{:address}}" class="w-full p-1 border border-gray-200 rounded" />
        </label>
        <label class="p-2">
            <input type="text" name="zipCode" value="{{:zipCode}}" class="w-full p-1 border border-gray-200 rounded" />
        </label>
        <label class="p-2">
            <input type="text" name="city" value="{{:city}}" class="w-full p-1 border border-gray-200 rounded" />
        </label>
        <label class="p-2">
            <input type="text" name="email" value="{{:email}}" class="w-full p-1 border border-gray-200 rounded" />
        </label>
        <span class="p-2 flex gap-2 justify-end items-center">
            <button title="{{:~text('SAVE')}}" type="button" class="p-1.5 leading-none text-xs rounded bg-black text-white" data-addresses="save">
                {{:~text('SAVE')}}
            </button>
            <button title="{{:~text('DELETE')}}" type="button" class="text-gray-400 hover:text-black transition-colors underline" data-addresses="delete">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                </svg>
            </button>
        </span>
    </li>
</script>

{/literal}

<div class="flex items-center gap-2">
    <button type="button" class="px-4 h-10 flex items-center gap-2 rounded bg-black text-white text-sm w-fit" data-addresses="openform">
        {$text.ADDRESSES_NEW}
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
        </svg>
    </button>
    <label class="px-4 h-10 flex cursor-pointer items-center gap-2 rounded bg-white border border-gray-200 text-black text-sm w-fit hover:bg-gray-50 transition-colors">
        Import CSV
        <input type="file" accept=".csv" class="hidden" data-addresses="import-csv">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5m-13.5-9L12 3m0 0 4.5 4.5M12 3v13.5" />
        </svg>
    </label>
</div>

<div class="flex flex-col gap-6 mt-6" style="display: none;" data-addresses="form">
    <div class="flex flex-col gap-2">
        <div class="flex flex-col lg:grid gap-6 lg:grid-cols-2">

            <label class="flex flex-col gap-1">
                <span class="text-xs">{$text.NAME}</span>
                <input type="text" name="name" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.NAME}">
            </label>

            <label class="flex flex-col gap-1">
                <span class="text-xs">{$text.CART_NOTE}</span>
                <input type="text" name="attention" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.CART_NOTE}">
            </label>

            <label class="flex flex-col gap-1">
                <span class="text-xs">{$text.ADDRESS}</span>
                <input type="text" name="address" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.ADDRESS}">
            </label>

            <label class="flex flex-col gap-1">
                <span class="text-xs">{$text.POSTCODE}</span>
                <input type="text" name="zipCode" data-smartform="zipcode" data-target="#addressCity" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.POSTCODE}">
            </label>

            <label class="flex flex-col gap-1">
                <span class="text-xs">{$text.CITY}</span>
                <input type="text" name="city" id="addressCity" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.CITY}">
            </label>

            <label class="flex flex-col gap-1">
                <span class="text-xs">{$text.MAIL}</span>
                <input type="text" name="email" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" placeholder="{$Text.MAIL}">
            </label>
        </div>
    </div>

    <div class="w-full">
        <button type="button" class="px-5 h-12 flex items-center gap-4 rounded bg-primary text-white w-fit" data-addresses="submit">
            {$text.CREATE}
        </button>
    </div>
</div>

<div class="flex flex-col gap-2 mt-6">
    <label class="flex flex-col gap-1">
        <input type="text" placeholder="{$text.SEARCH}" class="bg-white border border-gray-200 rounded w-full px-3 h-10 text-sm" data-addresses="search">
    </label>
</div>

<div class="flex flex-col border border-gray-200 rounded mt-4">
    <div class="border-b border-gray-200 last:border-b-0 grid grid-cols-10 text-xs font-bold">
        <span class="p-2 col-span-2">{$text.NAME}</span>
        <span class="p-2 col-span-2">{$text.CART_NOTE}</span>
        <span class="p-2 col-span-2">{$text.ADDRESS}</span>
        <span class="p-2">{$text.POSTCODE}</span>
        <span class="p-2">{$text.CITY}</span>
        <span class="p-2">{$text.MAIL}</span>
    </div>
    <ul data-addresses="list">
    </ul>
</div>