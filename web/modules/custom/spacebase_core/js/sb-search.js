(function($, Drupal) {
  Drupal.behaviors.sbAdvancedSearch = {
    attach:function() {
      if ($('a#org-advanced-search').length > 0) {

        if (localStorage.getItem("orgAdvancedSearchEnabled") == 'true') {
          $('a#org-advanced-search').addClass('label-default');
          $('#block-orgadvancedsearchblock').slideDown(300);
          $('body').addClass('topbar-open');
        }

        $('a#org-advanced-search').click(function() {
          $(this).toggleClass('label-default');
          if ($(this).hasClass('label-default')) {
            localStorage.setItem("orgAdvancedSearchEnabled", 'true');
            $('#block-orgadvancedsearchblock').slideDown(300);
            $('body').addClass('topbar-open');
          }
          else {
            localStorage.setItem("orgAdvancedSearchEnabled", 'false');
            $('#block-orgadvancedsearchblock').slideUp(300);
            $('body').removeClass('topbar-open');
          }
        });
      }



    }
  };
}(jQuery, Drupal));