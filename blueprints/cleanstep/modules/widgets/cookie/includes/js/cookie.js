;(function ($, platform, exports) {
  'use strict';

  var cookieRemoveWrap = $('[data-inject="cookieremove"]'),
      consentForm = $('[data-group=w-cookie-form]'),
      acceptButton = consentForm.find('button[type="submit"][name="accept"]');

  if (consentForm.length) {
    consentForm.find('button[type="submit"]').on('click', cookieFormHandler);
    consentForm.find('input[type="checkbox"]').on('change', cookieChangeHandler);
  }

  if ($('[data-inject="cookiedetails"]').length) {
    if (platform.cookielist.internal && platform.cookielist.external) {
      $.get(platform.cookielist.internal).done(function (internal) {
        $.get(platform.cookielist.external).done(function (external) {
          cookieDetails(internal, external);
        });
      });
    }
  }

  if (platform.cookies.indexOf("cookie_consent") > -1 && cookieRemoveWrap.length) {
    cookieRemoveWrap.html('<button class="cookie-button button-primary sw-cookie-remover">' + text.COOKIES_BUTTON_DELETE + '</button>');
    cookieRemoveWrap.find('button.sw-cookie-remover').on('click', cookieRemove);
  }

  // Toggle extended cookie info (used in Tailwind-based markup)
  document.addEventListener("DOMContentLoaded", function () {
    const toggleButtons = document.querySelectorAll(".toggle-extended");

    toggleButtons.forEach((btn) => {
      btn.addEventListener("click", () => {
        const parent = btn.closest("[data-group='w-cookie-form']");
        const description = parent.querySelector(".w-cookie-extended-info");
        if (description) description.classList.toggle("hidden");

        const icon = btn.querySelector("i");
        if (icon) icon.classList.toggle("rotate-90");
      });
    });

    const detailsToggle = document.querySelector(".toggle-details");
    if (detailsToggle) {
      detailsToggle.addEventListener("click", () => {
        const form = document.querySelector("[data-group='w-cookie-form']");
        if (!form) return;

        const listing = form.querySelector("[data-inject='cookiedetails']");
        const consent = form.querySelector("[data-group='w-cookie-text']");
        const showDetails = detailsToggle.querySelector(".details-show");
        const showConsent = detailsToggle.querySelector(".consent-show");

        if (listing) {
          listing.classList.toggle("max-h-[60vh]");
          listing.classList.toggle("opacity-100");
          listing.classList.toggle("opacity-0");
          listing.classList.toggle("overflow-hidden");
          listing.classList.toggle("overflow-auto");
        }

        if (consent) {
          consent.classList.toggle("max-h-[65vh]");  
          consent.classList.toggle("max-h-0");
          consent.classList.toggle("opacity-0");
          consent.classList.toggle("overflow-hidden");
        }

        if (showDetails) showDetails.classList.toggle("hidden");
        if (showConsent) showConsent.classList.toggle("hidden");
      });
    }
  });

  function cookieFormHandler(evt) {
    evt.preventDefault();
    var acceptAll = evt.target.name === 'accept_all';
    var inputVerification = ['REQUIRED', 'FUNCTIONAL', 'STATISTICS', 'MARKETING'];
    var inputs = consentForm.find('input');
    var states = [];
    var errors = false;

    consentForm.find('.w-cookie-loader').removeClass('hidden');

    inputs.each(function () {
      if (acceptAll || this.checked) states.push(this.name);
    });

    states.forEach(function (state) {
      if (inputVerification.indexOf(state) === -1) errors = true;
    });

    if (states.indexOf('REQUIRED') === -1) errors = true;

    if (errors) {
      errorHandler();
    } else {
      $.ajax({
        type: 'POST',
        url: '/actions/cookie/consent',
        data: {
          consent_given: states.length > 0,
          allowed_cookie_types: states.toString()
        },
        success: function () {
          var current = new Date();
          var expiration = new Date(current.getFullYear() + 1, current.getMonth(), current.getDate());
          document.cookie = 'cookie_consent=' + states.toString() + ';expires=' + expiration.toGMTString() + ';path=/';
          sessionStorage.setItem('referrer', document.referrer);
          window.location.reload();
        },
        dataType: 'json'
      }).fail(function (jqXHR) {
        var response = jqXHR.responseText;
        try {
          var parsed = JSON.parse(response);
          errorHandler(parsed.map(function (item) {
            return item.field[0] + ': ' + item.message;
          }).join('\n'));
        } catch (e) {
          errorHandler(response);
        }
      });
    }

    function errorHandler(message) {
      consentForm.find('.w-cookie-loader').addClass('hidden');
      alert(message ? message : text.COOKIES_VERIFICATION_ERROR + ': ' + inputVerification.join(', '));
    }
  }

  function cookieChangeHandler(evt) {
    evt.preventDefault();
    var optionalCookiesSelected = consentForm.find('input[type="checkbox"][name!="REQUIRED"]:checked');
    if (optionalCookiesSelected.length) {
      acceptButton.html(text.COOKIES_ACCEPT);
    } else {
      acceptButton.html(text.COOKIES_DECLINE_ALL);
    }
  }

  function cookieDetails(internal, external) {
    var categoriesDeDubed = Object.keys($.extend({}, internal, external));
    var listedCookies = [];
    var cookies = {};
    var boxTypeIds = consentForm.data('box-type-ids');
    var activeBoxTypeIds = boxTypeIds ? String(boxTypeIds).split(',') : [];

    categoriesDeDubed.forEach(function (category) {
      var categoryCookies = $.extend({}, internal[category], external[category]);

      listedCookies = listedCookies.concat(Object.keys(internal[category]).concat(Object.keys(external[category])));

      cookies[category] = Object.keys(categoryCookies).map(function (item) {
        if (typeof categoryCookies[item] === 'object') {
          var output = categoryCookies[item];
          var columnBoxIdChecker = [];

          var settingsRequirement = !output.requires || !output.requires.length || output.requires.map(function (setting) {
            if (setting.column_type) {
              return columnBoxIdChecker.push(activeBoxTypeIds.includes(setting.column_type));
            }
            return Boolean(platform.settings[setting]) || Boolean(platform.template.settings[setting]);
          }).includes(true);

          output.name = item;

          if (settingsRequirement && !columnBoxIdChecker.includes(false)) {
            return output;
          } else {
            return false;
          }
        }
      }).filter(Boolean);
    });

    platform.cookies.forEach(function (key) {
      if (listedCookies.indexOf(key) === -1) {
        cookies['uncategorized'] = cookies['uncategorized'] || [];
        cookies['uncategorized'].push({ name: key });
      }
    });

    $('[data-inject="cookiedetails"]').html(
      categoriesDeDubed.map(function (category) {
        return buildSection(cookies[category], category);
      }).join('')
    );

    initAccordion();

    function initAccordion() {
        $('button.accordion-btn').each(function() {
            $(this).unbind('click');
            $(this).click(function(evt) {
                var wrapper = $(evt.target).closest('.accordion-wrapper');
                wrapper.toggleClass('closed');
                wrapper.find('.accordion-section').slideToggle(300, function() {
                    $(this).toggleClass('open');
                });
                $(this).find('i').toggleClass('fa-caret-down fa-caret-up');
            });
        });
    }


    function buildSection(cookieList, category) {
      var categoryTrans = text['COOKIES_' + category.toUpperCase()] || category;
      var categoryDescription = text['COOKIES_DESCRIPTION_' + category.toUpperCase()] ?
        '<p class="accordion-description">' + text['COOKIES_DESCRIPTION_' + category.toUpperCase()] + '</p>' : '';

      var listString = cookieList.map(function (cookie) {
        var categoryName = cookie.category ? text['COOKIES_' + cookie.category.toUpperCase()] : text.COOKIES_UNKNOWN;
        var translation = { description: text.COOKIES_UNKNOWN, expiration: text.COOKIES_UNKNOWN };

        if (cookie.translations) {
          translation =
            cookie.translations[platform.language.iso] ||
            cookie.translations[platform.language.iso.substring(0, 2)] ||
            cookie.translations.UK ||
            translation;
        }

        return `
          <tr class="border-t">
            <td class="p-2">
              <p>${cookie.name}</p>
              <strong class="is-visible-s">${text.COOKIES_LIST_ORIGIN}:</strong>
              <p class="is-visible-s">${cookie.origin || ''}</p>
              <strong class="is-visible-s">${text.COOKIES_LIST_DESCRIPTION}:</strong>
              <p class="is-visible-s">${translation.description}</p>
            </td>
            <td class="is-hidden-s p-2"><p>${cookie.origin || ''}</p></td>
            <td class="is-hidden-s p-2"><p>${translation.description}</p></td>
            <td class="p-2"><p>${translation.expiration}</p></td>
          </tr>
        `;
      }).join('');

      return listString.length ? `
        <div class="accordion-wrapper closed rounded-2xl shadow-md border border-gray-200 overflow-hidden transition-all">
          <button type="button" class="accordion-btn flex items-center justify-between w-full px-4 py-3 bg-gray-100 hover:bg-gray-200 text-left transition-colors duration-200">
            <i class="fa fa-chevron-down text-gray-500 transition-transform duration-300"></i>
            <div class="accordion-text">
              <strong class="accordion-title text-base font-medium text-gray-800">${categoryTrans}</strong>
              ${categoryDescription}
            </div>
          </button>
          <div class="accordion-section handle-scrollHeight bg-white px-4 py-3 text-sm text-gray-700 transition-all">
            <table class="w-full table-auto border-t border-gray-200">
              <thead>
                <tr class="text-xs uppercase text-gray-500 bg-gray-50">
                    <th class="p-2 text-left">${text.COOKIES_LIST_COOKIE}:</th>
                    <th class="is-hidden-s p-2 text-left">${text.COOKIES_LIST_ORIGIN}:</th>
                    <th class="is-hidden-s p-2 text-left">${text.COOKIES_LIST_DESCRIPTION}:</th>
                    <th class="p-2 text-left">${text.COOKIES_LIST_EXPIRE}:</th>
                </tr>
              </thead>
              <tbody class="text-sm">${listString}</tbody>
            </table>
          </div>
        </div>
      ` : '';
    }
  }

  function cookieRemove() {
    var cookies = document.cookie.split(';');
    cookies.forEach(function (cookieItem) {
      var cookie = cookieItem.trim();
      var name = cookie.indexOf('=') > -1 ? cookie.substr(0, cookie.indexOf('=')) : cookie;
      document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/';
    });
    window.location.reload();
  }
})(jQuery, window.platform, window);
