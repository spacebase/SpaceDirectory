/**
 * @file
 * jQuery to let the Industry chart and map interact with each other
 */



(function ( $ ) {
  'use strict';

  /** chartClickPrep = prep the chart for clicks that change the map **/
  $.fn.chartClickPrep = function() {
    // I don't like the other event handlers provided by the C3 chart. 
    // Removing them is optional / opinion /review:
    // I do like mouseover, mouseout events.a
    /* FYI future dev efforts ...The efforts below all failed to remove them,
     * will have to dig, so wait for feedback to be sure it's time well spent:
    $('g').off();
    $('g.c3-legend-item').unbind('click');
    $('g.c3-legend-item').off("click");
    $('g.c3-legend-item').off();
    */

    // on click of pie chart label, fire the exposed filter of the map:
    $('g.c3-arcs').on( "click", function() {
      //console.log("clicked a pie slice");

      var classes = $(this).attr("class");
      var regex = /c3-shapes-(\w+)/;
      var indus = $(this).attr("class").match(regex); // failure is null
      if (indus) {
        // Set the (probably hidden) form SELECT
        $('[name="field_industry_segment_target_id"] option:contains("' + indus[1] + '")').prop('selected',true).trigger('change');
        // Click submit.
        $('.view-organizations-nz-overview-map button').click();
      }
    });

    // on click a taxonomy label below the map
    $('g.c3-legend-item').on( "click", function() {
      console.log("clicked a label");
      // Set the (probably hidden) form SELECT
      // from ex: <text....>Universities</text>
      $('[name="field_industry_segment_target_id"] option:contains("' + $(this).text() + '")').prop('selected',true).trigger('change');
      // Click submit.
      // note: first time only this works: $('#edit-submit-organizations-nz-overview-map').click();
      $('.view-organizations-nz-overview-map button').click();
    });

    return this;
  };
 
  /** Bind events on map features to a function that greps out the city and 
    *alters the chart exposed filter
   * This seems to still exist and re-bind as the map is reloaded (new
   * leaflet.feature's are triggered.)  @ToDo: isn't bind deprecated; use on?
   */

  /** Add a click function to features added to the map.
   * Note: This fires the first time the map appears and when ajax generates
   * a new view/map. It was previously encased in:
   *
   *   Drupal.behaviors.spacebase_core = {
   *     attach: function (context, settings) {
   *
   * but that didn't run the first time.
   */ 
  jQuery(document).bind('leaflet.feature', function(e, lFeature, feature) {
    lFeature.on('click', function(e) {
      // Get the city
      var regex = /locality">([\w\d\s]*)<\/span/;
      var city = lFeature._popup._content.match(regex); // null or Array, need [1]
      if (city !== null) {
        // exposed filter id's change after click, thus twisty effort to id:
        jQuery('input[name="city"]').val(city[1]);
        jQuery('#views-exposed-form-organizations-by-field-and-city-views-block-filter-bpdb-1 button').click();
      }
    })
  });



  /** When ajax reloads the charts from clicking cities on the map,
   * make the chart clickable again: */
  $( document ).ajaxComplete(function( event, xhr, settings ) {
    if (settings.url == '/views/ajax?_wrapper_format=drupal_ajax') {
      $().chartClickPrep(); 
    }
  });

  /** On initial pageload, make the chart clickable **/
  $(function () {
    $().chartClickPrep();
  });   

})(jQuery);

