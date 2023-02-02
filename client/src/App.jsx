import { useState, useEffect } from "react";
import { Routes, Route } from "react-router-dom"
import './App.css';
import SearchBar from "./components/SearchBar";
import ProduceListContainer from "./components/ProduceListContainer";
import NavBar from "./components/NavBar";
import About from "./components/About";
import BigMovers from "./components/BigMovers";

function App() {
  const [priceData, setPriceData] = useState([]);
  const [search, setSearch] = useState("");
  const [produceData, setProduceData] = useState([]);

  useEffect(() => {
    if (!search) return;
    request();
  }, []);

  const request = async () => {
    let req = await fetch(`https://parkslopeproduce-api-v1:10000/producepricetimeline?search=${search}`);
    let res = await req.json();
    if (req.ok) {
      setPriceData(res.prices);
    };
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    setProduceData([]);
    request();
  }

  return (
    <div className="App">
      <NavBar />
      <Routes>
        <Route path="/search"
          element={
            <>
              <SearchBar
                search={search}
                setSearch={setSearch}
                handleSubmit={handleSubmit}

              />
              <ProduceListContainer
                priceData={priceData}
                produceData={produceData}
                setProduceData={setProduceData}
              />
            </>
          } />
        <Route path="/about" element={<About />} />
        <Route path="/bigmovers" element={<BigMovers />} />
      </Routes>
    </div>
  );
}

export default App;
