var replaceFrom = 'w71.h71';
var replaceTo = 'w293.h293.fill';

let basketReady = false;
let productReady = false;

var _learnq = _learnq || [];

let domain = location.protocol + '//' + location.hostname + (location.port ? ':' + location.port : '');
if (window.platform && window.platform.consent.STATISTICS) {

    window.platform.subscribe("/cart/ready", function () {
        basketReady = true;
        console.log('basketready');
        klaviyoTrack('basket');
    });
    window.platform.subscribe("/product/ready", function () {
        productReady = true;
        console.log('product');
        klaviyoTrack('product');
    });

  //category tracking
    if (window.platform.page.isProduct && window.platform.product === null) {
        _learnq.push(["track", "Viewed Category",{
            "CategoryName": $('h1').first().text(),
            "CategoryID": window.platform.page.categoryId,
            "URL": window.platform.page.url 
        }]);
    }
}

function klaviyoTrack(str) {
    var sessionInfo = window.platform;

    if (sessionInfo.page.isProduct && basketReady && productReady) { 
        
        $('[data-product="buyButton"]').on('click', function () {
            //$.cookie('AddedToBasketMessageTriggered', true);
        });

        let name = sessionInfo.product.Title;
        let ProductNumber = sessionInfo.product.Id;
        let brand = sessionInfo.product.ProducerTitle;
        let price = sessionInfo.product.Prices[0].PriceMin;
        let url = window.location.href;
        let categories = [sessionInfo.product.CategoryTitle];
        let image = domain + sessionInfo.product.Images[0];

        
        $('[data-w-checkout="modal-open"]').on('click', function () {

            if (str == 'product') {
                setTimeout(function() {

                    //added to cart
                    var total = sessionInfo.cart.CartSubTotalPrice;
                    var products = GetBasketProducts(sessionInfo);
                
                    _learnq.push(["track", "Added to Cart", {
                        "$value": total,
                        "AddedItemProductName": name,
                        "AddedItemProductID": ProductNumber,
                        "AddedItemCategories": categories,
                        "AddedItemImageURL": image,
                        "AddedItemURL": url,
                        "AddedItemPrice": price,
                        "AddedItemQuantity": 1,
                        "CheckoutURL": CreateCheckoutUrl(products),
                        "Items": products
                    }]);
                
                
                    //identify
                    if (sessionInfo.user !== null) {
                        _learnq.push(['identify', { '$email': email }]);
                    }
                    
                    //started checkout
                    StartedCheckout(sessionInfo);

                },5000);
            }

        });
        
        if ($.cookie('AddedToBasketMessageTriggered') === "true") {
            $.removeCookie('AddedToBasketMessageTriggered');
            var total = sessionInfo.cart.CartSubTotalPrice;
            var products = GetBasketProducts(sessionInfo);

            _learnq.push(["track", "Added to Cart", {
                "$value": total,
                "AddedItemProductName": name,
                "AddedItemProductID": ProductNumber,
                "AddedItemCategories": categories,
                "AddedItemImageURL": image,
                "AddedItemURL": url,
                "AddedItemPrice": price,
                "AddedItemQuantity": 1,
                "CheckoutURL": CreateCheckoutUrl(products),
                "Items": products
            }]);
        }
        else {

            let item = {
                "ProductName": name,
                "ProductID": ProductNumber,
                "Categories": categories,
                "ImageURL": image,
                "URL": url,
                "Brand": brand,
                "Price": price,
            };

            _learnq.push(["track", "Viewed Product", item]);

            _learnq.push(["trackViewedItem", {
                "Title": item.ProductName,
                "ItemId": item.ProductID,
                "Categories": item.Categories,
                "ImageUrl": item.ImageURL,
                "Url": item.URL,
                "Metadata": {
                    "Brand": item.Brand,
                    "Price": item.Price,
                }
            }]);
        }
        
        //mobile pay checkout
        //$('[data-w-checkout="modal-open"]').one('click', function () {
        $('.m-product-title').on('click', function () {
            /*
            setTimeout(function() {
              
                //added to cart
                total = sessionInfo.cart.CartSubTotalPrice;
                products = GetBasketProducts(sessionInfo);
            
                _learnq.push(["track", "Added to Cart", {
                    "$value": total,
                    "AddedItemProductName": name,
                    "AddedItemProductID": ProductNumber,
                    "AddedItemCategories": categories,
                    "AddedItemImageURL": image,
                    "AddedItemURL": url,
                    "AddedItemPrice": price,
                    "AddedItemQuantity": 1,
                    "CheckoutURL": CreateCheckoutUrl(products),
                    "Items": products
                }]);
            
            
                //started checkout
                //identify
                if (sessionInfo.user !== null) {
                    _learnq.push(['identify', { '$email': email }]);
                }
                StartedCheckout(sessionInfo);
        
                console.log('done');
            },5000);
            */
        });
    }
     else if (sessionInfo.page.isCheckout && !sessionInfo.page.isCheckoutComplete) { 
        if (sessionInfo.user === null) {
            let $input = $('#email');
            $input.on('blur', function () {
                let email = $('#email').val();
                if (email.indexOf('@') > -1) { 
                    _learnq.push(['identify', { '$email': email }]);
                     setTimeout(function() {
                        StartedCheckout(sessionInfo);
                    },2000);
                }
            });
            StartedCheckout(sessionInfo);
        }
        else {
            let email = sessionInfo.user.Username;
            if (sessionInfo.user.Email !== "") email = sessionInfo.user.Email
            _learnq.push(['identify', { '$email': email }]);
            StartedCheckout(sessionInfo);
        }
    }
}

function CreateCheckoutUrl(products) {
	let basketProducts = [];
    for (let i = 0; i < products.length; i++) {
		basketProducts.push({
            "product": products[i].ProductID,
            "amount": products[i].Quantity
        });
    }
    return domain + '/actions/cart/addmulti/?input='+JSON.stringify(basketProducts);
}

function StartedCheckout(sessionInfo) {
    let products = GetBasketProducts(sessionInfo);
    let total = sessionInfo.cart.CartSubTotalPrice;
    let names = [];
    for (let i = 0; i < products.length; i++) {
        names.push(products[i].ProductName);
    }
    let date = new Date();
    let timeStamp = date.getTime();

    _learnq.push(["track", "Started Checkout", {
        "$event_id": uuidv4() + '_' + timeStamp,
        "$value": total,
        "ItemNames": names,
        "CheckoutURL": CreateCheckoutUrl(products),
        "Items": products
    }]);
}

function uuidv4() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        let r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

function GetBasketProducts(sessionInfo) {
    let basket = sessionInfo.cart.CartProduct;

    let products = [];

    for (let i = 0; i < basket.length; i++) {
        products.push({
            "ProductID": basket[i].ProductId,
            "ProductName": basket[i].Title,
            "Quantity": basket[i].Amount,
            "ItemPrice": basket[i].Price,
            "RowTotal": basket[i].FullPriceWithVat,
            "ProductURL": domain + basket[i].Url,
            "ImageURL": basket[i].CartImage.replace(replaceFrom,replaceTo),
            "VariantID": basket[i].VariantId
        });
    }
    return products;
}