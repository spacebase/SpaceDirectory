(function ($, Drupal, drupalSettings) {

  'use strict';
  
  Drupal.behaviors.generalFunctions = {
    attach: function (context, settings) {
      
    
      var clickTap = $.support.touch ? "tap" : "click";

      $('a[href*="#"]:not([href="#"])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
          var target = $(this.hash);
          target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
          if (target.length) {
            $('html, body').animate({
              scrollTop: target.offset().top
            }, 1500);
            return false;
          }
        }
      });
      
      window.FontAwesomeConfig = {
        searchPseudoElements: true
      }
    
     
      $('.navbar-collapse').on('show.bs.collapse', function () {
        $(this).addClass('open');
        $('body').addClass('nav-open');
        $('.body-overlay').show();
      }).on('hide.bs.collapse', function () {
        $(this).removeClass('open');
        $('body').removeClass('nav-open');
        $('.body-overlay').hide();
      });
      
      $('.body-overlay').on(clickTap, function () {
        $(".navbar-toggle").click();
      });
      
      $('.nav-link').on(clickTap, function (e) {
        e.stopPropagation();
        $('.user-dropdown').fadeToggle(300);
      });
      
      $(document).click(function(e){
        $('.user-dropdown').fadeOut(300);
      });
      
    }
  };

})(jQuery, Drupal, drupalSettings);