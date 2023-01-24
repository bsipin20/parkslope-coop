import { useState, useEffect } from "react";
import './App.css';
import SearchBar from "./components/SearchBar";
import ProduceListContainer from "./components/ProduceListContainer";

function App() {
  const [priceData, setPriceData] = useState([]);
  const [search, setSearch] = useState("");

  useEffect(() => {
    if (!search) return
    request();
  }, [])

  const request = async () => {
    let req = await fetch(`/producepricetimeline?search=${search}`);
    let res = await req.json();
    if (req.ok) {
      setPriceData(res.prices)
    };
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    request();
  }

  return (
    <div className="App">
      <h2>Parkslope Coop</h2>
      <SearchBar
        search={search}
        setSearch={setSearch}
        handleSubmit={handleSubmit}
      />
      <ProduceListContainer
        priceData={priceData}
      />
    </div>
  );
}

export default App;
