const fetchQuote = async () => {
    const response = await fetch("https://type.fit/api/quotes");
    return response.json();
}

export { fetchQuote }
