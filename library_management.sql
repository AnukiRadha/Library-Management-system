-- ====================================================================
-- Project Name: Simple Library Management System
-- Level: Beginner / College Mini-Project (B.Tech DBMS Practical)
-- Database Engine: MySQL
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. DATABASE CREATION
-- --------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- --------------------------------------------------------------------
-- 2. TABLE CREATION WITH RELATIONSHIPS
-- --------------------------------------------------------------------

-- Table 1: Books
-- Stores information about books available in the library
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    quantity INT NOT NULL
);

-- Table 2: Members
-- Stores information about students/members registered in the library
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    phone VARCHAR(15)
);

-- Table 3: Issue_Records
-- Stores details of books issued to members (Junction Table for Many-to-Many relationship)
CREATE TABLE Issue_Records (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    issue_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- --------------------------------------------------------------------
-- 3. SAMPLE DATA INSERTION (17 Total Records)
-- --------------------------------------------------------------------

-- Insert 6 Records into Books table
INSERT INTO Books (book_id, book_name, author, category, quantity) VALUES
(101, 'Let Us C', 'Yashavant Kanetkar', 'Programming', 4),
(102, 'Database System Concepts', 'Korth', 'DBMS', 3),
(103, 'Computer Networks', 'Andrew Tanenbaum', 'Networking', 2),
(104, 'Operating System Principles', 'Galvin', 'Operating Systems', 3),
(105, 'Higher Engineering Mathematics', 'B.S. Grewal', 'Mathematics', 5),
(106, 'Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography', 2);

-- Insert 5 Records into Members table
INSERT INTO Members (member_id, member_name, department, phone) VALUES
(1, 'Rahul Sharma', 'Computer Science', '9876543210'),
(2, 'Priya Patel', 'Information Technology', '9876543211'),
(3, 'Amit Verma', 'Mechanical', '9876543212'),
(4, 'Sneha Reddy', 'Electronics', '9876543213'),
(5, 'Rohan Gupta', 'Computer Science', '9876543214');

-- Insert 6 Records into Issue_Records table
INSERT INTO Issue_Records (issue_id, book_id, member_id, issue_date, return_date, status) VALUES
(1, 101, 1, '2024-03-01', '2024-03-15', 'Returned'),
(2, 102, 2, '2024-03-05', NULL, 'Issued'),
(3, 103, 1, '2024-03-10', NULL, 'Issued'),
(4, 104, 3, '2024-03-12', '2024-03-25', 'Returned'),
(5, 105, 4, '2024-03-15', NULL, 'Issued'),
(6, 101, 5, '2024-03-18', NULL, 'Issued');

-- --------------------------------------------------------------------
-- 4. BASIC SQL QUERIES FOR PRACTICAL DEMONSTRATION
-- --------------------------------------------------------------------

-- Query 1: Display all books
-- Shows the complete list of books stored in the library
SELECT * FROM Books;

-- Query 2: Display all members
-- Shows the complete list of registered students/members
SELECT * FROM Members;

-- Query 3: Find available books
-- Checks which books currently have a quantity greater than zero
SELECT * FROM Books 
WHERE quantity > 0;

-- Query 4: Display issued books
-- Lists all issue records where the status is currently 'Issued'
SELECT * FROM Issue_Records 
WHERE status = 'Issued';

-- Query 5: Find books issued by a particular member (e.g., member_id = 1)
-- Joins Books and Issue_Records to see titles borrowed by student Rahul Sharma
SELECT Books.book_name, Issue_Records.issue_date, Issue_Records.status
FROM Issue_Records
JOIN Books ON Issue_Records.book_id = Books.book_id
WHERE Issue_Records.member_id = 1;

-- Query 6: Count total books
-- Calculates the total number of book titles present in the catalog
SELECT COUNT(*) AS total_books 
FROM Books;

-- Query 7: Count issued books
-- Counts how many book copies are currently out on loan
SELECT COUNT(*) AS total_issued 
FROM Issue_Records 
WHERE status = 'Issued';

-- Query 8: Display books with their issue details using JOIN
-- Combines Books, Members, and Issue_Records to show complete issue information
SELECT 
    Issue_Records.issue_id,
    Books.book_name,
    Members.member_name,
    Issue_Records.issue_date,
    Issue_Records.status
FROM Issue_Records
JOIN Books ON Issue_Records.book_id = Books.book_id
JOIN Members ON Issue_Records.member_id = Members.member_id;

-- Query 9: Display members who have issued books
-- Uses JOIN to find all distinct students who currently have borrowing history
SELECT DISTINCT 
    Members.member_id,
    Members.member_name,
    Members.department
FROM Members
JOIN Issue_Records ON Members.member_id = Issue_Records.member_id;

-- Query 10: Update a book's return status
-- Updates an issue record when a student returns the book (e.g., returning issue_id = 2)
UPDATE Issue_Records
SET return_date = '2024-03-20', status = 'Returned'
WHERE issue_id = 2;

-- Verify the update
SELECT * FROM Issue_Records WHERE issue_id = 2;

