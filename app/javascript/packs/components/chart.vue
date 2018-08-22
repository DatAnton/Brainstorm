<template>
  <div class="chart-container">
    <canvas id="planet-chart"></canvas>
  </div>
</template>

<script>
import _ from 'lodash';
import Chart from 'chart.js';

export default {
  props: {
    source: Array,
  },
  data() {
    return {
      input: _.sortBy(this.source, ['impact', 'cost']),
    };
  },
  created() {
    this.matrix = {
      labels: (this.input || []).map(answer => answer.text),
      coords: (this.input || []).map(answer => ({ x: answer.impact, y: answer.cost })),
    }
  },
  mounted() {
    this.createChart('planet-chart', {
      data: {
        labels: this.matrix.labels,
        datasets: [
          {
            label: "Cost",
            data: this.matrix.coords,
		        borderColor: 'rgb(255, 205, 86)',
		        backgroundColor: 'rgb(255, 205, 86)',
            fill: false,
						pointRadius: 10,
						pointHoverRadius: 15,
						showLine: false // no line shown
          },
        ],
      },
      options: {
        tooltips: {
          callbacks: {
            title: (t, data) => "Solution",
            label: (t, data) => t.xLabel,
          }
        },
        elements: {
						point: {
							pointStyle: 'circle'
						}
					},
        // responsive: true,
        lineTension: 1,
        legend: {
						display: false
					},
        scales: {
          yAxes: [{
            ticks: {
              padding: 25,
              beginAtZero: true,
              labelString: 'Solution cost',
              callback: (value, index, values) => values.length - index,
            }
          }]
        }
      },
    });
  },
  methods: {
    createChart(chartId, config) {
      const ctx = document.getElementById(chartId);
      const myChart = new Chart(ctx, {
        type: 'line',
        data: config.data,
        options: config.options,
      });
    },
  },
}
</script>
