{if $general.languageIso == 'DK26'}
    <div class="container py-6 lg:py-12">
        <div class="trustpilot-widget" data-locale="da-DK" data-template-id="53aa8912dec7e10d38f59f36" data-businessunit-id="483ecd1400006400050297d1" data-style-height="140px" data-style-width="100%" data-stars="4,5" data-review-languages="da">
            <a href="https://dk.trustpilot.com/review/www.cleanstep.dk" target="_blank" rel="noopener">Trustpilot</a>
        </div>
    </div>
{/if}

{controller assign=pageCtrl type=page}

<footer class="bg-gray-900 text-white py-6 lg:py-12">
    <div class="container">
        <div class="flex flex-col md:grid md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 xl:gap-8">
            
            <!-- Column 1 -->
            <div class="flex flex-col row-span-2 gap-2">
                <strong class="text-lg font-bold">{$contactdata.name}</strong>
                <div class="flex flex-col gap-2 text-sm">
                    <a href="mailto:{$contactdata.email}" class="text-white hover:underline flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 12a4.5 4.5 0 1 1-9 0 4.5 4.5 0 0 1 9 0Zm0 0c0 1.657 1.007 3 2.25 3S21 13.657 21 12a9 9 0 1 0-2.636 6.364M16.5 12V8.25" />
                        </svg>                  
                        <span>{$contactdata.email}</span>
                    </a>
                    <a href="tel:{$contactdata.phone}" class="text-white hover:underline flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 0 0 2.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 0 1-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 0 0-1.091-.852H4.5A2.25 2.25 0 0 0 2.25 4.5v2.25Z" />
                        </svg>                      
                        <span>{$contactdata.phone}</span>
                    </a>
                    <div>
                        <span>{$text.VAT_NR}: {$contactdata.vatnumber}</span>
                    </div>
                </div>

                {$socialFooter =  $settings.social_instagram && !empty($settings.social_instagram_pageurl) ||
                $settings.social_facebook and !empty($settings.social_plugin_likebox_pageurl) ||
                $settings.social_twitter  and !empty($settings.social_twitter_pageurl) ||
                $settings.social_youtube  and !empty($settings.social_youtube_pageurl) ||
                $settings.social_linkedin and !empty($settings.social_linkedin_pageurl)}

                {if $socialFooter}
                    <ul class="flex flex-wrap gap-2 mt-2">
                        {if $settings.social_plugin_likebox_pageurl and $settings.social_facebook}
                            <li><a href="{$settings.social_plugin_likebox_pageurl}" title="{$text.SOCIAL_BOX_FACEBOOK}" target="_blank">{include file="modules/widgets/icon/icon.tpl" icon="facebook"}</a></li>
                        {/if}
                        {if $settings.social_twitter_pageurl and $settings.social_twitter}
                            <li><a href="{$settings.social_twitter_pageurl}" title="{$text.SOCIAL_BOX_TWITTER}" target="_blank">{include file="modules/widgets/icon/icon.tpl" icon="twitter"}</a></li>
                        {/if}
                        {if $settings.social_youtube_pageurl and $settings.social_youtube}
                            <li><a href="{$settings.social_youtube_pageurl}" title="{$text.SOCIAL_BOX_YOUTUBE}" target="_blank">{include file="modules/widgets/icon/icon.tpl" icon="youtube"}</a></li>
                        {/if}
                        {if $settings.social_linkedin_pageurl and $settings.social_linkedin}
                            <li><a href="{$settings.social_linkedin_pageurl}" title="{$text.SOCIAL_BOX_LINKEDIN}" target="_blank">{include file="modules/widgets/icon/icon.tpl" icon="linkedin"}</a></li>
                        {/if}
                        {if $settings.social_instagram_pageurl && $settings.social_instagram}
                            <li><a href="{$settings.social_instagram_pageurl}" title="{$text.SOCIAL_BOX_INSTAGRAM}" target="_blank">{include file="modules/widgets/icon/icon.tpl" icon="instagram"}</a></li>
                        {/if}
                    </ul>
                {/if}

                {$badgesText = $pageCtrl->getText(163)}
                <div class="text-sm mt-2 [&_img]:max-w-48 [&_img]:h-auto">
                    {$badgesText}
                </div>
            </div>

            <!-- Column 2 -->
            {collection assign=footerLinks controller=page categoryId=3}
            {entity assign=footerLinksTitle controller=pageCategory id=3}
            <div class="flex flex-col row-span-2">
                <strong class="text-lg font-bold mb-2">{$footerLinksTitle->Title}</strong>
                {if $footerLinks->getActualSize() > 0}
                    <ul class="flex flex-col gap-2 text-sm">
                        {foreach $footerLinks->getData() as $link}
                        <li>
                            <a href="{$link->Link|formatUrl}" class="text-white hover:underline">
                                <span>{$link->Title}</span>
                            </a>
                        </li>
                        {/foreach}
                    </ul>
                {/if}
            </div>

            <!-- Column 3 -->
            {$location1Headline = $pageCtrl->getHeadline(159)}
            {$location1Text = $pageCtrl->getText(159)}
            <div class="flex flex-col">
                <strong class="text-lg font-bold mb-2">{$location1Headline}</strong>
                <div class="text-sm leading-7">
                    {$location1Text}
                </div>
            </div>

            <!-- Column 4 -->
            {$location1OpeningHoursHeadline = $pageCtrl->getHeadline(161)}
            {$location1OpeningHoursText = $pageCtrl->getText(161)}
            <div class="flex flex-col">
                {if !empty($location1OpeningHoursHeadline)}
                    <strong class="text-lg font-bold mb-2">{$location1OpeningHoursHeadline}</strong>
                {/if}
                <div class="text-sm leading-7 {if empty($location1OpeningHoursHeadline)}lg:mt-9{/if}">
                    {$location1OpeningHoursText}
                </div>
            </div>

            <!-- Column 5 -->
            {$location2Headline = $pageCtrl->getHeadline(160)}
            {$location2Text = $pageCtrl->getText(160)}
            <div class="flex flex-col">
                <strong class="text-lg font-bold mb-2">{$location2Headline}</strong>
                <div class="text-sm leading-7">
                    {$location2Text}
                </div>
            </div>

            <!-- Column 6 -->
            {$location2OpeningHoursHeadline = $pageCtrl->getHeadline(162)}
            {$location2OpeningHoursText = $pageCtrl->getText(162)}
            <div class="flex flex-col">
                {if !empty($location2OpeningHoursHeadline)}
                    <strong class="text-lg font-bold mb-2">{$location2OpeningHoursHeadline}</strong>
                {/if}
                <div class="text-sm leading-7 {if empty($location2OpeningHoursHeadline)}lg:mt-9{/if}">
                    {$location2OpeningHoursText}
                </div>
            </div>

        </div>
    </div>
</footer>