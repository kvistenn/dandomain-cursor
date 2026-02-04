{*

# Description
Consent cookie popup box, lists all cookies on the website


## Date last modified
2023-02-02


## Primary variables
+ $settings                                                             - Global scope variable containing platform settings
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

{if isset($template.settings.COOKIE_TYPE) && $template.settings.COOKIE_TYPE == "COOKIE_CONSENT"}
    {addScript src='modules/widgets/cookie/includes/js/cookie.js'}
    {addLink href='modules/widgets/cookie/includes/css/cookie.css'}

    {if !isset($smarty.cookies["cookie_consent"]) && !$client.isCrawler}
        {$options = [
            'REQUIRED'   => $text.COOKIES_REQUIRED,
            'FUNCTIONAL' => $text.COOKIES_FUNCTIONAL,
            'STATISTICS' => $text.COOKIES_STATISTICS,
            'MARKETING'  => $text.COOKIES_MARKETING
        ]}

        {collection assign='boxes' controller='moduleBox' pageId=null}
        {$boxTypeIds = $boxes->pluck('TypeId')}

        <div class="newcookie">

            <form class="newcookie-container bg-white rounded" data-group="w-cookie-form" data-box-type-ids="{','|implode:$boxTypeIds}">

                <div class="newcookie-scrollarea">

                    <div class="newcookie-header w-cookie-consent handle-scrollHeight" data-group="w-cookie-text">
                        <strong class="newcookie-title">{$text.COOKIES_TITLE}</strong>
                        <div class="w-cookie-description handle-scrollHeight text-sm leading-5">{$text.COOKIES_INFO}</div>
                    </div>

                    <div class="newcookie-content">

                        <div class="w-cookie-listing" data-inject="cookiedetails">
                            {$text.COOKIES_LIST_ERROR}
                        </div>

                        <div class="newcookie-options w-cookie-options trailing-db">
                            {foreach $options as $key => $option}
                                <fieldset class="w-cookie-option">
                                    <span class="w-cookie-option-title">{$option}:</span>
                                    <label class="switch">
                                        <input name="{$key}" type="checkbox" {if $key == 'REQUIRED'} checked disabled{/if}>
                                        <span class="switch-rail {$template.settings.COOKIE_CONSENT_THEME}"></span>
                                    </label>
                                </fieldset>
                            {/foreach}
                        </div>
                    </div>
                </div>
                
                <div class="newcookie-seperator"></div>

                <div class="newcookie-actions">
                    <button name="accept" type="submit" class="button cookie-button border border-black text-black">{$text.COOKIES_DECLINE_ALL}</button>
                    <button class="w-cookie-toggle button flex justify-center border border-black border-b text-black" type="button" data-toggle="collapse" data-target="w-cookie-form" data-class="w-cookie-details">
                        <span class="w-cookie-toggle-details-show">{$text.NEWCOOKIE_POPUP_CUSTOMIZE}</span>
                        <span class="w-cookie-toggle-consent-show">{$text.BACK}</span>
                    </button>
                    <button name="accept_all" type="submit" class="button-primary cookie-button bg-green-600 text-white">{$text.COOKIES_ACCEPT_ALL}</button>
                </div>

            </form>

        </div>
    {/if}
{/if}