(function ($) {
    
    const $recaptcha = $('form .g-recaptcha');
    if (!$recaptcha.length) {
        return;
    }
    
    const $forms = $recaptcha.closest('form');
    const badgeOptions = $recaptcha.data('options');
    let hasLazyload = true;
    
    $recaptcha.each(function () {
        const options = $(this).data('options');
        if (!options.lazyload) {
            hasLazyload = false;
        }
    });

    window.reCaptchaCallback = globalCallback(badgeOptions, $recaptcha);

    if (hasLazyload) {
        $forms.one('mouseover.recaptchaInit focus.recaptchaInit', function () {
            $forms.off('.recaptchaInit');
            setLoading(true);
            load( setLoading(false) );
        });
    } else {
        load();
    }

    function load(complete) {
        const $script = $('script#recaptcha');
        const lazyLoadSrc = $script.data('lazyload-src');
        
        $.getScript(lazyLoadSrc).done(function () {
            !!complete && complete();
        }).fail(function () {
            console.error('failed to load recaptcha from google');
        });
    }

    function globalCallback() {

        // cache recaptcha width
        const reCaptchaWidth = 304;
        const reCaptchaInvisibleWidth = 256;
        
        return function () {
            $recaptcha.each(function () {
                let holderId;
                const self = this,
                    // elements
                    $this = $(this),
                    $form = $this.closest('form'),
                    // badge options
                    options = $this.data('options'),
                    version = options.version,
                    config = options.config,
                    isInvisible = config.size === 'invisible',
                    // box styling
                    boxWidth = isInvisible
                               ? reCaptchaInvisibleWidth
                               : reCaptchaWidth,
                    hasBoxOverflow = config.badge === 'inline' && boxWidth
                                     > $form.outerWidth();
                
                if (version === 'V3') {
                    if (hasBoxOverflow) {
                        $this.addClass('g-recaptcha-small');
                    }
                    holderId = grecaptcha.render(self, config);
                    $form.one('submit', function (evt) {
                        evt.preventDefault();
                        grecaptcha.execute(holderId, {action: 'submit'}).then(function(token) {
                            $form.find('[name="recaptcha_response"]').val(token);
                            $form.find(':submit').click();
                        });
                    });
                } else if (version === 'V2') {
                    const $parent = $this.closest('fieldset.w-recatpcha');
                    
                    config.callback = function (recaptchaToken) {
                        if (isInvisible) {
                            $form.find('#g-recaptcha-response').val(recaptchaToken);
                            $form.find(':submit').click();
                        }
                    }
                    if (isInvisible) {
                        if (hasBoxOverflow) {
                            $this.addClass('g-recaptcha-small');
                        }
                    } else {
                        config.size = hasBoxOverflow ? 'compact' : 'normal';
                    }

                    holderId = grecaptcha.render(self, config);
                    if (config.size === 'invisible') {
                        $form.on('submit', function (evt) {
                            const token = window.grecaptcha.getResponse(holderId);
                            let checkValidity = true;
                            if (typeof $form[0].checkValidity === 'function') {
                                checkValidity = $form[0].checkValidity(); //Trigger HTML5 validation
                            }
                            // if no token, mean user is not validated yet
                            if (checkValidity && !token) {
                                // trigger validation
                                evt.preventDefault();
                                window.grecaptcha.execute(holderId);
                            }
                        });
                    }

                    // Bind reset button to the associated field
                    $parent.find('i').click(function () { grecaptcha.reset(widgetId) });
                }
            });
        }
    }

    function setLoading(isLoading) {
        $forms.find('[type=submit]').prop('disabled', isLoading);
    }

})(jQuery);