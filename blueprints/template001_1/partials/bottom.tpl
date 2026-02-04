<footer class="site-footer"  itemscope itemtype="http://schema.org/WPFooter">
	<div class="container with-xlarge trailing-trip">
		<div class="row">
			<div class="col-s-4 col-m-12 col-l-12 col-xl-24 text-center">
				<ul class="list-inline contact-data-container">
					{if $contactdata.name && $template.settings.SETTINGS_SHOW_CONTACT_TITLE}
						<li class="contact-data-name contact-data-list"><span><strong>{$contactdata.name}</strong></span></li>
					{/if}
					{if $contactdata.address && $template.settings.SETTINGS_SHOW_CONTACT_ADDRESS}
						<li class="contact-data-address contact-data-list"><span>{$contactdata.address}</span></li>
					{/if}
					{if ($contactdata.zipcode && $template.settings.SETTINGS_SHOW_CONTACT_ZIPCODE) || ($contactdata.city && $template.settings.SETTINGS_SHOW_CONTACT_CITY)}
						<li class="contact-data-address contact-data-list"><span>
							{if $contactdata.zipcode && $template.settings.SETTINGS_SHOW_CONTACT_ZIPCODE}
								{$contactdata.zipcode}
							{/if}
							{if $contactdata.city && $template.settings.SETTINGS_SHOW_CONTACT_CITY}
								{$contactdata.city}
							{/if}
						</span></li>
					{/if}
					{if $contactdata.country && $template.settings.SETTINGS_SHOW_CONTACT_COUNTRY}
						<li class="contact-data-country contact-data-list"><span>{$contactdata.country}</span></li>
					{/if}
					{if $contactdata.phone && $template.settings.SETTINGS_SHOW_CONTACT_PHONE}
						<li class="contact-data-telephone contact-data-list"><span><span class="contact-text">{$text.TELEPHONE}</span><span class="contact-colon">:</span> {$contactdata.phone}</span></li>
					{/if}
					{if $contactdata.mobilephone && $template.settings.SETTINGS_SHOW_CONTACT_MOBILE}
						<li class="contact-data-mobile contact-data-list"><span><span class="contact-text">{$text.MOBILE}</span><span class="contact-colon">:</span> {$contactdata.mobilephone}</span></li>
					{/if}
					{if $contactdata.fax && $template.settings.SETTINGS_SHOW_CONTACT_FAX}
						<li class="contact-data-fax contact-data-list"><span><span class="contact-text">{$text.FAX}</span><span class="contact-colon">:</span> {$contactdata.fax}</span></li>
					{/if}
					{if $contactdata.email && $template.settings.SETTINGS_SHOW_CONTACT_EMAIL}
						<li class="contact-data-email contact-data-list">
							<span class="contact-text">{$text.MAIL}</span><span class="contact-colon">:</span>
							{if $settings.spam_email_block}
								{$email = $contactdata.email|replace:'@':'---'}
								{placeholdImage assign=placeholder text=$email color=$template.settings.FONT_COLOR_LINK atreplace='---' transparent=true size=10}
							   	<a href="/obfuscated/" onclick="var m = '{$email}'; this.href = 'mailto:' + m.replace('---', '@'); return true;">
							   		<span>
							      		{img style="margin:0; vertical-align: middle;" alt="" src="{$placeholder->getRelativeFile()}"}
							      </span>
							   	</a>
							{else}
							   	<a href="mailto:{$contactdata.email}">{$contactdata.email}</a>
							{/if}
						</li>
					{/if}
					{if $contactdata.vatnumber && $template.settings.SETTINGS_SHOW_CONTACT_VAT_NUMBER}
						<li class="contact-data-vat contact-data-list"><span><span class="contact-text">{$text.VAT_NR}</span><span class="contact-colon">:</span> {$contactdata.vatnumber}</span></li>
					{/if}
					{if $contactdata.bankinfo && $template.settings.SETTINGS_SHOW_CONTACT_BANK_NUMBER}
						<li class="contact-data-bank contact-data-list"><span><span class="contact-text">{$text.BANK_DETAILS}</span><span class="contact-colon">:</span> {$contactdata.bankinfo}</span></li>
					{/if}
					{if $template.settings.SETTINGS_SHOW_SITEMAP}
						<li class="contact-data-site-map contact-data-list"><a href="/{$text.SITEMAP_LINK}/">{$text.SITEMAP_HEADLINE}</a></li>
					{/if}
				</ul>
			</div>

			{$socialFooter = $settings.social_instagram && !empty($settings.social_instagram_pageurl) || 
				$settings.social_facebook && !empty($settings.social_plugin_likebox_pageurl) || 
				$settings.social_twitter  && !empty($settings.social_twitter_pageurl) || 
				$settings.social_youtube  && !empty($settings.social_youtube_pageurl) || 
				$settings.social_linkedin && !empty($settings.social_linkedin_pageurl)
			}

			{if $socialFooter}
				<div class="col-s-4 col-m-12 col-l-12 col-xl-24 text-center social-links">
					{if $settings.social_plugin_likebox_pageurl and $settings.social_facebook}
						<a class="social-link social-facebook" href="{$settings.social_plugin_likebox_pageurl}" title="{$text.SOCIAL_BOX_FACEBOOK}" target="_blank" rel="noopener"><i class="fa fa-facebook-square"></i> {$text.SOCIAL_BOX_FACEBOOK}</a>
					{/if}
					{if $settings.social_twitter_pageurl and $settings.social_twitter}
						<a class="social-link social-twitter" href="{$settings.social_twitter_pageurl}" title="{$text.SOCIAL_BOX_TWITTER}" target="_blank" rel="noopener"><i class="fa fa-twitter-square"></i> {$text.SOCIAL_BOX_TWITTER}</a>
					{/if}
					{if $settings.social_youtube_pageurl and $settings.social_youtube}
						<a class="social-link social-youtube" href="{$settings.social_youtube_pageurl}" title="{$text.SOCIAL_BOX_YOUTUBE}" target="_blank" rel="noopener"><i class="fa fa-youtube-play"></i> {$text.SOCIAL_BOX_YOUTUBE}</a>
					{/if}
					{if $settings.social_linkedin_pageurl and $settings.social_linkedin}
						<a class="social-link social-linkedin" href="{$settings.social_linkedin_pageurl}" title="{$text.SOCIAL_BOX_LINKEDIN}" target="_blank" rel="noopener"><i class="fa fa-linkedin-square"></i> {$text.SOCIAL_BOX_LINKEDIN}</a>
					{/if}
					{if $settings.social_instagram_pageurl && $settings.social_instagram}
						<a class="social-link social-instagram" href="{$settings.social_instagram_pageurl}" title="{$text.SOCIAL_BOX_INSTAGRAM}" target="_blank" rel="noopener"><i class="fa fa-instagram"></i> {$text.SOCIAL_BOX_INSTAGRAM}</a>
					{/if}
				</div>
			{/if}
		</div>
	</div>

	<!-- paymenticons -->
	{if $general.isShop && $template.settings.SETTINGS_SHOW_CART_ICONS_FOOTER}
		<div class="text-center footer-paymenticons">
			{if $template.settings.SETTINGS_SHOW_BIG_CART_ICONS_FOOTER}
				{$imageWidth  = 54}
				{$imageHeight = 30}
				{paymentIcons assign=icons iconSize=large}
			{else}
				{$imageWidth  = 34}
				{$imageHeight = 24}
				{paymentIcons assign=icons}
			{/if}
			{if $icons->getActualSize() gt 0}

				{include file="modules/widgets/image/placeholder-aspect.tpl" 
					width=$imageWidth 
					height=$imageHeight
					selector=":not(.ielt9) .footer-paymenticons"}

				<ul class="payment-icons list-unstyled">
					{foreach $icons->getData() as $icon}
						<li class="payments-icon payments-icon-{$icon@index} is-inline-block placeholder-wrapper">
							<span class="placeholder"></span>
							{img alt="{$icon->Title}" title="{$icon->Title}" src="{$template.cdn}{$icon->RelativeFile}"}
						</li>
					{/foreach}
				</ul>
			{/if}
		</div>
	{/if}

	{$builtWithText = $general.builtWithText}
	{if !empty($builtWithText)}
		<p class="text-center">{$builtWithText}</p>
	{/if}
</footer>
