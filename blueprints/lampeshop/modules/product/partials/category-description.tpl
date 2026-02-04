{*

# Description
Template partial for category description in the category / product list. Part of the Product page type.


# Date last modified
2015-04-20


## Primary variables
+ $title                                                                - Name of the category
+ $description 															- Description of the category
+ $page 																- Global scope variable containing all information about the page type


## Partials (templates)
No extra templates required for this template

*}

{*** Category description ***}
{if $description}
    <div class="category-description content ck-content">{$description}</div>
{/if}
