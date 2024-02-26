$(window).load(function(){
  $('#carousel').flexslider({
      animation: "slide",
      controlNav: false,
      animationLoop: true,
      slideshow: false,
      itemWidth: 210,
      itemMargin: 5,
      asNavFor: '#slider'
  });

  $('#slider').flexslider({
      animation: "fade",
      controlNav: false,
      animationLoop: true,
      slideshow: false,
      sync: "#carousel",
      start: function(slider){
          $('body').removeClass('loading');
      }
  });
});