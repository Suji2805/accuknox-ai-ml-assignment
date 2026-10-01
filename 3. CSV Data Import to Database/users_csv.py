import csv
import sqlite3

CSV_FILE = "users.csv"
DATABASE_FILE = "users.db"

def create_database(connection):
    """Create the users table if it does not already exist."""
    cursor = connection.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE
        )
    """)
    connection.commit()


def is_valid_email(email):
    """Perform a basic email validation."""
    if " " in email:
        return False
    if email.count("@") != 1:
        return False
    local_part, domain = email.split("@", 1)

    if not local_part:
        return False
    if not domain:
        return False
    if "." not in domain:
        return False
    if domain.startswith(".") or domain.endswith("."):
        return False
    return True


def import_users(connection):
    """Read users from the CSV file and insert valid data into SQLite."""
    cursor = connection.cursor()
    inserted = 0
    invalid = 0
    duplicates = 0
    with open(
        CSV_FILE,
        "r",
        newline="",
        encoding="utf-8-sig"
    ) as file:
        reader = csv.DictReader(file)
        if reader.fieldnames:
            reader.fieldnames = [
                field.strip().lower()
                for field in reader.fieldnames
            ]
        required_columns = {"name", "email"}
        if not reader.fieldnames or not required_columns.issubset(
            set(reader.fieldnames)
        ):
            raise ValueError(
                "CSV must contain 'name' and 'email' columns."
            )

        for row in reader:
            row_number = reader.line_num
            name = (row.get("name") or "").strip()
            email = (row.get("email") or "").strip().lower()
            if not name:
                print(
                    f"Row {row_number} skipped: missing name."
                )
                invalid += 1
                continue

            if not email:
                print(
                    f"Row {row_number} skipped: missing email."
                )
                invalid += 1
                continue

            if not is_valid_email(email):
                print(
                    f"Row {row_number} skipped: invalid email."
                )
                invalid += 1
                continue
            cursor.execute(
                """
                INSERT OR IGNORE INTO users (name, email)
                VALUES (?, ?)
                """,
                (name, email)
            )
            if cursor.rowcount == 1:
                inserted += 1
            else:
                print(
                    f"Row {row_number} skipped: duplicate email."
                )
                duplicates += 1
    connection.commit()
    print("\nImport summary:")
    print("Inserted:", inserted)
    print("Invalid/skipped:", invalid)
    print("Duplicates skipped:", duplicates)
    return inserted

def display_users(connection):
    """Display the users currently stored in the database."""
    cursor = connection.cursor()

    cursor.execute("""
        SELECT id, name, email
        FROM users
    """)
    users = cursor.fetchall()
    print("\nUsers in database:")
    for user in users:
        print(user)

def main():
    """Run the CSV import process."""
    connection = None
    try:
        connection = sqlite3.connect(DATABASE_FILE)
        create_database(connection)
        inserted = import_users(connection)
        display_users(connection)
        if inserted > 0:
            print("\nImport finished successfully.")
        else:
            print("\nImport finished. No new users were inserted.")
    except (sqlite3.Error, OSError, ValueError) as error:
        print("Error:", error)
    finally:
        if connection is not None:
            connection.close()

if __name__ == "__main__":
    main()