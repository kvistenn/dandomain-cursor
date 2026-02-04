<div class="bg-white border-t border-gray-200">
    
    <div class="py-6 md:py-10 2xl:py-14">
        <div class="container mx-auto flex flex-col gap-10 md:grid md:grid-cols-5">
            
            <div>
                <span class="text-lg tracking-wide block mb-3 md:mb-6 font-bold">{$text.CUSTOMER_SERVICE}</span>
                <div class="text-sm">
                    <div class="flex flex-col gap-1 mb-3">
                        <span>{$contactdata.company}</span>
                        <span>{$contactdata.address}</span>
                        <span>{$contactdata.zipcode} {$contactdata.city}</span>
                        <span>{$contactdata.country}</span>
                    </div>
                    <div class="mt-5 flex flex-col gap-2">
                        <a href="tel:{$contactdata.phone|strip:''}" class="flex items-center gap-2">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 01-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 00-1.091-.852H4.5A2.25 2.25 0 002.25 4.5v2.25z" />
                            </svg>                      
                            <span>{$contactdata.phone}</span>
                        </a>
                        <a href="mailto:{$contactdata.email}" class="flex items-center gap-2">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75" />
                            </svg>                      
                            <span>{$contactdata.email}</span>
                        </a>
                    </div>
                </div>
            </div>

            <div>
                {collection assign=items controller=page categoryId=34}
                {entity assign=category controller=pageCategory id=34}
                <span class="text-lg tracking-wide block mb-3 md:mb-6 font-bold">{$category->Title}</span>
                <div class="text-sm">
                    {if $items->getActualSize() gt 0}
                        <ul class="flex flex-col gap-3">
                            {foreach $items->getData() as $item}
                                <li><a href="{$item->Handle|formatUrl}">{$item->Title}</a></li>
                            {/foreach}
                        </ul>
                    {/if}
                </div>
            </div>

            <div>
                <span class="text-lg tracking-wide block mb-3 md:mb-6 font-bold">{$text.ACCOUNT}</span>
                <div class="text-sm">
                    <ul class="flex flex-col gap-3">
                        {if !$user}
                            <li><a data-fancybox="" data-src="#login" href="#">{$text.LOGIN_MENU}</a></li>
                        {else}
                            <li><a href="{$text.MY_ORDERS_LINK|formatUrl}">{$text.MY_ORDERS_MENU}</a></li>
                            <li><a href="{$text.USER_UPDATE_LINK|formatUrl}">{$text.USER_UPDATE_MENU}</a></li>
                            <li><a href="#" data-action="logout">{$text.LOGOUT_HEADLINE}</a></li>
                        {/if}
                    </ul>
                </div>
            </div>

            <div>
                {$pagelink = {page id=$page.productPageId print=Link}}
                {collection assign=categories controller=productCategory pageSize=5}
                <span class="text-lg tracking-wide block mb-3 md:mb-6 font-bold">{$text.CATEGORYS}</span>
                <div class="text-sm">
                    {if $categories->getActualSize() gt 0}
                        <ul class="flex flex-col gap-3">
                            {foreach $categories->getData() as $category}
                                <li><a href="/{$pagelink}/{$category->Handle}/">{$category->Title}</a></li>
                            {/foreach}
                        </ul>
                    {/if}
                </div>
            </div>

            <div>
                <span class="text-lg tracking-wide block mb-6 font-bold">{$text.SOCIAL_MEDIA}</span>
                <div class="text-sm">
                    <ul class="flex flex-wrap gap-4">
                        <li>
                            <a href="{$settings.social_plugin_likebox_pageurl}" class="fill-black" title="{$text.SOCIAL_BOX_FACEBOOK}" target="_blank">
                                <svg viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" id="fi_1051309" width="24" height="24">
                                    <path d="m437 0h-362c-41.351562 0-75 33.648438-75 75v362c0 41.351562 33.648438 75 75 75h151v-181h-60v-90h60v-61c0-49.628906 40.371094-90 90-90h91v90h-91v61h91l-15 90h-76v181h121c41.351562 0 75-33.648438 75-75v-362c0-41.351562-33.648438-75-75-75zm0 0"></path>
                                </svg>
                            </a>
                        </li>
                        <li>
                            <a href="{$settings.social_instagram_pageurl}" class="fill-black" title="{$text.SOCIAL_BOX_INSTAGRAM}" target="_blank">
                                <svg height="24" viewBox="0 0 511 511.9" width="24" xmlns="http://www.w3.org/2000/svg" id="fi_1384031">
                                    <path d="m510.949219 150.5c-1.199219-27.199219-5.597657-45.898438-11.898438-62.101562-6.5-17.199219-16.5-32.597657-29.601562-45.398438-12.800781-13-28.300781-23.101562-45.300781-29.5-16.296876-6.300781-34.898438-10.699219-62.097657-11.898438-27.402343-1.300781-36.101562-1.601562-105.601562-1.601562s-78.199219.300781-105.5 1.5c-27.199219 1.199219-45.898438 5.601562-62.097657 11.898438-17.203124 6.5-32.601562 16.5-45.402343 29.601562-13 12.800781-23.097657 28.300781-29.5 45.300781-6.300781 16.300781-10.699219 34.898438-11.898438 62.097657-1.300781 27.402343-1.601562 36.101562-1.601562 105.601562s.300781 78.199219 1.5 105.5c1.199219 27.199219 5.601562 45.898438 11.902343 62.101562 6.5 17.199219 16.597657 32.597657 29.597657 45.398438 12.800781 13 28.300781 23.101562 45.300781 29.5 16.300781 6.300781 34.898438 10.699219 62.101562 11.898438 27.296876 1.203124 36 1.5 105.5 1.5s78.199219-.296876 105.5-1.5c27.199219-1.199219 45.898438-5.597657 62.097657-11.898438 34.402343-13.300781 61.601562-40.5 74.902343-74.898438 6.296876-16.300781 10.699219-34.902343 11.898438-62.101562 1.199219-27.300781 1.5-36 1.5-105.5s-.101562-78.199219-1.300781-105.5zm-46.097657 209c-1.101562 25-5.300781 38.5-8.800781 47.5-8.601562 22.300781-26.300781 40-48.601562 48.601562-9 3.5-22.597657 7.699219-47.5 8.796876-27 1.203124-35.097657 1.5-103.398438 1.5s-76.5-.296876-103.402343-1.5c-25-1.097657-38.5-5.296876-47.5-8.796876-11.097657-4.101562-21.199219-10.601562-29.398438-19.101562-8.5-8.300781-15-18.300781-19.101562-29.398438-3.5-9-7.699219-22.601562-8.796876-47.5-1.203124-27-1.5-35.101562-1.5-103.402343s.296876-76.5 1.5-103.398438c1.097657-25 5.296876-38.5 8.796876-47.5 4.101562-11.101562 10.601562-21.199219 19.203124-29.402343 8.296876-8.5 18.296876-15 29.398438-19.097657 9-3.5 22.601562-7.699219 47.5-8.800781 27-1.199219 35.101562-1.5 103.398438-1.5 68.402343 0 76.5.300781 103.402343 1.5 25 1.101562 38.5 5.300781 47.5 8.800781 11.097657 4.097657 21.199219 10.597657 29.398438 19.097657 8.5 8.300781 15 18.300781 19.101562 29.402343 3.5 9 7.699219 22.597657 8.800781 47.5 1.199219 27 1.5 35.097657 1.5 103.398438s-.300781 76.300781-1.5 103.300781zm0 0"></path><path d="m256.449219 124.5c-72.597657 0-131.5 58.898438-131.5 131.5s58.902343 131.5 131.5 131.5c72.601562 0 131.5-58.898438 131.5-131.5s-58.898438-131.5-131.5-131.5zm0 216.800781c-47.097657 0-85.300781-38.199219-85.300781-85.300781s38.203124-85.300781 85.300781-85.300781c47.101562 0 85.300781 38.199219 85.300781 85.300781s-38.199219 85.300781-85.300781 85.300781zm0 0"></path><path d="m423.851562 119.300781c0 16.953125-13.746093 30.699219-30.703124 30.699219-16.953126 0-30.699219-13.746094-30.699219-30.699219 0-16.957031 13.746093-30.699219 30.699219-30.699219 16.957031 0 30.703124 13.742188 30.703124 30.699219zm0 0"></path>
                                </svg>
                            </a>
                        </li>
                        <li>
                            <a href="{$settings.social_youtube_pageurl}" class="fill-black" title="{$text.SOCIAL_BOX_YOUTUBE}" target="_blank">
                                <svg id="fi_49084" enable-background="new 0 0 90.677 90.677" viewBox="0 0 90.677 90.677" xmlns="http://www.w3.org/2000/svg" width="24" height="24">
                                    <path d="m82.287 45.907c-.937-4.071-4.267-7.074-8.275-7.521-9.489-1.06-19.098-1.065-28.66-1.06-9.566-.005-19.173 0-28.665 1.06-4.006.448-7.334 3.451-8.27 7.521-1.334 5.797-1.35 12.125-1.35 18.094s0 12.296 1.334 18.093c.936 4.07 4.264 7.073 8.272 7.521 9.49 1.061 19.097 1.065 28.662 1.061 9.566.005 19.171 0 28.664-1.061 4.006-.448 7.336-3.451 8.272-7.521 1.333-5.797 1.34-12.124 1.34-18.093-.001-5.97.009-12.297-1.324-18.094zm-53.387 4.493h-5.54v29.438h-5.146v-29.438h-5.439v-4.822h16.125zm13.977 29.439h-4.629v-2.785c-1.839 2.108-3.585 3.136-5.286 3.136-1.491 0-2.517-.604-2.98-1.897-.252-.772-.408-1.994-.408-3.796v-20.186h4.625v18.795c0 1.084 0 1.647.042 1.799.111.718.462 1.082 1.082 1.082.928 0 1.898-.715 2.924-2.166v-19.51h4.629zm17.573-7.662c0 2.361-.159 4.062-.468 5.144-.618 1.899-1.855 2.869-3.695 2.869-1.646 0-3.234-.914-4.781-2.824v2.474h-4.625v-34.262h4.625v11.189c1.494-1.839 3.08-2.769 4.781-2.769 1.84 0 3.078.969 3.695 2.88.311 1.027.468 2.715.468 5.132zm17.457-4.259h-9.251v4.525c0 2.363.773 3.543 2.363 3.543 1.139 0 1.802-.619 2.066-1.855.043-.251.104-1.279.104-3.134h4.719v.675c0 1.491-.057 2.518-.099 2.98-.155 1.024-.519 1.953-1.08 2.771-1.281 1.854-3.179 2.768-5.595 2.768-2.42 0-4.262-.871-5.599-2.614-.981-1.278-1.485-3.29-1.485-6.003v-8.941c0-2.729.447-4.725 1.43-6.015 1.336-1.747 3.177-2.617 5.54-2.617 2.321 0 4.161.87 5.457 2.617.969 1.29 1.432 3.286 1.432 6.015v5.285z"></path><path d="m70.978 58.163c-1.546 0-2.321 1.181-2.321 3.541v2.362h4.625v-2.362c-.001-2.36-.774-3.541-2.304-3.541z"></path><path d="m53.812 58.163c-.762 0-1.534.36-2.307 1.125v15.559c.772.774 1.545 1.14 2.307 1.14 1.334 0 2.012-1.14 2.012-3.445v-10.896c0-2.302-.678-3.483-2.012-3.483z"></path><path d="m56.396 34.973c1.705 0 3.479-1.036 5.34-3.168v2.814h4.675v-25.799h-4.675v19.718c-1.036 1.464-2.018 2.188-2.953 2.188-.626 0-.994-.37-1.096-1.095-.057-.153-.057-.722-.057-1.817v-18.994h-4.66v20.4c0 1.822.156 3.055.414 3.836.47 1.307 1.507 1.917 3.012 1.917z"></path><path d="m23.851 20.598v14.021h5.184v-14.021l6.236-20.598h-5.242l-3.537 13.595-3.68-13.595h-5.455c1.093 3.209 2.23 6.434 3.323 9.646 1.663 4.828 2.701 8.468 3.171 10.952z"></path><path d="m42.219 34.973c2.342 0 4.162-.881 5.453-2.641.981-1.291 1.451-3.325 1.451-6.067v-9.034c0-2.758-.469-4.774-1.451-6.077-1.291-1.765-3.11-2.646-5.453-2.646-2.33 0-4.149.881-5.443 2.646-.993 1.303-1.463 3.319-1.463 6.077v9.034c0 2.742.47 4.776 1.463 6.067 1.293 1.76 3.113 2.641 5.443 2.641zm-2.231-18.679c0-2.387.724-3.577 2.231-3.577s2.229 1.189 2.229 3.577v10.852c0 2.387-.722 3.581-2.229 3.581s-2.231-1.194-2.231-3.581z"></path>
                                </svg>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

        </div>
    </div>

    <div class="py-4 border-t border-gray-200">
        <div class="container mx-auto flex flex-col gap-3 md:gap-0 md:grid grid-cols-2">
            <div class="text-center md:text-left">
                <span class="text-xs md:text-sm">&copy; {date('Y')} {$contactdata.company}. Tema af <a href="https://www.bewise.dk">Bewise</a></span>
            </div>
            <div>
                <div class="mx-auto md:ml-auto md:mr-0 flex flex-wrap gap-2 md:gap-4 w-fit">
                    <img src="{$template.path}/assets/images/creditcards/card-visa.svg" alt="Visa" width="38" height="24" loading="lazy" class="w-auto h-4 md:h-6" />
                    <img src="{$template.path}/assets/images/creditcards/card-visa-electron.svg" alt="Visa Electron" width="38" height="24" loading="lazy" class="w-auto h-4 md:h-6" />
                    <img src="{$template.path}/assets/images/creditcards/card-mastercard.svg" alt="Mastercard" width="38" height="24" loading="lazy" class="w-auto h-4 md:h-6" />
                    <img src="{$template.path}/assets/images/creditcards/card-dankort.svg" alt="Dankort" width="38" height="24" loading="lazy" class="w-auto h-4 md:h-6" />
                    <img src="{$template.path}/assets/images/creditcards/card-jcb.svg" alt="JCB" width="38" height="24" loading="lazy" class="w-auto h-4 md:h-6" />
                    <img src="{$template.path}/assets/images/creditcards/card-maestro.svg" alt="Maestro" width="38" height="24" loading="lazy" class="w-auto h-4 md:h-6" />
                    <img src="{$template.path}/assets/images/creditcards/card-mobilepay.svg" alt="MobilePay" width="38" height="24" loading="lazy" class="w-auto h-4 md:h-6" />
                </div>
            </div>
        </div>
    </div>
</div>