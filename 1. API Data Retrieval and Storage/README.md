# Exercise 1 - API Data Retrieval and Storage

## Project Description

This project is created using Python. The main purpose of this project is to get book information from an external REST API, store the required information in a SQLite database, and display the stored data in JSON format.For this project, I used the Open Library Search API.

## API Used
Open Library Search API
The API is used to search for books related to Python.
The project retrieves the following information for each book:
        * Book title
        * Author name
        * Publication year

## Technologies Used

* Python
* Requests
* SQLite
* JSON
* REST API

## How the Project Works

The Python program first sends a request to the Open Library API.After receiving the response, it extracts the book information from the API response. I selected the title, author, and first publication year because these are the required fields for the assignment.

The extracted information is then stored in a SQLite database called `books.db`.Finally, the program reads the data from the database and displays it in JSON format.

## Database

The project uses SQLite because it is simple to use with Python and does not require a separate database server.
The database contains a `books` table with the following columns:

* `id`
* `title`
* `author`
* `publication_year`
Duplicate records with the same title and author are ignored when the program is run again.

## Error Handling

The program includes basic error handling for problems such as:

* API request failure
* Invalid JSON response
* SQLite database errors
* Missing information from the API response

If some information is not available from the API, the program handles it without stopping the complete execution.

## Assumptions

* The search term used in the API is `python`.
* The program retrieves up to 10 books.
* The Open Library API does not require authentication for this request.
* The required book fields are title, author, and publication year.
* If the author or title is missing, it is handled as `Unknown`.
* Duplicate books are not inserted into the database.

## How to Run
First, install the required Python package:

```bash
pip install -r requirements.txt
```
Then run the Python program:

```bash
python book_api.py
```
The program will retrieve the book data, store it in `books.db`, and display the stored records in JSON format.

## Project Files

```text
API Data Retrieval and Storage/
│
├── book_api.py
├── requirements.txt
├── README.md
└── books.db
```

## Result

The final output contains the book title, author, and publication year in JSON format after the data has been stored and retrieved from the SQLite database.
