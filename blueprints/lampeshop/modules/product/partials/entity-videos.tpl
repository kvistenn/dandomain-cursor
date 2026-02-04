{if $customDataTypes[9].Data}

    {$videos = $customDataTypes[9].Data[0]}
    {$videos = "##"|explode:$videos}

    <div class="mt-6">
        <strong class="text-sm block mb-2">{$customDataTypes[9].Title}</strong>
        <div class="grid grid-cols-4 gap-4">
            {for $i=0; $i < count($videos); $i++}
                {if $videos[$i]}

                    {$splits = "::"|explode:$videos[$i]}
                    {$videoSrc = $splits[0]}
                    {$videoLabel = $splits[1]}

                    <a href="#" data-src="#video{$i}" data-fancybox class="leading-none group">
                        <div class="relative rounded overflow-hidden">
                            <video class="w-full aspect-square object-cover">
                                <source src="{$videoSrc}" type="video/mp4">
                            </video>
                            <div class="absolute inset-0 flex items-center justify-center bg-black/20 fill-white">
                                <svg version="1.1" id="fi_27223" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24" height="24" class="w-4 h-4 group-hover:w-6 group-hover:h-6 transition-all" viewBox="0 0 163.861 163.861" style="enable-background:new 0 0 163.861 163.861;" xml:space="preserve">
                                    <path d="M34.857,3.613C20.084-4.861,8.107,2.081,8.107,19.106v125.637c0,17.042,11.977,23.975,26.75,15.509L144.67,97.275
                                        c14.778-8.477,14.778-22.211,0-30.686L34.857,3.613z"></path>
                                </svg>
                            </div>
                        </div>
                        <small class="block mt-2 text-xs text-center">{$videoLabel}</small>
                    </a>

                    <div id="video{$i}" style="display: none; max-width: 500px;">
                        <video controls class="w-full" loading="lazy">
                            <source src="{$videoSrc}" type="video/mp4">
                        </video>
                    </div>
                {/if}
            {/for}
        </div>
    </div>

{/if}