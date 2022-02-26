$('label.star').on('click', function(e) {
    $(this).prevAll().addClass("star--on")
    $(this).prevAll().removeClass("star--off")
    $(this).nextAll().removeClass("star--on")
    $(this).nextAll().addClass("star--off")
    $(this).addClass("star--on")
});