# Simple Library Management System (MySQL)

A simple, beginner-level **Library Management System** created using **MySQL**. This project is designed for college students learning Database Management Systems (DBMS) and SQL basics.

---

## 1. Project Overview

The objective of this project is to manage basic library operations using a relational database:
- Storing book details (title, author, category, available quantity).
- Storing student/member information (name, department, phone number).
- Recording book issue and return transactions.
- Checking book availability and viewing currently issued books.

---

## 2. Database Tables

The database consists of **3 main tables**:

### Table 1: `Books`
Stores catalog records of books in the library.
- `book_id` (INT, Primary Key, Auto Increment) - Unique ID for each book.
- `book_name` (VARCHAR) - Title of the book.
- `author` (VARCHAR) - Name of the author.
- `category` (VARCHAR) - Subject/category of the book.
- `quantity` (INT) - Total number of copies available.

### Table 2: `Members`
Stores records of registered students/library members.
- `member_id` (INT, Primary Key, Auto Increment) - Unique ID for each member.
- `member_name` (VARCHAR) - Full name of the student.
- `department` (VARCHAR) - Branch / Department of study.
- `phone` (VARCHAR) - Contact number.

### Table 3: `Issue_Records`
Associative table linking Books and Members to track loans.
- `issue_id` (INT, Primary Key, Auto Increment) - Unique ID for each issue record.
- `book_id` (INT, Foreign Key referencing `Books(book_id)`) - The issued book.
- `member_id` (INT, Foreign Key referencing `Members(member_id)`) - The student borrowing the book.
- `issue_date` (DATE) - Date the book was borrowed.
- `return_date` (DATE) - Date the book was returned (or NULL if currently issued).
- `status` (VARCHAR) - Status of the loan (`'Issued'` or `'Returned'`).

---

## 3. Database Relationships & ER Diagram

- **Books to Issue_Records:** One-to-Many (`1 : M`). A single book title can be issued multiple times across different records.
- **Members to Issue_Records:** One-to-Many (`1 : M`). A single student can borrow multiple books across different records.
- **Books to Members:** Many-to-Many (`M : N`) relationship resolved through the `Issue_Records` junction table.

![Entity Relationship Diagram](ER_Diagram.png)

---

## 4. Sample Data Summary

A total of **17 records** are included across the three tables:
- **6 Books:** Common engineering college textbooks (*Let Us C*, *Database System Concepts*, *Computer Networks*, etc.).
- **5 Members:** Indian engineering students across Computer Science, IT, Mechanical, and Electronics departments.
- **6 Issue Records:** Active (`'Issued'`) and completed (`'Returned'`) borrowing transactions.

---

## 5. SQL Queries Included

The project includes 10 basic, beginner-friendly SQL queries in `library_management.sql`:

1. **Display all books:** `SELECT * FROM Books;`
2. **Display all members:** `SELECT * FROM Members;`
3. **Find available books:** `SELECT * FROM Books WHERE quantity > 0;`
4. **Display issued books:** `SELECT * FROM Issue_Records WHERE status = 'Issued';`
5. **Find books issued by a particular member:** `JOIN` between `Books` and `Issue_Records` filtered by `member_id`.
6. **Count total books:** `SELECT COUNT(*) AS total_books FROM Books;`
7. **Count issued books:** `SELECT COUNT(*) AS total_issued FROM Issue_Records WHERE status = 'Issued';`
8. **Display books with their issue details using JOIN:** 3-table `INNER JOIN` combining `Issue_Records`, `Books`, and `Members`.
9. **Display members who have issued books:** `SELECT DISTINCT` with `JOIN` to see active borrowers.
10. **Update a book's return status:** `UPDATE Issue_Records SET return_date = '2024-03-20', status = 'Returned' WHERE issue_id = 2;`

---

## 6. How to Run the Project

### Option A: Using MySQL Command Line Client
1. Open terminal or command prompt.
2. Log in to MySQL:
   ```bash
   mysql -u root -p
   ```
3. Run the SQL script:
   ```sql
   source /path/to/library_management.sql;
   ```
   *(or copy and paste the contents of `library_management.sql` directly into the MySQL console)*.

### Option B: Using MySQL Workbench
1. Open **MySQL Workbench** and connect to your local MySQL server.
2. Click **File -> Open SQL Script...** and select `library_management.sql`.
3. Click the **Execute (Lightning Bolt ⚡)** icon to run all statements.
4. Refresh the **Schemas** sidebar to view `library_db` and its tables.

---

## 7. Project Screenshots

Screenshots showing actual MySQL terminal output are available in the `screenshots/` directory:

1. **`screenshots/01_database_tables.png`**: Database creation, `SHOW TABLES;`, and `DESCRIBE` schema for all 3 tables.
2. **`screenshots/02_sample_records.png`**: `SELECT *` output showing records inside `Books`, `Members`, and `Issue_Records`.
3. **`screenshots/03_join_query_output.png`**: Execution and tabular output of the 3-table SQL JOIN query, member query, and COUNT queries.
4. **`screenshots/04_er_diagram.png`**: Entity-Relationship (ER) diagram illustrating Primary Keys, Foreign Keys, and cardinalities.

---

## 8. Project File Structure

```
Library Management System/
│
├── library_management.sql      # Main MySQL script (schema, data, queries)
├── README.md                   # Project documentation & instructions
├── ER_Diagram.png              # Entity Relationship diagram
└── screenshots/                # Folder with actual output screenshots
    ├── 01_database_tables.png
    ├── 02_sample_records.png
    ├── 03_join_query_output.png
    └── 04_er_diagram.png
```
