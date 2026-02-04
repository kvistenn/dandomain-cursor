# Scraping af https://lib-of-smarty.netlify.app
> Max dybde: 3

---

# Kilde: https://lib-of-smarty.netlify.app (Niveau 0)

# Templet af Smarty
Komplet guide til at integrere moderne teknologier i DanDomain webshops. Lær Smarty Templates, AngularJS, Platform.js og TailwindCSS integration.
Udforsk dokumentationKom i gang med Smarty
🎨
### Smarty Templates
Server-side rendering med DanDomain controllere
→
🧱
### Komponenter
Genbrugelige UI komponenter og designsystem
→
🔧
### Platform.js
JavaScript framework til event-håndtering
→
🛒
### Ekstra tilkøb
Komplekse produktpakker og bundling
→

---

# Kilde: https://lib-of-smarty.netlify.app/docs/components (Niveau 1)

Components Library
# Components Library
En samling af genbrugelige Smarty komponenter til DanDomain webshops med eksempler og implementationsvejledning
# 🎨 Components Library
Velkommen til vores komponenter bibliotek! Her finder du en samling af professionelt designede og genbrugelige Smarty komponenter, der er klar til at blive integreret i dine DanDomain webshops.
## ✨ Filosofi
Alle vores komponenter er bygget med følgende principper i tankerne:
* **Genbrugelig** - Kopier-og-indsæt klar til enhver webshop
* **Fleksibel** - Nem at tilpasse med simple konfigurationsændringer
* **Vedligeholdelsesvenlig** - Klart struktureret kode med deskriptive navngivning
* **Dokumenteret** - Detaljerede vejledninger for hver komponent
## 📦 Tilgængelige Komponenter
### Footer USP Section
En tre-kolonne USP sektion til sidefoden med billeder, titler og beskrivelser
## 🚀 Kom i Gang
Hver komponent dokumentation inkluderer:
📋
### Setup Guide
Trin-for-trin vejledning
💾
### Smarty Code
Klar til at kopiere
⚙️
### Konfiguration
Tilpas til dine behov
## 💡 Generiske Navngivningskonventioner
For at gøre det nemt at genbruge komponenter på tværs af projekter, bruger vi følgende mønster:
```
[componentName]PageId        - ID for siden med komponent-indholdet
[componentName]1_title       - Titel for første element
[componentName]1_text        - Tekst for første element
[componentName]Image1/2/3    - Billeder (gennemløbsnummer)
```
**Eksempel for FooterUSP:**
* `footerUspPageId` - ID for siden med USP indhold
* `footerUsp1_title`, `footerUsp2_title`, `footerUsp3_title`
* `footerUsp1_text`, `footerUsp2_text`, `footerUsp3_text`
* `footerUspImage1`, `footerUspImage2`, `footerUspImage3`
💡 Pro Tip
Denne navngivning gør det super nemt at kopiere komponenten til dit eget projekt - du skal bare ændre præfikset fra `footerUsp` til dit eget komponent-navn!
## 🔄 Workflow
Her er det typiske workflow når du implementerer en komponent:
#### Læs dokumentationen
Gå gennem komponentets vejledning og forstå dets struktur
#### Opret backend-side
Opret en side i dit CMS med det indhold komponenten skal vise
#### Tilpas siden-ID
Opdater side-ID'et i komponenten til at passe med din backend-side
#### Tilpas indholdsformat
Strukturér dit side-indhold efter komponentens forventede format
#### Indsæt Smarty-koden
Kopier komponenten ind i din Smarty template hvor den skal vises
#### Test og optimér
Test output og tilpas styling efter behov
## 📚 Integration med dine projekter
Alle komponenter er designet til at kunne indlæses i dine eksisterende Smarty templates:
```
{* Load the component directly in your template *}
{include file="path/to/components/footer-usp.tpl"}
```
ℹ️ Best Practices
* Gruppér alle komponenter i en dedikeret `components/` mappe i dit projekt
* Brug samme navngivningskonvention på tværs af alle dine komponenter
* Dokumentér dine tilpasninger for fremtidig vedligeholdelse
* Test responsivt design på mobil, tablet og desktop
---
**Klar til at dykke ned?** Vælg en komponent ovenfor for at komme i gang! 🚀
Smarty Integration
Komplet guide til Smarty templates og DanDomain controllere
Footer USP Component
En tre-kolonne USP sektion designet til sidefoden med fleksibel konfiguration og generisk navngivning
### On this page
🎨 Components Library✨ Filosofi📦 Tilgængelige Komponenter🚀 Kom i Gang💡 Generiske Navngivningskonventioner🔄 Workflow📚 Integration med dine projekter

---

# Kilde: https://lib-of-smarty.netlify.app/docs (Niveau 1)

DanDomain Integrations Guide
# DanDomain Integrations Guide
Komplet guide til Smarty, AngularJS og TailwindCSS integration i DanDomain webshops
# Velkommen til DanDomain Integrations Guide
Dette er den ultimative guide til integration af moderne teknologier i DanDomain webshops. Her finder du alt, hvad du skal vide om:
## 🚀 Teknologi Stak
Vores platform kombinerer de bedste værktøjer til moderne e-handel:
### Smarty Templates
Server-side rendering med DanDomain controllere
### AngularJS
Dynamisk klient-side funktionalitet
### TailwindCSS
Utility-first CSS framework
### Platform.js
JavaScript framework til event-håndtering
## 📚 Dokumentationsområder
### 🔧 Smarty Integration
Komplet guide til Smarty templates og DanDomain controllere med praktiske eksempler
### 📋 Controller Directory
Oversigt over alle tilgængelige controllere og deres anvendelse med API reference
### ⚡ Platform Integration
JavaScript platform namespace og event-system til koordinering
### 🎯 AngularJS Integration
Integration af AngularJS med Smarty templates og data binding
### 🎨 Components Library
Samling af genbrugelige Smarty komponenter til DanDomain webshops med eksempler og implementationsvejledning
### 🛒 Extra Purchase System
Kompleks produktbundling med ekstra tilkøb og pakkehåndtering
💡 Tip
Start med **Smarty Integration** hvis du er ny til DanDomain, eller gå direkte til **Controller Directory** hvis du leder efter specifikke controller-metoder.
## 🎯 Målgruppe
Dette dokument er skrevet for:
* **Udviklere** der arbejder med DanDomain webshops
* **Frontend-udviklere** der skal integrere moderne JavaScript
* **Backend-udviklere** der arbejder med Smarty templates
* **Projektledere** der har brug for teknisk overblik
## 💡 Filosofi
Vores tilgang fokuserer på:
* **Genbrugelighed** - Mønstre der kan overføres mellem projekter
* **Vedligeholdelse** - Kode der er nem at forstå og udvide
* **Performance** - Optimerede løsninger til e-handel
* **Integration** - Sømløs kombination af teknologier
AngularJS Integration
Integration af AngularJS med Smarty templates i DanDomain webshops
### On this page
Velkommen til DanDomain Integrations Guide🚀 Teknologi Stak📚 Dokumentationsområder🎯 Målgruppe💡 Filosofi

---

# Kilde: https://lib-of-smarty.netlify.app/ (Niveau 1)

# Templet af Smarty
Komplet guide til at integrere moderne teknologier i DanDomain webshops. Lær Smarty Templates, AngularJS, Platform.js og TailwindCSS integration.
Udforsk dokumentationKom i gang med Smarty
🎨
### Smarty Templates
Server-side rendering med DanDomain controllere
→
🧱
### Komponenter
Genbrugelige UI komponenter og designsystem
→
🔧
### Platform.js
JavaScript framework til event-håndtering
→
🛒
### Ekstra tilkøb
Komplekse produktpakker og bundling
→

---

# Kilde: https://lib-of-smarty.netlify.app/docs/extra-purchase (Niveau 1)

Ekstra Tilkøbs-Flow (Pakkelogik)
# Ekstra Tilkøbs-Flow (Pakkelogik)
Kompleks produktbundling med ekstra tilkøb i DanDomain webshops
# Ekstra Tilkøbs-Flow (Pakkelogik)
## For Udviklere (Dansk)
Denne vejledning beskriver en generel, genanvendelig tilgang til produkter med ekstra tilkøb (fx dæk, sensorer, montering, tilbehør). Fokus er på konkrete handlinger, så mønstrene kan overføres til andre webshops uden afhængighed af specifikke filer.
### 1. Dataforberedelse i Smarty
```
{collection assign=extraBuyCategories controller=productExtraBuyCategory productId=$product->Id}{foreach $extraBuyCategories->getData() as $category}  {collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$category->Id}  {foreach $extraBuys->getData() as $item}      {entity assign=itemProduct controller=product productId=$item->Id}      {entity assign=itemImage controller=files type=product productId=$item->Id}      {$extraPurchase[] = [          'Id' => $item->Id,          'Category' => $category->Title,          'Title' => $itemProduct->Title,          'Image' => $itemImage ? $itemImage->thumbnail(320, 320) : null,          'Price' => $item->Price,          'IsMain' => $item->IsMain      ]}  {/foreach}{/foreach}
```
IsMain Markering
`IsMain` markerer basisvalget (fx "Kun fælge") - dette er det primære produkt uden ekstra tilkøb.
```
<script>  window.extraPurchaseData = {$extraPurchase|jsonify};  window.extraPurchaseContext = {      isPackageProduct: {if $isKomplethjulspakke}true{else}false{/if},      hasAccessoryOptions: {if $hasTireOptions}true{else}false{/if}  };</script><div id="extra-purchase-container"></div>
```
Standardiseret Struktur
Alle webshops kan følge samme mønster: serialiser en liste med felter som `Id`, `Category`, `Price`, `Image` og `IsMain`.
### 2. JavaScript-orkestrering
1. **Initialisering**
   ```
   function ExtraPurchaseController(options) {
       this.data = options.data; // window.extraPurchaseData
       this.context = options.context; // window.extraPurchaseContext
       this.$container = document.querySelector(options.selector);
       this.state = {
           mainId: this.data.find(function (item) { return item.IsMain; }).Id,
           accessoryIds: []
       };
       this.render();
       this.bindEvents();
       this.updateTotals();
   }
   ```
2. **Rendering**
   * Gruppér `data` efter `Category` og generér kort med billed, titel, pris.
   * Tilføj `data-id` attributter til kortene, så klik-handlinger kan identificere valgene.
3. **Bindings**
   ```
   ExtraPurchaseController.prototype.bindEvents = function () {
       var self = this;
       this.$container.addEventListener('click', function (event) {
           var card = event.target.closest('[data-extra-id]');
           if (!card) return;
           var id = card.getAttribute('data-extra-id');
           if (card.getAttribute('data-type') === 'main') {
               self.state.mainId = id;
           } else {
               var index = self.state.accessoryIds.indexOf(id);
               if (index === -1) self.state.accessoryIds.push(id);
               else self.state.accessoryIds.splice(index, 1);
           }
           self.updateTotals();
           self.renderSelections();
       });
   };
   ```
4. **Pris og mængde**
   ```
   ExtraPurchaseController.prototype.updateTotals = function () {
       var base = this.data.find(function (item) { return item.Id === this.state.mainId; }.bind(this));
       var accessories = this.data.filter(function (item) { return this.state.accessoryIds.indexOf(item.Id) !== -1; }.bind(this));
       var subtotal = (base ? base.Price : 0) + accessories.reduce(function (sum, item) { return sum + item.Price; }, 0);
       var multiplier = this.context.isPackageProduct ? 4 : 1;
       var total = subtotal * multiplier;
       document.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {
           detail: {
               total: total,
               base: base,
               accessories: accessories,
               quantity: multiplier
           }
       }));
   };
   ```
   * Multiplikator (antal stk.) kan tilpasses efter produkt-type.
### 3. Konsumenter af ændringer (universelle mønstre)
1. **Sammendragspanel**
   ```
   document.addEventListener('extraPurchaseSelectionChanged', function (event) {
       var detail = event.detail;
       var totalEl = document.querySelector('[data-summary="total"]');
       if (totalEl) totalEl.textContent = window.platform.currency_format(detail.total);
       var baseEl = document.querySelector('[data-summary="base"]');
       if (baseEl) baseEl.textContent = detail.base ? detail.base.Title : '';
   });
   ```
   * Panelet kan placeres hvor som helst (sticky panel, sidebar, osv.).
2. **Sticky footer / CTA**
   ```
   document.addEventListener('extraPurchaseSelectionChanged', function (event) {
       var checkoutBtn = document.querySelector('[data-footer="checkout"]');
       if (!checkoutBtn) return;
       var hasSelection = !!event.detail.base && event.detail.accessories.length > 0;
       checkoutBtn.disabled = !hasSelection;
   });
   ```
3. **Ajax-kurv integration**
   * Når kunden lægger produktet i kurven, send ekstra felter (fx hidden inputs) med valgte IDs eller en pakkekode.
   * Ved indlæsning af kurven, gruppér linjer efter samme pakkekode:
     ```
     function groupCartPackages(cartData) {
         return cartData.items.reduce(function (acc, line) {
             var packageId = line.ExtraPurchasePackageId;
             if (!packageId) {
                 acc.standalone.push(line);
                 return acc;
             }
             acc.packages[packageId] = acc.packages[packageId] || [];
             acc.packages[packageId].push(line);
             return acc;
         }, { packages: {}, standalone: [] });
     }
     ```
4. **Analytics og tracking**
   * Eventet `extraPurchaseSelectionChanged` kan bruges til at sende data til analytics, data layer m.m. uden at kende til intern struktur.
### 4. Best practices
* Hold navne generiske ("extra purchases" frem for domænespecifikke betegnelser).
* Eksportér kun de felter frontenden skal bruge, men inkluder altid `Id`, `Category`, `Price`, `Title`, `Image`.
* Udsend ét konsistent event, som alle UI-moduler kan lytte til.
* Sørg for fallback-tekster til noder, fx når ekstra valg fjernes.
* Brug `data-*` hooks for at gøre DOM-elementer nemme at målrette i scripts.
---
## For Language Models (English)
This guide outlines a reusable approach for products with optional add-ons ("extra purchases"), independent of any specific project.
### 1. Preparing data in Smarty
1. **Load categories and items**
   ```
   {collection assign=extraBuyCategories controller=productExtraBuyCategory productId=$product->Id}
   {foreach $extraBuyCategories->getData() as $category}
       {collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$category->Id}
       {foreach $extraBuys->getData() as $item}
           {entity assign=itemProduct controller=product productId=$item->Id}
           {entity assign=itemImage controller=files type=product productId=$item->Id}
           {$extraPurchase[] = [
               'Id' => $item->Id,
               'Category' => $category->Title,
               'Title' => $itemProduct->Title,
               'Image' => $itemImage ? $itemImage->thumbnail(320, 320) : null,
               'Price' => $item->Price,
               'IsMain' => $item->IsMain
           ]}
       {/foreach}
   {/foreach}
   ```
2. **Expose data to JavaScript**
   ```
   <script>
       window.extraPurchaseData = {$extraPurchase|jsonify};
       window.extraPurchaseContext = {
           isPackageProduct: {if $isPackage}true{else}false{/if},
           hasAccessoryOptions: {if $hasOptions}true{else}false{/if}
       };
   </script>
   <div id="extra-purchase-container"></div>
   ```
   * This pattern works for any add-on scenario: serialize ID, category, price, title, image, and a flag for the main entry.
### 2. JavaScript orchestration
1. **Initialization**
   ```
   function ExtraPurchaseController(options) {
       this.data = options.data;
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
   ```
2. **Rendering**
   * Group data by `Category`, build cards with title, price, image.
   * Mark cards with `data-extra-id` and `data-type="main"` or `data-type="accessory"`.
3. **Bindings**
   ```
   ExtraPurchaseController.prototype.bindEvents = function () {
       var self = this;
       this.$container.addEventListener('click', function (event) {
           var card = event.target.closest('[data-extra-id]');
           if (!card) return;
           var id = card.getAttribute('data-extra-id');
           if (card.getAttribute('data-type') === 'main') {
               self.state.mainId = id;
           } else {
               var index = self.state.accessoryIds.indexOf(id);
               if (index === -1) self.state.accessoryIds.push(id);
               else self.state.accessoryIds.splice(index, 1);
           }
           self.updateTotals();
           self.renderSelections();
       });
   };
   ```
4. **Price and quantity**
   ```
   ExtraPurchaseController.prototype.updateTotals = function () {
       var base = this.data.find(function (item) { return item.Id === this.state.mainId; }.bind(this));
       var accessories = this.data.filter(function (item) { return this.state.accessoryIds.indexOf(item.Id) !== -1; }.bind(this));
       var subtotal = (base ? base.Price : 0) + accessories.reduce(function (sum, item) { return sum + item.Price; }, 0);
       var multiplier = this.context.isPackageProduct ? 4 : 1;
       var total = subtotal * multiplier;
       document.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {
           detail: {
               total: total,
               base: base,
               accessories: accessories,
               quantity: multiplier
           }
       }));
   };
   ```
### 3. Consumers of the event (universal patterns)
1. **Summary panel**
   ```
   document.addEventListener('extraPurchaseSelectionChanged', function (event) {
       var detail = event.detail;
       var totalEl = document.querySelector('[data-summary="total"]');
       if (totalEl) totalEl.textContent = window.platform.currency_format(detail.total);
       var baseEl = document.querySelector('[data-summary="base"]');
       if (baseEl) baseEl.textContent = detail.base ? detail.base.Title : '';
   });
   ```
2. **Sticky footer or call-to-action**
   ```
   document.addEventListener('extraPurchaseSelectionChanged', function (event) {
       var checkoutBtn = document.querySelector('[data-footer="checkout"]');
       if (!checkoutBtn) return;
       var hasSelection = !!event.detail.base && event.detail.accessories.length > 0;
       checkoutBtn.disabled = !hasSelection;
   });
   ```
