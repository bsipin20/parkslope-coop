import { Chart } from 'chart.js/auto'
import { Line } from 'react-chartjs-2';

function PriceChart({ produceData }) {

    if (!produceData.length) {
        return
    }

    const data = {
        labels: produceData[0].dates,
        datasets: [
            {
                label: `Recent Price Trend for ${produceData[0].label}`,
                data: produceData[0].prices,
                borderColor: "black",
                backgroundColor: "black",
            }
        ],
    };

    const options = {
        responsive: true,
        elements: {
            point: {
                radius: 0
            }
        },
        plugins: {
            legend: {
                position: 'top',
            }
        },
        scales: {
            x: {
                ticks: {
                    callback: function (val, index) {
                        return index % 3 === 0 ? this.getLabelForValue(val) : "";
                    },
                    color: 'black',
                }
            }
        }
    };

    return (
        <div style={{ maxHeight: "100%" }}>
            <h3>Price Chart for {produceData[0].label}</h3>
            <Line
                data={data}
                options={options}
            />
        </div>
    )
}

export default PriceChart;