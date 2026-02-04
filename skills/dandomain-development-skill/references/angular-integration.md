# AngularJS Integration for DanDomain

Comprehensive guide to integrating AngularJS with Smarty templates and DanDomain controllers for dynamic client-side functionality.

## Integration Philosophy

AngularJS in DanDomain follows a specific pattern:
- **Smarty prepares initial state** via server-side rendering
- **AngularJS enhances with interactivity** on the client
- **Events coordinate** between Angular, jQuery, and vanilla JS
- **JSON endpoints** provide data without page reloads

## Bootstrap and Setup

### Application Bootstrap

Initialize AngularJS on the root element:

```html
<body id="ng-app" data-ng-app="platform-app">
  <!-- All Angular content goes here -->
</body>
```

The `platform-app` module is the main Angular application that coordinates all controllers and services.

### Controller Declaration

Declare Angular controllers on containers that need dynamic behavior:

```html
<div class="product-list-container"
     data-ng-controller="productlist-ctrl"
     data-ng-init="hasLeftColumns = 1"
     data-field="{$field}"
     data-viewmode="{$viewmode}"
     data-category-id="{$categoryId}"
     data-image-width="385">

  <!-- Controller scope applies to all children -->
</div>
```

**Key Points:**
- Use `data-ng-controller` for HTML5 validity
- Initialize values with `data-ng-init`
- Pass Smarty variables via `data-*` attributes
- Controller reads these attributes on initialization

## Data Flow Patterns

### Smarty to AngularJS

**Pattern 1: Data Attributes**

Simplest method for scalar values:

```html
{* Smarty template *}
<div data-ng-controller="product-ctrl"
     data-product-id="{$product->Id}"
     data-product-title="{$product->Title|escape:'html'}"
     data-price="{$product->Price}"
     data-in-stock="{if $product->Stock gt 0}true{else}false{/if}">
  <!-- Angular reads from element.dataset -->
</div>
```

**Pattern 2: JSON in Script Tags**

For complex data structures:

```smarty
{* Prepare data in Smarty *}
{$productData = []}
{foreach $products->getData() as $product}
  {entity assign=image controller=files type=product productId=$product->Id}
  {$productData[] = [
    'id' => $product->Id,
    'title' => $product->Title,
    'price' => $product->Price,
    'image' => $image ? $image->thumbnail(400, 400) : null,
    'stock' => $product->Stock
  ]}
{/foreach}

{* Expose to JavaScript *}
<script>
  window.productListData = {$productData|jsonify};
</script>

{* Angular controller reads window.productListData *}
<div data-ng-controller="productlist-ctrl"
     data-ng-init="loadProducts()">
  <!-- Products rendered by Angular -->
</div>
```

**Pattern 3: Server-Side Initial Render**

Combine Smarty rendering with Angular enhancement:

```smarty
<div data-ng-controller="productlist-ctrl">
  {* Smarty renders initial content for SEO *}
  {foreach $products->getData() as $product}
    <div class="product-card"
         data-product-id="{$product->Id}"
         data-ng-click="selectProduct({$product->Id})">
      <h3>{$product->Title}</h3>
      <p>{$product->Price|formatPrice}</p>
    </div>
  {/foreach}

  {* Angular can replace or enhance this markup *}
</div>
```

### AngularJS to Backend

**AJAX Requests to JSON Endpoints:**

```javascript
// In Angular controller
$scope.loadProducts = function(categoryId) {
  $http.get('/json/products/category/' + categoryId)
    .then(function(response) {
      if (response.data.code === 1) {
        $scope.products = response.data.data;
      }
    });
};

$scope.loadVariant = function(productId, dataIds) {
  var params = { dataIds: dataIds.join(',') };
  $http.get('/json/productvariants/' + productId, { params: params })
    .then(function(response) {
      $scope.updateProductDisplay(response.data);
    });
};
```

**JSON Endpoint Structure:**

```smarty
{* modules/json/products.tpl *}
{collection assign=products controller=productList categoryId=$request.args.categoryId}
{assign var=output value=['code'=>1,'data'=>[]]}

{foreach $products->getData() as $product}
  {entity assign=image controller=files type=product productId=$product->Id}
  {entity assign=brand controller=brand id=$product->ProducerId}

  {$output.data[] = [
    'id' => $product->Id,
    'title' => $product->Title,
    'price' => $product->Price,
    'description' => $product->Description,
    'image' => $image ? $image->thumbnail(400, 400) : null,
    'brand' => $brand ? ['name' => $brand->Name, 'logo' => $brand->Logo] : null,
    'stock' => $product->Stock,
    'active' => $product->Active
  ]}
{/foreach}

{$output|jsonify}
```

