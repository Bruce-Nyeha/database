# University Database Project (ITM111)

This repository contains my work from the ITM111 Introduction to Databases course.

### What I learned during the course

- Designed and built a full university database with 7 tables:
  - college
  - departments
  - course
  - faculty
  - section
  - students
  - enrollment (linking table for many-to-many)

- Understood relationships:
  - One-to-many (college to departments, department to course, etc.)
  - Many-to-many (students to sections via enrollment table)

- Learned normalization (1NF, 2NF, 3NF) and why 3NF is usually enough

- Mastered SQL:
  - SELECT, WHERE, JOINs (INNER, LEFT), GROUP BY, HAVING
  - Aggregates: COUNT, SUM, AVG
  - Date functions: DATEDIFF, DATE_FORMAT
  - INSERT, UPDATE, DELETE with correct order to avoid foreign key errors

- Fixed many common errors:
  - Unknown column (1054)
  - Foreign key constraint fails (1451/1452)
  - Safe update mode (1175)
  - GROUP BY issues with ONLY_FULL_GROUP_BY
  - Wrong insert order (parents before children)

- Used MySQL Workbench for:
  - Creating ER diagrams with crow's foot notation
  - Forward engineering to create tables
  - Reverse engineering existing databases

### Key project outcome
Built and populated a working university database.  
Wrote real queries like:
- Students born in September
- Age calculation as of specific date
- Students in a course
- Instructors for a student
- Total credits per student
- Number of courses per college

This project taught me how databases work in real applications and how to debug patiently.

Still learning, but now I feel confident with relational databases and SQL.

Thanks for looking at my work!
