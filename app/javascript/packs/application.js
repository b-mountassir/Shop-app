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
import Chart from 'chart.js/auto';

document.addEventListener('turbolinks:load', () => {
    var ctx1 = document.getElementById('myChart').getContext('2d');
    var ctx2 = document.getElementById('myChart1').getContext('2d');
    var myChart = new Chart(ctx1, {
        type: 'doughnut',
        data: {
            labels: JSON.parse(ctx1.canvas.dataset.labels),
            datasets: [{
                data: JSON.parse(ctx1.canvas.dataset.data),
                backgroundColor: JSON.parse(ctx1.canvas.dataset.colors)
            }]
        },
    });
    var myChart = new Chart(ctx2, {
        type: 'line',
        data: {
            labels: JSON.parse(ctx2.canvas.dataset.labels),
            datasets: [{
                label: 'Daily orders in Dollars',
                data: JSON.parse(ctx2.canvas.dataset.data),
            }]
        },
    });
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