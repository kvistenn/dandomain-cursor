---
name: DanDomain Webshop Development
description: This skill should be used when the user asks to "develop for DanDomain", "create DanDomain webshop", "build DanDomain template", "use Smarty templates for DanDomain", "integrate AngularJS with DanDomain", "work with DanDomain controllers", "create DanDomain components", "implement product variants", "handle DanDomain extra purchases", or mentions DanDomain Webshop Hostedshop development, Smarty integration, platform.js, or DanDomain-specific controllers.
version: 1.0.0
---

# DanDomain Webshop Development

Master DanDomain Webshop Hostedshop development with Smarty templates, AngularJS integration, and the platform.js event system.

## Purpose

Enable expert-level development for DanDomain Webshop Hostedshop platform, combining server-side Smarty templating with client-side AngularJS and platform.js for modern, maintainable e-commerce solutions.

## When to Use This Skill

Use when working on:
- DanDomain webshop template development
- Smarty template integration with DanDomain controllers
- AngularJS dynamic functionality in DanDomain
- Product listing and filtering systems
- Shopping cart and checkout flows
- Variant selection and extra purchase systems
- Platform.js event-driven architecture
- Component library development for DanDomain

## Technology Stack Overview

DanDomain development combines three core technologies:

### Smarty Templates (Server-Side)
- Foundation for all server-side rendering
- Access to DanDomain controllers for data fetching
- Template composition with includes and captures
- JSON template endpoints for AJAX/Angular

### AngularJS (Client-Side)
- Dynamic product lists and filtering
- Interactive UI components
- Data binding with Smarty-provided initial state
- Event-driven communication via platform.js

### Platform.js (Event System)
- Global namespace (`window.platform`)
- Pub/sub event coordination
- Product and variant management
- Cross-module communication

### TailwindCSS (Styling)
- Utility-first CSS framework
- Configured to scan `.tpl` files
- Build process via Grunt/PostCSS

## Core Concepts

### 1. Smarty Controllers and Data Flow

Controllers are the primary way to fetch data from DanDomain:

```smarty
{* Initialize controller *}
{controller type=product assign=productController}

{* Fetch collection of products *}
{collection assign=products controller=productList categoryId=123}

{* Fetch single entity *}
{entity assign=product controller=product productId=456}

{* Access data *}
{if $products->getActualSize() gt 0}
  {foreach $products->getData() as $product}
    <h2>{$product->Title|escape:'html'}</h2>
    <p>{$product->Price|formatPrice}</p>
  {/foreach}
{/if}
```

**Controller Lifecycle:**
- Assign controllers to variables with `assign=...`
- Reuse controller instances to avoid repetition
- Controllers support parameters from other controllers
- Use `primary=true` for cached data when appropriate

### 2. Data Preparation Patterns

**From CMS to Structured Data:**
```smarty
{controller type=page assign=pageController}
{$content = $pageController->getText(16)|strip_tags}
{$title = $content|regex_replace:'/.*overskrift:\s*/s':''|regex_replace:'/\s*beskrivelse:.*/s':''|trim}
```

**Building Arrays for JavaScript:**
```smarty
{$dataArray = []}
{foreach $collection->getData() as $item}
  {$dataArray[] = [
    'Id' => $item->Id,
    'Title' => $item->Title,
    'Price' => $item->Price
  ]}
{/foreach}

<script>
window.componentData = {$dataArray|jsonify};
</script>
```

### 3. AngularJS Integration

**Bootstrap the App:**
```html
<body id="ng-app" data-ng-app="platform-app">
```

**Controller with Smarty Data:**
```html
<div data-ng-controller="productlist-ctrl"
     data-ng-init="hasLeftColumns = 1"
     data-field="{$field}"
     data-viewmode="{$viewmode}">
  <div data-ng-repeat="product in productlist track by product.Id"
       data-ng-controller="product-ctrl"
       data-repeat-done="loaded.productlist">
    <!-- Product markup -->
  </div>
</div>
```

