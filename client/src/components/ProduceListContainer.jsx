import { useState } from "react";
import PriceChart from "./PriceChart";
import PriceTable from "./PriceTable";
import "../App.css"

function ProduceListContainer({ priceData, produceData, setProduceData }) {
    const [showPriceTable, setShowPriceTable] = useState(false);

    if (!priceData.length) return;

    const handleClick = (e) => {
        const produceClicked = e.target.dataset.name;
        const selectedProduceData = priceData.filter(data => data.label === produceClicked);
        setProduceData(selectedProduceData);
    }

    const produceList = priceData.map(produce => {
        return (
            <li
                key={produce.label}
                data-name={produce.label}
                onClick={handleClick}
                className={produceData[0]?.label === produce.label ? "selected" : null}
            >
                {produce.label}
            </li>
        )
    })
    return (
        <div id="main-container">
            <div id="produce-list-container">
                <h4>Produce List</h4>
                <ul className="produce-list-items">
                    {produceList}
                </ul>
            </div>
            {priceData.length &&
                <div id="price-chart">
                    <PriceChart produceData={produceData} />
                    <button onClick={() => setShowPriceTable(val => !val)}>{showPriceTable ? "Hide Table" : "Show Table"}</button>
                </div>}
            {showPriceTable && <PriceTable produceData={produceData[0]} />}
        </div>
    )
}

export default ProduceListContainer;