3. **Ajax cart grouping**
   ```
   function groupCartPackages(cartData) {
       return cartData.items.reduce(function (acc, line) {
           var packageId = line.ExtraPurchasePackageId;
           if (!packageId) {
               acc.standalone.push(line);
               return acc;
           }
           acc.packages[packageId] = acc.packages[packageId] || [];
           acc.packages[packageId].push(line);
           return acc;
       }, { packages: {}, standalone: [] });
   }
   ```
4. **Analytics / tracking**
   * Subscribe to `extraPurchaseSelectionChanged` and push data to a data layer or analytics endpoint.
### 4. Best practices
* Use neutral naming ("extra purchases") so the pattern scales beyond a single domain.
* Export the minimal data the frontend needs: `Id`, `Category`, `Title`, `Price`, `Image`, `IsMain`.
* Broadcast a single, consistent event; let downstream modules subscribe.
* Provide UI fallbacks for deselected content (empty states, default copy).
* Mark up DOM nodes with `data-*` attributes to keep selectors portable.
Controller Directory
Oversigt over alle tilgængelige DanDomain controllere og deres anvendelse
Mest Anvendte Controllere
Analyse af de mest anvendte Smarty controllere på tværs af forskellige webshops med praktiske eksempler og integrationsmuligheder
### On this page
Ekstra Tilkøbs-Flow (Pakkelogik)For Udviklere (Dansk)1. Dataforberedelse i Smarty2. JavaScript-orkestrering3. Konsumenter af ændringer (universelle mønstre)4. Best practicesFor Language Models (English)1. Preparing data in Smarty2. JavaScript orchestration3. Consumers of the event (universal patterns)4. Best practices
```
{collection assign=extraBuyCategories controller=productExtraBuyCategory productId=$product->Id}
{foreach $extraBuyCategories->getData() as $category}
  {collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$category->Id}
  {foreach $extraBuys->getData() as $item}
      {entity assign=itemProduct controller=product productId=$item->Id}
      {entity assign=itemImage controller=files type=product productId=$item->Id}
      {$extraPurchase[] = [
          'Id' => $item->Id,
          'Category' => $category->Title,
          'Title' => $itemProduct->Title,
          'Image' => $itemImage ? $itemImage->thumbnail(320, 320) : null,
          'Price' => $item->Price,
          'IsMain' => $item->IsMain
      ]}
  {/foreach}
{/foreach}
```
```
<script>
  window.extraPurchaseData = {$extraPurchase|jsonify};
  window.extraPurchaseContext = {
      isPackageProduct: {if $isKomplethjulspakke}true{else}false{/if},
      hasAccessoryOptions: {if $hasTireOptions}true{else}false{/if}
  };
</script>
<div id="extra-purchase-container"></div>
```

---

# Kilde: https://lib-of-smarty.netlify.app/docs/smarty-integration (Niveau 1)

Smarty Integration
# Smarty Integration
Komplet guide til Smarty templates og DanDomain controllere
# Smarty Integration Guide
## For Udviklere (Dansk)
Dette dokument beskriver, hvordan Smarty, AngularJS og TailwindCSS anvendes sammen i dette DanDomain-projekt for at skabe en moderne og vedligeholdelsesvenlig webshop.
### Overordnet Arkitektur
Kernen i projektet er DanDomains Smarty-baserede template-system. Vi bruger dette system til at rendere siderne på serveren. Oven på dette har vi et lag af AngularJS til dynamisk funktionalitet på klientsiden og TailwindCSS til styling.
### Smarty
Smarty er fundamentet og håndterer al server-side rendering.
**Controllere og Datahentning:**
Data hentes via indbyggede DanDomain Smarty-controllere. Den mest almindelige måde at initialisere en controller på er:
```
{controller type=page assign=pageController}
```
Når controlleren er tildelt en variabel (her `pageController`), kan dens metoder bruges til at hente data. Et typisk mønster er at hente indhold fra en DanDomain-side (f.eks. en tekstside) og bruge det som en datakilde for en komponent:
```
{controller type=page assign=pageController}{$featureContent = $pageController->getText(16)|strip_tags}{* Indholdet kan derefter manipuleres med regex for at udtrække specifikke dele *}{$featureTitle = $featureContent|regex_replace:'/.*overskrift:s*/s':''|regex_replace:'/s*beskrivelse:.*/s':''|trim}
```
Vigtigt Mønster
Dette mønster ses ofte i komponenter, hvor sideindhold skal omskabes til moduler. Det gør det muligt at gøre CMS-indhold dynamisk og genbrugelig på tværs af forskellige sektioner.
**Controller-livscyklus og genbrug:**
* Tildel controlleren til en variabel (`assign=...`) og genbrug den gennem hele template-blokken for at undgå gentagne instanser.
* Når data skal bruges i flere sektioner, kan du sætte controlleren i en `parent`-template og bruge `{include}` med `assign` for at dele data mellem child-templates.
* Ved komplekse dataflows (fx JSON-endpoints) kan du kombinere flere controllere i samme template og lagre delresultater i arrays via `{assign}`.
**Controller parametre og variabler:**
GrundlæggendeAvanceredeGET Parametre
Brug variabler fra andre controllere som parametre:
```
{collection assign=products controller=productList categoryId=$category->Id}
```
(hvor `$category` kommer fra en `productCategory` controller)
Kombinér flere filtre for avanceret sortering:
```
{collection assign=products controller=productList focus=frontpage orderBy="-Sold" pageSize=15}
```
Tilføj ekstra kontekst:
```
{collection assign=prices controller=productPrice productId=$product->Id variantId=$variant->Id productDiscountGroupId=$product->DiscountGroupId}
```
Brug GET-parametre til dynamisk indhold:
```
{entity assign=variant controller=productVariant productId=$item->Id variantId=(int)$smarty.get.variantId}
```
**Collections, Entities og Præload:**
* `{collection ...}` bruges til at hente lister af data (fx produkter, filer eller sider). Resultatet giver adgang til `getData()`, `getActualSize()` og `pluck()` til videre behandling.
* `{entity ...}` henter en enkelt Datadomæne-entitet og bruges ofte sammen med `{collection}` til at slå supplerende data op (fx brandets billede baseret på produktets `ProducerId`).
* Store datasæt præindlæses systematisk med inkluderede præload-skabeloner (`modules/json/*-preload.tpl`). Det mønster sikrer færre databasekald og konsekvent datatilgængelighed, når JSON-endpoints eller Angular-komponenter efterspørger data.
**Iteration og loops:**
Brug `{foreach}` til at iterere over collections med sikkerhedstjek:
```
{if $products->getActualSize() gt 0}  {foreach $products->getData() as $product}      <li>{$product->Title|escape:'html'}</li>  {foreachelse}      <li>Ingen produkter tilgængelige.</li>  {/foreach}{/if}
```
Udnyt `smarty.foreach.loopName.first`, `last`, `index` og `iteration`:
```
{foreach $products->getData() as $product}  <div class="product {if $smarty.foreach.products.first}first{/if} {if $smarty.foreach.products.last}last{/if}">      Produkt #{$smarty.foreach.products.iteration}: {$product->Title}  </div>{/foreach}
```
Arbejd med komplekse datastrukturer:
```
{foreach from=$productData key=productId item=product}  <h3>{$product.title}</h3>  {foreach from=$product.variants key=variantId item=variant}      <option value="{$variantId}">{$variant.name}</option>  {/foreach}{/foreach}
```
Bedste Praksis
Undgå `{section}` medmindre du arbejder på numeriske arrays; `{foreach}` er mere læsbar og understøtter `foreachelse`. For nested loops, kombiner `{foreach}` med `{assign}` for at bygge strukturer.
**Conditional rendering:**
* Brug `eq`, `neq`, `gt`, `lt`, `ge`, `le`, `and`, `or` for sammenligninger i `{if}`.
* Kombinér `isset`, `empty` og `is_array` med Smarty-syntaks: `{if isset($product.CustomData) && $product.CustomData|@count gt 0}`.
* Benyt `default`-modifikatoren til fallback værdier: `{$product->Subtitle|default:'Kommer snart'}`.
* Brug betingelser i loops: `{foreach $products->getData() as $product}{if $product->Stock gt 0}<li>{$product->Title}</li>{/if}{/foreach}`.
* Kontrollér flere værdier: `{if $product->Type eq 'variant' && $product->VariantDisplayMode neq 'none'}`.
* Når du arbejder med oversættelser, brug `{$text.KEY|default:'Fallback'}` eller `{translation id=... module=... title='...'}`.
**Assignments og arrays:**
* Brug `{assign}` til at gemme midlertidige værdier:
  ```
  {assign var=firstImage value=$imageCollection->getData()[0]}
  ```
* Append til arrays ved hjælp af `set`/`append`-syntaks:
  ```
  {$extras = []}
  {$extras[] = ['title' => $item->Title, 'price' => $item->Price]}
  ```
* Til associative arrays: `{$extras[$item->Id] = ['title' => $item->Title]}`.
**Formatterings- og helper-modifikatorer:**
* `|formatPrice` formatterer tal efter shoppens valutaindstillinger.
* `|formatUrl` eller `|formatLink` genererer SEO-venlige links (kombinér med `ProductController::link`).
* `|solutionPath` konverterer relative billedstier til CDN/hosting stier.
* `|regex_replace`, `|replace`, `|truncate`, `|escape`, `|nl2br` bruges til strengmanipulation.
* Brug `ProductController::link`, `PageController::link`, `BrandController::link` i PHP-lignende variabler når rene handles ikke er tilgængelige.
* Kombinér modifikatorer: `{$product->Description|strip_tags|truncate:100|default:'Ingen beskrivelse'}`.
* Brug i loops: `{foreach $products->getData() as $product}<span>{$product->Title|escape:'html'|upper}</span>{/foreach}`.
**Internationale tekster:**
* `$text` objektet indeholder standard-oversættelser. Brug `|default` for at undgå tomme strenge i custom sproglag.
* `{translation id=$deliveryTimeId module='delivery_time' title='title_on_stock'}` henter CMS-styrede oversættelser; navngiv `title` så det matcher backend-feltet.
* Ved HTML i oversættelser, brug `|unescape:"htmlall"` efter at have valideret indholdet.
**Globale Variabler:**
DanDomain stiller en række globale variabler til rådighed, som er essentielle for udvikling:
* `{$page}`: Indeholder information om den nuværende side (f.eks. ID, navn, om det er forsiden).
* `{$general}`: Generelle shop-informationer som sprog.
* `{$settings}`: Indeholder diverse indstillinger fra shoppens backend.
* `{$text}`: Bruges til at hente oversatte tekststrenge.
**JSON-Templates og API-lag:**
* JSON-endpoints i `modules/json/*.tpl` følger samme controller-mønstre som templates og udgør et API-lag for frontend scripts. Fx bruger `/json/products` både `productListController` og `productController` for at levere komplette produktobjekter inklusive billeder, priser og branddata.
* Når en JSON-fil kræver ekstra data, anvendes præload-skabeloner (fx `products-preload.tpl` og `productvariants-dataids-preload.tpl`) for at cache kontrolldata.
* Navngivning følger URL-struktur: `/json/products/{field}/{value}` læser `{$request.verb}` og `{$request.args}` for dynamisk routing.
**Event- og render-hooks:**
* Smarty-templates sætter JavaScript-begivenheder via `$(platform).publish(...)` eller `document.dispatchEvent(...)`. Disse hooks holder AngularJS, jQuery-moduler og sticky UI-komponenter synkroniserede. Eksempler:
  + `data-repeat-done="loaded.productlist"` udsender et event når Angular er færdig med en `ng-repeat`.
  + `document.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {...}))` informerer andre scripts om, at prisen eller valgene er ændret.
* Brug altid eksisterende hook-navne for at undgå duplikation (fx `fetch.productlist`, `loaded.productlist`, `cart/packageRemoved`). Når nye hooks introduceres, dokumentér dem sammen med den tilhørende payload (`detail`).
**Template-komposition:**
* `{include file="partials/head.tpl" with=...}` kan bruges til at sende data videre til child-templates. Brug `scope="parent"` når child-templates skal skrive data tilbage til parent-scope.
* `{capture}` er nyttigt til at buffer HTML eller tekst, der senere kan injiceres i en anden blok (fx til meta-tags eller structured data).
* `{strip}` reducerer whitespace i kritiske områder (fx `<head>`), men bør anvendes sparsomt for at undgå fejl i inline scripts.
**Output og sikkerhed:**
* Standard-escaping i DanDomain bruger `|escape:'html'`. Når du forventer HTML fra en sikker kilde (fx CMS-felter), brug `|unescape:"htmlall"` bevidst og kombiner det med sanitiseringslogik (regex eller whitelist).
* Brug `filter_var`-lignende mønstre via Smarty (`regex_replace`, `replace`) til at fjerne uønskede tags eller attributter.
* Husk at `|strip_tags` fjerner alt HTML – kombiner det med `|nl2br` hvis linjeskift skal bevares.
**Performance og caching:**
* Brug controllerens `primary=true` for at undgå implicitte cache-miss (fx `productReview primary=true`).
* Til statiske inkluder (`addLink`, `addScript`) kan du udnytte DanDomains egen versionering: `{addScript src="assets/js/{$bundleVersion}/app.js" cache=true}`.
* Overvej at gemme tunge controller-resultater i Smarty-variabler (`{$cacheData = ...}`) hvis den samme data bruges i flere sektioner.
* I loops: `{foreach $products->getData() as $product}{assign var=cachedPrice value=$product->Prices[0]}{/foreach}`.
**Fejlhåndtering:**
* Tjek `getActualSize()` før loops for at undgå tomme udsnit, og lever fallback-indhold (placeholders, default-tekster).
* Når JSON-endpoints ikke finder data, returnér strukturerede `code`/`message` felter, så frontend kan håndtere tilstanden (`{assign var=output value=['code'=>0,'result'=>[]]}`).
**Template Struktur:**
index.tpl
partials
modules
## API Reference
### Controller Metoder
Her er de vigtigste metoder tilgængelige på DanDomain controllere:
Prop
Type
`controller?`object
`controller->getData()?`array
`controller->getActualSize()?`integer
`controller->pluck(field)?`array
`collection->getData()?`array
`entity->Id?`integer|string
`entity->Title?`string
### AngularJS
AngularJS bruges til at tilføje dynamisk funktionalitet på klientsiden.
**Bootstrap:**
Applikationen initialiseres i `index.tpl` på `<body>`-tagget:
```
<body id="ng-app" data-ng-app="platform-app" ...>
```
Dette starter AngularJS-applikationen `platform-app`.
Smarty kommunikerer med AngularJS ved at printe JavaScript-kode:
```
{if $message}  <script>  function waitForMessage() {      if (typeof platform.Message !== 'undefined' && typeof platform.Message.load === 'function') {          platform.Message.load('{$message->text()}', '{$message->status()}');      } else {          setTimeout(waitForMessage, 100);      }  }  waitForMessage();  </script>{/if}
```
Kommunikationsmønster
Dette eksempel demonstrerer det generelle mønster: Smarty leverer data til en ventende JavaScript-funktion, som eksekveres, når modulet er indlæst.
### TailwindCSS
TailwindCSS bruges til al styling for at sikre et konsistent og utility-first design system.
**Konfiguration:**
```
// tailwind.config.cjscontent: ["./*.tpl","./partials/*.tpl","./modules/**/*.tpl",// ... andre stier],
```
Vigtigt
Dette sikrer, at alle CSS-klasser, der bruges i Smarty-templates, bliver inkluderet i den endelige CSS-fil.
**Inkludering og build-output:**
Template InkluderingBuild ProcessCDN Optimering
Den kompilerede CSS-fil inkluderes i `index.tpl`:
```
{addLink href='assets/css/bewise.css'}
```
Denne fil genereres af Grunt/PostCSS pipeline og indeholder Tailwind-output kombineret med øvrige moduler.
`gruntfile.js` definerer build-processen:
```
// Gruntfile.jspostcss: {tailwind: {  src: 'assets/tailwindcss/index.css',  dest: 'assets/css/bewise.css'}}
```
Build-pipelinen tager højde for DanDomain CDN ved at skrive versionerede filer:
```
// Template settings{$BUNDLE_VERSION = '1.2.3'}// Assets inkluderes med version{addScript src="assets/js/{$BUNDLE_VERSION}/app.js" cache=true}
```
---
## For Language Models (English)
This document describes how Smarty, AngularJS, and TailwindCSS are used together in this DanDomain project to create a modern and maintainable webshop.
### Overall Architecture
The core of the project is DanDomain's Smarty-based template system. We use this system to render the pages on the server. On top of this, we have a layer of AngularJS for dynamic client-side functionality and TailwindCSS for styling.
### Smarty
Smarty is the foundation and handles all server-side rendering.
**Controllers and Data Fetching:**
Data is fetched via built-in DanDomain Smarty controllers. The most common way to initialize a controller is:
```
{controller type=page assign=pageController}
```
Once the controller is assigned to a variable (here `pageController`), its methods can be used to fetch data. A typical pattern is to fetch content from a DanDomain page (e.g., a text page) and use it as a data source for a component:
```
{controller type=page assign=pageController}{$featureContent = $pageController->getText(16)|strip_tags}{* The content can then be manipulated with regex to extract specific parts *}{$featureTitle = $featureContent|regex_replace:'/.*overskrift:s*/s':''|regex_replace:'/s*beskrivelse:.*/s':''|trim}
```
This shows how raw CMS content can be transformed into structured component data.
**Controller lifecycle and reuse:**
* Assign controllers to variables and reuse them inside the same template to avoid repetitive instantiation.
* When multiple templates need the same data, assign on the parent template and pass values into child templates using `{include ... with=$data}` or by setting variables on the parent scope.
* For complex data flows (e.g., JSON responses) combine multiple controllers and consolidate output in arrays via `{assign}`.
**Collections, Entities, and Preload:**
* `{collection ...}` retrieves lists (products, files, pages) with helper methods like `getData()`, `getActualSize()`, and `pluck()`.
* `{entity ...}` loads a single record and is frequently combined with `{collection}` to enrich data (e.g., fetching the brand logo for each product).
* Large JSON payloads use preload templates (`modules/json/*-preload.tpl`) to warm caches before iteration.
**Global Variables:**
DanDomain provides a range of global variables that are essential for development:
* `{$page}`: Contains information about the current page (e.g., ID, name, if it is the front page).
* `{$general}`: General shop information like language.
* `{$settings}`: Contains various settings from the shop's backend.
* `{$text}`: Used to fetch translated text strings.
**JSON Templates and the API layer:**
* Templates under `modules/json/` expose controller data as JSON for the frontend. `products.tpl`, for example, orchestrates `productListController`, `productController`, brand lookups, and file thumbnails in one response.
* Preload includes (e.g., `products-preload.tpl`, `productvariants-dataids-preload.tpl`) cache related data before loops render output.
* URL conventions map directly to Smarty input: `/json/products/{field}/{value}` populates `{$request.verb}` and `{$request.args}`.
**Events and render hooks:**
* Templates emit JavaScript events such as `$(platform).publish('loaded.productlist')` or `document.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {...}))`. Consumers (Angular controllers, jQuery helpers, analytics trackers) subscribe to these events to stay synchronized.
* Reuse canonical hook names (`fetch.productlist`, `loaded.productlist`, `cart/packageRemoved`) to keep integrations predictable. When new hooks are defined, document their payload format.
**Template composition:**
* `{include ...}` with `with` or `scope="parent"` passes data between templates.
* `{capture}` stores generated markup so it can be injected later (e.g., in meta tags or schema data).
* `{strip}` removes whitespace; use carefully around inline scripts.
**Output and security:**
* Default to escaped output (`|escape:'html'`).
* Allow HTML only from trusted sources; use `|unescape:"htmlall"` together with sanitisation (regex or whitelisting).
* Combine `|strip_tags` and `|nl2br` to convert CMS content into safe HTML.
**Performance and caching:**
* Use `primary=true` when a controller should provide cached data (e.g., reviews).
* Take advantage of DanDomain asset versioning (`BUNDLE_VERSION`) with `addScript`/`addLink` so static assets can be cached aggressively.
* Cache heavy controller responses in Smarty variables if reused across sections.
**Error handling:**
* Guard loops with `getActualSize()` and provide defaults when data is missing.
* JSON templates should return predictable structures (`code`, `message`, `result`) so frontends can render appropriate states.
**Template Structure:**
* `index.tpl`: The main file that assembles all parts of the page.
* `partials/`: Contains reusable layout components such as `head.tpl`, `top.tpl`, and `bottom.tpl`.
* `modules/`: Houses larger, self-contained features (product, cart, checkout, etc.).
* `modules/widgets/`: Smaller reusable components (hero, newsletter, productslider, etc.).
* `modules/json/`: Acts as the server-side API for Ajax/Angular features.
### AngularJS
AngularJS is used to add dynamic functionality on the client-side.
**Bootstrap:**
* The application is initialized in `index.tpl` on the `<body>` tag:
  ```
  <body id="ng-app" data-ng-app="platform-app" ...>
  ```
  This starts the AngularJS application `platform-app`.