**Key Principles:**
- Smarty provides initial data via `data-*` attributes
- Angular controllers consume and enhance this data
- `data-repeat-done` directive triggers events when rendering completes
- Events keep jQuery/vanilla JS in sync with Angular state

### 4. Platform.js Event System

**Publishing Events:**
```javascript
// Publish product ready event
window.platform.publish('/product/ready', productInstance);

// Publish variant selection
window.platform.publish('/product/variant/selected', product, variant);
```

**Subscribing to Events:**
```javascript
// Listen for product list loaded
window.platform.subscribe('/product/ready', function(event, product) {
  console.log('Product ready:', product.Title);
  // Update UI, analytics, etc.
});

// Listen for variant changes
window.platform.subscribe('/product/variant/selected', function(event, product, variant) {
  console.log('Variant selected:', variant.Title);
  platform.product.updatePanel(variant);
});
```

**Standard Event Names:**
- `/product/ready`, `/product/selected`, `/product/buy`
- `/product/variant/selected`, `/product/variant/unselected`
- `/product/packet/selected`, `/product/packet/unselected`
- `/cart/ready`, `/platform/ready`
- `loaded.productlist`, `fetch.productlist`

**Custom DOM Events:**
```javascript
// Dispatch custom event
document.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {
  detail: {
    total: calculatedTotal,
    selections: state,
    baseProduct: selectedProduct
  }
}));

// Listen to custom event
document.addEventListener('extraPurchaseSelectionChanged', function(event) {
  updateStickyFooter(event.detail.total);
});
```

### 5. JSON Templates (API Layer)

JSON templates in `modules/json/*.tpl` provide AJAX endpoints:

```smarty
{* modules/json/products.tpl *}
{collection assign=products controller=productList categoryId=$request.args.categoryId}
{assign var=output value=['code'=>1,'data'=>[]]}

{foreach $products->getData() as $product}
  {entity assign=image controller=files type=product productId=$product->Id}
  {$output.data[] = [
    'Id' => $product->Id,
    'Title' => $product->Title,
    'Price' => $product->Price,
    'Image' => $image ? $image->thumbnail(400, 400) : null
  ]}
{/foreach}

{$output|jsonify}
```

**URL Convention:**
- `/json/products/{field}/{value}` maps to `$request.verb` and `$request.args`
- Preload includes cache related data before loops
- Return consistent structure with `code`, `message`, `result`

## Most Common Controllers

Based on analysis across multiple DanDomain shops:

1. **ProductController** - Product data, variants, prices, stock
2. **ProductCategoryController** - Category navigation and structure
3. **FilesController** - Images and media for products/pages
4. **PageController** - CMS content and text pages
5. **ProductListController** - Product collections with filtering
6. **ProductExtraBuyCategory** - Extra purchase categories
7. **ProductExtraBuy** - Extra purchase items (accessories, add-ons)
8. **ProductVariant** - Variant data for products
9. **ProductVariantType** - Variant type definitions (color, size)
10. **ProductVariantData** - Specific variant values

For complete controller reference, see `references/controller-reference.md`.

## Template Structure

Standard DanDomain template organization:

```
├── index.tpl              # Main entry point
├── partials/              # Reusable layout components
│   ├── head.tpl          # <head> section
│   ├── top.tpl           # Header/navigation
│   └── bottom.tpl        # Footer/scripts
├── modules/               # Feature modules
│   ├── product/          # Product pages
│   ├── cart/             # Shopping cart
│   ├── checkout/         # Checkout flow
│   ├── widgets/          # UI components
│   └── json/             # AJAX endpoints
└── assets/               # Static assets
    ├── css/
    └── js/
```

## Smarty Best Practices

