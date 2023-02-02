import '../App.css';
import { Link } from 'react-router-dom';

function NavBar() {
    return (
        <div id="navbar-container">
            <h2>Parslope Coop</h2>
            <ul id="navbar-list">
                <Link to={"/about"}><li>About</li></Link>
                <Link to={"/search"}><li>Search</li></Link>
                <Link to={"/bigmovers"}><li>Big Price Moves</li></Link>
            </ul>
        </div>
    )
}

export default NavBar;