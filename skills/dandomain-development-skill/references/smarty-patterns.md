# Advanced Smarty Patterns for DanDomain

This reference contains advanced Smarty patterns, techniques, and best practices for DanDomain webshop development.

## Controller Patterns

### Controller Lifecycle and Reuse

Assign controllers to variables and reuse them throughout templates to avoid repetitive instantiation:

```smarty
{* Assign once *}
{controller type=page assign=pageController}

{* Reuse multiple times *}
{$content1 = $pageController->getText(10)}
{$content2 = $pageController->getText(20)}
{$content3 = $pageController->getText(30)}
```

When multiple templates need the same data, set the controller in the parent template and pass values to child templates:

```smarty
{* parent.tpl *}
{controller type=product assign=productCtrl}
{collection assign=products controller=$productCtrl categoryId=123}

{* Pass to child *}
{include file="partials/product-grid.tpl" products=$products}
```

### Complex Data Flows

For complex scenarios like JSON endpoints, combine multiple controllers and consolidate output in arrays:

```smarty
{* Initialize controllers *}
{controller type=product assign=productCtrl}
{controller type=files assign=filesCtrl}
{controller type=productCategory assign=categoryCtrl}

{* Build complex data structure *}
{assign var=output value=['code'=>1,'products'=>[]]}

{collection assign=products controller=$productCtrl categoryId=$categoryId}
{foreach $products->getData() as $product}
  {* Get related data *}
  {entity assign=category controller=$categoryCtrl id=$product->CategoryId}
  {entity assign=image controller=$filesCtrl type=product productId=$product->Id}

  {* Build product object *}
  {$output.products[] = [
    'id' => $product->Id,
    'title' => $product->Title,
    'price' => $product->Price,
    'category' => $category ? $category->Name : '',
    'image' => $image ? $image->thumbnail(400, 400) : null
  ]}
{/foreach}

{$output|jsonify}
```

### Controller Parameters

Use variables from other controllers as parameters:

```smarty
{* Get category first *}
{entity assign=category controller=productCategory id=$categoryId}

{* Use category data in collection *}
{collection assign=products controller=productList categoryId=$category->Id limit=12}
```

Dynamic parameters from GET/POST:

```smarty
{* From URL: /products?sort=price&order=asc *}
{collection assign=products
  controller=productList
  categoryId=$categoryId
  sort=$request.args.sort
  order=$request.args.order}
```

## Collections, Entities, and Preload

### Collection Methods

`{collection}` provides helper methods for data manipulation:

```smarty
{collection assign=products controller=productList categoryId=123}

{* Get actual size *}
{$products->getActualSize()}  {* Returns: 15 *}

{* Get data array *}
{$productArray = $products->getData()}

{* Pluck specific field *}
{$productIds = $products->pluck('Id')}  {* Returns: [1, 5, 8, 12, ...] *}
```

### Entity Lookups

Use `{entity}` for single-record lookups, often combined with collections:

```smarty
{collection assign=products controller=productList categoryId=123}
{foreach $products->getData() as $product}
  {* Fetch brand for each product *}
  {entity assign=brand controller=brand id=$product->ProducerId}
  <div class="product">
    <img src="{$brand->Logo}" alt="{$brand->Name}">
    <h3>{$product->Title}</h3>
  </div>
{/foreach}
```

### Preload Strategy

Large datasets benefit from preload templates that cache data before iteration:

```smarty
{* modules/json/products-preload.tpl *}
{collection assign=products controller=productList categoryId=$categoryId}
{$productIds = $products->pluck('Id')}

{* Preload all product data at once *}
{collection assign=allPrices controller=productPrice productIds=$productIds}
{collection assign=allImages controller=files type=product productIds=$productIds}
{collection assign=allBrands controller=brand ids=$brandIds}

{* Now iterate without additional queries *}
{foreach $products->getData() as $product}
  {* Data is already cached *}
{/foreach}
```

## Iteration and Loops

### Foreach with Safety Checks

Always check size before iterating:

```smarty
{collection assign=products controller=productList categoryId=$categoryId}

{if $products->getActualSize() gt 0}
  {foreach $products->getData() as $product}
    <li>{$product->Title|escape:'html'}</li>
  {foreachelse}
    <li>No products available.</li>
  {/foreach}
{else}
  <p>This category is empty.</p>
{/if}
```

### Loop Variables

Smarty provides useful loop variables:

```smarty
{foreach $products->getData() as $product}
  <div class="product
    {if $smarty.foreach.products.first} first{/if}
    {if $smarty.foreach.products.last} last{/if}
    {if $smarty.foreach.products.index % 2 eq 0} even{else} odd{/if}">

    Product #{$smarty.foreach.products.iteration}: {$product->Title}

    {if $smarty.foreach.products.iteration % 4 eq 0}
      <div class="ad-slot"><!-- Ad every 4th item --></div>
    {/if}
  </div>
{/foreach}
```

