// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require chosen-jquery
//= require 'rails_admin/jquery.remotipart.fixed'
//=  require 'jquery-ui/sortable'
//=  require 'jquery-ui/autocomplete'
//=  require 'jquery-ui/datepicker'
//= require bootstrap
//= require tinymce-jquery
//= require rails_admin/custom/tinymce
//= require 'rails_admin/ra.filter-box'
//= require 'rails_admin/ra.filtering-multiselect'
//= require 'rails_admin/ra.filtering-select'
//= require 'rails_admin/ra.widgets'
//= require moment.min
//= require datetimepicker/build/jquery.datetimepicker.full

//= require jquery_nested_form

//= require chartkick


$(function(){
  // Date Picker
  var currentDate = new Date();
  var completedAtVal = $('#completed_at').val();

  $('input.date-picker').datetimepicker({
    dayOfWeekStart : 1,
    lang:'en',
    minDate:0,
    step:5,
    mouseWheel: false,
    scrollMonth: false,
    format:'m/d/Y - g:i a',
    formatTime: 'g:i a',
    onChangeDateTime:function(dp,$input){
      var val = $input.val();
      var m = moment(val, "MM/DD/YYYY - hh:mm a");
      var proxy = $input.attr('data-proxy');
      console.log(m.format("YYYY-MM-DD HH:mm:00"));
      $('#'+proxy).val( m.utc() );
    }
  });

  $('input.project-date-picker').datetimepicker({
    dayOfWeekStart : 1,
    lang:'en',
    minDate:new Date(2010, 1 - 1, 1),
    timepicker: false,
    step:5,
    mouseWheel: false,
    scrollMonth: false,
    format:'m/d/Y',
    onChangeDateTime:function(dp,$input){
      var val = $input.val();
      var m = moment(val, "MM/DD/YYYY");
      var proxy = $input.attr('data-proxy');
      console.log(m.format("YYYY-MM-DD HH:mm:00"));
      $('#'+proxy).val( m.utc() );
    }
  });


  if(completedAtVal){

  } else {
    $('#completed_at').val(currentDate);
  }

  $('.date').click(function(){
    $(this).parent().find('input.date-picker').focus();
  });

  // Contact Image Upload
  $('.img-upload-btn').click(function(event){
    event.stopPropagation();
    var input = $(this).siblings('input').first();
    input.trigger('click');
    return false;
  });

  // Header Nav toggle
  $('.nav-toggle').click(function(){
    $('header').toggleClass('nav-active');
    $('.sidebar-nav').toggleClass('open');
  });

  $('.acct-link').click(function(){
    $('.profile-nav').toggleClass('show');
  });

  $('.profile-nav').mouseleave(function(){
    $('.profile-nav').removeClass('show');
  });

  $('header .magnify').click(function(){
    $('body').addClass('search-active');
    $('header .search input').focus();
  });

  $('header .search .close').click(function(){
    $('body').removeClass('search-active');
  });

  $('.utility .list-view').click(function(){
    $(this).addClass('current');
    $('.utility .grid-view').removeClass('current');
    $('.layout').removeClass('grid');
  });

  $('.utility .grid-view').click(function(){
    $(this).addClass('current');
    $('.utility .list-view').removeClass('current');
    $('.layout').addClass('grid');
  });

  $('.edit-toggle').click(function(){
    $(this).closest('.form-holder').addClass('edit-active');
  });

  $('.edit-form .close').click(function(){
    $(this).closest('.form-holder').removeClass('edit-active');
  });

  $('.info-block-head .close').click(function(){
    $(this).closest('.form-holder').removeClass('edit-active');
  });

  $('.info-block-head li').click(function(){
    $(this).closest('.form-holder').removeClass('edit-active');
  });

  // Detail Block Actions
  $('.info-block-head > ul li').click(function(){
    var position = $(this).parent().children().index(this);
    $(this).closest('.info-block-head').find('> ul li').removeClass('current');
    $(this).addClass('current');
    $(this).closest('.info-block').find('.info-block-content > ul > li').removeClass('current');
    $(this).closest('.info-block').find('.info-block-content > ul > li').eq(position).addClass('current');
  });

  $('.info-block-head > ul > li:first-child').trigger( "click" );

  // Contact Activity/Task forms
  $('.link-block .create').click(function(){
    $(this).closest('.hidden-form').addClass('form-active');
  });

  $('.hidden-form .actions a').click(function(event){
    if($('body').hasClass('contacts')){
      event.stopPropagation();
      $(this).closest('.hidden-form').removeClass('form-active');
      return false;
    }
  });
  // Contact Activity form hidden description
  $('tr.description-toggle').click(function(event){
      if($('body').hasClass('contacts')){
        event.stopPropagation();
        if( $(this).hasClass('open') ){
          $('tr.description-toggle').removeClass('open');
          $('tr.description').addClass('hidden');
          $(this).removeClass('open');
        } else {
          $('tr.description-toggle').removeClass('open');
          $('tr.description').addClass('hidden');
          $(this).addClass('open');
          $(this).next().removeClass('hidden');
        }

        return false;
      }
  });


  $(document).on('nested:fieldAdded', function(event){
    $('.chosen-select').chosen({allow_single_deselect: true});
  });


  $('.chosen-select').chosen({allow_single_deselect: true});

  $('fieldset#company_name').hide();

  $('#contact_contact_type_id').change(function () {
    $('fieldset#company_name').hide();
      if ($(this).find("option:selected").text() == "Company") {
        $('.non_copmany_field').hide();
        $('fieldset#company_name').show();
      } else {
          $('.non_copmany_field').show();
      }
  });


  $('.chosen-search').bind("enterKey",function(e){
    var search = $('.chosen-search input');
    var opt = search.val();
    $('.chosen-select').append('<option>'+opt+'</option>');
    $('.chosen-select').trigger('chosen:updated');
   });

   $( '.chosen-search' ).keyup(function(e) {
    if(e.keyCode == 13){
        $(this).trigger("enterKey");
      }
  });

});


