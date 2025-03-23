function parseDate(dateString) {
    const [day, month, year] = dateString.split('-').map(Number);
    return new Date(year, month - 1, day);
}

function validateDate(dateString) {
    const regex = /^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[0-2])-\d{4}$/;
    return regex.test(dateString);
}

function deleteItem(path) {
    console.log(`Deleting item by: ${path}`);
    fetch(`${path}`, {
        method: 'DELETE'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`Error during deletion. Status: ${response.status}`);
        }
    })
    .then(data => {
            window.location.reload();
    })
    .catch(error => {
        console.error('Error:', error);
    });
}