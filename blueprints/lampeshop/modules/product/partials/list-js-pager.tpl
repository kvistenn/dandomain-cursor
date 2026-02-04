{*

# Description
AngularJS template for paging of the product list. Part of the Product page type.


## Date last modified
2015-06-18


## Resource
+ [AngularJS](https://angularjs.org/)


## Primary variables
+ page 														- Number telling the current page displayed


## Partials (templates)
No extra templates required for this template

*}


{literal}
    <div class="ng-hide" data-ng-show="maxPage > 1">
        <ul class="flex gap-4 items-center border-t border-gray-200 p-3 px-4">
            <li data-ng-class="{'is-disabled': page == 1}" class="mr-auto w-8 h-8 flex items-center justify-center bg-secondary text-black cursor-pointer rounded">
                <a data-ng-href="{{link('prev')}}" href="" data-ng-click="version >= 20170706 ? nav($event, 'prev') : prevPage()">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
                    </svg>
                </a>
            </li>

            <li data-ng-repeat="n in range()"
                data-ng-class="{'text-black': n == page, 'text-gray-400': n != page}"
                data-ng-click="version >= 20170706 ? nav($event, n) : setPage()">
                    <a data-ng-href="{{link(n)}}" href="" data-ng-bind="n">1</a>
            </li>

            <li data-ng-class="{'is-disabled': page == maxPage}" class="ml-auto w-8 h-8 flex items-center justify-center bg-secondary text-black cursor-pointer rounded">
                <a data-ng-href="{{link('next')}}" href="" data-ng-click="version >= 20170706 ? nav($event, 'next') : nextPage()">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
                    </svg>
                </a>
            </li>
        </ul>
    </div>
    {/literal}
    