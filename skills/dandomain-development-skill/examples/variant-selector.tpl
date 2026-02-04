{*
  Product Variant Selector

  Demonstrates:
  - Variant type and data controllers
  - Dynamic variant selection UI
  - AJAX variant data updates
  - Platform.js event publishing
  - Image and price updates
*}

{* Initialize controllers *}
{controller type=product assign=productCtrl}
{controller type=productVariantType assign=variantTypeCtrl}
{controller type=productVariantData assign=variantDataCtrl}
{controller type=files assign=filesCtrl}

{* Get product *}
{entity assign=product controller=$productCtrl productId=$productId}

{* Get variant types (e.g., Color, Size) *}
{collection assign=variantTypes controller=$variantTypeCtrl productId=$product->Id}

{* Product Display *}
<article class="product-detail" data-product-id="{$product->Id}">
  <div class="container">
    <div class="row">
      {* Product Images *}
      <div class="col-md-6">
        <div class="product-images">
          {* Main Image *}
          <div class="main-image" id="mainProductImage">
            {entity assign=mainImage controller=$filesCtrl type=product productId=$product->Id}
            {if $mainImage}
              <img src="{$mainImage->thumbnail(800, 800)}"
                   alt="{$product->Title|escape:'html'}"
                   class="img-fluid">
            {else}
              <img src="/assets/images/placeholder.jpg"
                   alt="No image"
                   class="img-fluid">
            {/if}
          </div>

          {* Thumbnail Gallery *}
          {collection assign=images controller=$filesCtrl type=product productId=$product->Id}
          {if $images->getActualSize() gt 1}
            <div class="thumbnail-gallery">
              {foreach $images->getData() as $image}
                <img src="{$image->thumbnail(100, 100)}"
                     data-large="{$image->thumbnail(800, 800)}"
                     alt="{$product->Title}"
                     class="thumbnail"
                     onclick="changeMainImage(this)">
              {/foreach}
            </div>
          {/if}
        </div>
      </div>

      {* Product Info *}
      <div class="col-md-6">
        <div class="product-info">
          <h1 class="product-title">{$product->Title}</h1>

          {* Product Price *}
          <div class="product-price-container">
            <p class="product-price" id="productPrice">
              {$product->Price|formatPrice}
            </p>
          </div>

          {* Stock Status *}
          <p class="stock-status" id="stockStatus"
             data-stock="{$product->Stock}">
            {if $product->Stock gt 0}
              <span class="in-stock">In Stock ({$product->Stock} available)</span>
            {else}
              <span class="out-of-stock">Out of Stock</span>
            {/if}
          </p>

          {* Variant Selectors *}
          {if $variantTypes->getActualSize() gt 0}
            <div class="variant-selectors">
              {foreach $variantTypes->getData() as $type}
                <div class="variant-selector-group"
                     data-variant-type-id="{$type->Id}"
                     data-variant-type-name="{$type->Title}">

                  <label class="variant-label">
                    Select {$type->Title}:
                    <span class="selected-value" id="selected-{$type->Id}"></span>
                  </label>

                  <div class="variant-options" data-variant="variant">
                    {collection assign=variantData controller=$variantDataCtrl typeId=$type->Id productId=$product->Id}

                    {foreach $variantData->getData() as $data}
                      <button type="button"
                              class="variant-option"
                              data-value="{$data->Id}"
                              data-display-value="{$data->Value|escape:'html'}"
                              onclick="selectVariant(this, {$type->Id})">

                        {* If variant has an image (e.g., color swatch) *}
                        {if $data->ImagePath neq ''}
                          <img src="{$data->ImagePath|solutionPath}"
                               alt="{$data->Value}"
                               class="variant-swatch">
                        {/if}

                        <span class="variant-text">{$data->Value}</span>
                      </button>
                    {/foreach}
                  </div>
                </div>
              {/foreach}
            </div>

            {* Selected Variant Info *}
            <div class="selected-variant-info" id="selectedVariantInfo" style="display: none;">
              <p><strong>Selected:</strong> <span id="variantDescription"></span></p>
              <p class="variant-sku">SKU: <span id="variantSku"></span></p>
            </div>
          {/if}

          {* Quantity Selector *}
          <div class="quantity-selector">
            <label for="quantity">Quantity:</label>
            <div class="quantity-controls">
              <button type="button"
                      class="qty-btn"
                      onclick="changeQuantity(-1)">−</button>
              <input type="number"
                     id="quantity"
                     name="quantity"
                     value="1"
                     min="1"
                     max="{$product->Stock}"
                     class="qty-input">
              <button type="button"
                      class="qty-btn"
                      onclick="changeQuantity(1)">+</button>
            </div>
          </div>

          {* Add to Cart Button *}
          <button type="button"
                  class="btn btn-primary btn-lg add-to-cart"
                  id="addToCartBtn"
                  onclick="addToCart()"
                  {if $product->Stock eq 0}disabled{/if}>
            {if $product->Stock gt 0}
              Add to Cart
            {else}
              Out of Stock
            {/if}
          </button>

          {* Product Description *}
          {if $product->Description neq ''}
            <div class="product-description">
              <h3>Description</h3>
              {$product->Description}
            </div>
          {/if}
        </div>
      </div>
    </div>
  </div>
