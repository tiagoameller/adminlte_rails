$(document).on('turbolinks:load', function () {

  // alert('hi!');
  $('.icheck').iCheck(
    {
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    }
  );

});