import json
import sqlite3
import requests

API_URL = "https://openlibrary.org/search.json"
SEARCH_QUERY = "python"
BOOK_LIMIT = 10
DATABASE_NAME = "books.db"

def fetch_books():
    """Fetch book data from the Open Library API."""
    params = {
        "q": SEARCH_QUERY,
        "limit": BOOK_LIMIT
    }

    try:
        response = requests.get(API_URL, params=params, timeout=10)
        response.raise_for_status()
        data = response.json()

        return data.get("docs", [])

    except requests.RequestException as error:
        print("Could not retrieve book data:", error)
        return []
    except ValueError:
        print("The API returned an invalid JSON response.")
        return []


def parse_books(docs):
    """Extract the required fields from the API response."""
    
    books = []
    for book in docs:
        title = book.get("title", "Unknown")

        authors = book.get("author_name", [])
        author = ", ".join(authors) if authors else "Unknown"

        publication_year = book.get("first_publish_year")

        books.append(
            (title, author, publication_year)
        )

    return books


def init_db(connection):
    """Create the books table if it does not already exist."""
    cursor = connection.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            author TEXT NOT NULL,
            publication_year INTEGER,
            UNIQUE(title, author)
        )
    """)
    connection.commit()


def save_books(connection, books):
    """Save book records into the SQLite database."""
    cursor = connection.cursor()
    cursor.executemany("""
        INSERT OR IGNORE INTO books
        (title, author, publication_year)
        VALUES (?, ?, ?)
    """, books)
    connection.commit()


def display_books(connection):
    """Retrieve books from SQLite and display them as JSON."""
    cursor = connection.cursor()
    cursor.execute("""
        SELECT title, author, publication_year
        FROM books
    """)

    rows = cursor.fetchall()
    result = []
    for row in rows:
        result.append({
            "title": row[0],
            "author": row[1],
            "publication_year": row[2]
        })
    print(json.dumps(result, indent=4))


def main():
    docs = fetch_books()
    if not docs:
        print("No book data was retrieved.")
        return
    books = parse_books(docs)
    connection = None
    try:
        connection = sqlite3.connect(DATABASE_NAME)

        init_db(connection)
        save_books(connection, books)
        display_books(connection)

    except sqlite3.Error as error:
        print("Database error:", error)

    finally:
        if connection is not None:
            connection.close()

if __name__ == "__main__":
    main()