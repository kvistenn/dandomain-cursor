{*

# Description
Notification widget. A widget is a small helper template, with some functionality.
Panel used to show system notifications


## Date last modified
2014-08-01


## Primary variables
+ $message                                                              - Message information from the system
+ $text                                                                 - Global scope variable containing translations


## Partials (templates)
No extra templates required for this template

*}

<div data-notification></div>

{if $message}
    <script>
        
        function waitForMessage() {
            if (typeof platform.Message !== 'undefined' && typeof platform.Message.load === 'function') {
                platform.Message.load('{$message->text()}', '{$message->status()}');
            } else {
                setTimeout(waitForMessage, 100);
            }
        }

        waitForMessage();
    </script>
{/if}

