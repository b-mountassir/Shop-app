var modal = (function() {
    var
        method = {},
        $overlay,
        $modal,
        $content,
        $close;

    // Center the modal in the viewport
    method.center = function() {
        var top, left;

        top = Math.max($(window).height() - $modal.outerHeight(), 0) / 2;
        left = Math.max($(window).width() - $modal.outerWidth(), 0) / 2;

        $modal.css({
            top: top + $(window).scrollTop(),
            left: left + $(window).scrollLeft(),
            zIndex: 99999,
        });
    };

    // Open the modal
    method.open = function() {
        // $content.empty().append(settings.content);

        $modal.css({
            width: 'auto',
            height: 'auto'
        });
        $(window).bind('resize.modal', method.center);
        $(document.body).css({
            position: 'fixed',
            top: `-${window.scrollY}px`,
            width: '-webkit-fill-available'
        })

        method.center();
        $modal.show();
        $overlay.show();
    };

    // Close the modal
    method.close = function() {
        $modal.hide();
        $overlay.hide();
        $content.empty();
        $(window).unbind('resize.modal');
        $(document.body).css({
            position: '',
            top: '',
            width: ''
        })
    };

    // Generate the HTML and add it to the document
    $overlay = $('<div id="overlay"></div>');
    $modal = $('<div id="modal"></div>');
    $content = $('<div id="content"></div>');
    $close = $('<a id="close" href="#">close</a>');

    $modal.hide();
    $overlay.hide();
    $modal.append($content, $close);

    $(document).ready(function() {
        $('body').append($overlay, $modal);
    });

    $close.click(function(e) {
        e.preventDefault();
        method.close();
    });

    $overlay.click(function(e) {
        e.preventDefault();
        method.close();
    });

    return method;
}());

// Wait until the DOM has loaded before querying the document
$(document).ready(function() {
    $('#create-new-product').click(function(e) {
        createProduct();

        function createProduct() {
            $.ajax({
                url: 'products/new',
                type: 'get',
                success: function() {
                    // Add response in Modal body
                    modal.open();
                }
            });
            e.preventDefault();
        }
    });
});