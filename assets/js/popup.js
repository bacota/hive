/**
 * Popup Code
 * @param  {[type]} ) {             })( [description]
 * @return {[type]}   [description]
 */
var Popup = (function _popup() {

  var _mini_popup_wrapper = '',
  onProfileclick = function (){},

  oDispatch,

  // HTML Template
  // 
  profileHTML = d3.select('#popup_large_profile_tpl').html(),
  profileScoreHTML = d3.select('#profile_miniscore_tpl').html();

  Mustache.parse(profileHTML);
  Mustache.parse(profileScoreHTML);

  function miniPopup(aData) {

    var popup = d3.select(document.createElement('div')),
    list = d3.select(document.createElement('div')),
    oData = {};

    list.classed('popup popup--mini', true);

    // Add Header
    // 
    var firstFeature = aData[0],
    header = d3.select(document.createElement('h4')),
    sRecord = aData.length > 1 ? 'records' : 'record',
    headerText = [aData.length, sRecord, 'in', _.startCase(firstFeature.City) + ',', firstFeature.State].join(' ');

    header.text(headerText);

    header.classed('popup__title', true);

    // add profiles
    // 
    aData = aData.map(function(d){
      return getProfileWithMetaProperties(d);
    });

    // Profile Map
    // 
    oData = d3.map(aData, function(d){
      return d.ID;
    });

    list.html(Mustache.render(profileScoreHTML, {
      profiles: aData
    }));
    
    list.selectAll('li')
    .on('click', function(d, i){
      
      var sID = this.getAttribute('data-id'),
      d = oData.get(sID);
      
      //console.log('clicked profile', d);

      // Update property;
      // 
      d.isActiveProfile = true;

      oData.set(sID, d);

      onProfileclick(oData.values(), i);
    });

    // add list to popup
    // 
    jQuery(popup.node()).append(header.node());

    jQuery(popup.node()).append(list.node());


    return popup.node();
    
  }

  function profilePopup(oData) {

    // creat a wrapper div and add popup html
    // 
    var el = d3.select(document.createElement('div'))
      .html(Mustache.render(profileHTML, oData));

    // Bind Events
    // 

    // Toggle Profile Bookmark
    // 
    el.selectAll('.profilepanel__bookmark')
      .on('click', function(d){
        // get profile ID
        // 
        var btn = jQuery(this);

        //console.log('Toggle Bookmark on Profile', this.getAttribute('data-id'));

        // trigger bookmark event
        // 
        oDispatch.apply('toggleBookmark', null, [{
          ID: this.getAttribute('data-id')
        }]);

        // Toggle class
        // 
        if (btn.hasClass('profilepanel__bookmark--active')) {
          btn.removeClass('profilepanel__bookmark--active');
        }else{
          btn.addClass('profilepanel__bookmark--active');
        }

      });

    // Go Back to Profile Listing
    // 
    el.selectAll('.profilepanel__back')
      .on('click', function(d){
        
        // Remove active class
        // 
        jQuery('.popup--activeprofile')
          .removeClass('popup--activeprofile');

        jQuery('.profilepanel--active')
          .removeClass('profilepanel--active');
        
      });

    // Make a Profile Active
    // 
    el.selectAll('.profilepanel--handle')
      .on('click', function(d){
        
        // If not already active class
        //
        var $panel = jQuery(this).closest('.profilepanel');
        if (!$panel.hasClass('profilepanel--active')) { 
          jQuery('.popup--large')
            .addClass('popup--activeprofile');

          $panel
            .addClass('profilepanel--active');
        }
        
      });




      return el.node();
   
  }

  return {

    miniPopup: miniPopup,

    profilePopup: profilePopup,

    onProfileclick: function(fn){
      onProfileclick = fn;
    },

    setDispatch: function(od){
      if (!!od) {
        oDispatch = od;
      }
    }

  }
  
})();