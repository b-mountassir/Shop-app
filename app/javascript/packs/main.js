(function($) {
    "use strict";

    // Dropdown on mouse hover
    $(document).ready(function() {
        function toggleNavbarMethod() {
            if ($(window).width() > 992) {
                $('.navbar .dropdown').on('mouseover', function() {
                    $('.dropdown-menu').toggleClass('show');
                }).on('mouseout', function() {
                    $('.dropdown-menu').toggleClass('show');
                });
            } else {
                $('.navbar .dropdown').off('mouseover').off('mouseout');
            }
        }
        toggleNavbarMethod();
        $(window).resize(toggleNavbarMethod);
    });

    let page = document.location.pathname;
    $(".nav-item.nav-link").map(function() {
        if ($(this).attr('href') == page) {
            $(this).toggleClass("active")
        }
    })


    // Back to top button
    $(window).scroll(function() {
        if ($(this).scrollTop() > 100) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function() {
        $('html, body').animate({ scrollTop: 0 }, 1000, 'swing');
        return false;
    });

})(jQuery);