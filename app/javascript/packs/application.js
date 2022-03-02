// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'trix/dist/trix.css';


$(document).on("click", (e) => {
    if ($(".nav-link[data-toggle='collapse']").attr('aria-expanded') === "true" && !e.target.className.includes("nav-item")) {
        $('.collapse').collapse('hide');
    }
})

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")
global.jQuery = require('jquery');
try {
    global.Popper = require('popper.js').default;
    require('jquery.easing'); // dat works :3
} catch (e) {}


window.$ = jQuery