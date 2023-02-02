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
                    required
                    value={search}
                    onChange={handleChange}
                    onInvalid={e => e.target.setCustomValidity("Search for a produce item. Try 'blueberries'")}
                    onInput={e => e.target.setCustomValidity("")}
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