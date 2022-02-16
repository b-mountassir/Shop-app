let input = document.querySelector("#query"),
    button = document.querySelector("#search");
let timeout = null
input.addEventListener('keyup', function(e) {
    let s = input.value
    clearTimeout(timeout);
    timeout = setTimeout(function() {
        button.click();
    }, 1000);
})