**Smarty to AngularJS Communication:**
* Data is often passed from Smarty to JavaScript/AngularJS by printing JavaScript code directly in the `.tpl` files. This is used, for example, to display system messages:
  ```
  {if $message}
      <script>
      function waitForMessage() {
          if (typeof platform.Message !== 'undefined' && typeof platform.Message load === 'function') {
              platform.Message.load('{$message->text()}', '{$message->status()}');
          } else {
              setTimeout(waitForMessage, 100);
          }
      }
      waitForMessage();
      </script>
  {/if}
  ```
  This example demonstrates the general approach: Smarty delivers data to a JavaScript helper which waits until the relevant module exists.
### TailwindCSS
TailwindCSS is used for all styling to ensure a consistent and utility-first design system.
**Configuration:**
* The configuration is located in `tailwind.config.cjs`. This file defines the theme (colors, spacing, etc.) and, most importantly, which files Tailwind should scan to find used utility classes:
  ```
  content: [
    "./*.tpl",
    "./partials/*.tpl",
    "./modules/**/*.tpl",
    // ... other paths
  ],
  ```
* This ensures that all CSS classes used in the Smarty templates are included in the final CSS file.
**Inclusion and build output:**
* The compiled CSS file is included in `index.tpl` through `{addLink href='assets/css/bewise.css'}`. This file is produced by the Grunt/PostCSS pipeline and contains Tailwind output plus project-specific utilities.
* `gruntfile.js` orchestrates Tailwind (`postcss:tailwind`), legacy CSS concatenation, and JavaScript bundling. When `BUNDLE_VERSION` changes in the template settings, files are deployed under `assets/js/{version}/`.
**Build Process:**
* The project uses Grunt to run tasks, including the compilation of TailwindCSS. Typical commands include:
  + `grunt postcss:tailwind` – generates the Tailwind output.
  + `grunt concat:css` and `grunt uglify:js` – bundle vendor assets.
  + The pipeline is CDN-aware for DanDomain environments by writing versioned bundles to `assets/js/{version}/` when necessary.
Platform Integration
JavaScript platform namespace og event-system til DanDomain integration
Components Library
En samling af genbrugelige Smarty komponenter til DanDomain webshops med eksempler og implementationsvejledning
### On this page
Smarty Integration GuideFor Udviklere (Dansk)Overordnet ArkitekturSmartyAPI ReferenceController MetoderAngularJSTailwindCSSFor Language Models (English)Overall ArchitectureSmartyAngularJSTailwindCSS
```
{controller type=page assign=pageController}
```
```
{controller type=page assign=pageController}
{$featureContent = $pageController->getText(16)|strip_tags}
{* Indholdet kan derefter manipuleres med regex for at udtrække specifikke dele *}
{$featureTitle = $featureContent|regex_replace:'/.*overskrift:s*/s':''|regex_replace:'/s*beskrivelse:.*/s':''|trim}
```
```
{collection assign=products controller=productList categoryId=$category->Id}
```
```
{collection assign=products controller=productList focus=frontpage orderBy="-Sold" pageSize=15}
```
```
{collection assign=prices controller=productPrice productId=$product->Id variantId=$variant->Id productDiscountGroupId=$product->DiscountGroupId}
```
```
{entity assign=variant controller=productVariant productId=$item->Id variantId=(int)$smarty.get.variantId}
```
```
{if $products->getActualSize() gt 0}
  {foreach $products->getData() as $product}
      <li>{$product->Title|escape:'html'}</li>
  {foreachelse}
      <li>Ingen produkter tilgængelige.</li>
  {/foreach}
{/if}
```
```
{foreach $products->getData() as $product}
  <div class="product {if $smarty.foreach.products.first}first{/if} {if $smarty.foreach.products.last}last{/if}">
      Produkt #{$smarty.foreach.products.iteration}: {$product->Title}
  </div>
{/foreach}
```
```
{foreach from=$productData key=productId item=product}
  <h3>{$product.title}</h3>
  {foreach from=$product.variants key=variantId item=variant}
      <option value="{$variantId}">{$variant.name}</option>
  {/foreach}
{/foreach}
```
```
<body id="ng-app" data-ng-app="platform-app" ...>
```
```
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
```
```
// tailwind.config.cjs
content: [
"./*.tpl",
"./partials/*.tpl",
"./modules/**/*.tpl",
// ... andre stier
],
```
```
{addLink href='assets/css/bewise.css'}
```
```
// Gruntfile.js
postcss: {
tailwind: {
  src: 'assets/tailwindcss/index.css',
  dest: 'assets/css/bewise.css'
}
}
```
```
// Template settings
{$BUNDLE_VERSION = '1.2.3'}
// Assets inkluderes med version
{addScript src="assets/js/{$BUNDLE_VERSION}/app.js" cache=true}
```
```
{controller type=page assign=pageController}
```
```
{controller type=page assign=pageController}
{$featureContent = $pageController->getText(16)|strip_tags}
{* The content can then be manipulated with regex to extract specific parts *}
{$featureTitle = $featureContent|regex_replace:'/.*overskrift:s*/s':''|regex_replace:'/s*beskrivelse:.*/s':''|trim}
```

---

# Kilde: https://lib-of-smarty.netlify.app/docs/platform-integration (Niveau 1)

Platform Integration
# Platform Integration
JavaScript platform namespace og event-system til DanDomain integration
# Platform Integration Guide
## For Udviklere (Dansk)
`platform.js` stiller et globalt namespace (`window.platform`) til rådighed i browseren. Det indeholder pub/sub events, helper-funktioner og klassedefinitioner, som kan bruges til at orkestrere frontend-adfærd på tværs af moduler.
### Pub/Sub mekanisme
```
// Udsend produkt data når det er klarwindow.platform.publish('/product/ready', produktObjekt);// Udsend variant valgwindow.platform.publish('/product/variant/selected', produkt, variant);
```
```
// Lyt til produkt eventswindow.platform.subscribe('/product/ready', function(event, produkt) {  // opdater UI, analytics, osv.  console.log('Produkt klar:', produkt.Title);});// Lyt til variant ændringerwindow.platform.subscribe('/product/variant/selected', function(event, produkt, variant) {  console.log('Variant valgt:', variant.Title);});
```
Event Konventioner
Kanalnavne følger en fleksibel strengkonvention (`/namespace/event`). Genbrug eksisterende events når det er muligt:
* `/product/ready`, `/product/selected`, `/product/buy`, `/product/wishlist`
* `/product/variant/selected`, `/product/variant/unselected`
* `/product/packet/selected`, `/product/packet/unselected`
* `/cart/ready`, `/platform/ready`
### `platform.product`
* `platform.product` er typisk en instans af `window.platform.classes.Product`
* Indeholder metoder som `updatePanel`, `updateUnitTitle`, `updateDescriptions`, `updateInputs`, `getVariants`, osv.
```
window.platform.subscribe('/product/selected', function (event, produkt, variant) {  if (variant) {      console.log('Variant valgt:', variant.Title, variant.Prices[0].PriceMin);      // Opdater pris, billeder, beskrivelser osv.      platform.product.updatePanel(variant);  } else {      console.log('Produkt valgt:', produkt.Title);  }});
```
Funktionalitet
Gør det muligt for scripts at interagere med det aktuelle produkt uanset hvilken variant/pakke der er valgt. Brug `platform.product` metoder til at opdatere UI elementer dynamisk.
### Andre `platform`-funktioner
* `platform.publish` og `platform.subscribe` (jQuery-baseret pub/sub).
* `platform.classes`: indeholder constructorer for produkt, varianthåndtering, billedtyper og pakker.
* `platform.settings`: eksponerer konfigurationsværdier (fx `shop_product_image_structure`, `cartLastCache`).
* `platform.currency_format`, `platform.number_format`: helper-funktioner til visning af valuta og tal (bruges også i Smarty via `formatPrice`).
* `platform.cart`: modul med metoder til at få/ændre kurvens indhold og udsende `/cart/ready` events.
### Typiske anvendelser
Variant HåndteringPakke SystemGlobal InitCustom Events
**Variantvalg:**
```
// product.entity.variant.*.js udsender eventswindow.platform.subscribe('/product/variant/selected', function(event, produkt, variant) {  // Opdater sticky footer med ny variant info  updateStickyFooter(variant);  // Send analytics data  analytics.track('variant_selected', { variantId: variant.Id });});
```
**Pakketilkøb:**
```
// product.entity.packet.js udsender eventswindow.platform.subscribe('/product/packet/selected', function(event, produkt, packet) {  // Juster total pris  updateTotalPrice(packet.Price);  // Opdater CTA knap  updateCheckoutButton(packet);});
```
**Global initialisering:**
```
// Vent på platform klarwindow.platform.subscribe('/platform/ready', function(event) {  // Start widgets der afhænger af platform  initializeProductWidgets();  initializeCartWidget();  initializeAnalytics();});
```
**Ekstra køb (custom events):**
```
// Projektet udsender custom DOM eventsdocument.addEventListener('extraPurchaseSelectionChanged', function(event) {  var detail = event.detail;  // Kan kombineres med platform.publish for bredere kompatibilitet  window.platform.publish('/extra-purchase/updated', detail);});
```
### Best practices
* Abonner (subscribe) først, derefter publicer (publish) – især når moduler indlæses asynkront.
* Navngiv events konsistent og undgå overlap med andre moduler.
* Frigør event handlers hvis et modul fjernes fra DOM (reduce memory leaks).
* Brug `platform.settings` til at læse konfiguration i stedet for hardcodede værdier.
---
## For Language Models (English)
`platform.js` exposes a global `window.platform` namespace used throughout the frontend. It provides pub/sub helpers, utility functions, and class constructors.
### Pub/Sub
* Publish events:
  ```
  window.platform.publish('/product/ready', productInstance);
  ```
* Subscribe to events:
  ```
  window.platform.subscribe('/product/ready', function (event, product) {
      // update UI, analytics, etc.
  });
  ```
* Reuse canonical channels: `/product/ready`, `/product/selected`, `/product/buy`, `/cart/ready`, `/platform/ready`, `/product/variant/selected`, etc.
### `platform.product`
* Usually an instance of `window.platform.classes.Product`.
* Offers methods like `updatePanel`, `updateDescriptions`, `updateInputs`, `updateUnitTitle`, etc.
* Use the instance to inspect current variant/packet data when responding to events.
### Additional helpers
* `platform.classes`: constructors for product variants, packet handling, image viewers.
* `platform.settings`: configuration map (image structure, cached timestamps, shop flags).
* `platform.currency_format`, `platform.number_format`: number helpers.
* `platform.cart`: cart module exposing `get`, `action`, and emitting `/cart/ready`.
### Usage patterns
1. Variant selection (`/product/variant/selected`).
2. Packet selection (`/product/packet/selected`).
3. Global initialization (`/platform/ready`).
4. Custom events combining DOM CustomEvent + `platform.publish` for cross-widget communication.
### Best practices
* Subscribe before publishing, especially if modules load lazily.
* Keep event names descriptive and unique.
* Clean up event listeners if components are destroyed.
* Reference `platform.settings` instead of hardcoding values.
Mest Anvendte Controllere
Analyse af de mest anvendte Smarty controllere på tværs af forskellige webshops med praktiske eksempler og integrationsmuligheder
Smarty Integration
Komplet guide til Smarty templates og DanDomain controllere
### On this page
Platform Integration GuideFor Udviklere (Dansk)Pub/Sub mekanisme`platform.product`Andre `platform`-funktionerTypiske anvendelserBest practicesFor Language Models (English)Pub/Sub`platform.product`Additional helpersUsage patternsBest practices
```
// Udsend produkt data når det er klar
window.platform.publish('/product/ready', produktObjekt);
// Udsend variant valg
window.platform.publish('/product/variant/selected', produkt, variant);
```
```
// Lyt til produkt events
window.platform.subscribe('/product/ready', function(event, produkt) {
  // opdater UI, analytics, osv.
  console.log('Produkt klar:', produkt.Title);
});
// Lyt til variant ændringer
window.platform.subscribe('/product/variant/selected', function(event, produkt, variant) {
  console.log('Variant valgt:', variant.Title);
});
```
```
window.platform.subscribe('/product/selected', function (event, produkt, variant) {
  if (variant) {
      console.log('Variant valgt:', variant.Title, variant.Prices[0].PriceMin);
      // Opdater pris, billeder, beskrivelser osv.
      platform.product.updatePanel(variant);
  } else {
      console.log('Produkt valgt:', produkt.Title);
  }
});
```
```
// product.entity.variant.*.js udsender events
window.platform.subscribe('/product/variant/selected', function(event, produkt, variant) {
  // Opdater sticky footer med ny variant info
  updateStickyFooter(variant);
  // Send analytics data
  analytics.track('variant_selected', { variantId: variant.Id });
});
```
```
// product.entity.packet.js udsender events
window.platform.subscribe('/product/packet/selected', function(event, produkt, packet) {
  // Juster total pris
  updateTotalPrice(packet.Price);
  // Opdater CTA knap
  updateCheckoutButton(packet);
});
```
```
// Vent på platform klar
window.platform.subscribe('/platform/ready', function(event) {
  // Start widgets der afhænger af platform
  initializeProductWidgets();
  initializeCartWidget();
  initializeAnalytics();
});
```
```
// Projektet udsender custom DOM events
document.addEventListener('extraPurchaseSelectionChanged', function(event) {
  var detail = event.detail;
  // Kan kombineres med platform.publish for bredere kompatibilitet
  window.platform.publish('/extra-purchase/updated', detail);
});
```

---

# Kilde: https://lib-of-smarty.netlify.app/docs/mest-anvendte-controllere (Niveau 2)

