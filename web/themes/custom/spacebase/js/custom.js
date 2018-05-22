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
        e.stopImmediatePropagation();
        if($('.user-dropdown').is(":visible")){
          $('.user-dropdown').fadeOut(300);
          e.stopPropagation();
          return false;
        } else {
          $('.user-dropdown').fadeIn(300);
          e.stopPropagation();
          return false;
        }
        
      });
      
      $('.leave-reply').on(clickTap, function (e) {
        e.stopPropagation();
        $('.comment-form').slideDown(400);
        $(this).slideUp(100);
        $('.close-comment').fadeIn(200);
        return false;
      });
      
      $('.close-comment').on(clickTap, function (e) {
        e.stopPropagation();
        $('.comment-form').slideUp(400);
        $('.leave-reply').slideDown(200);
        $(this).hide();
        return false;
      });
      
      $('.icon-blocks').on(clickTap, function (e) {
        e.stopImmediatePropagation();
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
      
      $(function() {
        // Javascript to enable link to tab
        var url = document.location.toString();
        if (url.match('#')) {
          $('.nav-tabs-responsive a[href="#'+url.split('#')[1]+'"]').tab('show') ;
        }
      
        // Change hash for page-reload
        $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
          window.location.hash = e.target.hash;
        });
      });
      
      $('.admin-links').find('.fa-thumbtack').on(clickTap,function(){
        $(this).parent().find('.checkbox-toggle').click();
        if ($(this).parent().find('.checkbox-toggle').is(":checked")){
          $(this).addClass('pinned');
        } else {
          $(this).removeClass('pinned');
        }
      });
      
      $('.reject-accept').find('i').on(clickTap,function(){
        if ($(this).parent().hasClass('active')){
          $(this).parent().removeClass('active');
          $(this).parent().parent().find('.fieldgroup .form-item:nth-child(2)').find('input').prop("checked", true);
        } else {
          $(this).parent().parent().find('span').removeClass('active');
          if($(this).parent().hasClass('reject')){
            $(this).parent().addClass('active');
            $(this).parent().parent().find('.fieldgroup .form-item:nth-child(1)').find('input').prop("checked", true);
          } else if($(this).parent().hasClass('accept')){
            $(this).parent().addClass('active');
            $(this).parent().parent().find('.fieldgroup .form-item:nth-child(3)').find('input').prop("checked", true);
          }
        }
      });
      
    }
  };

})(jQuery, Drupal, drupalSettings);