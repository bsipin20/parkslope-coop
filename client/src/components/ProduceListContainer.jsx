import { useState } from 'react';
import PriceChart from "./PriceChart";

function ProduceListContainer({ priceData }) {
    const [produceData, setProduceData] = useState("");

    if (!priceData.length) {
        return
    }

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
            >
                {produce.label}
            </li>
        )
    })
    return (<div>
        <h4>Produce List</h4>
        <ul>
            {produceList}
        </ul>
        {priceData.length && <PriceChart produceData={produceData} />}
    </div>)
}

export default ProduceListContainer;