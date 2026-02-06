(function($) {

  function realignMegamenuHandler(event) {
      var megamenu = event.data.megamenu
      megamenu.css("left", "");
      var menuOffset = megamenu.offset();
      if (menuOffset.left < 0) {
          megamenu.css("left", "calc(50% + " + Math.abs(menuOffset.left) + "px)");
      }
      var menuOffsetRight = window.innerWidth - (menuOffset.left + megamenu.innerWidth());
      if (menuOffsetRight < 0) {
          megamenu.css("left", "calc(50% - " + Math.abs(menuOffsetRight) + "px)");
      }
  }

  var menuItems = $(".productmenu > li");
  for (var i = 0; i < menuItems.length; i++) {
      var menuItem = $(menuItems[i]);
      var secondLevelCategoryCount = menuItem.find("> ul > li").length;
      var thirdLevelMenuCount = menuItem.find("> ul > li > ul").length;
      if (thirdLevelMenuCount > 0) {
          var megamenu = menuItem.find("> ul");
          megamenu.addClass("megamenu");
          menuItem.addClass("has-megamenu");

          if (secondLevelCategoryCount >= 9) {
              megamenu.addClass("megamenu--extralarge");
          }
          else if (secondLevelCategoryCount >= 7) {
              megamenu.addClass("megamenu--large");
          }

          menuItem.on('pointerenter', { megamenu: megamenu }, realignMegamenuHandler);
      }
  }

  var sidebar = $("#site-sidebar");
  sidebar.find("li.has-dropdown > a > .item-arrow").on("click", function(e) {
    e.preventDefault();
    var li = $(this).parent().parent();
    li.find("> ul").slideToggle();
  });

  if(platform.page.isProduct && platform.page.productId == null) {
    var productGroups = $('.m-productlist-categories').children();
    if(productGroups.first().height() < 2) {
      $(window).trigger('resize');
    }
  }

  var delay = 0;
  var offset = 100;

  document.addEventListener('invalid', function(e){
    if($(e.target).attr('id') != "acceptTerms") {
      $(e.target).addClass("invalid");
      $('html, body').animate({scrollTop: $($(".invalid")[0]).offset().top - offset }, delay);
    }
  }, true);

  document.addEventListener('change', function(e){
    $(e.target).removeClass("invalid")
  }, true);

  var searchInput = $('.w-search-input');
  var searchOpen = $('.w-search-open');
  searchOpen.on('click', function(e) {
    searchInput.focus();
  });
  
})(jQuery);
