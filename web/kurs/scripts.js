
$(document).ready(function() {

  $('#contactForm').submit(function(event) {
    event.preventDefault();
    $('#name').val('');
    $('#email').val('');
    $('#message').val('');
    alert('Спасибо за ваше сообщение!');
  });
});



  $(document).ready(function() {
    $(window).on('scroll', function() {
      $('.content').each(function() {
        var elementTop = $(this).offset().top;
        var viewportBottom = $(window).scrollTop() + $(window).height();
        if (elementTop < viewportBottom - 100) {
          $(this).addClass('visible');
        }
      });
    });
  });

