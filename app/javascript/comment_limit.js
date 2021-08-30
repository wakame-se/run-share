$(function() {
  $(document).on("input", '#count-down', function() {
    let txtcount = 140 - $(this).val().length;
    $('#txtlmt').text(txtcount);
    if (txtcount < 10) {
      $('#txtlmt').css('color', 'red');
    } else {
      $('#txtlmt').css('color', 'black');
    }
  });
});