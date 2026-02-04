{*
  Product List with AngularJS Filters

  Demonstrates:
  - Smarty controller initialization
  - Data preparation for Angular
  - AngularJS ng-repeat
  - Client-side filtering
  - Event-driven updates
*}

{* Initialize controllers *}
{controller type=productList assign=productListCtrl}
{controller type=product assign=productCtrl}
{controller type=files assign=filesCtrl}
{controller type=brand assign=brandCtrl}

{* Get products *}
{collection assign=products controller=$productListCtrl categoryId=$categoryId}

{* Get brands for filter *}
{collection assign=brands controller=$brandCtrl}

{* Prepare data for Angular *}
{$productData = []}
{foreach $products->getData() as $product}
  {entity assign=image controller=$filesCtrl type=product productId=$product->Id}
  {entity assign=brand controller=$brandCtrl id=$product->ProducerId}

  {$productData[] = [
    'Id' => $product->Id,
    'Title' => $product->Title,
    'Description' => $product->Description,
    'Price' => $product->Price,
    'Stock' => $product->Stock,
    'Image' => $image ? $image->thumbnail(400, 400) : null,
    'BrandId' => $product->ProducerId,
    'BrandName' => $brand ? $brand->Name : ''
  ]}
{/foreach}

{$brandData = []}
{foreach $brands->getData() as $brand}
  {$brandData[] = [
    'id' => $brand->Id,
    'name' => $brand->Name
  ]}
{/foreach}

{* Expose data to JavaScript *}
<script>
window.productListData = {$productData|jsonify};
window.brandFilterData = {$brandData|jsonify};
</script>

