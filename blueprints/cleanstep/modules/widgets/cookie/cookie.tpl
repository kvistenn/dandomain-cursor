{if isset($template.settings.COOKIE_TYPE) && $template.settings.COOKIE_TYPE == "COOKIE_CONSENT"}
    {addScript src='modules/widgets/cookie/includes/js/cookie.js' preload=true}
    
    {if !isset($smarty.cookies["cookie_consent"]) && !$client.isCrawler}
        {$options = [
            'REQUIRED'   => $text.COOKIES_REQUIRED,
            'FUNCTIONAL' => $text.COOKIES_FUNCTIONAL,
            'STATISTICS' => $text.COOKIES_STATISTICS,
            'MARKETING'  => $text.COOKIES_MARKETING
        ]}
        {collection assign='boxes' controller='moduleBox' pageId=null}
        {$boxTypeIds = $boxes->pluck('TypeId')}

        <div class="fixed inset-0 z-[9999999] bg-black/20 flex justify-center items-center">
            <div class="bg-white rounded-lg shadow-xl max-w-3xl w-full mx-4 overflow-hidden">
                <form class="p-6 space-y-4" data-group="w-cookie-form" data-box-type-ids="{','|implode:$boxTypeIds}">
                    <div class="max-h-[65vh] overflow-y-auto transition-all duration-300" data-group="w-cookie-text">
                        <p class="text-2xl font-bold mb-2">{$text.COOKIES_TITLE}</p>
                        <div class="text-gray-700 mb-4">{$text.COOKIES_INFO}</div>

                        <button type="button" class="text-black hover:underline flex items-center gap-1 mb-4 toggle-extended" data-toggle="collapse" data-target="w-cookie-text" data-class="extended-open">
                            <i class="fa fa-caret-up"></i> {$text.COOKIES_LINK}
                        </button>

                        <div class="w-cookie-extended-info text-sm text-gray-600 hidden transition-all duration-300">
                            {$text.COOKIES_EXTENDED_INFO}
                        </div>

                        <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mt-6">
                            {foreach $options as $key => $option}
                                <fieldset class="flex flex-col items-center space-y-2">
                                    <strong>{$option}:</strong>
                                    <label class="relative inline-flex items-center cursor-pointer">
                                        <input name="{$key}" type="checkbox"
                                            class="sr-only peer"
                                            {if $key == 'REQUIRED'} checked disabled{/if}>
                                        <div class="w-11 h-6 bg-gray-200 rounded-full peer-checked:bg-black transition duration-300"></div>
                                        <div class="absolute left-0.5 top-0.5 w-5 h-5 bg-white rounded-full shadow transform transition-all duration-300 peer-checked:translate-x-full"></div>
                                    </label>
                                </fieldset>
                            {/foreach}
                        </div>
                    </div>

                    <div class="flex flex-col space-y-4">
                        <div class="flex justify-center gap-4">
                            <button name="accept" type="submit" class="bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium py-2 px-4 rounded">
                                {$text.COOKIES_DECLINE_ALL}
                            </button>
                            <button name="accept_all" type="submit" class="bg-black hover:bg-gray-700 text-white font-medium py-2 px-4 rounded">
                                {$text.COOKIES_ACCEPT_ALL}
                            </button>
                        </div>
                        <button type="button" class="flex flex-col items-center text-sm text-black toggle-details" data-toggle="collapse" data-target="w-cookie-form" data-class="w-cookie-details">
                            <div class="details-show">{$text.COOKIES_SHOW_DETAILS}</div>
                            <div class="consent-show hidden">{$text.COOKIES_SHOW_CONSENT}</div>
                            <i class="fa fa-arrow-down"></i>
                        </button>
                    </div>

                    <div class="max-h-0 overflow-hidden opacity-0 transition-all duration-300" data-inject="cookiedetails">
                        <center>{$text.COOKIES_LIST_ERROR}</center>
                    </div>

                    <div class="hidden absolute inset-0 bg-white bg-opacity-70 flex justify-center items-center z-10 w-cookie-loader">
                        <svg class="animate-spin h-12 w-12 text-black" viewBox="10 10 20 20">
                            <circle cx="20" cy="20" r="8" fill="none" stroke="currentColor" stroke-width="2" />
                        </svg>
                    </div>
                </form>
            </div>
        </div>
    {/if}
{/if}