Available loop variables:
- `first` - TRUE if first iteration
- `last` - TRUE if last iteration
- `index` - Zero-based index (0, 1, 2, ...)
- `iteration` - One-based iteration (1, 2, 3, ...)
- `total` - Total number of iterations
- `show` - TRUE if foreach will execute

### Nested Loops

Handle complex data structures with nested loops:

```smarty
{foreach from=$productData key=productId item=product}
  <div class="product">
    <h3>{$product.title}</h3>

    <select name="variant">
      {foreach from=$product.variants key=variantId item=variant}
        <option value="{$variantId}"
          {if $variant.stock eq 0}disabled{/if}>
          {$variant.name} - {$variant.price|formatPrice}
        </option>
      {/foreach}
    </select>

    <ul class="attributes">
      {foreach from=$product.attributes key=attrName item=attrValue}
        <li><strong>{$attrName}:</strong> {$attrValue}</li>
      {/foreach}
    </ul>
  </div>
{/foreach}
```

## Conditional Rendering

### Comparison Operators

Smarty uses text-based operators for clarity:

```smarty
{* Equality *}
{if $status eq 'active'} Active {/if}
{if $status neq 'inactive'} Not Inactive {/if}

{* Numeric comparison *}
{if $product->Stock gt 0} In Stock {/if}
{if $product->Stock lt 5} Low Stock {/if}
{if $product->Price ge 100} Premium {/if}
{if $product->Price le 50} Budget {/if}

{* Logical operators *}
{if $product->Active eq true and $product->Stock gt 0}
  <button>Add to Cart</button>
{/if}

{if $product->OnSale eq true or $product->IsFeatured eq true}
  <span class="badge">Special</span>
{/if}

{* Negation *}
{if not $product->Active}
  <span class="unavailable">Out of Stock</span>
{/if}
```

### Existence and Type Checks

Check if variables exist and have values:

```smarty
{* Check if set *}
{if isset($product.CustomData)}
  Custom data exists
{/if}

{* Check if empty *}
{if empty($product->Description)}
  <p>No description available</p>
{/if}

{* Check array size *}
{if isset($product.CustomData) && $product.CustomData|@count gt 0}
  {foreach from=$product.CustomData item=data}
    {$data}
  {/foreach}
{/if}

{* Check if array *}
{if is_array($variants)}
  {foreach from=$variants item=variant}
    {$variant.name}
  {/foreach}
{/if}
```

### Conditional in Loops

Filter data within iteration:

```smarty
{foreach $products->getData() as $product}
  {if $product->Stock gt 0 and $product->Active eq true}
    <div class="product-card">
      <h3>{$product->Title}</h3>
      <p>{$product->Price|formatPrice}</p>
    </div>
  {/if}
{/foreach}
```

## Assignments and Arrays

### Simple Assignments

Store values for reuse:

```smarty
{* Store single value *}
{assign var=firstImage value=$imageCollection->getData()[0]}
<img src="{$firstImage->thumbnail(800, 800)}" alt="Product">

{* Store computed value *}
{assign var=discountPrice value=$product->Price * 0.8}
<span class="price">
  <del>{$product->Price|formatPrice}</del>
  <strong>{$discountPrice|formatPrice}</strong>
</span>
```

### Array Building

Build arrays dynamically:

```smarty
{* Initialize empty array *}
{$extras = []}

{* Append to array *}
{collection assign=extraItems controller=productExtraBuy productId=$product->Id}
{foreach $extraItems->getData() as $item}
  {$extras[] = [
    'id' => $item->Id,
    'title' => $item->Title,
    'price' => $item->Price
  ]}
{/foreach}

{* Associative arrays *}
{$productMap = []}
{foreach $products->getData() as $product}
  {$productMap[$product->Id] = [
    'title' => $product->Title,
    'price' => $product->Price
  ]}
{/foreach}
```

### Array Access

Access array elements by key:

```smarty
{* Numeric index *}
{$firstProduct = $productArray[0]}
{$secondProduct = $productArray[1]}

{* Associative key *}
{$productTitle = $productMap[$productId].title}
{$productPrice = $productMap[$productId].price}

{* With default fallback *}
{$title = $productMap[$productId].title|default:'Unknown Product'}
```

## Formatting and Modifiers

### Price Formatting

Use `|formatPrice` for consistent monetary display:

```smarty
{* Simple price *}
{$product->Price|formatPrice}  {* Output: $19.99 *}

{* With calculations *}
{($product->Price * $quantity)|formatPrice}

{* In conditionals *}
{if $product->Price gt 100}
  <span class="premium">{$product->Price|formatPrice}</span>
{/if}
```

### URL and Link Generation

Generate SEO-friendly URLs:

```smarty
{* Product link *}
<a href="{$product|formatLink}">{$product->Title}</a>

{* Category link *}
<a href="{$category|formatLink}">{$category->Name}</a>

{* Manual URL formatting *}
<a href="{$product->Title|formatUrl}.html">{$product->Title}</a>
```

### Image Path Handling

Convert relative paths to CDN/hosting paths:

```smarty
{* Convert to solution path *}
<img src="{$imagePath|solutionPath}" alt="{$product->Title}">

{* Controller method for thumbnails *}
{entity assign=image controller=files type=product productId=$product->Id}
{if $image}
  <img src="{$image->thumbnail(400, 400)}" alt="{$product->Title}">
{/if}
```

### String Manipulation

Transform text with powerful modifiers:

```smarty
{* Truncate with ellipsis *}
{$product->Description|truncate:100:'...'|escape:'html'}

{* Strip HTML tags *}
{$product->Description|strip_tags}

{* Convert newlines to <br> *}
{$product->Description|nl2br}

{* Regex replace *}
{$product->Title|regex_replace:'/[^a-zA-Z0-9]/':'-'|lower}

{* String replace *}
{$product->Description|replace:'old text':'new text'}

{* Escape for HTML *}
{$product->Title|escape:'html'}

{* Escape for JavaScript *}
{$product->Title|escape:'javascript'}

{* Escape for URL *}
{$product->Title|escape:'url'}

{* Upper/lower case *}
{$product->Title|upper}
{$product->Title|lower}

{* Capitalize *}
{$product->Title|capitalize}
```

### Chaining Modifiers

Combine multiple modifiers for complex transformations:

```smarty
{* Clean and truncate description *}
{$product->Description|strip_tags|truncate:150|default:'No description available'}

{* Safe HTML display *}
{$product->Title|escape:'html'|upper}

{* URL-safe slug *}
{$product->Title|lower|regex_replace:'/[^a-z0-9]+/':'-'|trim:'-'}

{* Price with formatting *}
{$product->Price|number_format:2|cat:' EUR'}
```

## Translations and Internationalization

### Standard Text Objects

Access built-in translations:

```smarty
{* Use with fallback *}
{$text.CART_ADD_TO_CART|default:'Add to Cart'}
{$text.PRODUCT_OUT_OF_STOCK|default:'Out of Stock'}
{$text.CHECKOUT_CONTINUE|default:'Continue to Checkout'}
```

### Translation Controller

Fetch CMS-managed translations:

```smarty
{translation
  id=$deliveryTimeId
  module='delivery_time'
  title='title_on_stock'}

{* With HTML content *}
{translation
  id=$bannerId
  module='banners'
  title='html_content'|unescape:"htmlall"}
```

### Multi-Language Handling

Support multiple languages dynamically:

```smarty
{* Check current language *}
{if $general.LanguageISO eq 'da'}
  {$danishText}
{elseif $general.LanguageISO eq 'en'}
  {$englishText}
{else}
  {$defaultText}
{/if}

{* Language-specific includes *}
{include file="partials/footer-{$general.LanguageISO}.tpl"}
```

## Template Composition

### Include with Parameters

Pass data between templates:

```smarty
{* parent.tpl *}
{collection assign=products controller=productList categoryId=123}
{include file="partials/product-grid.tpl"
  products=$products
  columns=3
  showPrices=true}

{* partials/product-grid.tpl *}
<div class="grid columns-{$columns}">
  {foreach $products->getData() as $product}
    <div class="product-card">
      <h3>{$product->Title}</h3>
      {if $showPrices}
        <p>{$product->Price|formatPrice}</p>
      {/if}
    </div>
  {/foreach}
</div>
```

### Scope Management

Control variable scope between templates:

```smarty
{* Include with parent scope *}
{include file="partial.tpl" scope="parent"}
{* Variables set in partial.tpl are now available here *}

{* Include with isolated scope (default) *}
{include file="partial.tpl"}
{* Variables in partial.tpl don't leak out *}
```

### Capture for Buffering

Buffer output for later use:

```smarty
{* Capture product list HTML *}
{capture name="productList"}
  {foreach $products->getData() as $product}
    <li>{$product->Title}</li>
  {/foreach}
{/capture}

{* Use captured content *}
<ul class="products">
  {$smarty.capture.productList}
</ul>

{* Capture for meta tags *}
{capture name="metaDescription"}
  {$category->Name} - Shop {$products->getActualSize()} products
{/capture}

{* In head section *}
<meta name="description" content="{$smarty.capture.metaDescription|escape:'html'}">
```