{* Angular-powered product list *}
<div class="product-list-container"
     data-ng-controller="productlist-ctrl"
     data-ng-init="initialize()"
     data-category-id="{$categoryId}">

  <div class="container">
    <div class="row">
      {* Filters Sidebar *}
      <aside class="col-md-3 filters-sidebar">
        <h3>Filters</h3>

        {* Search *}
        <div class="filter-group">
          <label>Search</label>
          <input type="text"
                 class="form-control"
                 ng-model="filters.search"
                 ng-change="applyFilters()"
                 placeholder="Search products...">
        </div>

        {* Price Range *}
        <div class="filter-group">
          <label>Max Price: {{ filters.maxPrice | formatPrice }}</label>
          <input type="range"
                 class="form-control-range"
                 ng-model="filters.maxPrice"
                 ng-change="applyFilters()"
                 min="0" max="5000" step="50">
        </div>

        {* Brand Filter *}
        <div class="filter-group">
          <label>Brand</label>
          <select class="form-control"
                  ng-model="filters.brandId"
                  ng-change="applyFilters()">
            <option value="">All Brands</option>
            <option ng-repeat="brand in brands" value="{{ brand.id }}">
              {{ brand.name }}
            </option>
          </select>
        </div>

        {* In Stock Only *}
        <div class="filter-group">
          <label class="checkbox">
            <input type="checkbox"
                   ng-model="filters.inStockOnly"
                   ng-change="applyFilters()">
            In Stock Only
          </label>
        </div>

        {* Clear Filters *}
        <button class="btn btn-secondary"
                ng-click="clearFilters()">
          Clear Filters
        </button>

        {* Results Count *}
        <div class="results-info">
          <p>Showing {{ filteredProducts.length }} of {{ products.length }} products</p>
        </div>
      </aside>

      {* Product Grid *}
      <main class="col-md-9">
        {* Sort Options *}
        <div class="sort-bar">
          <label>Sort by:</label>
          <select class="form-control"
                  ng-model="sortField"
                  ng-change="applySorting()">
            <option value="Title">Name</option>
            <option value="Price">Price</option>
            <option value="BrandName">Brand</option>
          </select>

          <select class="form-control"
                  ng-model="sortDirection"
                  ng-change="applySorting()">
            <option value="asc">Ascending</option>
            <option value="desc">Descending</option>
          </select>
        </div>

        {* Product Grid *}
        <div class="product-grid row">
          <div ng-repeat="product in filteredProducts | orderBy:sortField:sortDirection==='desc' track by product.Id"
               data-ng-controller="product-ctrl"
               data-repeat-done="loaded.productlist"
               class="col-md-4 col-sm-6 product-card-wrapper">

            <article class="product-card">
              {* Product Image *}
              <div class="product-image">
                <img ng-src="{{ product.Image }}"
                     alt="{{ product.Title }}"
                     class="img-fluid">

                {* Out of Stock Overlay *}
                <div ng-if="product.Stock === 0" class="out-of-stock-overlay">
                  <span>Out of Stock</span>
                </div>
              </div>

              {* Product Info *}
              <div class="product-info">
                <p class="brand-name">{{ product.BrandName }}</p>
                <h3 class="product-title">{{ product.Title }}</h3>
                <p class="product-description">{{ product.Description | limitTo:100 }}...</p>

                {* Price *}
                <p class="product-price">
                  {{ product.Price | currency }}
                </p>

                {* Stock Status *}
                <p class="stock-status" ng-class="{'in-stock': product.Stock > 0, 'out-of-stock': product.Stock === 0}">
                  <span ng-if="product.Stock > 0">In Stock</span>
                  <span ng-if="product.Stock === 0">Out of Stock</span>
                </p>

                {* Add to Cart Button *}
                <button class="btn btn-primary add-to-cart"
                        ng-click="addToCart(product.Id)"
                        ng-disabled="product.Stock === 0">
                  <span ng-if="product.Stock > 0">Add to Cart</span>
                  <span ng-if="product.Stock === 0">Unavailable</span>
                </button>
              </div>
            </article>
          </div>
        </div>

        {* No Results Message *}
        <div ng-if="filteredProducts.length === 0" class="no-results">
          <div class="alert alert-info">
            <h4>No products found</h4>
            <p>Try adjusting your filters or search terms.</p>
            <button class="btn btn-primary" ng-click="clearFilters()">Clear Filters</button>
          </div>
        </div>

        {* Loading Indicator *}
        <div ng-if="isLoading" class="loading-indicator">
          <div class="spinner"></div>
          <p>Loading products...</p>
        </div>
      </main>
    </div>
  </div>
</div>

{* JavaScript Controller *}
<script>
angular.module('platform-app').controller('productlist-ctrl', function($scope, $http) {
  // Initialize data
  $scope.products = [];
  $scope.filteredProducts = [];
  $scope.brands = [];
  $scope.isLoading = false;

  // Filter state
  $scope.filters = {
    search: '',
    maxPrice: 5000,
    brandId: '',
    inStockOnly: false
  };

  // Sort state
  $scope.sortField = 'Title';
  $scope.sortDirection = 'asc';

  // Initialize from Smarty data
  $scope.initialize = function() {
    if (window.productListData) {
      $scope.products = window.productListData;
      $scope.filteredProducts = window.productListData;
    }

    if (window.brandFilterData) {
      $scope.brands = window.brandFilterData;
    }

    // Publish ready event
    window.platform.publish('/productlist/ready', {
      productCount: $scope.products.length
    });
  };

  // Apply filters
  $scope.applyFilters = function() {
    $scope.filteredProducts = $scope.products.filter(function(product) {
      // Search filter
      if ($scope.filters.search) {
        var search = $scope.filters.search.toLowerCase();
        var matchesSearch = product.Title.toLowerCase().indexOf(search) !== -1 ||
                          (product.Description && product.Description.toLowerCase().indexOf(search) !== -1) ||
                          product.BrandName.toLowerCase().indexOf(search) !== -1;
        if (!matchesSearch) return false;
      }

      // Price filter
      if ($scope.filters.maxPrice && product.Price > $scope.filters.maxPrice) {
        return false;
      }

      // Brand filter
      if ($scope.filters.brandId && product.BrandId != $scope.filters.brandId) {
        return false;
      }

      // Stock filter
      if ($scope.filters.inStockOnly && product.Stock === 0) {
        return false;
      }

      return true;
    });

    // Publish filter event
    window.platform.publish('/productlist/filtered', {
      filters: $scope.filters,
      resultCount: $scope.filteredProducts.length
    });
  };

  // Clear all filters
  $scope.clearFilters = function() {
    $scope.filters = {
      search: '',
      maxPrice: 5000,
      brandId: '',
      inStockOnly: false
    };
    $scope.applyFilters();
  };

  // Apply sorting
  $scope.applySorting = function() {
    // Sorting is handled by Angular's orderBy filter in template
    window.platform.publish('/productlist/sorted', {
      field: $scope.sortField,
      direction: $scope.sortDirection
    });
  };

  // Add to cart
  $scope.addToCart = function(productId) {
    window.platform.publish('/product/buy', { productId: productId });

    // Could make AJAX call here
    // $http.post('/cart/add', { productId: productId, quantity: 1 })
    //   .then(function(response) {
    //     // Handle success
    //   });
  };
});

