
function PriceTable({ produceData }) {
    const produceTableRows = produceData?.dates.map((date, index) => {
        return (
            <tr key={index}>
                <td>{date}</td>
                <td>{produceData?.prices[index]}</td>
            </tr>
        )
    })

    return (
        <div id="price-table">
            <table>
                <thead>
                    <tr>
                        <th style={{ width: "10em" }}>Date</th>
                        <th>$/{produceData?.unit}</th>
                    </tr>
                </thead>
                <tbody>
                    {produceTableRows}
                </tbody>
            </table>
        </div>
    )
}

export default PriceTable;