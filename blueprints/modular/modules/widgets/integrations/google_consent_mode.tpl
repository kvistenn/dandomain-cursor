{*

# Description
Google Analytics consent mode handling for gtag.js


## Date last modified
2024-02-12


## Primary variables
+ $template                                                             - Array with settings from the template


## Partials (templates)
No extra templates required for this template

*}

{* Print tags *}
{if $template.settings.COOKIE_TYPE === 'COOKIE_CONSENT'}
    {$defaultParameters = [
        'functionality_storage' => 'denied',
        'security_storage' => 'denied',
        'personalization_storage' => 'denied',
        'analytics_storage' => 'denied',
        'ad_storage' => 'denied',
        'ad_user_data' => 'denied',
        'ad_personalization' => 'denied'
    ]}

    gtag('consent', 'default', {$defaultParameters|jsonify});

    {if in_array(true, $cookieConsent.consent, true)}
        {call getUpdateParameters 
            defaultParameters=$defaultParameters
            consentState=$cookieConsent.consent
            returnVar='updateParameters'
        }

        gtag('consent', 'update', {$updateParameters|jsonify});
    {/if}
{/if}

{* Functions *}
{function getUpdateParameters
    defaultParameters=[]
    consentState=[
        REQUIRED => false,
        FUNCTIONAL => false,
        STATISTICS => false,
        MARKETING => false
    ]
}
    {$parameters = $defaultParameters}

    {if $consentState['REQUIRED']}
        {$parameters['functionality_storage'] = 'granted'}
        {$parameters['security_storage'] = 'granted'}
    {/if}

    {if $consentState['FUNCTIONAL']}
        {$parameters['personalization_storage'] = 'granted'}
    {/if}
    
    {if $consentState['STATISTICS']}
        {$parameters['analytics_storage'] = 'granted'}
    {/if}
    
    {if $consentState['MARKETING']}
        {$parameters['ad_storage'] = 'granted'}
        {$parameters['ad_user_data'] = 'granted'}
        {$parameters['ad_personalization'] = 'granted'}
    {/if}

    {assign var=$returnVar value=$parameters scope='parent'}
{/function}
