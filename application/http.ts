/*
const json = fetch("https://quotes.rest/qod");

json.then((response) => {
    return response.json();
}).then((jsonData) => {})
*/
const fetchQuote = async () => {
    const response = await fetch("https://type.fit/api/quotes");
    return response.json();
}

export { fetchQuote }