### Conditional Rendering
```smarty
{* Use Smarty operators *}
{if $product->Stock gt 0 and $product->Active eq true}
  <button>Add to Cart</button>
{/if}

{* Check existence *}
{if isset($product.CustomData) && $product.CustomData|@count gt 0}
  {* Process custom data *}
{/if}

{* Provide fallbacks *}
{$product->Subtitle|default:'Coming Soon'}
```

### Iteration with Safety
```smarty
{if $products->getActualSize() gt 0}
  {foreach $products->getData() as $product}
    <div class="product {if $smarty.foreach.products.first}first{/if}">
      Product #{$smarty.foreach.products.iteration}: {$product->Title}
    </div>
  {foreachelse}
    <p>No products available.</p>
  {/foreach}
{/if}
```

### Modifiers and Formatting
```smarty
{* Price formatting *}
{$product->Price|formatPrice}

{* URL generation *}
<a href="{$product|formatLink}">{$product->Title}</a>

{* Image paths *}
<img src="{$imagePath|solutionPath}" alt="{$product->Title|escape:'html'}">

{* Text manipulation *}
{$product->Description|strip_tags|truncate:100|default:'No description'}

{* Chain modifiers *}
{$product->Title|escape:'html'|upper}
```

### Global Variables
```smarty
{* Page information *}
{$page.Id} {$page.Name} {$page.IsFrontPage}

{* Shop settings *}
{$general.LanguageISO} {$general.CurrencyISO}

{* Text translations *}
{$text.CART_ADD_TO_CART|default:'Add to Cart'}

{* Settings *}
{$settings.someCustomSetting}
```

## Integration Patterns

### jQuery/Vanilla JS with Angular
```javascript
// Wait for Angular to finish rendering
$(platform).on('loaded.productlist', function () {
  // Now safe to manipulate DOM
  document.querySelectorAll('[data-variant="variant"]').forEach(function (container) {
    container.addEventListener('click', function (event) {
      var valueEl = event.target.closest('span[data-value]');
      if (!valueEl) return;

      var dataIds = collectVariantData(container);
      var productId = container.dataset.productId;

      fetch('/json/productvariants/' + productId + '?dataIds=' + dataIds.join(','))
        .then(function (res) { return res.json(); })
        .then(updateProductCard);
    });
  });
});
```

### Extra Purchase System Pattern
```javascript
function ExtraPurchaseController(options) {
  this.data = options.data;  // window.extraPurchaseData from Smarty
  this.context = options.context;
  this.$container = document.querySelector(options.selector);
  this.state = {
    mainId: this.data.find(function (item) { return item.IsMain; }).Id,
    accessoryIds: []
  };
  this.render();
  this.bindEvents();
  this.updateTotals();
}

ExtraPurchaseController.prototype.updateTotals = function () {
  var base = this.data.find(function (item) {
    return item.Id === this.state.mainId;
  }.bind(this));

  var accessories = this.data.filter(function (item) {
    return this.state.accessoryIds.indexOf(item.Id) !== -1;
  }.bind(this));

  var subtotal = (base ? base.Price : 0) + accessories.reduce(function (sum, item) {
    return sum + item.Price;
  }, 0);

  var total = subtotal * (this.context.isPackageProduct ? 4 : 1);

  document.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {
    detail: { total: total, base: base, accessories: accessories }
  }));
};
```

## Component Development

When creating reusable components:

### Naming Convention
Use consistent prefixes for related variables:
```smarty
{* Component: footerUsp *}
{assign var=footerUspPageId value=123}
{assign var=footerUsp1_title value="Fast Delivery"}
{assign var=footerUsp1_text value="Ships within 24 hours"}
{assign var=footerUspImage1 value=$image1}
```

