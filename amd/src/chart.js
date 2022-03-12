// Standard license block omitted.
/*
 * @module     mod_digitala/mic
 * @copyright  2022 Name
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

import chart from 'chart';


export const init = (pagenum) => {
    window.console.log('töttöröö', pagenum);

    if (pagenum == 2) {
        

        const kaavio = document.getElementById('kaavio').getContext('2d');
        const myChart = new chart.Chart(kaavio, {
            type: 'bar',
            data: {
                labels: [""],
                datasets: [
                {
                    label: 'Tottoroo 1',
                    data: [1],
                    backgroundColor: 'rgba(255, 99, 132, 0.2)'
                },
                {
                    label: 'Tottoroo 2',
                    data: [1],
                    backgroundColor: 'rgba(54, 162, 235, 0.2)'
                },
                {
                    label: 'Tottoroo 3',
                    data: [1],
                    backgroundColor: 'rgba(255, 206, 86, 0.2)'
                },
                {
                    label: 'Tottoroo 4',
                    data: [1],
                    backgroundColor: 'rgba(75, 192, 192, 0.2)'
                },
                ]
            },
            options: {
                plugins: {
                    legend: {
                      display: false
                    }
                },
                lineAt: 14,
                indexAxis: 'y',
                scales: {
                    x: {
                        stacked: true,
                    },
                    y: {
                        stacked: true
                    },
                    yAxes: [{
                        ticks: {
                            beginAtZero:true
                        }
                    }]
                }
            }
        });
        window.console.log('myChart', myChart);
    }
};