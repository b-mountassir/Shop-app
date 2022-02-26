import Chart from 'chart.js/auto';

document.addEventListener('turbolinks:load', () => {
    if (document.querySelector(".dashboard.index")) {
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
    }
})