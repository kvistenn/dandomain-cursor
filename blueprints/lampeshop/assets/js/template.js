;(function ($, exports) {

  function detectOverflowingMenus(el) {
    let menuItem = $(el)[0];
    let rect = menuItem.getBoundingClientRect();
    let isOverflowing = rect.bottom > window.innerHeight;
  
    if (isOverflowing) {
      menuItem.style.overflowY = 'auto';
      menuItem.style.maxHeight = (window.innerHeight - rect.top) + 'px';
    } else {
      menuItem.style.overflowY = '';
      menuItem.style.maxHeight = '';
    }
  }

  $('.menu').hover(function () {
    let menuItems = $(this).find('.menu-items');
    detectOverflowingMenus(menuItems);
  });
  


    function handleReviews() {

        // Review form
        var reviewInput = $('.review-stars-input');
        var reviewStars = $('[data-star]');
  
        reviewStars.hover(function () {
            if (reviewInput.attr('data-hover')) {
             var star = $(this).data('star');
             reviewInput.attr('data-hover', star);
            }
          });
  
          reviewStars.on('mouseleave', function () {
            if (reviewInput.attr('data-hover')) {
            reviewInput.attr('data-hover', 0);
            }
          });
  
        reviewStars.on('click', function () {
            var star = $(this).data('star');
            if (reviewInput.attr('data-hover')) {
              reviewInput.removeAttr('data-hover');
              $('#review-stars-amount').val(star);
              reviewInput.attr('data-stars', star);
            } else {
              reviewInput.attr('data-hover', star);
              $('#review-stars-amount').val('');
              reviewInput.attr('data-stars', 0);
            }
        });
  
    }

    $(document).on('click', '[data-toggle="collapse"]', function(e) {
      var target = $(e.target).closest('[data-toggle="collapse"]');
      var addClass = target.data('class');
      var classTarget = target.data('target');
      $('[data-group="' + classTarget + '"]').toggleClass(addClass);
    });


    if(platform.page.isProduct && platform.page.productId !== null) {
        handleReviews();
    }

})(jQuery, window);