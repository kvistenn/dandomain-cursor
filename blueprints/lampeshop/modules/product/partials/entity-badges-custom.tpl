{$badges = []}
{if $customDataTypes[6].Data|@count gt 0}
    {$badges = ', '|explode:$customDataTypes[6].Data[0]}
{/if}

{if $customDataTypes[6].Data|@count gt 0}
    <div class="absolute top-0 left-0 flex-col gap-2 lg:gap-4 z-20 hidden xl:flex">
        {foreach $badges as $badge}
            <div class="bg-gray-100 p-4 rounded text-center flex flex-col items-center gap-2 w-40">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-8 h-8">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span>{$badge}</span>      
            </div>
        {/foreach}
    </div>
{/if}