## Repeat and Rendering

### ng-repeat Directive

Render dynamic lists with AngularJS:

```html
<div data-ng-controller="productlist-ctrl">
  <div class="product-grid">
    <div data-ng-repeat="product in productlist track by product.Id"
         data-ng-controller="product-ctrl"
         data-repeat-done="loaded.productlist"
         class="product-card">

      <img ng-src="{{ product.Image }}" alt="{{ product.Title }}">
      <h3>{{ product.Title }}</h3>
      <p class="price">{{ product.Price | currency }}</p>

      <button ng-click="addToCart(product.Id)"
              ng-disabled="product.Stock === 0">
        Add to Cart
      </button>
    </div>
  </div>
</div>
```

**Important:**
- Use `track by` for performance (avoid re-rendering unchanged items)
- Nest controllers for hierarchical data management
- `data-repeat-done` directive emits event when rendering completes

### The repeat-done Directive

Custom directive that fires events after ng-repeat completes:

```html
<div data-ng-repeat="product in products track by product.Id"
     data-repeat-done="loaded.productlist">
  <!-- Content -->
</div>
```

**When repeat finishes:**
```javascript
// Event is published via platform.js
$(platform).publish('loaded.productlist', { count: products.length });

// Or as DOM event
document.dispatchEvent(new CustomEvent('loaded.productlist', {
  detail: { count: products.length }
}));
```

**Listen to the event:**
```javascript
$(platform).on('loaded.productlist', function(event, data) {
  console.log('Product list rendered:', data.count, 'items');
  // Initialize variant selectors, lazy load images, etc.
  initializeProductCardInteractions();
});
```

## Event-Driven Architecture

### Platform Events

AngularJS publishes events via `platform.js` to notify other modules:

```javascript
// In Angular controller
$scope.selectProduct = function(product) {
  $scope.selectedProduct = product;

  // Notify platform
  window.platform.publish('/product/selected', product);
};

$scope.selectVariant = function(product, variant) {
  $scope.selectedVariant = variant;

  // Notify with multiple arguments
  window.platform.publish('/product/variant/selected', product, variant);
};
```

**Standard event names:**
- `/product/ready` - Product data loaded
- `/product/selected` - Product selected by user
- `/product/variant/selected` - Variant choice made
- `/product/packet/selected` - Package/bundle selected
- `/cart/ready` - Cart initialized
- `fetch.productlist` - Before fetching product list
- `loaded.productlist` - After product list rendered

### Custom DOM Events

For cross-module communication without Angular dependency:

```javascript
// Dispatch custom event from Angular
$scope.updateSelection = function() {
  var total = calculateTotal();

  document.dispatchEvent(new CustomEvent('productSelectionChanged', {
    detail: {
      productId: $scope.selectedProduct.Id,
      variantId: $scope.selectedVariant.Id,
      quantity: $scope.quantity,
      total: total
    }
  }));
};
```

**Listen from non-Angular code:**
```javascript
document.addEventListener('productSelectionChanged', function(event) {
  var detail = event.detail;

  // Update sticky footer
  updateStickyPrice(detail.total);

  // Update analytics
  trackProductView(detail.productId);

  // Update cart button
  updateCartButton(detail.quantity);
});
```

### Conditional Events

Choose event names dynamically based on page context:

```javascript
// Determine event name
var eventName = platform.page.isProduct && !platform.page.productId
  ? 'fetch.productlist'
  : 'loaded.productlist';

// Publish appropriate event
window.platform.publish(eventName, { products: $scope.products });

// Listeners can handle both
$(platform).on('fetch.productlist loaded.productlist', function(event, data) {
  console.log('Product list event:', event.type, data);
});
```

## Integration with jQuery and Vanilla JS

### Listening to Angular Events

Non-Angular code waits for Angular to finish rendering:

```javascript
$(platform).on('loaded.productlist', function() {
  // Angular has finished rendering products
  // Safe to manipulate DOM

  // Initialize variant selectors
  document.querySelectorAll('[data-variant="variant"]').forEach(function(container) {
    initializeVariantSelector(container);
  });

  // Lazy load images
  document.querySelectorAll('[data-lazy-src]').forEach(function(img) {
    img.src = img.getAttribute('data-lazy-src');
  });

  // Initialize tooltips
  $('[data-toggle="tooltip"]').tooltip();
});
```

### Variant Selection Pattern

