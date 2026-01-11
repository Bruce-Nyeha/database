# My Database Learning Journey (ITM111)
This repo is about what I learned in ITM111 - Introduction to Databases at BYU-Pathway.

I started with almost no SQL knowledge. Now I can build full databases, fix errors, write good queries, and understand how data works behind apps.

### What I learned
- I built a complete university database with 7 tables: students, courses, sections, enrollment, faculty, departments, and colleges.
- I learned how to connect tables with JOINs (INNER, LEFT, RIGHT) and how to use bridge tables for many-to-many relationships.
- I learned normal forms (1NF, 2NF, 3NF) and why 3NF is usually enough for real projects.
- I wrote many queries: SELECT with WHERE, GROUP BY + HAVING, SUM, COUNT, AVG, DATE_FORMAT, DATEDIFF, and more.
- I fixed a lot of errors like 1054 (unknown column), 1451 (foreign key), 1175 (safe mode), and duplicate data problems.
- I learned the correct order of INSERTs: first parents (college → department → course → faculty → section), then children (student → enrollment).
- I learned how to make clean ER diagrams in MySQL Workbench and how to read crow's foot notation.

### My biggest win
I had many problems with errors and wrong results. I lost points on the final exam first time. But I asked for another chance, fixed my database schema, and got 100% on the retake. That felt really good.

### Why this is important for backend jobs
SQL is very important for backend developers. When you know SQL well, you can:
- Work fast with data
- Write good API endpoints
- Fix bugs quickly
- Understand the full system (frontend → backend → database)

### Next step
Now I want to learn Node.js + Express + SQL together to build real APIs.  
This project helped me a lot to be ready for junior backend roles.

Thanks for reading!  
Feel free to ask me anything about databases.

Bruce  
(December 2025)
