let input = document.querySelector("#query")
let timeout = null
input.addEventListener('keyup', function(e){
    let s = input.value
    let search_path = "?q%5Btitle_cont%5D=" + s + "&commit=Search"
    let search_path_name = '/products'+search_path
    search_path_name = encodeURIComponent(search_path_name)
    clearTimeout(timeout);
    timeout = setTimeout(function () {
        if (window.location.pathname.endsWith('/products')){
            window.location.search = search_path
        }else{
            window.location.href =  decodeURIComponent(search_path_name)
        } 
    }, 1000);
})