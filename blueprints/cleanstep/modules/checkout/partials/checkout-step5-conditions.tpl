{controller assign=pageController type=page}
{$termsLink = $settings.link_terms_and_conditions}
{if $user and $user->IsB2B and $settings.link_terms_and_conditions_b2b}
    {$termsLink = $settings.link_terms_and_conditions_b2b}
{/if}

{if !isset($repay)}
    {$repay = false}
{/if}

<label class="mt-5 flex items-center rounded gap-4 text-xs md:text-sm bg-white {if $repay}w-fit{else}w-full border border-gray-300 p-4{/if}">
    <input type="checkbox" name="acceptTerms" class="w-4 h-4 flex-none" id="acceptTerms" value="1" required />
    <span class="flex-auto">{$Text.CHECKOUT_STEP_FOUR_ACCEPT_TERMS}</span>
</label>

{if $repay}
    <button class="px-6 h-14 rounded bg-black text-white text-sm w-full md:w-fit my-5" type="submit">{$text.CHECKOUT_PAYMENT_FORM_PROCEED}</button>
    {else}
    <div class="mt-5 flex flex-col md:items-center gap-4 md:grid md:grid-cols-2 lg:hidden">
        <div>
            <a href="{$text.CART_LINK|formatUrl}" class="text-brand-2 text-sm flex items-center gap-1 justify-center md:justify-start">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4">
                    <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" />
                </svg>
                {$text.CART_GO_TO}
            </a>
        </div>
        <div>
            <button data-checkout="proceed" class="px-6 h-14 rounded bg-black text-white text-sm w-full md:w-fit hidden md:block" type="submit">{$text.CHECKOUT_PAYMENT_FORM_PROCEED}</button>
        </div>
    </div>
    {/if}
