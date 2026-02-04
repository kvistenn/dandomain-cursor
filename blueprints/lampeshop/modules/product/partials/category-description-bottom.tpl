{*

# Description
Template partial for category description bottom in the category / product list. Part of the Product page type.


# Date last modified
2014-08-01


## Primary variables
+ $title                                                                - Name of the category
+ $descriptionBottom 													- Short description of the category
+ $page 																- Global scope variable containing all information about the page type


## Partials (templates)
No extra templates required for this template

*}


{*** Category short description ***}
<div class="py-2 lg:py-10 border-t border-gray-200">

    <div class="container mx-auto">
        <div class="p-5 lg:pr-10">
            <div class="category-short-description prose max-w-full">
                {$descriptionBottom}
            </div>
        </div>
    </div>
</div>