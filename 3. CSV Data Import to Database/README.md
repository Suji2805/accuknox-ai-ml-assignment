# CSV Data Import to Database

## About

In this exercise, I used Python to read user details from a CSV file and store them in a SQLite database.

The CSV file contains the user's name and email address. Before inserting the data, the program checks whether the values are valid.

## Tools Used

* Python
* SQLite
* CSV

I used Python's built-in `csv` and `sqlite3` modules, so no external packages are needed.

## How the Program Works

The program does the following:

1. Reads the data from `users.csv`.
2. Checks if the CSV contains the required `name` and `email` columns.
3. Reads each user row from the CSV.
4. Checks for missing names or emails.
5. Performs a basic check on the email format.
6. Converts emails to lowercase before storing them.
7. Creates a SQLite database called `users.db`.
8. Creates a `users` table if it does not already exist.
9. Uses the email column as a unique value to avoid duplicate users.
10. Inserts the valid records into the database.
11. Displays the users stored in the database.
12. Prints a summary of inserted, invalid, and duplicate records.

## Email Validation

I used a simple email validation instead of a complex regular expression.

The program checks that:

* The email contains exactly one `@`.
* There is text before `@`.
* There is a domain after `@`.
* The domain contains a dot.
* The domain does not start or end with a dot.
* The email does not contain spaces.

This is only a basic validation and does not cover every possible email format.

I also convert emails to lowercase. This means `Bob@Example.com` and `bob@example.com` are treated as the same email.

## Database

The database is stored in:

`users.db`

The `users` table has three columns:

* `id` – primary key
* `name` – user name
* `email` – user email

I added a `UNIQUE` constraint to the email column because I used the email as the value that identifies a user.

I also used `INSERT OR IGNORE` so that if the same email is already present, it will not be inserted again.

## Invalid and Duplicate Rows

If a row has a missing name, missing email, or invalid email, the program skips it and prints the reason.

Duplicate emails are also skipped.

The program prints a summary like:

```text
Import summary:
Inserted: 6
Invalid/skipped: 3
Duplicates skipped: 1
```

The actual numbers depend on the CSV data being used.

## Testing

I created a test CSV containing different cases such as valid users, missing values, invalid emails, duplicate emails, emails with different capitalization, and a short row with fewer columns.

I also ran the program twice to check that the same users were not inserted again.

## CSV File

The main CSV file is:

`users.csv`

The expected columns are:

```text
name,email
```

The program also handles CSV files with a UTF-8 BOM, which can sometimes be added when a CSV file is saved using Excel.

If the CSV contains additional columns, they are ignored because this exercise only requires the name and email fields.

## How to Run

Keep these files in the same folder:

```text
users_csv.py
users.csv
```
Then run:

```bash
python users_csv.py
```

The `users.db` file will be created automatically.

## Files

* `users_csv.py` – Python program
* `users.csv` – CSV input file
* `users.db` – SQLite database
* `README.md` – Project information
