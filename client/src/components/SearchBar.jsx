function SearchBar({ search, setSearch, handleSubmit }) {

    const handleChange = (e) => {
        setSearch(e.target.value)
    }

    return (
        <div>
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    placeholder="search produce..."
                    name="search"
                    value={search}
                    onChange={handleChange}
                >
                </input>
                <input
                    type="submit"
                    value="Find"
                >
                </input>
            </form>
        </div>
    )
}

export default SearchBar;