Common pattern for variant selectors that update via AJAX:

```javascript
$(platform).on('loaded.productlist', function() {
  // Find all variant selectors
  document.querySelectorAll('[data-variant="variant"]').forEach(function(container) {
    var productId = container.getAttribute('data-product-id');

    // Bind click events to variant values
    container.addEventListener('click', function(event) {
      var valueEl = event.target.closest('span[data-value]');
      if (!valueEl) return;

      // Collect selected variant data IDs
      var dataIds = [];
      container.querySelectorAll('span.selected').forEach(function(selected) {
        dataIds.push(selected.getAttribute('data-value'));
      });

      // Fetch updated variant data
      fetch('/json/productvariants/' + productId + '?dataIds=' + dataIds.join(','))
        .then(function(response) { return response.json(); })
        .then(function(data) {
          // Update product card with new variant info
          updateProductCard(container, data);
        })
        .catch(function(error) {
          console.error('Variant fetch failed:', error);
        });
    });
  });
});

function updateProductCard(container, variantData) {
  // Update image
  var img = container.querySelector('.product-image');
  if (img && variantData.image) {
    img.src = variantData.image;
  }

  // Update price
  var price = container.querySelector('.product-price');
  if (price && variantData.price) {
    price.textContent = window.platform.currency_format(variantData.price);
  }

  // Update stock status
  var stockEl = container.querySelector('.stock-status');
  if (stockEl) {
    stockEl.textContent = variantData.stock > 0 ? 'In Stock' : 'Out of Stock';
    stockEl.className = 'stock-status ' + (variantData.stock > 0 ? 'in-stock' : 'out-of-stock');
  }

  // Update add to cart button
  var button = container.querySelector('.add-to-cart');
  if (button) {
    button.disabled = variantData.stock === 0;
    button.setAttribute('data-variant-id', variantData.id);
  }
}
```

### Communication Boundaries

**Best Practice:** Use events as integration boundaries

```javascript
// ❌ Bad: Direct DOM manipulation from Angular
angular.module('platform-app').controller('product-ctrl', function($scope) {
  $scope.selectVariant = function(variant) {
    // Don't do this - reaching outside Angular
    document.querySelector('.sticky-footer .price').textContent = variant.price;
  };
});

// ✅ Good: Publish event, let listener handle it
angular.module('platform-app').controller('product-ctrl', function($scope) {
  $scope.selectVariant = function(variant) {
    // Publish event
    window.platform.publish('/product/variant/selected', $scope.product, variant);
  };
});

// External listener updates UI
window.platform.subscribe('/product/variant/selected', function(event, product, variant) {
  document.querySelector('.sticky-footer .price').textContent =
    window.platform.currency_format(variant.price);
});
```

## Smarty-Angular Communication Patterns

### Waiting for Angular Modules

Smarty can't directly execute Angular code, so use polling:

```smarty
{if $message}
<script>
function waitForMessage() {
  if (typeof platform.Message !== 'undefined' &&
      typeof platform.Message.load === 'function') {
    platform.Message.load('{$message->text()}', '{$message->status()}');
  } else {
    setTimeout(waitForMessage, 100);
  }
}
waitForMessage();
</script>
{/if}
```

**Pattern:**
1. Smarty renders script that checks for module existence
2. If not ready, retry after delay
3. Once available, call Angular module method

### Hydrating Angular Controllers

Pass complex initialization data:

```smarty
{* Prepare data structure *}
{$filterOptions = [
  'brands' => [],
  'priceRanges' => [
    ['min' => 0, 'max' => 50],
    ['min' => 50, 'max' => 100],
    ['min' => 100, 'max' => 500]
  ],
  'categories' => []
]}

{collection assign=brands controller=brand}
{foreach $brands->getData() as $brand}
  {$filterOptions.brands[] = [
    'id' => $brand->Id,
    'name' => $brand->Name
  ]}
{/foreach}

<script>
window.filterOptions = {$filterOptions|jsonify};
</script>

{* Angular controller initialization *}
<div data-ng-controller="filter-ctrl"
     data-ng-init="initialize()">
  {* Controller reads window.filterOptions in initialize() *}
</div>
```

### Dynamic Script Execution

Execute Angular methods after Smarty rendering:

```smarty
{foreach $selectedFilters as $filter}
<script>
(function() {
  function applyFilter() {
    var scope = angular.element(document.getElementById('filter-ctrl')).scope();
    if (scope && scope.applyFilter) {
      scope.$apply(function() {
        scope.applyFilter('{$filter.type}', '{$filter.value}');
      });
    } else {
      setTimeout(applyFilter, 100);
    }
  }
  applyFilter();
})();
</script>
{/foreach}
```

