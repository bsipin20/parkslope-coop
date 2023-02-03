import "../App.css"

function SummaryTable({ produceData }) {
    const today = new Date("2023-01-23"); // hardcoded to most recent datapoint. Remove string argument when price data is up to date
    const milliSecsInDay = 24 * 60 * 60 * 1000;

    if (!produceData?.label) return;

    const summaryTableCalc = (numOfDays) => {
        const lastDateTime = new Date(today - numOfDays * milliSecsInDay);
        const dateIndex = produceData?.dates.findLastIndex(date => {
            const day = new Date(date);
            return day <= lastDateTime;
        })

        const pricesFromLastDate = produceData?.prices.slice(dateIndex + 1);
        const avgPrice = pricesFromLastDate?.reduce((a, c) => a + parseFloat(c), 0) / (pricesFromLastDate.length);

        return {
            "Avg": !avgPrice ? "N/A" : avgPrice.toFixed(2),
            "High": !avgPrice ? "-" : Math.max(...pricesFromLastDate),
            "Low": !avgPrice ? "-" : Math.min(...pricesFromLastDate)
        }
    }

    return (
        <div id="summary-table">
            <table>
                <thead>
                    <tr>
                        <th></th>
                        <th>Avg ($)</th>
                        <th>Low ($)</th>
                        <th>High ($)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Past 7 days</td>
                        <td>{summaryTableCalc(7)["Avg"]}</td>
                        <td>{summaryTableCalc(7)["Low"]}</td>
                        <td>{summaryTableCalc(7)["High"]}</td>

                    </tr>
                    <tr>
                        <td>Past month</td>
                        <td>{summaryTableCalc(30)["Avg"]}</td>
                        <td>{summaryTableCalc(30)["Low"]}</td>
                        <td>{summaryTableCalc(30)["High"]}</td>
                    </tr>
                    <tr>
                        <td>3 months</td>
                        <td>{summaryTableCalc(90)["Avg"]}</td>
                        <td>{summaryTableCalc(90)["Low"]}</td>
                        <td>{summaryTableCalc(90)["High"]}</td>

                    </tr>
                    <tr>
                        <td>6 months</td>
                        <td>{summaryTableCalc(180)["Avg"]}</td>
                        <td>{summaryTableCalc(180)["Low"]}</td>
                        <td>{summaryTableCalc(180)["High"]}</td>
                    </tr>
                    <tr>
                        <td>12 months</td>
                        <td>{summaryTableCalc(365)["Avg"]}</td>
                        <td>{summaryTableCalc(365)["Low"]}</td>
                        <td>{summaryTableCalc(365)["High"]}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    )
}

export default SummaryTable;