</article>

{* JavaScript for Variant Selection *}
<script>
// Global state
var selectedVariantData = {};
var productId = {$product->Id};
var basePrice = {$product->Price};

// Select variant
function selectVariant(button, typeId) {
  // Remove selected class from siblings
  var siblings = button.parentElement.querySelectorAll('.variant-option');
  siblings.forEach(function(sibling) {
    sibling.classList.remove('selected');
  });

  // Add selected class to clicked button
  button.classList.add('selected');

  // Update selected value display
  var displayValue = button.getAttribute('data-display-value');
  var selectedSpan = document.getElementById('selected-' + typeId);
  if (selectedSpan) {
    selectedSpan.textContent = displayValue;
  }

  // Store selected variant data ID
  selectedVariantData[typeId] = button.getAttribute('data-value');

  // Check if all variant types are selected
  var allTypesSelected = checkAllVariantsSelected();

  if (allTypesSelected) {
    // Fetch variant details
    fetchVariantData();
  }
}

// Check if all variant types have a selection
function checkAllVariantsSelected() {
  var variantGroups = document.querySelectorAll('.variant-selector-group');
  var allSelected = true;

  variantGroups.forEach(function(group) {
    var typeId = group.getAttribute('data-variant-type-id');
    if (!selectedVariantData[typeId]) {
      allSelected = false;
    }
  });

  return allSelected;
}

// Fetch variant data from API
function fetchVariantData() {
  // Collect all selected data IDs
  var dataIds = [];
  for (var typeId in selectedVariantData) {
    dataIds.push(selectedVariantData[typeId]);
  }

  // Show loading state
  document.getElementById('productPrice').innerHTML = '<span class="loading">Updating...</span>';

  // Fetch from JSON endpoint
  fetch('/json/productvariants/' + productId + '?dataIds=' + dataIds.join(','))
    .then(function(response) { return response.json(); })
    .then(function(data) {
      if (data.code === 1 && data.variant) {
        updateProductDisplay(data.variant);
      } else {
        console.error('Variant not found');
        resetProductDisplay();
      }
    })
    .catch(function(error) {
      console.error('Error fetching variant:', error);
      resetProductDisplay();
    });
}

// Update product display with variant data
function updateProductDisplay(variant) {
  // Update price
  var priceEl = document.getElementById('productPrice');
  if (priceEl && variant.Price) {
    priceEl.textContent = window.platform.currency_format(variant.Price);
  }

  // Update stock
  var stockEl = document.getElementById('stockStatus');
  if (stockEl && typeof variant.Stock !== 'undefined') {
    stockEl.setAttribute('data-stock', variant.Stock);
    if (variant.Stock > 0) {
      stockEl.innerHTML = '<span class="in-stock">In Stock (' + variant.Stock + ' available)</span>';
    } else {
      stockEl.innerHTML = '<span class="out-of-stock">Out of Stock</span>';
    }
  }

  // Update main image
  if (variant.Image) {
    var mainImage = document.querySelector('#mainProductImage img');
    if (mainImage) {
      mainImage.src = variant.Image;
    }
  }

  // Update SKU
  if (variant.Sku) {
    var skuEl = document.getElementById('variantSku');
    if (skuEl) {
      skuEl.textContent = variant.Sku;
    }
  }

  // Show variant info
  var variantInfo = document.getElementById('selectedVariantInfo');
  if (variantInfo) {
    variantInfo.style.display = 'block';
  }

  // Update description
  var descEl = document.getElementById('variantDescription');
  if (descEl) {
    var description = [];
    for (var typeId in selectedVariantData) {
      var button = document.querySelector('[data-value="' + selectedVariantData[typeId] + '"]');
      if (button) {
        description.push(button.getAttribute('data-display-value'));
      }
    }
    descEl.textContent = description.join(' / ');
  }

  // Enable/disable add to cart button
  var addToCartBtn = document.getElementById('addToCartBtn');
  if (addToCartBtn) {
    if (variant.Stock > 0) {
      addToCartBtn.disabled = false;
      addToCartBtn.textContent = 'Add to Cart';
    } else {
      addToCartBtn.disabled = true;
      addToCartBtn.textContent = 'Out of Stock';
    }
    addToCartBtn.setAttribute('data-variant-id', variant.Id);
  }

  // Update quantity max
  var qtyInput = document.getElementById('quantity');
  if (qtyInput && variant.Stock) {
    qtyInput.setAttribute('max', variant.Stock);
    if (parseInt(qtyInput.value) > variant.Stock) {
      qtyInput.value = variant.Stock;
    }
  }

  // Publish event
  window.platform.publish('/product/variant/selected', {
    productId: productId,
    variantId: variant.Id,
    price: variant.Price,
    stock: variant.Stock
  });
}