### Strip Whitespace

Remove unnecessary whitespace in critical sections:

```smarty
{strip}
  <style>
    .product { margin: 0; padding: 10px; }
    .title { font-size: 18px; }
  </style>
{/strip}
```

**Note:** Use sparingly as it can break inline scripts or preformatted content.

## Performance Optimization

### Reuse Controller Instances

Avoid repeated controller initialization:

**Bad:**
```smarty
{foreach $productIds as $id}
  {entity assign=product controller=product productId=$id}
{/foreach}
```

**Good:**
```smarty
{controller type=product assign=productCtrl}
{foreach $productIds as $id}
  {entity assign=product controller=$productCtrl productId=$id}
{/foreach}
```

### Use primary=true for Caching

Enable caching for frequently-accessed data:

```smarty
{entity assign=reviews controller=productReview primary=true productId=$product->Id}
```

### Cache Heavy Computations

Store computed values in variables:

```smarty
{* Bad: Recalculates every time *}
{foreach $products->getData() as $product}
  <p>Discount: {($product->Price * 0.8)|formatPrice}</p>
{/foreach}

{* Good: Calculate once *}
{foreach $products->getData() as $product}
  {assign var=discountPrice value=$product->Price * 0.8}
  <p>Discount: {$discountPrice|formatPrice}</p>
{/foreach}
```

### Asset Versioning

Leverage DanDomain's built-in versioning:

```smarty
{addScript src="assets/js/{$bundleVersion}/app.js" cache=true}
{addLink href="assets/css/{$bundleVersion}/styles.css" cache=true}
```

## Error Handling and Fallbacks

### Safe Data Access

Always provide fallbacks for missing data:

```smarty
{* Simple fallback *}
{$product->Subtitle|default:'Coming Soon'}

{* Fallback with HTML *}
{if isset($product->Description) && $product->Description neq ''}
  {$product->Description}
{else}
  <p class="no-content">No description available</p>
{/if}

{* Fallback image *}
{entity assign=image controller=files type=product productId=$product->Id}
{if $image}
  <img src="{$image->thumbnail(400, 400)}" alt="{$product->Title}">
{else}
  <img src="/assets/images/placeholder.jpg" alt="No image">
{/if}
```

### JSON Error Responses

Return structured errors from JSON endpoints:

```smarty
{* Check for data *}
{collection assign=products controller=productList categoryId=$categoryId}

{if $products->getActualSize() gt 0}
  {assign var=output value=['code'=>1,'data'=>$products->getData()]}
{else}
  {assign var=output value=['code'=>0,'message'=>'No products found']}
{/if}

{$output|jsonify}
```

### Loop Safety

Guard against empty collections:

```smarty
{collection assign=products controller=productList categoryId=$categoryId}

{if $products->getActualSize() gt 0}
  <div class="product-grid">
    {foreach $products->getData() as $product}
      <div class="product-card">
        {* Product content *}
      </div>
    {foreachelse}
      <p>No products to display</p>
    {/foreach}
  </div>
{else}
  <div class="empty-state">
    <h3>No Products Found</h3>
    <p>Check back later for new arrivals.</p>
  </div>
{/if}
```

## Security Best Practices

### Output Escaping

Always escape user-generated or dynamic content:

```smarty
{* HTML escaping (default for most content) *}
<h1>{$product->Title|escape:'html'}</h1>

{* JavaScript escaping *}
<script>
  var productName = '{$product->Title|escape:'javascript'}';
</script>

{* URL escaping *}
<a href="/search?q={$searchTerm|escape:'url'}">Search</a>

{* HTML attribute escaping *}
<input type="text" value="{$product->Title|escape:'html'}" />
```

### Safe HTML from CMS

When displaying trusted HTML from CMS:

```smarty
{* Only unescape content you control *}
{translation id=$bannerId module='banners' title='html_content'|unescape:"htmlall"}

{* Better: sanitize first with regex *}
{assign var=safeHtml value=$cmsContent|regex_replace:'/<script[^>]*>.*?<\/script>/si':''}
{$safeHtml|unescape:"htmlall"}
```

### Strip Tags Carefully

Remove HTML while preserving line breaks:

```smarty
{* Just strip tags *}
{$product->Description|strip_tags}

{* Strip and preserve line breaks *}
{$product->Description|strip_tags|nl2br}
```

This comprehensive reference covers the most important Smarty patterns for DanDomain development. Combine these techniques for powerful, maintainable template code.
