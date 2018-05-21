(function($, Drupal) {
  Drupal.behaviors.sbAdvancedSearch = {
    attach:function() {
      if ($('a#org-advanced-search').length > 0) {

        if (localStorage.getItem("orgAdvancedSearchEnabled") == 'true') {
          $('a#org-advanced-search').addClass('label-default');
          $('#block-orgadvancedsearchblock').show();
        }

        $('a#org-advanced-search').click(function() {
          $(this).toggleClass('label-default');
          if ($(this).hasClass('label-default')) {
            localStorage.setItem("orgAdvancedSearchEnabled", 'true');
            $('#block-orgadvancedsearchblock').show();
          }
          else {
            localStorage.setItem("orgAdvancedSearchEnabled", 'false');
            $('#block-orgadvancedsearchblock').hide();
          }
        });
      }



    }
  };
}(jQuery, Drupal));