// Reset to base product display
function resetProductDisplay() {
  var priceEl = document.getElementById('productPrice');
  if (priceEl) {
    priceEl.textContent = window.platform.currency_format(basePrice);
  }

  var variantInfo = document.getElementById('selectedVariantInfo');
  if (variantInfo) {
    variantInfo.style.display = 'none';
  }
}

// Change main image
function changeMainImage(thumbnail) {
  var largeImageUrl = thumbnail.getAttribute('data-large');
  var mainImage = document.querySelector('#mainProductImage img');
  if (mainImage && largeImageUrl) {
    mainImage.src = largeImageUrl;
  }

  // Remove active class from all thumbnails
  document.querySelectorAll('.thumbnail').forEach(function(thumb) {
    thumb.classList.remove('active');
  });
  thumbnail.classList.add('active');
}

// Quantity controls
function changeQuantity(delta) {
  var input = document.getElementById('quantity');
  var newValue = parseInt(input.value) + delta;
  var min = parseInt(input.getAttribute('min'));
  var max = parseInt(input.getAttribute('max'));

  if (newValue >= min && newValue <= max) {
    input.value = newValue;
  }
}

// Add to cart
function addToCart() {
  var variantId = document.getElementById('addToCartBtn').getAttribute('data-variant-id');
  var quantity = parseInt(document.getElementById('quantity').value);

  var cartData = {
    productId: productId,
    quantity: quantity
  };

  if (variantId) {
    cartData.variantId = variantId;
  }

  // Publish event
  window.platform.publish('/product/buy', cartData);

  // Make AJAX call to add to cart
  // This would be a POST request to your cart endpoint
  console.log('Adding to cart:', cartData);

  // Show success message
  alert('Product added to cart!');
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
  // Publish product ready event
  window.platform.publish('/product/ready', {
    productId: productId
  });

  // Set first thumbnail as active
  var firstThumb = document.querySelector('.thumbnail');
  if (firstThumb) {
    firstThumb.classList.add('active');
  }
});
</script>

{* Styles *}
<style>
.product-detail {
  padding: 40px 0;
}

.main-image {
  margin-bottom: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  overflow: hidden;
}

.thumbnail-gallery {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.thumbnail {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border: 2px solid transparent;
  border-radius: 4px;
  cursor: pointer;
  transition: border-color 0.2s;
}

.thumbnail:hover,
.thumbnail.active {
  border-color: #007bff;
}

.product-title {
  font-size: 32px;
  font-weight: 700;
  margin-bottom: 20px;
}

.product-price {
  font-size: 28px;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 15px;
}

.stock-status {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 25px;
}

.stock-status .in-stock {
  color: #28a745;
}

.stock-status .out-of-stock {
  color: #dc3545;
}

.variant-selector-group {
  margin-bottom: 25px;
}

.variant-label {
  display: block;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 10px;
}

.variant-label .selected-value {
  color: #007bff;
  font-weight: 400;
}

.variant-options {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.variant-option {
  padding: 10px 20px;
  border: 2px solid #ddd;
  background: #fff;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  gap: 8px;
}

.variant-option:hover {
  border-color: #007bff;
  background: #f8f9fa;
}

.variant-option.selected {
  border-color: #007bff;
  background: #007bff;
  color: #fff;
}

.variant-swatch {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  border: 1px solid #ddd;
}

.selected-variant-info {
  padding: 15px;
  background: #f8f9fa;
  border-radius: 4px;
  margin-bottom: 20px;
}

.quantity-selector {
  margin-bottom: 25px;
}

.quantity-controls {
  display: flex;
  align-items: center;
  gap: 0;
  margin-top: 10px;
}

.qty-btn {
  width: 40px;
  height: 40px;
  border: 1px solid #ddd;
  background: #f8f9fa;
  font-size: 20px;
  cursor: pointer;
  transition: background 0.2s;
}

.qty-btn:hover {
  background: #e9ecef;
}

.qty-input {
  width: 80px;
  height: 40px;
  text-align: center;
  border: 1px solid #ddd;
  border-left: none;
  border-right: none;
  font-size: 16px;
}

.add-to-cart {
  width: 100%;
  margin-bottom: 30px;
}

.product-description {
  border-top: 1px solid #ddd;
  padding-top: 30px;
  margin-top: 30px;
}

.loading {
  color: #666;
  font-style: italic;
}
</style>