### Component Structure
```smarty
{* Load component data *}
{controller type=page assign=pageController}
{$componentContent = $pageController->getText($componentPageId)|strip_tags}

{* Parse structured content *}
{$title1 = $componentContent|regex_replace:'/.*title1:\s*/s':''|regex_replace:'/\s*text1:.*/s':''|trim}
{$text1 = $componentContent|regex_replace:'/.*text1:\s*/s':''|regex_replace:'/\s*title2:.*/s':''|trim}

{* Render component *}
<section class="component">
  <div class="component-item">
    <h3>{$title1}</h3>
    <p>{$text1}</p>
  </div>
</section>
```

### Component Best Practices
- Keep components self-contained
- Document expected data structure
- Provide fallback content
- Use `data-*` attributes for JavaScript hooks
- Follow consistent naming across projects

## Additional Resources

### Reference Files

For detailed implementation guidance:
- **`references/controller-reference.md`** - Complete controller documentation with methods and examples
- **`references/smarty-patterns.md`** - Advanced Smarty patterns and techniques
- **`references/angular-integration.md`** - Detailed AngularJS integration patterns
- **`references/platform-js-api.md`** - Platform.js complete API reference

### Example Files

Working examples in `examples/`:
- **`product-list-with-filters.tpl`** - Product listing with AngularJS filtering
- **`variant-selector.tpl`** - Variant selection UI with AJAX updates
- **`extra-purchase-flow.tpl`** - Complete extra purchase implementation
- **`json-endpoint-products.tpl`** - JSON API endpoint example

## Performance and Security

### Performance
- Reuse controller instances within templates
- Use preload templates for JSON endpoints
- Cache heavy controller results in Smarty variables
- Leverage DanDomain asset versioning with `addScript`/`addLink`
- Check `getActualSize()` before loops

### Security
- Default to escaped output: `|escape:'html'`
- Only use `|unescape:"htmlall"` on trusted CMS content
- Combine `|strip_tags` with `|nl2br` for safe HTML conversion
- Validate data at system boundaries
- Use `|formatPrice` for monetary values

### Error Handling
- Always check `getActualSize()` before iterating
- Provide fallback content with `|default` modifier
- Return structured responses from JSON endpoints
- Use `foreachelse` for empty state messaging

## Development Workflow

1. **Understand Requirements** - Identify data sources and UI needs
2. **Initialize Controllers** - Set up required DanDomain controllers
3. **Prepare Data** - Transform and structure controller data
4. **Create Template** - Build Smarty template with proper escaping
5. **Add Interactivity** - Integrate AngularJS if dynamic behavior needed
6. **Implement Events** - Use platform.js for cross-module communication
7. **Style with Tailwind** - Apply utility classes for responsive design
8. **Test Thoroughly** - Verify on multiple devices and browsers

## Common Patterns Summary

**Product Display:**
```smarty
{collection assign=products controller=productList categoryId=$categoryId}
{foreach $products->getData() as $product}
  {entity assign=image controller=files type=product productId=$product->Id}
  <article class="product-card">
    <img src="{$image->thumbnail(400, 400)}" alt="{$product->Title|escape:'html'}">
    <h3>{$product->Title}</h3>
    <p class="price">{$product->Price|formatPrice}</p>
  </article>
{/foreach}
```

**Variant Selection:**
```smarty
{collection assign=variantTypes controller=productVariantType productId=$product->Id}
{foreach $variantTypes->getData() as $type}
  <div class="variant-selector" data-variant-type="{$type->Id}">
    <label>{$type->Title}</label>
    {collection assign=variantData controller=productVariantData typeId=$type->Id}
    {foreach $variantData->getData() as $data}
      <button data-value="{$data->Id}">{$data->Value}</button>
    {/foreach}
  </div>
{/foreach}
```

**Event-Driven UI Update:**
```javascript
document.addEventListener('loaded.productlist', function() {
  initializeComponents();
});

window.platform.subscribe('/product/variant/selected', function(event, product, variant) {
  updateProductDisplay(variant);
  updateStickyBar(variant);
});
```

With these patterns and practices, build modern, maintainable DanDomain webshops that leverage the full power of Smarty, AngularJS, and platform.js integration.
