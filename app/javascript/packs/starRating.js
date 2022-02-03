var checked;
document.querySelector(".star-field").addEventListener("click", function() {
    for (let i = 0; i < $(".star-rating").length; i++) {
        if ($($($(".star-rating"))[i]).is(":checked")) {
            checked = i;
        }

        if (document.querySelector("label.star--off")) {
            $($($("label.star--off"))[i])[0].classList.add("star--on");
            $($($("label.star--off"))[i])[0].classList.remove("star--off")
        }
    }
    for (let j = 0; j < (4 - checked); j++) {
        if (document.querySelector("label.star--on")) {
            $($($("label.star--on"))[4 - j])[0].classList.add("star--off");
            $($($("label.star--on"))[4 - j])[0].classList.remove("star--on")
        }
    }
})