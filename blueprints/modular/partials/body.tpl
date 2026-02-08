<script>
    ;(function (exports) {
        exports.text = {$text|jsonify};
        exports.platform = exports.platform || {};
        exports.platform.template = {$template|jsonify};
        exports.platform.currency = {$currency|json_encode};
        exports.platform.general = {$general|jsonify};
        exports.platform.shop = {$shop|jsonify};
        exports.platform.cookies = {$smarty.cookies|array_keys|jsonify};
        exports.platform.client = {
            ip: '{$client.ip}'
        };
        exports.platform.consent = {$cookieConsent.consent|jsonify};
        exports.platform.cookielist = {
            internal: {$cookieConsent.lists.internal},
            external: {$cookieConsent.lists.external}
        };
        exports.platform.language = {
            iso: '{$general.languageIso}',
            iso639: '{$general.languageIso639}'
        };
        exports.platform.page = {$page|jsonify};
        exports.platform.user = {$user|jsonify};
        exports.platform.adminUser = {$adminUser|jsonify};
        exports.platform.settings = {$settings|jsonify};
        exports.platform.getSetting = function (key) {
            if (typeof this.settings[key] !== 'undefined') {
                return this.settings[key];
            }
            return null;
        };
        {helperSession key='cartLastCache' assign='cartCache'}
        {if $cartCache}
            exports.platform.settings.cartLastCache = '{$cartCache}';
        {/if}
    })(window);
</script>

{*** Display all scripts added thru addScript help ***}
{foreach $head.scripts as $script}<script {foreach $script->attributes as $k => $v}{$k}="{$v}" {/foreach}></script>
{/foreach}

{*** Facebook like ***}
{* Modules will be added here as they are redesigned *}

{*** Twitter tweet ***}
{* Modules will be added here as they are redesigned *}

{*** Google integration ***}
{* Modules will be added here as they are redesigned *}

{*** Facebook Marketing Pixel integration ***}
{* Modules will be added here as they are redesigned *}

{*** ViaBill integration ***}
{* Modules will be added here as they are redesigned *}

{includeScript file='partials/bodyBottom.js.tpl'}