Mest Anvendte Controllere
# Mest Anvendte Controllere
Analyse af de mest anvendte Smarty controllere på tværs af forskellige webshops med praktiske eksempler og integrationsmuligheder
# Mest Anvendte Controllere - Dansk Guide
Denne guide præsenterer de mest anvendte Smarty-controllere på tværs af webshops i `shops-to-gain-knowledge-from/` mappen og korrelerer dem med den omfattende controller-dokumentation i `file-with-controller-info.md`.
📚 Læringsmål
Forstå de mest kritiske controllere i Smarty framework og deres praktiske anvendelse i forskellige shop-typer.
## Metodologi
Analysen blev udført ved:
Gennemgik alle `.tpl` template-filer på tværs af alle webshops
Identificerede både `{controller assign=... type=...}` og `{collection assign=... controller=...}` brug
Talte forekomster af hver controller-type på tværs af alle shops
Kortlagde fund til den omfattende controller-dokumentation
## Mest Anvendte Controllere
🥇 ProductController🥈 ProductCategoryController🥉 FilesController📊 PageController🎯 ProductListController
### 🥇 **ProductController** (Mest Anvendt)
**Brugsfrekvens**: Ekstremt høj (findes i næsten alle produktrelaterede templates)
**Primær Anvendelse**:
* Produkt-detaljesider (`product-entity.tpl`)
* Produkt-lister (`product-list.tpl`)
* Produkt-samlinger og displays
* Indkøbskurv integration
* Produkt søgefunktionalitet
**Nøglefunktioner**:
* Produkt data management
* Variant håndtering
* Pris beregninger
* Lager management
* Medie associationer
```
{* Grundlæggende ProductController brug *}{controller assign=productCtrl type=product}{* Hent specifik produkt *}{entity assign=product controller=$productCtrl id=123}{* Vis produkt titel *}<h1>{$product->Title}</h1>{* Hent produkt pris *}{collection assign=prices controller=productPrice productId=$product->Id}{$price = $prices->getData()[0]->Price}
```
### 🥈 **ProductCategoryController** (Anden Mest Anvendt)
**Brugsfrekvens**: Meget høj (findes i navigation, menuer og produktlister)
**Primær Anvendelse**:
* Kategori navigation (`menu.tpl`, `productmenu.tpl`)
* Kategori-baseret produkt filtrering
* Breadcrumb navigation
* Kategori hierarki display
* Produkt kategorisering
**Nøglefunktioner**:
* Kategori træ-strukturer
* Forælder-barn relationer
* Synlighed og adgangskontrol
* Kategori-baseret filtrering
```
{* Kategori navigation *}{controller assign=catCtrl type=productCategory}{collection assign=categories controller=$catCtrl}{foreach $categories->getData() as $category}<a href="/products/{$category->Id}">{$category->Title}</a>{/foreach}{* Underkategorier *}{collection assign=subcats controller=$catCtrl parentId=$category->Id}{if $subcats->getActualSize() > 0}<ul>  {foreach $subcats->getData() as $subcat}    <li>{$subcat->Title}</li>  {/foreach}</ul>{/if}
```
### 🥉 **FilesController** (Tredje Mest Anvendt)
**Brugsfrekvens**: Høj (findes i billedgallerier, medie-displays og indhold)
**Primær Anvendelse**:
* Billedgallerier og medie-displays
* Fil vedhæftninger og downloads
* Produkt billeder og medier
* Side og indholds-medier
* Dokument og PDF håndtering
**Nøglefunktioner**:
* Flere filtyper (billeder, PDF'er, videoer)
* Medie optimering og behandling
* Fil organisation og kategorisering
* Indholdslevering optimering
```
{* Billedgalleri *}{controller assign=fileCtrl type=files}{collection assign=images controller=$fileCtrl type=product id=$productId}<div class="gallery">{foreach $images->getData() as $image}  <img src="{$image->Path}" alt="{$image->Title}" />{/foreach}</div>{* PDF downloads *}{collection assign=pdfs controller=$fileCtrl type=productPdf id=$productId}{foreach $pdfs->getData() as $pdf}<a href="{$pdf->Path}" download>{$pdf->Title}</a>{/foreach}
```
### 📊 **PageController** (Fjerde Mest Anvendt)
**Brugsfrekvens**: Høj (findes i indholdssider og navigation)
**Primær Anvendelse**:
* Indholdssider og statisk indhold
* Side hierarkier og navigation
* SEO og meta data management
* Side templates og layouts
**Nøglefunktioner**:
* Indholdsmanagement system
* Side hierarkier og relationer
* SEO optimering funktioner
* Template system integration
```
{* Indholdsside *}{controller assign=pageCtrl type=page}{entity assign=page controller=$pageCtrl id=$pageId}<article><h1>{$page->Title}</h1><div class="content">  {$page->Text}</div></article>{* Under sider *}{collection assign=subPages controller=$pageCtrl parentId=$page->Id}{if $subPages->getActualSize() > 0}<nav>  {foreach $subPages->getData() as $subPage}    <a href="/{$subPage->Link}">{$subPage->Title}</a>  {/foreach}</nav>{/if}
```
### 🎯 **ProductListController** (Femte Mest Anvendt)
**Brugsfrekvens**: Høj (findes i produktlister og søgeresultater)
**Primær Anvendelse**:
* Produkt katalog displays
* Søgeresultat sider
* Kategori produktlister
* Produkt filtrering og sortering
* Paginering håndtering
**Nøglefunktioner**:
* Avanceret filtreringskapabilitet
* Sortering og ordningsmuligheder
* Paginering management
* Performance optimering
```
{* Produkt liste med filtrering *}{controller assign=listCtrl type=productList}{collection assign=products controller=$listCtrlcategoryId=$categoryIdorderBy='Title'pageSize=12}{* Vis produkter *}<div class="product-grid">{foreach $products->getData() as $product}  <div class="product-card">    <img src="{$product->Image}" alt="{$product->Title}" />    <h3>{$product->Title}</h3>    <p>{$product->Price} kr.</p>  </div>{/foreach}</div>{* Paginering *}{if $products->hasMorePages()}<nav class="pagination">  {for $page=1 to $products->getTotalPages()}    <a href="?page={$page}" class="{if $page == $products->getCurrentPage()}active{/if}">{$page}</a>  {/for}</nav>{/if}
```
## Ekstra Køb (ExtraBuy)
Hvorfor disse?
ExtraBuy-controllere er blandt de mest anvendte på tværs af shops, da de understøtter pakkelogik, tilbehør og produkt-tilvalg i UI og kurv.
### ProductExtraBuyCategory
Se fanen "ProductExtraBuyCategory" for detaljerede eksempler.
### ProductExtraBuy
Se fanen "ProductExtraBuy" for detaljerede eksempler.
OversigtProductExtraBuyCategoryProductExtraBuy
### Oversigt
Typisk brug
* Pakkelogik på produktsiden og grouping i kurven
* Tilvalg som sensorer/montering/tilbehør pr. produkt
* JSON-endpoints til widgets/slidere
### ProductExtraBuyCategory
```
{controller assign=extraBuyCategoryCtrl type=productExtraBuyCategory}{collection assign=extraBuyCategories controller=$extraBuyCategoryCtrl productId=$product->Id}
```
```
{foreach $extraBuyCategories->getData() as $ebc}<h3>{$ebc->Title}</h3>{/foreach}
```
Prop
Type
`ProductExtraBuyCategoryController::getDescriptionShort?`function
### ProductExtraBuy
```
{controller assign=extraBuyCtrl type=productExtraBuy}{collection assign=extraBuys controller=$extraBuyCtrl productId=$product->Id categoryId=$ebc->Id}{if $extraBuys->getActualSize() gt 0}{foreach $extraBuys->getData() as $item}  <div class="extra-item">    <span class="title">{$item->Title}</span>    <span class="price">{$item->Price|formatPrice}</span>  </div>{/foreach}{/if}
```
```
{collection assign=extraBuyCategories controller=productExtraBuyCategory productId=$product->Id}{foreach $extraBuyCategories->getData() as $ebc}{collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$ebc->Id}{/foreach}
```
Prop
Type
`ProductExtraBuyController::ExtraBuyAmount?`property
Se også
* Controller Directory
* `ProductExtraBuyCategoryController`: `https://shop68200.mywebshop.io/framework/help/ProductExtraBuyCategoryController`
* `ProductExtraBuyController`: `https://shop68200.mywebshop.io/framework/help/ProductExtraBuyController`
## Varianter (Variants)
Hvorfor disse?
Variant-controllere driver UI for valg af farver/størrelser mm., og data til JSON-endpoints og pakkelogik.
### ProductVariant
Se fanen "ProductVariant" for detaljerede eksempler.
### ProductVariantType
Se fanen "ProductVariantType" for detaljerede eksempler.
### ProductVariantData
Se fanen "ProductVariantData" for detaljerede eksempler.
### ProductVariantPacket
Se fanen "ProductVariantPacket" for detaljerede eksempler.
OversigtProductVariantProductVariantTypeProductVariantDataProductVariantPacket
### Oversigt
Typisk brug
* Variantvælgere på produktkort og produktside
* Indlæs variantdata pr. type til badge/chips UI
* Pakkespecifikke varianter i bundle flows
### ProductVariant
```
{controller assign=variantCtrl type=productVariant}{collection assign=variants controller=$variantCtrl productId=$product->Id}{if $variants->getActualSize() gt 0}<label for="variant">Variant</label><select id="variant" name="variant">  {foreach $variants->getData() as $v}    <option value="{$v->Id}">{$v->Title}</option>  {/foreach}</select>{/if}
```
### ProductVariantType
```
{collection assign=variantTypes controller=productVariantType productId=$product->Id}<ul class="variant-types">{foreach $variantTypes->getData() as $variantType}  <li><strong>{$variantType->Title}</strong></li>{/foreach}</ul>
```
### ProductVariantData
```
{collection assign=variantTypes controller=productVariantType productId=$product->Id}{foreach $variantTypes->getData() as $variantType}{collection assign=variantDatas controller=productVariantData productId=$product->Id typeId=$variantType->Id}<div class="variant-row">  <span class="type">{$variantType->Title}</span>  {foreach $variantDatas->getData() as $data}    <span class="chip">{$data->Title}</span>  {/foreach}</div>{/foreach}
```
### ProductVariantPacket
```
{controller assign=variantPacketCtrl type=productVariantPacket}{collection assign=packetVariants controller=$variantPacketCtrl productId=$product->Id packetGroupId=$packetGroupId packetProductId=$packetProductId}{foreach $packetVariants->getData() as $pv}<div class="packet-variant">{$pv->Title}</div>{/foreach}
```
Prop
Type
`ProductVariantController::getDescriptionShort?`function
`ProductVariantDataController::getPreloadFieldValues?`function
`ProductVariantTypeController::preload?`function
Se også
* Controller Directory
* `ProductVariantController`: `https://shop68200.mywebshop.io/framework/help/ProductVariantController`
* `ProductVariantTypeController`: `https://shop68200.mywebshop.io/framework/help/ProductVariantTypeController`
* `ProductVariantDataController`: `https://shop68200.mywebshop.io/framework/help/ProductVariantDataController`
* `ProductVariantPacketController`: `https://shop68200.mywebshop.io/framework/help/ProductVariantPacketController`
## Controller Brugsmønstre efter Shop Type
E-commerce FokusVin/Gave FokusSpecialiserede Shops
### **E-commerce Fokuserede Shops** (dsi, tekimex, watchesnordic)
**Primære Controllere**:
* ProductController (95% af templates)
* ProductCategoryController (85% af templates)
* ProductListController (70% af templates)
* CartController (60% af templates)
* OrderController (55% af templates)
**Nøglefunktioner**:
* Omfattende produktkatalog management
* Kompleks indkøbskurv funktionalitet
* Omfattende ordrebehandling
* Avanceret produkt filtrering og søgning
💡 E-commerce Bedste Praksis
Fokuser på ProductController for kernefunktionalitet og brug ProductCategoryController til navigation.
### **Vin/Gave Fokuserede Shops** (gogift-wine)
**Primære Controllere**:
* ProductController (90% af templates)
* ProductCategoryController (75% af templates)
* ProductListController (65% af templates)
* FilesController (60% af templates)
* PageController (55% af templates)
**Nøglefunktioner**:
* Produktkatalog med rige medier
* Kategori-baseret organisation
* Gave-relateret funktionalitet
* Forbedret indholds præsentation
🎁 Gave Shop Strategi
Udnyt FilesController til produkt billeder og PageController til indhold.
### **Specialiserede Shops** (oz-racing)
**Primære Controllere**:
* ProductController (85% af templates)
* ProductCategoryController (70% af templates)
* FilesController (65% af templates)
* BrandController (60% af templates)
* PageController (50% af templates)
**Nøglefunktioner**:
* Teknisk produkt fokus
* Brand-centreret organisation
* Rige medie præsentationer
* Specialiseret indholdsmanagement
🔧 Specialiseret Udvikling
Kombiner ProductController med BrandController for brand-fokuserede shops.
## Framework Styrker og Integrationsmuligheder
### 🏗️ Modulær Arkitektur
### 🔄 Konsistent API
### ⚡ Omfattende Funktionssæt
### 🔗 Integrationsmuligheder
## Udviklings Prioriteringer
Kerne fokus for alle shops - ProductController er fundamentet
Essentielt for al web tilstedeværelse - PageController og FilesController
Kritisk for kommercielle operationer - Cart og Order controllere
Vigtigt for rig indholds præsentation - FilesController optimering
Navigation og interaktions features - Category og Menu controllere
## Konklusion
Analysen afslører et vel-designet, omfattende controller framework der tjener behovene for forskellige e-commerce operationer. De mest anvendte controllere danner kernen af e-commerce funktionalitet, mens specialiserede controllere håndterer specifikke forretningskrav.
Den eksisterende dokumentation i `file-with-controller-info.md` giver komplet dækning af de mest kritiske controllere anvendt på tværs af alle analyserede webshops.
🚀 Næste Skridt
Fokuser på at mestre ProductController og ProductCategoryController for at bygge effektive e-commerce løsninger.
---
*Analyse Dato: $(date)*
*Analyserede Shops: 5 (dsi, gogift-wine, oz-racing, tekimex, watchesnordic)*
*Analyserede Templates: 400+ på tværs af alle shops*
*Identificerede Controller Brugsmønstre: 15+ forskellige controller typer*
Ekstra Tilkøb
Kompleks produktbundling med ekstra tilkøb i DanDomain webshops
Platform Integration
JavaScript platform namespace og event-system til DanDomain integration
### On this page
Mest Anvendte Controllere - Dansk GuideMetodologiMest Anvendte Controllere🥇 **ProductController** (Mest Anvendt)🥈 **ProductCategoryController** (Anden Mest Anvendt)🥉 **FilesController** (Tredje Mest Anvendt)📊 **PageController** (Fjerde Mest Anvendt)🎯 **ProductListController** (Femte Mest Anvendt)Ekstra Køb (ExtraBuy)ProductExtraBuyCategoryProductExtraBuyOversigtProductExtraBuyCategoryProductExtraBuyVarianter (Variants)ProductVariantProductVariantTypeProductVariantDataProductVariantPacketOversigtProductVariantProductVariantTypeProductVariantDataProductVariantPacketController Brugsmønstre efter Shop Type**E-commerce Fokuserede Shops** (dsi, tekimex, watchesnordic)**Vin/Gave Fokuserede Shops** (gogift-wine)**Specialiserede Shops** (oz-racing)Framework Styrker og IntegrationsmulighederUdviklings PrioriteringerKonklusion
```
{* Grundlæggende ProductController brug *}
{controller assign=productCtrl type=product}
{* Hent specifik produkt *}
{entity assign=product controller=$productCtrl id=123}
{* Vis produkt titel *}
<h1>{$product->Title}</h1>
{* Hent produkt pris *}
{collection assign=prices controller=productPrice productId=$product->Id}
{$price = $prices->getData()[0]->Price}
```
```
{* Kategori navigation *}
{controller assign=catCtrl type=productCategory}
{collection assign=categories controller=$catCtrl}
{foreach $categories->getData() as $category}
<a href="/products/{$category->Id}">{$category->Title}</a>
{/foreach}
{* Underkategorier *}
{collection assign=subcats controller=$catCtrl parentId=$category->Id}
{if $subcats->getActualSize() > 0}
<ul>
  {foreach $subcats->getData() as $subcat}
    <li>{$subcat->Title}</li>
  {/foreach}
</ul>
{/if}
```
```
{* Billedgalleri *}
{controller assign=fileCtrl type=files}
{collection assign=images controller=$fileCtrl type=product id=$productId}
<div class="gallery">
{foreach $images->getData() as $image}
  <img src="{$image->Path}" alt="{$image->Title}" />
{/foreach}
</div>
{* PDF downloads *}
{collection assign=pdfs controller=$fileCtrl type=productPdf id=$productId}
{foreach $pdfs->getData() as $pdf}
<a href="{$pdf->Path}" download>{$pdf->Title}</a>
{/foreach}
```
```
{* Indholdsside *}
{controller assign=pageCtrl type=page}
{entity assign=page controller=$pageCtrl id=$pageId}
<article>
<h1>{$page->Title}</h1>
<div class="content">
  {$page->Text}
</div>
</article>
{* Under sider *}
{collection assign=subPages controller=$pageCtrl parentId=$page->Id}
{if $subPages->getActualSize() > 0}
<nav>
  {foreach $subPages->getData() as $subPage}
    <a href="/{$subPage->Link}">{$subPage->Title}</a>
  {/foreach}
</nav>
{/if}
```
```
{* Produkt liste med filtrering *}
{controller assign=listCtrl type=productList}
{collection assign=products controller=$listCtrl
categoryId=$categoryId
orderBy='Title'
pageSize=12}
{* Vis produkter *}
<div class="product-grid">
{foreach $products->getData() as $product}
  <div class="product-card">
    <img src="{$product->Image}" alt="{$product->Title}" />
    <h3>{$product->Title}</h3>
    <p>{$product->Price} kr.</p>
  </div>
{/foreach}
</div>
{* Paginering *}
{if $products->hasMorePages()}
<nav class="pagination">
  {for $page=1 to $products->getTotalPages()}
    <a href="?page={$page}" class="{if $page == $products->getCurrentPage()}active{/if}">{$page}</a>
  {/for}
</nav>
{/if}
```
```
{controller assign=extraBuyCategoryCtrl type=productExtraBuyCategory}
{collection assign=extraBuyCategories controller=$extraBuyCategoryCtrl productId=$product->Id}
```
```
{foreach $extraBuyCategories->getData() as $ebc}
<h3>{$ebc->Title}</h3>
{/foreach}
```
```
{controller assign=extraBuyCtrl type=productExtraBuy}
{collection assign=extraBuys controller=$extraBuyCtrl productId=$product->Id categoryId=$ebc->Id}
{if $extraBuys->getActualSize() gt 0}
{foreach $extraBuys->getData() as $item}
  <div class="extra-item">
    <span class="title">{$item->Title}</span>
    <span class="price">{$item->Price|formatPrice}</span>
  </div>
{/foreach}
{/if}
```
```
{collection assign=extraBuyCategories controller=productExtraBuyCategory productId=$product->Id}
{foreach $extraBuyCategories->getData() as $ebc}
{collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$ebc->Id}
{/foreach}
```
```
{controller assign=variantCtrl type=productVariant}
{collection assign=variants controller=$variantCtrl productId=$product->Id}
{if $variants->getActualSize() gt 0}
<label for="variant">Variant</label>
<select id="variant" name="variant">
  {foreach $variants->getData() as $v}
    <option value="{$v->Id}">{$v->Title}</option>
  {/foreach}
</select>
{/if}
```
```
{collection assign=variantTypes controller=productVariantType productId=$product->Id}
<ul class="variant-types">
{foreach $variantTypes->getData() as $variantType}
  <li><strong>{$variantType->Title}</strong></li>
{/foreach}
</ul>
```
```
{collection assign=variantTypes controller=productVariantType productId=$product->Id}
{foreach $variantTypes->getData() as $variantType}
{collection assign=variantDatas controller=productVariantData productId=$product->Id typeId=$variantType->Id}
<div class="variant-row">
  <span class="type">{$variantType->Title}</span>
  {foreach $variantDatas->getData() as $data}
    <span class="chip">{$data->Title}</span>
  {/foreach}
</div>
{/foreach}
```
```
{controller assign=variantPacketCtrl type=productVariantPacket}
{collection assign=packetVariants controller=$variantPacketCtrl productId=$product->Id packetGroupId=$packetGroupId packetProductId=$packetProductId}
{foreach $packetVariants->getData() as $pv}
<div class="packet-variant">{$pv->Title}</div>
{/foreach}
```

---

# Kilde: https://lib-of-smarty.netlify.app/docs/angular-integration (Niveau 2)

AngularJS Integration
# AngularJS Integration
Integration af AngularJS med Smarty templates i DanDomain webshops
# AngularJS Integration Guide
## For Udviklere (Dansk)
Dette dokument beskriver, hvordan vi anvender AngularJS sammen med Smarty-templates og DanDomain-controllere. Målet er at give et lavpraktisk overblik, så integrationer kan genbruges i andre webshops uden kendskab til et bestemt projekt.
### Overblik
* AngularJS bruges til interaktive produktlister, filtrering og dynamiske widgets.
* Smarty forbereder data (via controllere/collections) og eksponerer dem i DOM som `data-*` attributter.
* JavaScript-moduler (AngularJS + jQuery eller ren vanilla JS) udveksler status via `$(platform).on(...)` og `document.dispatchEvent(...)` events.
### Bootstrap og struktur
**Aktivér Angular** i roden af layoutet:
```
<body id="ng-app" data-ng-app="platform-app">
```
**Konfigurer et container-element** med data fra Smarty:
```
<div class="angular-productlist">  <div data-ng-controller="productlist-ctrl"       data-ng-init="hasLeftColumns = 1"       data-field="{$field}"       data-viewmode="{$viewmode}"       data-image-width="385">      <div data-ng-repeat="product in productlist track by product.Id"           data-ng-controller="product-ctrl"           data-repeat-done="loaded.productlist">          <!-- Produktmarkup -->      </div>  </div></div>
```
Data Flow
* `data-*` attributterne er udfyldt af Smarty, så Angular har alt, hvad der skal bruges uden ekstra forespørgsler.
* `data-repeat-done="loaded.productlist"` er et specialiseret direktiv, der udsender et event, når Angular har færdiggjort en `ng-repeat`.
### Datakilder
* **JSON endpoints** genereres via Smarty (`modules/json/*.tpl`). De kombinerer controllere som `productList`, `product`, `productReview`, `files` og udstiller resultatet i JSON.
* **Preload inkluder** (f.eks. `products-preload.tpl`) sikrer, at relaterede data caches, før de bruges i loops.
* **Initiale data** leveres via `data-*` attributter, så Angular kan starte uden at lave et ekstra kald. Det er nyttigt til server-side renderede preloader states og SEO.
### Event flow
```
// Dynamisk event navngivning baseret på side typevar eventName = platform.page.isProduct && !platform.page.productId  ? 'fetch.productlist'  : 'loaded.productlist';// Lyt til event og initialiser komponenter$(platform).on(eventName, function () {  initializeVariantPickers();  setupQuantityButtons();  bindProductEvents();});
```
```
// Udsend custom events for cross-module kommunikationdocument.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {  detail: {      total: calculatedTotal,      selections: state,      baseProduct: selectedProduct  }}));// Lyt til events i andre modulerdocument.addEventListener('extraPurchaseSelectionChanged', function(event) {  var detail = event.detail;  updateStickyFooter(detail.total);  updateAnalytics(detail);});
```
Event Arkitektur
Frontend-moduler, footers, popups osv. kan lytte på samme event for at opdatere UI uden at kende til Angulars interne tilstand.
### Integration med jQuery eller vanilla JS
Efter Angular har rendret DOM, sørger events for, at resterende scripts kan køre uden at kende Angulars interne state:
```
$(platform).on('loaded.productlist', function () {  // Find alle variant vælgere  $('[data-variant="variant"]').each(function () {      var $container = $(this);      // Bind klik events til variant værdier      $container.on('click', 'span[data-value]', function () {          var dataIds = collectVariantData($container);          var productId = $container.data('product-id');          // Hent opdaterede variant data          $.getJSON('/json/productvariants/' + productId, { dataIds: dataIds })              .then(function(data) {                  updateProductCard($container, data);              });      });  });});
```
```
// Integration uden jQuerydocument.addEventListener('loaded.productlist', function() {  document.querySelectorAll('[data-variant="variant"]').forEach(function(container) {      container.addEventListener('click', function(event) {          var target = event.target.closest('span[data-value]');          if (!target) return;          var dataIds = collectVariantData(container);          var productId = container.dataset.productId;          fetch('/json/productvariants/' + productId + '?dataIds=' + dataIds.join(','))              .then(function(response) { return response.json(); })              .then(function(data) {                  updateProductCard(container, data);              });      });  });});
```
Integration Filosofi
Brug events som integrationsoverflade – direkte DOM-manipulation inde i Angular-controllers bør undgås for at opretholde separation of concerns.
### Best practices
* Brug events som integrationsoverflade – direkte DOM-manipulation inde i Angular-controllers bør undgås.
* Sørg for, at JSON-endpoints returnerer komplette objekter (pris, billeder, lager, ekstra data), så frontenden er selvforsynende.
* Navngiv custom events efter funktion (fx `extraPurchaseSelectionChanged`, `filtersApplied`, `cartPackageUpdated`) og genbrug dem på tværs af projekter.
* Placér Angular-specifik logik i separate JS-filer, så de er lette at flytte mellem shops.
---
## For Language Models (English)
This document explains how AngularJS is integrated with Smarty templates and DanDomain controllers. The intent is to provide reusable steps that do not rely on project-specific structure.
### Overview
* AngularJS powers interactive product lists, filters, and widgets.
* Smarty prepares data (via controllers/collections) and exposes values through `data-*` attributes so Angular can consume them immediately.
* JavaScript modules exchange state through shared events (`$(platform).on(...)`, `document.dispatchEvent(...)`).
### Bootstrap and structure
1. **Enable AngularJS** on the root layout:
   ```
   <body id="ng-app" data-ng-app="platform-app">
   ```
2. **Provide a controller container** that receives initial data from Smarty:
   ```
   <div class="angular-productlist">
       <div data-ng-controller="productlist-ctrl"
            data-ng-init="hasLeftColumns = 1"
            data-field="{$field}"
            data-viewmode="{$viewmode}"
            data-image-width="385">
           <div data-ng-repeat="product in productlist track by product.Id"
                data-ng-controller="product-ctrl"
                data-repeat-done="loaded.productlist">
               <!-- Product markup -->
           </div>
       </div>
   </div>
   ```
   * The `data-*` attributes are populated by Smarty so the Angular controller knows how to query the backend or render placeholders.
   * `data-repeat-done="loaded.productlist"` is a directive that dispatches an event once the iteration is complete.
### Data sources
* **JSON templates** (`modules/json/*.tpl`) aggregate controller data (`productList`, `product`, `productReview`, `files`, etc.) and return JSON for Angular or Ajax consumers.
* **Preload includes** ensure related data is cached to avoid repeated controller calls.
* **Initial state** is supplied via `data-*` attributes to avoid "flash of empty content" and to let Angular start hydrated.
### Event flow
* **Platform-wide events** keep jQuery/vanilla scripts in sync:
  ```
  var eventName = platform.page.isProduct && !platform.page.productId
      ? 'fetch.productlist'
      : 'loaded.productlist';
  $(platform).on(eventName, function () {
      initialiseVariantPickers();
      setupQuantityButtons();
  });
  ```
* **Custom DOM events** broadcast state changes beyond Angular scopes:
  ```
  document.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {
      detail: {
          total: calculatedTotal,
          selections: state
      }
  }));
  ```
  Any widget (sticky summary, floating CTA, analytics tracker) can subscribe without depending on Angular.
### Integration with jQuery or vanilla JS
* Once Angular renders, scripts attach behaviour through the shared events instead of reaching into Angular scopes.
* Example variant refresh:
  ```
  $(platform).on('loaded.productlist', function () {
      document.querySelectorAll('[data-variant="variant"]').forEach(function (container) {
          container.addEventListener('click', function (event) {
              var valueEl = event.target.closest('span[data-value]');
              if (!valueEl) return;
              var dataIds = collectVariantData(container);
              fetch('/json/productvariants/' + productId + '?dataIds=' + dataIds.join(','))
                  .then(function (res) { return res.json(); })
                  .then(updateProductCard);
          });
      });
  });
  ```
### Best practices
* Treat events as the integration boundary; avoid manipulating Angular scope from outside code.
* Make JSON endpoints self-contained (prices, media, stock, extra data) so the frontend does not require chained requests.
* Use descriptive event names and reuse them across shops to keep scripts interchangeable.
* Store Angular-specific logic in standalone JS modules so they can be ported with minimal changes.
Hjem
Komplet guide til Smarty, AngularJS og TailwindCSS integration i DanDomain webshops
Controller Directory
Oversigt over alle tilgængelige DanDomain controllere og deres anvendelse
### On this page
AngularJS Integration GuideFor Udviklere (Dansk)OverblikBootstrap og strukturDatakilderEvent flowIntegration med jQuery eller vanilla JSBest practicesFor Language Models (English)OverviewBootstrap and structureData sourcesEvent flowIntegration with jQuery or vanilla JSBest practices
```
<body id="ng-app" data-ng-app="platform-app">
```
```
<div class="angular-productlist">
  <div data-ng-controller="productlist-ctrl"
       data-ng-init="hasLeftColumns = 1"
       data-field="{$field}"
       data-viewmode="{$viewmode}"
       data-image-width="385">
      <div data-ng-repeat="product in productlist track by product.Id"
           data-ng-controller="product-ctrl"
           data-repeat-done="loaded.productlist">
          <!-- Produktmarkup -->
      </div>
  </div>
</div>
```
```
// Dynamisk event navngivning baseret på side type
var eventName = platform.page.isProduct && !platform.page.productId
  ? 'fetch.productlist'
  : 'loaded.productlist';
// Lyt til event og initialiser komponenter
$(platform).on(eventName, function () {
  initializeVariantPickers();
  setupQuantityButtons();
  bindProductEvents();
});
```
```
// Udsend custom events for cross-module kommunikation
document.dispatchEvent(new CustomEvent('extraPurchaseSelectionChanged', {
  detail: {
      total: calculatedTotal,
      selections: state,
      baseProduct: selectedProduct
  }
}));
// Lyt til events i andre moduler
document.addEventListener('extraPurchaseSelectionChanged', function(event) {
  var detail = event.detail;
  updateStickyFooter(detail.total);
  updateAnalytics(detail);
});
```
```
$(platform).on('loaded.productlist', function () {
  // Find alle variant vælgere
  $('[data-variant="variant"]').each(function () {
      var $container = $(this);
      // Bind klik events til variant værdier
      $container.on('click', 'span[data-value]', function () {
          var dataIds = collectVariantData($container);
          var productId = $container.data('product-id');
          // Hent opdaterede variant data
          $.getJSON('/json/productvariants/' + productId, { dataIds: dataIds })
              .then(function(data) {
                  updateProductCard($container, data);
              });
      });
  });
});
```
```
// Integration uden jQuery
document.addEventListener('loaded.productlist', function() {
  document.querySelectorAll('[data-variant="variant"]').forEach(function(container) {
      container.addEventListener('click', function(event) {
          var target = event.target.closest('span[data-value]');
          if (!target) return;
          var dataIds = collectVariantData(container);
          var productId = container.dataset.productId;
          fetch('/json/productvariants/' + productId + '?dataIds=' + dataIds.join(','))
              .then(function(response) { return response.json(); })
              .then(function(data) {
                  updateProductCard(container, data);
              });
      });
  });
});
```

---

# Kilde: https://lib-of-smarty.netlify.app/docs/components/footer-usp (Niveau 2)

Footer USP Component
Components Library
# Footer USP Component
En tre-kolonne USP sektion designet til sidefoden med fleksibel konfiguration og generisk navngivning
# 🎯 Footer USP Component
En elegant og responsiv tre-kolonne USP (Unique Selling Proposition) sektion designet til at blive placeret i sidefoden. Komponenten henter indhold fra en backend-side, billeder fra filarkivet, og viser dem på en stilfuld måde.
## 🔎 Quick Preview & Code
Gå direkte til kode ↓
## 📋 Oversigt
| Egenskab | Beskrivelse |
| --- | --- |
| **Type** | Smarty Template |
| **Kolonner** | 3 (responsive på mobile) |
| **Billeder** | 3 påkrævede billeder |
| **Indholdsformat** | Struktureret tekst med regex-parsing |
| **Responsive** | Ja (mobile, tablet, desktop) |
| **Styling** | Tailwind CSS |
## 🎨 Visuel Preview
```
┌─────────────────────────────────────────────────────┐
│  [BILLEDE]  [BILLEDE]  [BILLEDE]                   │
│   Titel 1    Titel 2    Titel 3                    │
│   Tekst 1    Tekst 2    Tekst 3                    │
└─────────────────────────────────────────────────────┘
```
ℹ️ Info
Komponenten er designet til 3 elementer som standard, men kan nemt tilpasses til flere eller færre ved at tilføje flere regex-regler.
## 🚀 Kom i Gang
### Trin 1: Opret Backend-Side
I dit CMS (DanDomain), opret en ny side som skal indeholde dit USP-indhold:
#### Navigér til Pages
Gå til administrationspanelet og find siden-håndtering
#### Opret ny side
Klik "Ny side" og giv den et sigende navn (fx. "Footer USPs")
#### Hent siden-ID
Efter oprettelse, noter dig siden-ID'et (vises i URL eller egenskaber)
#### Upload billeder
Upload præcis 3 billeder til siden (i den rækkefølge de skal vises)
#### Tilføj indholdet
Se "Indholdsformat" sektionen nedenfor for korrekt struktur
### Trin 2: Strukturér dit Indhold
Indholdet skal følge dette præcise format i siden-editoren:
```
footerUsp1_title: Dit første USP-navn
footerUsp1_text: Dit første USP-beskrivelse med så mange ord du har brug for.
footerUsp2_title: Dit andet USP-navn
footerUsp2_text: Dit andet USP-beskrivelse med så mange ord du har brug for.
footerUsp3_title: Dit tredje USP-navn
footerUsp3_text: Dit tredje USP-beskrivelse med så mange ord du har brug for.
```
💡 Pro Tip
Du kan tilføje flere linjeumbrydninger, mellemrum og formatering - regex'et er fleksibelt og vil parse korrekt!
### Trin 3: Implementer Komponenten
## 📝 Konfiguration
Før du indsætter komponenten i din template, skal du opdatere variablen med dit backend-side-ID:
```
{$footerUspPageId = 33}  {* ← Ændre 33 til dit side-ID *}
```
## 💾 Smarty Template Kode
Her er den komplette, generiske komponent klar til at blive kopieret:
Komplet templateKun HTML-renderingKun data-parsing
```
{*
    Footer USP Component (Generisk)
    ================================
    En tre-kolonne USP sektion til sidefoden.
    Konfiguration:
    - Opdater $footerUspPageId til ID'et på din backend-side
    - Upload 3 billeder til siden
    - Strukturér indholdet efter mønsteret nedenfor
    Indholdsformat:
    footerUsp1_title: Titel for første USP
    footerUsp1_text: Tekst for første USP
    footerUsp2_title: Titel for anden USP
    footerUsp2_text: Tekst for anden USP
    footerUsp3_title: Titel for tredje USP
    footerUsp3_text: Tekst for tredje USP
*}
{controller type=page assign=pageController}
{* Konfiguration *}
{$footerUspPageId = 33}
{* Hent billeder og indhold fra backend *}
{collection assign=footerUspImages controller=files type=page id=$footerUspPageId pageSize=3}
{$footerUspContent = $pageController->getText($footerUspPageId)}
{* Vis komponenten kun hvis vi har 3 billeder og indhold *}
{if $footerUspImages->getActualSize() gte 3 && $footerUspContent}
    {$footerUspImagesList = $footerUspImages->getData()}
    {$footerUspImage1 = $footerUspImagesList[0]}
    {$footerUspImage2 = $footerUspImagesList[1]}
    {$footerUspImage3 = $footerUspImagesList[2]}
    {* Parse indholdet - Ekstraher titler *}
    {$footerUsp1_title = $footerUspContent|regex_replace:'/.*footerUsp1_title:\s*/s':''|regex_replace:'/\s*footerUsp1_text:.*/s':''|trim}
    {$footerUsp2_title = $footerUspContent|regex_replace:'/.*footerUsp2_title:\s*/s':''|regex_replace:'/\s*footerUsp2_text:.*/s':''|trim}
    {$footerUsp3_title = $footerUspContent|regex_replace:'/.*footerUsp3_title:\s*/s':''|regex_replace:'/\s*footerUsp3_text:.*/s':''|trim}
    {* Parse indholdet - Ekstraher tekster *}
    {$footerUsp1_text = $footerUspContent|regex_replace:'/.*footerUsp1_text:\s*/s':''|regex_replace:'/\s*footerUsp2_title:.*/s':''|trim}
    {$footerUsp2_text = $footerUspContent|regex_replace:'/.*footerUsp2_text:\s*/s':''|regex_replace:'/\s*footerUsp3_title:.*/s':''|trim}
    {$footerUsp3_text = $footerUspContent|regex_replace:'/.*footerUsp3_text:\s*/s':''|trim}
    {* Render komponenten *}
    <div class="py-12 bg-white sm:py-16 border-b border-slate-200">
        <div class="container px-4 mx-auto sm:px-6 lg:px-8">
            <div class="flex flex-col text-center md:flex-row md:justify-around md:items-start gap-6">
                {* USP 1 *}
                <div class="flex flex-col items-center p-4 md:w-1/3">
                    <div class="mb-4 w-auto h-20 flex items-center justify-center">
                        <img src="{$footerUspImage1->getRelativeFile()}" alt="{$footerUsp1_title|strip}" class="max-h-20 w-auto object-contain">
                    </div>
                    <h3 class="text-lg font-semibold uppercase text-slate-900">{$footerUsp1_title}</h3>
                    <p class="mt-2 text-sm text-slate-600 leading-relaxed">{$footerUsp1_text}</p>
                </div>
                {* USP 2 *}
                <div class="flex flex-col items-center p-4 md:w-1/3">
                    <div class="mb-4 w-auto h-20 flex items-center justify-center">
                        <img src="{$footerUspImage2->getRelativeFile()}" alt="{$footerUsp2_title|strip}" class="max-h-20 w-auto object-contain">
                    </div>
                    <h3 class="text-lg font-semibold uppercase text-slate-900">{$footerUsp2_title}</h3>
                    <p class="mt-2 text-sm text-slate-600 leading-relaxed">{$footerUsp2_text}</p>
                </div>
                {* USP 3 *}
                <div class="flex flex-col items-center p-4 md:w-1/3">
                    <div class="mb-4 w-auto h-20 flex items-center justify-center">
                        <img src="{$footerUspImage3->getRelativeFile()}" alt="{$footerUsp3_title|strip}" class="max-h-20 w-auto object-contain">
                    </div>
                    <h3 class="text-lg font-semibold uppercase text-slate-900">{$footerUsp3_title}</h3>
                    <p class="mt-2 text-sm text-slate-600 leading-relaxed">{$footerUsp3_text}</p>
                </div>
            </div>
        </div>
    </div>
{/if}
```
```
{* Denne del viser kun HTML-strukturen *}
<div class="py-12 bg-white sm:py-16 border-b border-slate-200">
    <div class="container px-4 mx-auto sm:px-6 lg:px-8">
        <div class="flex flex-col text-center md:flex-row md:justify-around md:items-start gap-6">
            {* USP 1 *}
            <div class="flex flex-col items-center p-4 md:w-1/3">
                <div class="mb-4 w-auto h-20 flex items-center justify-center">
                    <img src="{$footerUspImage1->getRelativeFile()}" alt="{$footerUsp1_title|strip}" class="max-h-20 w-auto object-contain">
                </div>
                <h3 class="text-lg font-semibold uppercase text-slate-900">{$footerUsp1_title}</h3>
                <p class="mt-2 text-sm text-slate-600 leading-relaxed">{$footerUsp1_text}</p>
            </div>
            {* USP 2 *}
            <div class="flex flex-col items-center p-4 md:w-1/3">
                <div class="mb-4 w-auto h-20 flex items-center justify-center">
                    <img src="{$footerUspImage2->getRelativeFile()}" alt="{$footerUsp2_title|strip}" class="max-h-20 w-auto object-contain">
                </div>
                <h3 class="text-lg font-semibold uppercase text-slate-900">{$footerUsp2_title}</h3>
                <p class="mt-2 text-sm text-slate-600 leading-relaxed">{$footerUsp2_text}</p>
            </div>
            {* USP 3 *}
            <div class="flex flex-col items-center p-4 md:w-1/3">
                <div class="mb-4 w-auto h-20 flex items-center justify-center">
                    <img src="{$footerUspImage3->getRelativeFile()}" alt="{$footerUsp3_title|strip}" class="max-h-20 w-auto object-contain">
                </div>
                <h3 class="text-lg font-semibold uppercase text-slate-900">{$footerUsp3_title}</h3>
                <p class="mt-2 text-sm text-slate-600 leading-relaxed">{$footerUsp3_text}</p>
            </div>
        </div>
    </div>
</div>
```
```
{* Denne del viser hvordan data bliver parset *}
{controller type=page assign=pageController}
{$footerUspPageId = 33}
{* Hent billeder og indhold *}
{collection assign=footerUspImages controller=files type=page id=$footerUspPageId pageSize=3}
{$footerUspContent = $pageController->getText($footerUspPageId)}
{* Check om vi har tilstrækkeligt data *}
{if $footerUspImages->getActualSize() gte 3 && $footerUspContent}
    {$footerUspImagesList = $footerUspImages->getData()}
    {$footerUspImage1 = $footerUspImagesList[0]}
    {$footerUspImage2 = $footerUspImagesList[1]}
    {$footerUspImage3 = $footerUspImagesList[2]}
    {* Regex parsing - Titler *}
    {$footerUsp1_title = $footerUspContent|regex_replace:'/.*footerUsp1_title:\s*/s':''|regex_replace:'/\s*footerUsp1_text:.*/s':''|trim}
    {$footerUsp2_title = $footerUspContent|regex_replace:'/.*footerUsp2_title:\s*/s':''|regex_replace:'/\s*footerUsp2_text:.*/s':''|trim}
    {$footerUsp3_title = $footerUspContent|regex_replace:'/.*footerUsp3_title:\s*/s':''|regex_replace:'/\s*footerUsp3_text:.*/s':''|trim}
    {* Regex parsing - Tekster *}
    {$footerUsp1_text = $footerUspContent|regex_replace:'/.*footerUsp1_text:\s*/s':''|regex_replace:'/\s*footerUsp2_title:.*/s':''|trim}
    {$footerUsp2_text = $footerUspContent|regex_replace:'/.*footerUsp2_text:\s*/s':''|regex_replace:'/\s*footerUsp3_title:.*/s':''|trim}
    {$footerUsp3_text = $footerUspContent|regex_replace:'/.*footerUsp3_text:\s*/s':''|trim}
{/if}
```
## ⚙️ Tilpasning & Ekstensioner
### Tilføj mere indhold til billeder
Hvis du vil have en titel eller tekst over billedet:
```
{* Før billedet *}
<div class="mb-4">
    <p class="text-xs font-medium text-slate-500 uppercase mb-2">Label</p>
    <img src="{$footerUspImage1->getRelativeFile()}" alt="..." class="...">
</div>
```
### Tilpas styling
Standard styling bruger:
* **Baggrundsfarve**: Hvid (`bg-white`)
* **Grænse**: Smal grå linje (`border-b border-slate-200`)
* **Padding**: 12px (sm) til 16px (lg)
Du kan nemt tilpasse disse Tailwind-klasser:
```
{* Ændre baggrundsfarve *}
<div class="py-12 bg-slate-50 sm:py-16 border-b border-slate-200">
```
### Tilføj mere information
Du kan udvide indholdsformatet med flere felter:
```
footerUsp1_title: Titel
footerUsp1_icon: icon-name
footerUsp1_text: Tekst
footerUsp1_link: /url/her
```
Og derefter parse dem med samme regex-mønster.
## 🔗 Generisk Navngivning Reference
For at gøre komponenten nemt genbrugelig på tværs af projekter, skal alle variabelnavne følge dette mønster:
```
footerUsp[ElementNumber]_[PropertyType]
```
| Variabel | Formål |
| --- | --- |
| `$footerUspPageId` | Backend-side ID |
| `$footerUspImages` | Billedsamlingen |
| `$footerUspContent` | Rå tekstindhold |
| `$footerUspImage1/2/3` | Individuelle billeder |
| `$footerUsp1_title` | Titel tekst |
| `$footerUsp1_text` | Beskrivelse tekst |
💡 Tips til nye komponenter
Når du kopierer denne komponent til et nyt projekt, skal du blot:
1. Omdøbe `footerUsp` til dit nye komponent-navn (fx. `heroSection`)
2. Ændre antallet af elementer efter behov (3 → 4 eller 2)
3. Tilpasse HTML-strukturen til dit design
Al logik forbliver den samme!
## 🧪 Testing & Fejlfinding
### Komponenten vises ikke?
Tjek følgende:
* Er `$footerUspPageId` sat til korrekt side-ID?
* Har siden præcis 3 billeder uploadet?
* Følger side-indholdet det korrekte format?
* Er alle regex-regler korrekte?
### Indhold vises, men styling er forkert?
* Tjek at Tailwind CSS er indlæst i dit projekt
* Kontrollér at billederne er den rigtige størrelse
* Test responsivt design på mobile
### Debug indhold
Tilføj denne debug-linje for at se det parsede indhold:
```
{* Debug - Fjern dette efter test *}
<pre>{$footerUspContent|escape}</pre>
```
## 📦 Filstruktur (projekt-anbefalelse)
```
your-project/
├── modules/
│   └── widgets/
│       └── footer-usp/
│           ├── footer-usp.tpl
│           └── assets/
│               ├── css/
│               │   └── footer-usp.css
│               └── js/
│                   └── footer-usp.js
└── ...
```
---
**Næste trin?** Gå tilbage til Components Library for at udforske flere komponenter! 🚀
Components Library
En samling af genbrugelige Smarty komponenter til DanDomain webshops med eksempler og implementationsvejledning
### On this page
🎯 Footer USP Component🔎 Quick Preview & Code📋 Oversigt🎨 Visuel Preview🚀 Kom i GangTrin 1: Opret Backend-SideTrin 2: Strukturér dit IndholdTrin 3: Implementer Komponenten📝 Konfiguration💾 Smarty Template Kode⚙️ Tilpasning & EkstensionerTilføj mere indhold til billederTilpas stylingTilføj mere information🔗 Generisk Navngivning Reference🧪 Testing & FejlfindingKomponenten vises ikke?Indhold vises, men styling er forkert?Debug indhold📦 Filstruktur (projekt-anbefalelse)

---

# Kilde: https://lib-of-smarty.netlify.app/docs/controller-directory (Niveau 2)

Controller Directory
# Controller Directory
Oversigt over alle tilgængelige DanDomain controllere og deres anvendelse
# Controller Directory Guide
## For Udviklere (Dansk)
Dette dokument giver en oversigt over de centrale Smarty-controllere, der anvendes i dette DanDomain-projekt. For hver controller beskrives dens formål og typiske anvendelse med eksempler.
### Generelle mønstre
Initialiser controllere med `{controller type=... assign=...}` og genbrug instansen:
```
{controller type=page assign=pageController}{collection assign=products controller=productList categoryId=$category->Id}
```
Brug `{collection ...}` til lister og `{entity ...}` til enkeltobjekter:
```
{collection assign=products controller=productList focus=frontpage}{entity assign=product controller=product id=$productId}
```
Brug `primary=true` når controller-data bør caches og træk data ud via metoder:
```
{controller assign=reviewController type=productReview primary=true}{$reviews = $reviewController->getData()}{$total = $reviewController->getActualSize()}
```
Bedste Praksis
Suppler data med ekstra felter ved at kæde `entity`, `collection` og arrays for at undgå unødvendige databasekald.
### Iteration og loops (gælder for alle controllere)
* Kontrollér altid `getActualSize()` før loops for at undgå tomme resultater.
* Brug `{foreach $collection->getData() as $item}` sammen med `foreachelse` for at håndtere tomme states.
* Anvend `smarty.foreach.loopName.index`, `iteration`, `first`, `last` for præcis kontrol over rendering (fx separatorer eller specialklasser).
* Når du arbejder med associative arrays, brug `{foreach from=$array key=key item=item}`; for numeriske arrays kan `{section}` stadig bruges, men `{foreach}` er mere fleksibel.
* For nested data, kan du kombinere `{foreach}` og `{assign}` til at bygge flerdimensionelle strukturer:
  ```
  {$data = []}
  {foreach $categories->getData() as $category}
      {$data[$category->Id] = []}
      {collection assign=extraItems controller=productExtraBuy productId=$product->Id categoryId=$category->Id}
      {foreach $extraItems->getData() as $extra}
          {$data[$category->Id][] = ['id' => $extra->Id, 'title' => $extra->Title]}
      {/foreach}
  {/foreach}
  ```
* Kombinér loops med modifikatorer (fx `|formatPrice`, `|escape`, `|default`) for at formatere output korrekt.
### Smarty Controllere
Disse er de primære controllere fra DanDomain-platformen, der bruges til at hente og vise data.
#### `page`
* **Formål:** Henter data relateret til sider, såsom tekstindhold og sidekategorier.
TekstindholdSide Samlinger
**Hente tekstindhold fra en specifik side:**
```
{controller type=page assign=pageController}{$pageContent = $pageController->getText(16)}{$featureTitle = $pageContent|regex_replace:'/.*overskrift:s*/s':''|regex_replace:'/s*beskrivelse:.*/s':''|trim}
```
*Bruges ofte til at gøre indhold redigerbart via DanDomain-backend*
**Hente en samling af sider fra en kategori:**
```
{collection assign=pageCollection controller=page categoryId=KATEGORI_ID}{foreach $pageCollection->getData() as $item}  <a href="{$item->Handle|formatUrl}">{$item->Title}</a>{/foreach}
```
*Bruges til at bygge dynamiske menuer eller lister*
Visningseksempel:
```
{controller type=page assign=pageController}
{$content = $pageController->getText(16)}
<h1 class="page-title">Om os</h1>
<p class="lead">{$content|strip_tags|truncate:200}</p>
```
#### `files`
* **Formål:** Henter filer (typisk billeder, PDF eller video) tilknyttet andre entiteter som sider, produkter eller brands.
```
{controller type=files assign=fileController}{collection assign=imageCollection controller=$fileController type=product productId=$product.Id}{if $imageCollection->getActualSize() > 0}  {$image = $imageCollection->getData()[0]}  <img src="{$image->thumbnail(800, 600)}" alt="{$image->Alt}">{/if}
```
Anvendelsesområde
Bruges i `modules/product/partials/entity-image.tpl` og lignende templates for at hente og vise billeder tilknyttet entiteter.
#### `product`
* **Formål:** Henter detaljeret information om et enkelt produkt.
* **Typisk Anvendelse:** Produktvisning, e-mails, sticky footers.
  ```
  {controller assign=productController type=product}
  {entity assign=product controller=$productController id=PRODUKT_ID}
  ```
  *Eksempel i `modules/framework/email/content/standard-with-order.tpl` og `modules/product/product-entity.tpl`.*
Visningseksempel:
```
{controller assign=productController type=product}
{entity assign=product controller=$productController id=PRODUKT_ID}
<h1 class="product-title">{$product->Title}</h1>
<p class="product-intro">{$product->Description|strip_tags|truncate:200}</p>
```
#### `productList`
* **Formål:** Henter en liste af produkter baseret på kriterier (kategori, "mest solgte", kampagner osv.).
* **Typisk Anvendelse:** AngularJS produktlister, slidere, JSON-endpoints.
  ```
  {collection assign=products controller=productList focus=frontpage pageSize=15}
  <ul class="product-list">
    {foreach $products->getData() as $item}
      <li>
        <a href="{$item->Handle|formatUrl}">{$item->Title}</a>
      </li>
    {/foreach}
  </ul>
  ```
  *Eksempel i `modules/product/product-list-js-entity.tpl` og `modules/json/products.tpl`.*
#### `productCategory`
* **Formål:** Henter information om produktkategorier.
* **Typisk Anvendelse:** Kategoritekster, breadcrumb, menuopbygning.
  ```
  {controller assign=categoryController type=productCategory}
  {entity assign=category controller=$categoryController id=$page.id}
  <h1>{$category->Title}</h1>
  ```
  *Eksempel i `modules/product/product-list.tpl`.*
#### `brand`
* **Formål:** Henter information om brands/producenter.
* **Typisk Anvendelse:** Liste over brands, brandfiltre, brandlogoer.
  ```
  {controller assign=brandController type=brand}
  {collection assign=brands controller=$brandController}
  ```
  *Eksempel i `modules/product/product-list.tpl` og `modules/json/products.tpl`.*
Visningseksempel:
```
{controller assign=brandController type=brand}
{collection assign=brands controller=$brandController}
<ul class="brand-list">
  {foreach $brands->getData() as $brand}
    <li>{$brand->Title}</li>
  {/foreach}
  {foreachelse}
    <li>Ingen brands fundet.</li>
  {/foreachelse}
</ul>
```
#### `productReview`
* **Formål:** Henter anmeldelser, gennemsnitlige ratings og kommentarer for produkter.
* **Typisk Anvendelse:** Vise stjerner eller review-moduler, JSON-restdata.
  ```
  {controller assign=reviewController type=productReview primary=true}
  {$avg = $reviewController->getAverageRating($product.Id)}
  ```
  *Eksempel i `modules/product/partials/entity-reviews-stars.tpl` og `modules/json/products.tpl`.*
Visningseksempel:
```
{controller assign=reviewController type=productReview primary=true}
{$avg = $reviewController->getAverageRating($product.Id)}
<p class="rating">Bed�f8mmelse: {$avg}/5</p>
```
#### `productPrice`
* **Formål:** Leverer prisintervaller, kundespecifikke priser og kampagnepriser.
* **Typisk Anvendelse:** Prisudregning i produktvisning, ekstra tillæg, JSON data.
  ```
  {collection assign=prices controller=productPrice productId=$product->Id variantId=$variant->Id}
  {$price = $prices->getData()[0]}
  ```
  *Eksempel i `modules/product/product-entity.tpl` og `modules/json/productvariants.tpl`.*
Visningseksempel:
```
{controller assign=variantController type=productVariant}
{collection assign=variants controller=$variantController productId=$product->Id}
<label for="variant">Variant</label>
<select id="variant" name="variant">
  {foreach $variants->getData() as $v}
    <option value="{$v->Id}">{$v->Title}</option>
  {/foreach}
</select>
```
Visningseksempel:
```
{collection assign=prices controller=productPrice productId=$product->Id variantId=$variant->Id}
{if $prices->getActualSize() gt 0}
  {$price = $prices->getData()[0]}
  <p class="price">{$price->Price|formatPrice}</p>
{/if}
```
#### `productVariant`
* **Formål:** Henter variantkombinationer for et produkt.
* **Typisk Anvendelse:** Variantvælger i produktlisten og på produktsiden, JSON-endpoint `/json/productvariants`.
  ```
  {controller assign=variantController type=productVariant}
  {collection assign=variants controller=$variantController productId=$product->Id}
  ```
  *Eksempel i `modules/product/product-entity.tpl` og `modules/json/productvariants.tpl`.*
#### `productVariantType` og `productVariantData`
* **Formål:** Definerer varianttyper (fx farve, størrelse) og deres data.
* **Typisk Anvendelse:** Opbygge variantmatrixer, navngivning af varianter.
  ```
  {collection assign=variantTypes controller=productVariantType productId=$product->Id}
  {collection assign=variantDatas controller=productVariantData productId=$product->Id variantId=$variant->Id typeId=$variantType->Id}
  ```
  *Eksempel i `modules/json/productvariants.tpl` og `modules/product/product-entity.tpl`.*
Visningseksempel:
```
{collection assign=variantTypes controller=productVariantType productId=$product->Id}
<ul class="variant-types">
  {foreach $variantTypes->getData() as $variantType}
    <li>
      <strong>{$variantType->Title}:</strong>
      {collection assign=variantDatas controller=productVariantData productId=$product->Id variantId=$variant->Id typeId=$variantType->Id}
      {foreach $variantDatas->getData() as $data}
        <span>{$data->Title}</span>
      {/foreach}
    </li>
  {/foreach}
</ul>
```
#### `productExtraBuyCategory` og `productExtraBuy`
* **Formål:** Leverer "ekstra køb" grupper og tilhørende produkter (dæk, sensorer, montering, tilbehør osv.).
* **Typisk Anvendelse:** Dynamisk pakkeopsætning på produktet, samt kurv-gruppering.
  ```
  {collection assign=extraBuyCategories controller=productExtraBuyCategory productId=$product->Id}
  {foreach $extraBuyCategories->getData() as $ebc}
      {collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$ebc->Id}
      {if $extraBuys->getActualSize() gt 0}
          {foreach $extraBuys->getData() as $extraBuy}
              <div>{$extraBuy->Title} - {$extraBuy->Price|formatPrice}</div>
          {/foreach}
      {/if}
  {/foreach}
  ```
  *Eksempel i `modules/product/partials/entity-extra-buy.tpl` og `modules/product/product-entity.tpl`.*
#### `productAdditionalType` og `productAdditional`
* **Formål:** Ekstra produktinformation (fx tekniske data, monteringstilbehør).
* **Typisk Anvendelse:** Udfylde info-tabeller på produktet.
  ```
  {collection assign=additionalTypes controller=productAdditionalType productId=$product->Id}
  {collection assign=additionals controller=productAdditional productId=$product->Id typeId=$type->Id}
  ```
  *Eksempel i `modules/product/partials/entity-additionals.tpl` .*
Visningseksempel:
```
{collection assign=additionalTypes controller=productAdditionalType productId=$product->Id}
{foreach $additionalTypes->getData() as $type}
  {collection assign=additionals controller=productAdditional productId=$product->Id typeId=$type->Id}
  {if $additionals->getActualSize() gt 0}
    <h3>{$type->Title}</h3>
    <table class="table">
      {foreach $additionals->getData() as $row}
        <tr><th>{$row->Title}</th><td>{$row->Value}</td></tr>
      {/foreach}
    </table>
  {/if}
{/foreach}
```
#### `productCustomDataType` og `productCustomData`
* **Formål:** Brugerdefinerede felter på produktet (fx label badges, tekniske specs).
* **Typisk Anvendelse:** Vise kundetilpassede tekstfelter, styre ekstra logik (fx Bred/Smal pakke).
  ```
  {collection assign=customTypes controller=productCustomDataType productId=$product->Id}
  {collection assign=customData controller=productCustomData productId=$product->Id typeId=$customType->Id}
  ```
  *Eksempel i `modules/product/product-entity.tpl` og `modules/product/partials/entity-extra-buy.tpl`.*
Visningseksempel:
```
{collection assign=customTypes controller=productCustomDataType productId=$product->Id}
<div class="badges">
  {foreach $customTypes->getData() as $customType}
    {collection assign=customData controller=productCustomData productId=$product->Id typeId=$customType->Id}
    {foreach $customData->getData() as $cd}
      <span class="badge">{$cd->Title}</span>
    {/foreach}
  {/foreach}
</div>
```
#### `productCustomData`
* **Speciale:** Kan bruges til avanceret logik som at markere "Bred/Smal" pakker, styre sensor-tekster, eller vise snippet-baserede labels.
* Kombinér `productCustomData` og `productCustomDataType` til at bygge associative arrays:
  ```
  {$customData = []}
  {foreach $productCustomData->getData() as $item}
      {$customData[$item->TypeId][] = $item->Title}
  {/foreach}
  ```
#### `checkoutPaymentMethod`
* **Formål:** Henter betalingsmetoder til kassen.
* **Typisk Anvendelse:** Vise betalingskort, Klarna, MobilePay m.m. i checkout.
  ```
  {controller type=checkoutPaymentMethod assign=checkoutPaymentMethodController}
  {collection assign=paymentMethods controller=$checkoutPaymentMethodController}
  {foreach $paymentMethods->getData() as $method}
      <option value="{$method->Id}">{$method->Title}</option>
  {/foreach}
  ```
  *Eksempel i `modules/cart/cart.tpl` og `modules/checkout/partials/checkout-step4-payment.tpl`.*
#### `user`, `order`, `wishlist`, `dealer`
* **Formål:** Dække DanDomains øvrige dataområder (brugere, ordrer, favoritlister, forhandlere).
* **Typisk Anvendelse:**
  + `user` controller til at hente brugerdata ved login eller checkout.
  + `order` controller til ordrehistorik.
  + `wishlist` JSON til frontend-lister.
  + `dealer` til oversigt over forhandlere/afhentningssteder.
* Disse controllere følger samme `{collection}`/`{entity}` mønstre og kan kombineres med `files` for billeder eller `page` for beskrivelser.
#### `form` og `formElement`
* **Formål:** Formularer og deres felter (kontaktformularer, tilbud, retur mm.).
* **Typisk Anvendelse:** Hent formular-definition og tilhørende felter for at bygge tilgængelige formularer i temaet.
  ```
  {controller assign=formController type=form}
  {entity assign=form controller=$formController id=FORM_ID}
  {collection assign=formElements controller=formElement formId=$form->Id}
  {foreach $formElements->getData() as $el}
      {* Render felt efter type *}
  {/foreach}
  ```
Visningseksempel:
```
{controller assign=formController type=form}
{entity assign=form controller=$formController id=FORM_ID}
{collection assign=formElements controller=formElement formId=$form->Id}
<form>
  {foreach $formElements->getData() as $el}
    <label>{$el->Title}{if $el->Required} *{/if}</label>
    <input type="text" name="field_{$el->Id}" />
  {/foreach}
  <button type="submit">Send</button>
</form>
```
#### `customData` (generisk) vs. produkt-specifik
* **Formål:** Brugerdefinerede data tilknyttet entiteter (fx sider, produkter, brands). Produkt-udgaven er dækket ovenfor.
* **Typisk Anvendelse:** Vis labels, badges, ekstra metadata eller styr visningslogik.
  ```
  {controller assign=cdCtrl type=customData}
  {collection assign=entityCustomData controller=$cdCtrl type=page entityId=$page->Id}
  ```
Visningseksempel:
```
{controller assign=cdCtrl type=customData}
{collection assign=entityCustomData controller=$cdCtrl type=page entityId=$page->Id}
<div class="labels">
  {foreach $entityCustomData->getData() as $cd}
    <span class="label">{$cd->Title}</span>
  {/foreach}
</div>
```
#### `event`
* **Formål:** Henter events (fx begivenheder/kalender eller systemevents afhængig af setup).
* **Typisk Anvendelse:** Vis kommende events eller historik.
  ```
  {collection assign=events controller=event}
  {if $events->getActualSize() gt 0}
      {foreach $events->getData() as $ev}
          <div>{$ev->Title}</div>
      {/foreach}
  {/if}
  ```
#### `currency`
* **Formål:** Henter tilgængelige valutaer og evt. kurs/format-info.
* **Typisk Anvendelse:** Vise valutavælger eller formatere beløb korrekt.
  ```
  {collection assign=currencies controller=currency active=true}
  {foreach $currencies->getData() as $cur}
      <option value="{$cur->Id}">{$cur->IsoCode}</option>
  {/foreach}
  ```
#### `cart` og `discountLine`/`priceLine`
* **Formål:** Kurvlinjer, rabatlinjer og prislinjer.
* **Typisk Anvendelse:** Byg kurvoversigt og summeringer.
  ```
  {controller assign=cartController type=cart}
  {collection assign=cartLines controller=$cartController}
  {collection assign=discountLines controller=discountLine}
  {collection assign=priceLines controller=priceLine}
  ```
Visningseksempel:
```
{controller assign=cartController type=cart}
{collection assign=cartLines controller=$cartController}
<ul class="cart-lines">
  {foreach $cartLines->getData() as $line}
    <li>{$line->Title} &times; {$line->Quantity}</li>
  {/foreach}
</ul>
```
#### `blog`, `blogCategory`, `blogComment`
* **Formål:** Blogindlæg, kategorier og kommentarer.
* **Typisk Anvendelse:** Blogoversigt, kategorifiltrering, kommentarvisning.
  ```
  {collection assign=posts controller=blog}
  {collection assign=blogCats controller=blogCategory}
  {collection assign=comments controller=blogComment postId=$post->Id}
  ```
Visningseksempel:
```
{collection assign=posts controller=blog}
<section class="blog">
  {foreach $posts->getData() as $post}
    <article>
      <h2><a href="{$post->Handle|formatUrl}">{$post->Title}</a></h2>
      <p>{$post->Text|strip_tags|truncate:160}</p>
    </article>
  {/foreach}
</section>
```
#### `emailText` og `printText`
* **Formål:** Tekstskabeloner til e-mails og print.
* **Typisk Anvendelse:** Hent standardtekster til ordre-e-mails eller udskrifter.
  ```
  {collection assign=emailTexts controller=emailText}
  {collection assign=printTexts controller=printText}
  ```
#### `priceLine` og `priceIndex`
* **Formål:** Prislinjer og prisindeks (avanceret prislogik/kampagner).
* **Typisk Anvendelse:** Udregne eller vise prisnedbrydning og indeksdata.
  ```
  {collection assign=priceLines controller=priceLine productId=$product->Id}
  {collection assign=priceIndex controller=priceIndex}
  ```
#### `site`
* **Formål:** Information om sitet (titel, domæne, standard-sprog/valuta mm.).
* **Typisk Anvendelse:** Global konfiguration i header/footer.
  ```
  {collection assign=siteInfo controller=site}
  {$site = $siteInfo->getData()[0]}
  ```
Visningseksempel:
```
{collection assign=siteInfo controller=site}
{$site = $siteInfo->getData()[0]}
<footer>
  <p>&copy; {$site->Title} — {$site->Domain}</p>
  <p>Standard valuta: {$site->CurrencyIso}</p>
  <p>Standard sprog: {$site->LanguageIso}</p>
</footer>
```
#### `collection` og `entity` i JSON-filer
* JSON-endpoints for AngularJS/Ajax kombinerer flere controllere for at returnere komplette objekter. Eksempel fra `modules/json/products.tpl`:
  ```
  {controller assign=productListController type=productList}
  {collection assign=productlist controller=$productListController options=$options}
  {collection assign=products controller=$controller productId=$productlist->pluck('Id')}
  {include file='modules/json/products-preload.tpl' scope=parent}
  ```
  Denne struktur sikrer, at AngularJS og widgets kan hente hele produktkort med ét kald.
* I JSON-filer kan du også bruge `{foreach}` loops for at bygge arrays: `{foreach $products->getData() as $product}{assign var=output[] value=$product}{/foreach}`.
### Avancerede tips
* Kombinér flere controllere i ét template for at skabe rige dataobjekter (fx produkt + brand + filer + pris).
* Brug `{assign var=arrayVar value=$arrayVar|@array_merge:$newData}` til at samle data i associative arrays.
* Når controllere eksponerer metadata (fx `AvailabilityText`, `DeliveryTimeText`), gem dem i `data-*` attributter, så JavaScript kan reagere uden ekstra kald.
* Dokumentér eventuelle custom controllers eller aliaser (fx `checkoutPaymentMethod`), så teamet ved, hvilke metoder der findes.
* Brug arrays til at cache beregninger: `{$cache = ProductController::calculateSomething(...)}` og genbrug output.
* Sammensæt filter- og søgedata i JSON ved at kombinere `collection`-resultater med `{strip_tags}` eller `|json_encode` efter behov.
## API Reference
### Controller Metoder
Nedenfor finder du de vigtigste metoder med korte beskrivelser og praktiske eksempler.
#### Eksempler (grundlæggende brug)
##### controller->getData()
Returnerer controllerens datasæt som et PHP-array. Brug det til iteration; kombiner med `getActualSize()` for at håndtere tomme resultater uden unødige loops. Returnerer `[]` når der ikke er data.
```
{controller assign=reviewController type=productReview primary=true}
{$reviews = $reviewController->getData()}
{if is_array($reviews) && $reviews|@count gt 0}
    {$first = $reviews[0]}
{/if}
```
##### controller->getActualSize()
Returnerer et heltal med antal elementer i datasættet. Brug det til at gate loops og tom-states; typisk hurtigere og tydeligere end at kalde `|@count` på `getData()`.
```
{collection assign=products controller=productList focus=frontpage}
{if $products->getActualSize() gt 0}
    Antal: {$products->getActualSize()}
{else}
    Ingen produkter fundet.
{/if}
```
##### collection->pluck(field)
Udtrækker et array af værdier for et givet felt fra alle elementer i collection. Velegnet til batch-opslag (fx produkt-id'er til sekundære kald). Manglende felter ignoreres implicit.
```
{collection assign=products controller=productList focus=frontpage}
{$ids = $products->pluck('Id')}
```
##### collection->getData()
Returnerer collectionens data som array. Bruges sammen med `{foreach ...}` til at rendere lister eller til at bygge afledte datastrukturer.
```
{collection assign=brands controller=brand}
{foreach $brands->getData() as $brand}
    <li>{$brand->Title}</li>
{/foreach}
```
##### collection->getActualSize()
Returnerer et heltal med element-antal i collection. Bruges før iteration for at undgå at rendere tom markup eller placeholders.
```
{collection assign=images controller=$fileController type=product productId=$product.Id}
{if $images->getActualSize() gt 0}
    {$img = $images->getData()[0]}
{/if}
```
##### entity->Id, entity->Title, entity->Handle
Standard egenskaber på en entitet. `Handle` kombineres typisk med `|formatUrl` til links; `Title` bør escapes når det indgår i HTML.
```
{controller assign=categoryController type=productCategory}
{entity assign=category controller=$categoryController id=$page.id}
<a href="{$category->Handle|formatUrl}">{$category->Title}</a>
```
##### pageController->getText(pageId)
Returnerer CMS-tekst for en given side. Indholdet kan indeholde HTML; brug `|strip_tags` for ren tekst eller `|unescape:"htmlall"` bevidst når HTML ønskes.
```
{controller type=page assign=pageController}
{$content = $pageController->getText(16)|strip_tags}
```
##### file->thumbnail(width, height) og file->Alt
`thumbnail(w,h)` genererer en URL til en skaleret version af billedet. `Alt` indeholder alternativ tekst; brug den konsekvent for tilgængelighed og SEO.
```
{controller type=files assign=fileController}
{collection assign=imageCollection controller=$fileController type=product productId=$product.Id}
{if $imageCollection->getActualSize() gt 0}
    {$image = $imageCollection->getData()[0]}
    <img src="{$image->thumbnail(800, 600)}" alt="{$image->Alt}">
{/if}
```
##### reviewController->getAverageRating(productId)
Returnerer gennemsnitlig rating (typisk 0–5) for et produkt. Returnerer `0` når der ikke findes anmeldelser.
```
{controller assign=reviewController type=productReview primary=true}
{$avg = $reviewController->getAverageRating($product.Id)}
```
### Performance Tips
Brug `primary=true` for at cache controller data:
```
{controller type=productReview primary=true assign=reviews}
```
Kombinér flere controllere for at reducere databasekald:
```
{controller type=product assign=productCtrl}{collection assign=products controller=$productCtrl focus=featured}{collection assign=brands controller=brand}
```
---
## For Language Models (English)
This document provides an overview of the central Smarty controllers used in this DanDomain project. For each controller, its purpose and typical usage are described with examples.
### General patterns
* Initialise controllers with `{controller type=... assign=...}` and reuse them within the template.
* Use `{collection ...}` for lists and `{entity ...}` for single records.
* Combine controllers in JSON templates to return full objects for AngularJS/Ajax.
* Set `primary=true` for cached data (e.g., reviews).
* Enrich objects with metadata (images, custom fields) by chaining `entity`, `collection`, and array assignments.
### Controller Methods
Below are the key methods with short descriptions and practical examples.
#### Examples (basic usage)
##### controller->getData()
Returns the controller dataset as a PHP array. Use for iteration; combine with `getActualSize()` to handle empty states efficiently. Returns `[]` when no data is available.
```
{controller assign=reviewController type=productReview primary=true}
{$reviews = $reviewController->getData()}
{if is_array($reviews) && $reviews|@count gt 0}
    {$first = $reviews[0]}
{/if}
```
##### controller->getActualSize()
Returns an integer with the number of items in the dataset. Gate loops and empty states with it; typically clearer than calling `|@count` on `getData()`.
```
{collection assign=products controller=productList focus=frontpage}
{if $products->getActualSize() gt 0}
    Count: {$products->getActualSize()}
{else}
    No products found.
{/if}
```
##### collection->pluck(field)
Extracts an array of field values from all items in the collection. Great for batch lookups (e.g., product IDs for subsequent calls). Missing fields are ignored.
```
{collection assign=products controller=productList focus=frontpage}
{$ids = $products->pluck('Id')}
```
##### collection->getData()
Returns the collection data as an array. Use with `{foreach ...}` for rendering lists or building derived data structures.
```
{collection assign=brands controller=brand}
{foreach $brands->getData() as $brand}
    <li>{$brand->Title}</li>
{/foreach}
```
##### collection->getActualSize()
Returns an integer with the number of items in the collection. Use before iteration to avoid rendering empty markup.
```
{collection assign=images controller=$fileController type=product productId=$product.Id}
{if $images->getActualSize() gt 0}
    {$img = $images->getData()[0]}
{/if}
```
##### entity->Id, entity->Title, entity->Handle
Common properties on entities. `Handle` is typically combined with `|formatUrl` for links; escape `Title` when inserting into HTML.
```
{controller assign=categoryController type=productCategory}
{entity assign=category controller=$categoryController id=$page.id}
<a href="{$category->Handle|formatUrl}">{$category->Title}</a>
```
##### pageController->getText(pageId)
Returns CMS text for a given page. Content may include HTML; use `|strip_tags` for plain text or `|unescape:"htmlall"` carefully when HTML is desired.
```
{controller type=page assign=pageController}
{$content = $pageController->getText(16)|strip_tags}
```
##### file->thumbnail(width, height) and file->Alt
`thumbnail(w,h)` generates a URL to a scaled image. `Alt` contains alternative text; always include for accessibility and SEO.
```
{controller type=files assign=fileController}
{collection assign=imageCollection controller=$fileController type=product productId=$product.Id}
{if $imageCollection->getActualSize() gt 0}
    {$image = $imageCollection->getData()[0]}
    <img src="{$image->thumbnail(800, 600)}" alt="{$image->Alt}">
{/if}
```
##### reviewController->getAverageRating(productId)
Returns the average rating (typically 0–5) for a product. Returns `0` if no reviews exist.
```
{controller assign=reviewController type=productReview primary=true}
{$avg = $reviewController->getAverageRating($product.Id)}
```
### Smarty Controllers
These are the primary controllers from the DanDomain platform used to fetch and display data.
#### `page`
* **Purpose:** Fetches data related to pages, such as text content and page categories.
* **Typical Usage:**
  1. **Fetch text content from a specific page:** Often used to make content editable for the webshop owner via the DanDomain backend.
     ```
     {controller type=page assign=pageController}
     {$pageContent = $pageController->getText(PAGE_ID)}
     ```
     *Example in `modules/widgets/about-us-feature/about-us-feature.tpl`.*
  2. **Fetch a collection of pages from a category:** Used to build dynamic menus or lists.
     ```
     {collection assign=pageCollection controller=page categoryId=CATEGORY_ID}
     {foreach $pageCollection->getData() as $item}
         <a href="{$item->Handle|formatUrl}">{$item->Title}</a>
     {/foreach}
     ```
     *Example in `partials/bottom.tpl`.*
#### `files`
* **Purpose:** Retrieves files (images, PDFs, videos) associated with entities such as pages, products, or brands.
* **Typical Usage:** Load a thumbnail or download link.
  ```
  {controller type=files assign=fileController}
  {collection assign=imageCollection controller=$fileController type=product productId=$product.Id}
  {if $imageCollection->getActualSize() > 0}
      {$image = $imageCollection->getData()[0]}
      <img src="{$image->thumbnail(800, 600)}" alt="{$image->Alt}">
  {/if}
  ```
  *Used in `modules/product/partials/entity-image.tpl`.*
#### `product`
* **Purpose:** Fetches detailed information about a single product.
* **Typical Usage:** Product detail pages, transactional emails, sticky footer updates.
  ```
  {controller assign=productController type=product}
  {entity assign=product controller=$productController id=PRODUCT_ID}
  ```
  *Example in `modules/framework/email/content/standard-with-order.tpl` and `modules/product/product-entity.tpl`.*
#### `productList`
* **Purpose:** Retrieves lists of products based on filters (category, "most sold", campaigns, etc.).
* **Typical Usage:** AngularJS product list, sliders, JSON endpoints.
  ```
  {collection assign=products controller=productList focus=frontpage pageSize=15}
  {foreach $products->getData() as $product}
      {* Render product *}
  {/foreach}
  ```
  *Used in `modules/product/product-list-js-entity.tpl` and `modules/json/products.tpl`.*
#### `productCategory`
* **Purpose:** Fetches product category information.
* **Typical Usage:** Category descriptions, breadcrumbs, menu hierarchies.
  ```
  {controller assign=categoryController type=productCategory}
  {entity assign=category controller=$categoryController id=$page.id}
  <h1>{$category->Title}
  ```
  *Example in `modules/product/product-list.tpl`.*
#### `brand`
* **Purpose:** Fetches information about brands/manufacturers.
* **Typical Usage:** Brand filters, brand carousels, brand metadata.
  ```
  {controller assign=brandController type=brand}
  {collection assign=brands controller=$brandController}
  ```
  *Example in `modules/product/product-list.tpl` and `modules/json/products.tpl`.*
#### `productReview`
* **Purpose:** Provides review averages, star ratings, and review lists.
* **Typical Usage:** Display star ratings or embed reviews in JSON responses.
  ```
  {controller assign=reviewController type=productReview primary=true}
  {$avg = $reviewController->getAverageRating($product.Id)}
  ```
  *Example in `modules/product/partials/entity-reviews-stars.tpl` and `modules/json/products.tpl`.*
#### `productPrice`
* **Purpose:** Supplies price tiers, discount information, and currency-ready prices.
* **Typical Usage:** Pricing blocks in templates, JSON payloads, and "extra buy" calculations.
  ```
  {collection assign=prices controller=productPrice productId=$product->Id variantId=$variant->Id}
  {$price = $prices->getData()[0]}
  ```
  *Example in `modules/product/product-entity.tpl` and `modules/json/productvariants.tpl`.*
#### `productVariant`
* **Purpose:** Retrieves variant combinations for a product.
* **Typical Usage:** Variant pickers on product cards, `/json/productvariants` endpoint.
  ```
  {controller assign=variantController type=productVariant}
  {collection assign=variants controller=$variantController productId=$product->Id}
  ```
  *Example in `modules/product/product-entity.tpl` og `modules/json/productvariants.tpl`.*
#### `productVariantType` and `productVariantData`
* **Purpose:** Define variant dimensions (color, size) and their values.
* **Typical Usage:** Compose variant matrices, build display titles, load variant icons.
  ```
  {collection assign=variantTypes controller=productVariantType productId=$product->Id}
  {collection assign=variantDatas controller=productVariantData productId=$product->Id variantId=$variant->Id typeId=$variantType->Id}
  ```
  *Example in `modules/json/productvariants.tpl`.*
#### `productExtraBuyCategory` and `productExtraBuy`
* **Purpose:** Deliver "extra purchase" groups (tyres, sensors, mounting, accessories) and their items.
* **Typical Usage:** Build bundle selectors on the product page and synchronize cart groupings.
  ```
  {collection assign=extraBuyCategories controller=productExtraBuyCategory productId=$product->Id}
  {collection assign=extraBuys controller=productExtraBuy productId=$product->Id categoryId=$ebc->Id}
  ```
  *Example in `modules/product/partials/entity-extra-buy.tpl` og `modules/product/product-entity.tpl`.*
#### `productAdditionalType` and `productAdditional`
* **Purpose:** Provide supplementary product information (technical specs, included accessories).
* **Typical Usage:** Compose info tabs on the product page.
  ```
  {collection assign=additionalTypes controller=productAdditionalType productId=$product->Id}
  {collection assign=additionals controller=productAdditional productId=$product->Id typeId=$type->Id}
  ```
  *Example in `modules/product/partials/entity-additionals.tpl`.*
#### `productCustomDataType` and `productCustomData`
* **Purpose:** Supply custom fields (labels, flags, detailed text) configured per product.
* **Typical Usage:** Drive additional UI logic such as "Bred/Smal" pack toggles.
  ```
  {collection assign=customTypes controller=productCustomDataType productId=$product->Id}
  {collection assign=customData controller=productCustomData productId=$product->Id typeId=$customType->Id}
  ```
  *Example in `modules/product/product-entity.tpl` og `modules/product/partials/entity-extra-buy.tpl`.*
#### `checkoutPaymentMethod`
* **Purpose:** Fetch payment methods for checkout.
* **Typical Usage:** Render payment options, integrate with OnPay/Klarna within checkout.
  ```
  {controller type=checkoutPaymentMethod assign=checkoutPaymentMethodController}
  {collection assign=paymentMethods controller=$checkoutPaymentMethodController}
  ```
  *Example in `modules/cart/cart.tpl` og `modules/checkout/partials/checkout-step4-payment.tpl`.*
#### `user`, `order`, `wishlist`, `dealer`
* **Purpose:** Provide access to user profiles, order history, wishlists, and dealer data.
* **Typical Usage:**
  + `user`: Retrieve logged-in user info for account sections.
  + `order`: List past orders in account pages or transactional emails.
  + `wishlist`: Serve wishlist JSON endpoints for frontend rendering.
  + `dealer`: Show pickup locations or dealer listings.
* Follow the same patterns as above (collections/entities, enrichment with files/custom data).
#### `form` and `formElement`
* **Purpose:** Forms and their fields (contact, quote request, returns, etc.).
* **Typical Usage:** Load form definition and elements to render accessible forms.
  ```
  {controller assign=formController type=form}
  {entity assign=form controller=$formController id=FORM_ID}
  {collection assign=formElements controller=formElement formId=$form->Id}
  {foreach $formElements->getData() as $el}
      {* Render by field type *}
  {/foreach}
  ```
#### `customData` (generic) vs product-specific
* **Purpose:** Custom fields attached to entities (pages, products, brands). Product-specific usage is covered above.
* **Typical Usage:** Display labels/badges or drive UI logic.
  ```
  {controller assign=cdCtrl type=customData}
  {collection assign=entityCustomData controller=$cdCtrl type=page entityId=$page->Id}
  ```
#### `event`
* **Purpose:** Events (calendar or system, depending on setup).
* **Typical Usage:** Show upcoming events or history.
  ```
  {collection assign=events controller=event}
  {if $events->getActualSize() gt 0}
      {foreach $events->getData() as $ev}
          <div>{$ev->Title}</div>
      {/foreach}
  {/if}
  ```
#### `currency`
* **Purpose:** Available currencies and formatting/rates.
* **Typical Usage:** Currency selector or price formatting.
  ```
  {collection assign=currencies controller=currency active=true}
  {foreach $currencies->getData() as $cur}
      <option value="{$cur->Id}">{$cur->IsoCode}</option>
  {/foreach}
  ```
#### `cart` with `discountLine`/`priceLine`
* **Purpose:** Cart lines, discount lines and price lines.
* **Typical Usage:** Build cart overview and totals.
  ```
  {controller assign=cartController type=cart}
  {collection assign=cartLines controller=$cartController}
  {collection assign=discountLines controller=discountLine}
  {collection assign=priceLines controller=priceLine}
  ```
#### `blog`, `blogCategory`, `blogComment`
* **Purpose:** Blog posts, categories and comments.
* **Typical Usage:** Blog listing, category filtering, comments.
  ```
  {collection assign=posts controller=blog}
  {collection assign=blogCats controller=blogCategory}
  {collection assign=comments controller=blogComment postId=$post->Id}
  ```
#### `emailText` and `printText`
* **Purpose:** Text templates for emails and print.
* **Typical Usage:** Load default texts for order emails or printouts.
  ```
  {collection assign=emailTexts controller=emailText}
  {collection assign=printTexts controller=printText}
  ```
#### `priceLine` and `priceIndex`
* **Purpose:** Price lines and price index (advanced pricing/campaign logic).
* **Typical Usage:** Display or compute price breakdowns and index data.
  ```
  {collection assign=priceLines controller=priceLine productId=$product->Id}
  {collection assign=priceIndex controller=priceIndex}
  ```
#### `site`
* **Purpose:** Site-level information (title, domain, default language/currency, etc.).
* **Typical Usage:** Global configuration in header/footer.
  ```
  {collection assign=siteInfo controller=site}
  {$site = $siteInfo->getData()[0]}
  ```
#### `collection` and `entity` in JSON templates
* JSON endpoints combine multiple controllers to expose rich objects. Example from `modules/json/products.tpl`:
  ```
  {controller assign=productListController type=productList}
  {collection assign=productlist controller=$productListController options=$options}
  {collection assign=products controller=$controller productId=$productlist->pluck('Id')}
  {include file='modules/json/products-preload.tpl' scope=parent}
  ```
  This approach lets AngularJS or Ajax consumers load product cards (with prices, reviews, brand logos, extra buys) in a single request.
### Advanced tips
* Compose richer objects by combining controllers (product + brand + files + custom data + prices).
* Use arrays to store computed values and merge them with controller outputs (`{$data = array_merge($data, $extra)}` via Smarty modifiers).
* Store important pieces in `data-*` attributes for JavaScript consumers (stock, tiered pricing, additional labels).
* Document any custom controller extensions or aliases to ease onboarding.
AngularJS Integration
Integration af AngularJS med Smarty templates i DanDomain webshops
Ekstra Tilkøb
Kompleks produktbundling med ekstra tilkøb i DanDomain webshops
### On this page
Controller Directory GuideFor Udviklere (Dansk)Generelle mønstreIteration og loops (gælder for alle controllere)Smarty Controllere`page``files``product``productList``productCategory``brand``productReview``productPrice``productVariant``productVariantType` og `productVariantData``productExtraBuyCategory` og `productExtraBuy``productAdditionalType` og `productAdditional``productCustomDataType` og `productCustomData``productCustomData``checkoutPaymentMethod``user`, `order`, `wishlist`, `dealer``form` og `formElement``customData` (generisk) vs. produkt-specifik`event``currency``cart` og `discountLine`/`priceLine``blog`, `blogCategory`, `blogComment``emailText` og `printText``priceLine` og `priceIndex``site``collection` og `entity` i JSON-filerAvancerede tipsAPI ReferenceController MetoderEksempler (grundlæggende brug)controller->getData()controller->getActualSize()collection->pluck(field)collection->getData()collection->getActualSize()entity->Id, entity->Title, entity->HandlepageController->getText(pageId)file->thumbnail(width, height) og file->AltreviewController->getAverageRating(productId)Performance TipsFor Language Models (English)General patternsController MethodsExamples (basic usage)controller->getData()controller->getActualSize()collection->pluck(field)collection->getData()collection->getActualSize()entity->Id, entity->Title, entity->HandlepageController->getText(pageId)file->thumbnail(width, height) and file->AltreviewController->getAverageRating(productId)Smarty Controllers`page``files``product``productList``productCategory``brand``productReview``productPrice``productVariant``productVariantType` and `productVariantData``productExtraBuyCategory` and `productExtraBuy``productAdditionalType` and `productAdditional``productCustomDataType` and `productCustomData``checkoutPaymentMethod``user`, `order`, `wishlist`, `dealer``form` and `formElement``customData` (generic) vs product-specific`event``currency``cart` with `discountLine`/`priceLine``blog`, `blogCategory`, `blogComment``emailText` and `printText``priceLine` and `priceIndex``site``collection` and `entity` in JSON templatesAdvanced tips
```
{controller type=page assign=pageController}
{collection assign=products controller=productList categoryId=$category->Id}
```
```
{collection assign=products controller=productList focus=frontpage}
{entity assign=product controller=product id=$productId}
```
```
{controller assign=reviewController type=productReview primary=true}
{$reviews = $reviewController->getData()}
{$total = $reviewController->getActualSize()}
```
```
{controller type=page assign=pageController}
{$pageContent = $pageController->getText(16)}
{$featureTitle = $pageContent|regex_replace:'/.*overskrift:s*/s':''|regex_replace:'/s*beskrivelse:.*/s':''|trim}
```
```
{collection assign=pageCollection controller=page categoryId=KATEGORI_ID}
{foreach $pageCollection->getData() as $item}
  <a href="{$item->Handle|formatUrl}">{$item->Title}</a>
{/foreach}
```
```
{controller type=files assign=fileController}
{collection assign=imageCollection controller=$fileController type=product productId=$product.Id}
{if $imageCollection->getActualSize() > 0}
  {$image = $imageCollection->getData()[0]}
  <img src="{$image->thumbnail(800, 600)}" alt="{$image->Alt}">
{/if}
```
```
{controller type=productReview primary=true assign=reviews}
```
```
{controller type=product assign=productCtrl}
{collection assign=products controller=$productCtrl focus=featured}
{collection assign=brands controller=brand}
```

---