// Product card controller
angular.module('platform-app').controller('product-ctrl', function($scope) {
  // Individual product card logic can go here
  $scope.viewProduct = function() {
    window.location.href = '/product/' + $scope.product.Id;
  };
});

// Listen for loaded event
$(platform).on('loaded.productlist', function() {
  console.log('Product list rendered');

  // Initialize any jQuery plugins
  $('[data-toggle="tooltip"]').tooltip();

  // Lazy load images
  if ('IntersectionObserver' in window) {
    var imageObserver = new IntersectionObserver(function(entries) {
      entries.forEach(function(entry) {
        if (entry.isIntersecting) {
          var img = entry.target;
          if (img.dataset.lazySrc) {
            img.src = img.dataset.lazySrc;
            delete img.dataset.lazySrc;
            imageObserver.unobserve(img);
          }
        }
      });
    });

    document.querySelectorAll('[data-lazy-src]').forEach(function(img) {
      imageObserver.observe(img);
    });
  }
});
</script>

{* Styles *}
<style>
.product-list-container {
  padding: 20px 0;
}

.filters-sidebar {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
}

.filter-group {
  margin-bottom: 20px;
}

.filter-group label {
  display: block;
  font-weight: 600;
  margin-bottom: 8px;
}

.sort-bar {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
  padding: 15px;
  background: #fff;
  border-radius: 8px;
}

.product-grid {
  margin: 0 -10px;
}

.product-card-wrapper {
  padding: 10px;
  margin-bottom: 20px;
}

.product-card {
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  transition: transform 0.2s, box-shadow 0.2s;
}

.product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 16px rgba(0,0,0,0.15);
}

.product-image {
  position: relative;
  padding-top: 100%;
  overflow: hidden;
}

.product-image img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.out-of-stock-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-weight: 600;
}

.product-info {
  padding: 15px;
}

.brand-name {
  color: #666;
  font-size: 14px;
  margin-bottom: 5px;
}

.product-title {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 10px;
  min-height: 40px;
}

.product-description {
  font-size: 14px;
  color: #666;
  margin-bottom: 10px;
}

.product-price {
  font-size: 20px;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 10px;
}

.stock-status {
  font-size: 14px;
  margin-bottom: 15px;
}

.stock-status.in-stock {
  color: #28a745;
}

.stock-status.out-of-stock {
  color: #dc3545;
}

.add-to-cart {
  width: 100%;
}

.no-results {
  text-align: center;
  padding: 40px 20px;
}

.loading-indicator {
  text-align: center;
  padding: 40px 20px;
}

.results-info {
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid #dee2e6;
}
</style>
