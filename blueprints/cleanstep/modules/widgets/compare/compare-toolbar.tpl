{literal}
    <script id="render-compare-toolbar" type="text/x-jsrender">
        {{if CompareProduct.length > 1}}
            <div class="w-full fixed bottom-0 left-0 z-40 hidden xl:block">
                <div class="container mx-auto">
                    <div class="bg-white rounded-t flex overflow-hidden shadow-[0_35px_90px_rgba(0,0,0,0.4)]">

                        <div class="flex items-center flex-auto">
                            {{for CompareProduct}}

                                <div class="h-full p-6 border-r border-gray-200 flex-1 last:border-r-0 flex gap-3 relative">
                                    <span data-compare="delete" class="absolute top-2 left-2 cursor-pointer" data-id="{{:Id}}">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                                        </svg>
                                    </span>
                                    <a href="{{:Handle}}" class="block aspect-square h-12 flex-none">
                                        <img src="{{:Image}}" alt="{{:Title}}" width="80" height="80" class="w-full height-auto aspect-square">
                                    </a>
                                    <div>
                                        <strong class="text-sm block"><a href="{{:Handle}}">{{:Title}}</a></strong>
                                        <span>{{:~currency(Price)}}</span>
                                        {{if FullPrice != Price}}
                                            <strike>{{:~currency(FullPrice)}}</strike>
                                        {{/if}}
                                    </div>
                                </div>

                            {{/for}}
                        </div>
                        
                        <a href="{{:~text('COMPARE_LINK')}}" class="bg-black text-white h-24 px-8 text-lg flex items-center gap-3 hover:bg-primary transition-colors">
                            <svg xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 24 24" width="24" height="24" class="h-5 lg:h-6 w-auto fill-white">
                                <path d="M24,5c0-2.206-1.794-4-4-4s-4,1.794-4,4c0,1.86,1.277,3.428,3,3.873v8.127c0,.551-.449,1-1,1h-4.996l2.203-2.203-1.414-1.414-3.256,3.256c-.774,.775-.774,2.037,0,2.812l3.256,3.256,1.414-1.414-2.304-2.293h5.097c1.654,0,3-1.346,3-3V8.873c1.723-.445,3-2.013,3-3.873Zm-4,2c-1.103,0-2-.897-2-2s.897-2,2-2,2,.897,2,2-.897,2-2,2Zm-9.838,2.662l3.256-3.255c.775-.775,.775-2.037,0-2.812L10.162,.338l-1.414,1.414,2.259,2.248H6c-1.654,0-3,1.346-3,3V15.127c-1.723,.445-3,2.013-3,3.873,0,2.206,1.794,4,4,4s4-1.794,4-4c0-1.86-1.277-3.428-3-3.873V7c0-.551,.449-1,1-1h4.995l-2.248,2.248,1.414,1.414Zm-4.162,9.338c0,1.103-.897,2-2,2s-2-.897-2-2,.897-2,2-2,2,.897,2,2Z"/>
                            </svg>
                            {{:~text('COMPARE_MENU')}}
                        </a>
                    </div>
                </div>
            </div>
        {{/if}}
    </script>
{/literal}

<div id="ajaxcomparetoolbar"></div>