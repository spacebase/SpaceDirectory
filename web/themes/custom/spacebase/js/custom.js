(function ($, Drupal, drupalSettings) {

  'use strict';
  
  Drupal.behaviors.generalFunctions = {
    attach: function (context, settings) {
      
    
      var clickTap = $.support.touch ? "tap" : "click";
/*
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
*/      
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
        $('.main-nav').find('.region-navdropdown').fadeOut(300);
        $('.user-dropdown').fadeToggle(300);
      });
      
      $('.icon-blocks').on(clickTap, function (e) {
        e.stopPropagation();
        $('.user-dropdown').fadeOut(300);
        $('.main-nav').find('.region-navdropdown').fadeToggle(300);
      });
      
      $(document).click(function(e){
        $('.user-dropdown').fadeOut(300);
        $('.main-nav').find('.region-navdropdown').fadeOut(300);
      });

      $(document).on('show.bs.tab', '.nav-tabs-responsive [data-toggle="tab"]', function(e) {
        var $target = $(e.target);
        var $tabs = $target.closest('.nav-tabs-responsive');
        var $current = $target.closest('li');
        var $parent = $current.closest('li.dropdown');
    		$current = $parent.length > 0 ? $parent : $current;
        var $next = $current.next();
        var $prev = $current.prev();
        var updateDropdownMenu = function($el, position){
          $el
          	.find('.dropdown-menu')
            .removeClass('pull-xs-left pull-xs-center pull-xs-right')
          	.addClass( 'pull-xs-' + position );
        };
    
        $tabs.find('>li').removeClass('next prev');
        $prev.addClass('prev');
        $next.addClass('next');
        
        updateDropdownMenu( $prev, 'left' );
        updateDropdownMenu( $current, 'center' );
        updateDropdownMenu( $next, 'right' );
      });
      
    }
  };

})(jQuery, Drupal, drupalSettings);