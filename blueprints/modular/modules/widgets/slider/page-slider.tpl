{*
# Description
Widget for the general picture element slider (page images). Uses Swiper.

## Supplied variables
+ $crop - Possible values: false, true, "fill", "white", default: "fill"
*}

{controller type=page assign=pageController}
{$peSettings = $pageController->pictureElementSettings($page.id)}

{$height = 440}
{if !empty($peSettings["height"])}
    {$height = $peSettings["height"]}
{/if}

{$cycleSpeed = 5000}
{if !empty($peSettings["cycleSpeed"])}
    {$cycleSpeed = $peSettings["cycleSpeed"]}
{/if}

{$cycleRandom = false}
{if !empty($peSettings["sortingOrder"]) && $peSettings["sortingOrder"] == "random"}
    {$cycleRandom = true}
{/if}

{if !isset($crop)}
    {if !empty($template.settings.DESIGN_IMAGE_BACKGROUND_COLOR)}
        {$crop = $template.settings.DESIGN_IMAGE_BACKGROUND_COLOR}
    {else}
        {$crop = "fill"}
    {/if}
{/if}

{$sliderSettings = [
    "theme"      => "slider-theme",
    "pagination" => true,
    "nav"        => true,
    "width"      => 1240,
    "height"     => $height,
    "crop"       => $crop,
    "speed"      => $cycleSpeed,
    "autoplay"   => true,
    "random"     => $cycleRandom
]}

{include file="modules/widgets/slider/slider.tpl" widgetSettings=$sliderSettings type=page id=$page.id}