## Product List Controller Pattern

Complete pattern for product listing with filters:

```html
{* Smarty: Prepare initial data *}
{collection assign=products controller=productList categoryId=$categoryId}
{$initialProducts = []}
{foreach $products->getData() as $product}
  {entity assign=image controller=files type=product productId=$product->Id}
  {$initialProducts[] = [
    'Id' => $product->Id,
    'Title' => $product->Title,
    'Price' => $product->Price,
    'Image' => $image ? $image->thumbnail(400, 400) : null
  ]}
{/foreach}

<script>
window.initialProducts = {$initialProducts|jsonify};
</script>

{* Angular controller *}
<div class="product-list-page"
     data-ng-controller="productlist-ctrl"
     data-ng-init="initialize()"
     data-category-id="{$categoryId}">

  {* Filters *}
  <aside class="filters">
    <div class="filter-group">
      <label>Price Range</label>
      <input type="range"
             ng-model="filters.maxPrice"
             ng-change="applyFilters()"
             min="0" max="1000" step="10">
      <span>{{ filters.maxPrice | currency }}</span>
    </div>

    <div class="filter-group">
      <label>Brand</label>
      <select ng-model="filters.brandId" ng-change="applyFilters()">
        <option value="">All Brands</option>
        <option ng-repeat="brand in brands" value="{{ brand.id }}">
          {{ brand.name }}
        </option>
      </select>
    </div>
  </aside>

  {* Product grid *}
  <div class="product-grid">
    <div ng-repeat="product in filteredProducts track by product.Id"
         data-ng-controller="product-ctrl"
         data-repeat-done="loaded.productlist"
         class="product-card">

      <img ng-src="{{ product.Image }}" alt="{{ product.Title }}">
      <h3>{{ product.Title }}</h3>
      <p class="price">{{ product.Price | currency }}</p>
      <button ng-click="addToCart(product.Id)">Add to Cart</button>
    </div>
  </div>

  {* No results message *}
  <div ng-if="filteredProducts.length === 0" class="no-results">
    <p>No products match your filters</p>
  </div>
</div>
```

**JavaScript Controller:**
```javascript
angular.module('platform-app').controller('productlist-ctrl', function($scope, $http) {
  $scope.products = [];
  $scope.filteredProducts = [];
  $scope.filters = {
    maxPrice: 1000,
    brandId: ''
  };

  $scope.initialize = function() {
    // Load initial data from Smarty
    if (window.initialProducts) {
      $scope.products = window.initialProducts;
      $scope.filteredProducts = window.initialProducts;
    }

    // Could also fetch via AJAX
    // $scope.loadProducts();
  };

  $scope.applyFilters = function() {
    $scope.filteredProducts = $scope.products.filter(function(product) {
      if ($scope.filters.maxPrice && product.Price > $scope.filters.maxPrice) {
        return false;
      }
      if ($scope.filters.brandId && product.BrandId != $scope.filters.brandId) {
        return false;
      }
      return true;
    });

    // Publish event
    window.platform.publish('filters.applied', {
      filters: $scope.filters,
      resultCount: $scope.filteredProducts.length
    });
  };
});
```

## Best Practices Summary

### Data Initialization
- ✅ Use Smarty for initial server-side render (SEO, fast first paint)
- ✅ Pass data via JSON in `<script>` tags for complex structures
- ✅ Use `data-*` attributes for simple scalar values
- ❌ Don't make unnecessary AJAX calls for data Smarty already has

### Event Communication
- ✅ Use `platform.publish/subscribe` for Angular ↔ jQuery/vanilla JS
- ✅ Use custom DOM events for framework-agnostic communication
- ✅ Document event names and payload structure
- ❌ Don't manipulate DOM directly from Angular controllers

### Performance
- ✅ Use `track by` in `ng-repeat` for better rendering
- ✅ Batch DOM updates after Angular rendering completes
- ✅ Debounce filter/search inputs to avoid excessive updates
- ❌ Don't render large lists without pagination or virtual scrolling

### Maintainability
- ✅ Keep Angular controllers focused on data/logic
- ✅ Use events as module boundaries
- ✅ Reuse event names across projects
- ✅ Separate Angular code into standalone files
- ❌ Don't couple Angular directly to specific DOM structures

This integration pattern enables powerful client-side interactivity while maintaining clean separation between server-rendered content and dynamic functionality.
