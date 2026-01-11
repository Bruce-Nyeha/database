USE university_db;
USE university_db;

CREATE TABLE college (
    college_id INT AUTO_INCREMENT PRIMARY KEY,
    college_name VARCHAR(100) NOT NULL
);

CREATE TABLE department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    college_id INT,
    department_name VARCHAR(100),
    department_code VARCHAR(10),
    FOREIGN KEY (college_id) REFERENCES college(college_id)
);

CREATE TABLE course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
    course_num VARCHAR(10) NOT NULL,
    course_title VARCHAR(100),
    credits INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_fname VARCHAR(50),
    faculty_lname VARCHAR(50)
);

CREATE TABLE section (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    faculty_id INT,
    year INT,
    term VARCHAR(10),
    capacity INT,
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('M','F'),
    city VARCHAR(50),
    state VARCHAR(2),
    birthdate DATE
);

CREATE TABLE enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    section_id INT,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (section_id) REFERENCES section(section_id)
);

-- 1. Colleges
INSERT INTO college (college_name) VALUES
('College of Physical Science and Engineering'),
('College of Business and Communication'),
('College of Language and Letters');

-- 2. Departments
INSERT INTO department (college_id, department_name, department_code) VALUES
(1, 'Computer Information Technology', 'CIT'),
(2, 'Economics', 'ECON'),
(3, 'Humanities and Philosophy', 'HUM');

-- 3. Courses
INSERT INTO course (department_id, course_num, course_title, credits) VALUES
(1, 'ITM111', 'Intro to Databases', 3),
(2, 'ECON150', 'Micro Economics', 3),
(2, 'ECON388', 'Econometrics', 4),
(3, 'HUM376', 'Classical Heritage', 2);

-- 4. Faculty
INSERT INTO faculty (faculty_fname, faculty_lname) VALUES
('Marty','Morring'),('Nate','Norris'),('Ben','Barrus'),
('John','Jensen'),('Bill','Barney');

-- 5. Sections (with capacity!)
INSERT INTO section (course_id, faculty_id, year, term, capacity) VALUES
(1,1,2019,'Fall',30),(2,2,2019,'Fall',50),(2,2,2019,'Fall',50),
(3,3,2019,'Fall',35),(4,4,2019,'Fall',30),
(1,1,2018,'Winter',30),(1,5,2018,'Winter',35),
(2,2,2018,'Winter',50),(2,2,2018,'Winter',50),(4,4,2018,'Winter',30);

-- 6. Students
INSERT INTO student (first_name,last_name,gender,city,state,birthdate) VALUES
('Paul','Miller','M','Dallas','TX','1996-02-22'),
('Katie','Smith','F','Provo','UT','1995-07-22'),
('Kelly','Jones','F','Provo','UT','1998-06-22'),
('Devon','Merrill','M','Mesa','AZ','2000-07-22'),
('Mandy','Murdock','F','Topeka','KS','1996-11-22'),
('Alece','Adams','F','Rigby','ID','1997-05-22'),
('Bryce','Carlson','M','Bozeman','MT','1997-11-22'),
('Preston','Larsen','M','Decatur','TN','1996-09-22'),
('Julia','Madsen','F','Rexburg','ID','1998-09-22'),
('Susan','Sorensen','F','Mesa','AZ','1998-08-09');

-- 7. Enrollments
INSERT INTO enrollment (student_id, section_id) VALUES
(6,6),(7,6),(7,8),(7,10),(4,5),(9,9),(2,4),(3,4),(5,4),(5,5),(1,1),(1,2),(8,9),(10,6);


-- 1. Students born in September (formatted birthday), sorted by last name
SELECT first_name, last_name,
       DATE_FORMAT(birthdate, '%M %e, %Y') AS Birthday
FROM student
WHERE MONTH(birthdate) = 9
ORDER BY last_name;

-- 2. Student's age in years and days as of Jan 5, 2017 (365-day year)
SELECT first_name, last_name,
       FLOOR(DATEDIFF('2017-01-05', birthdate)/365) AS Years,
       DATEDIFF('2017-01-05', birthdate) % 365 AS Days,
       CONCAT(FLOOR(DATEDIFF('2017-01-05', birthdate)/365), ' years, ',
              DATEDIFF('2017-01-05', birthdate) % 365, ' days') AS "Age on Jan 5, 2017"
FROM student
ORDER BY DATEDIFF('2017-01-05', birthdate) DESC;

-- 3. Students taught by John Jensen, sorted by last name
SELECT DISTINCT s.first_name, s.last_name
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
WHERE f.faculty_fname = 'John' AND f.faculty_lname = 'Jensen'
ORDER BY s.last_name;

-- 4. Instructors Bryce Carlson will have in Winter 2018, sorted by last name
SELECT DISTINCT f.faculty_fname, f.faculty_lname
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
WHERE s.first_name = 'Bryce' AND s.last_name = 'Carlson'
  AND sec.year = 2018 AND sec.term = 'Winter'
ORDER BY f.faculty_lname;

-- 5. Students taking Econometrics in Fall 2019, sorted by last name
SELECT s.first_name, s.last_name
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN course c ON sec.course_id = c.course_id
WHERE c.course_title = 'Econometrics' AND sec.year = 2019 AND sec.term = 'Fall'
ORDER BY s.last_name;

-- 6. Total number of enrollments for Fall 2019
SELECT COUNT(*) AS "Total Enrollments Fall 2019"
FROM enrollment e
JOIN section sec ON e.section_id = sec.section_id
WHERE sec.year = 2019 AND sec.term = 'Fall';

-- 7. Number of courses in each college, sorted by college name
SELECT col.college_name AS College, COUNT(c.course_id) AS "Number of Courses"
FROM college col
LEFT JOIN department d ON col.college_id = d.college_id
LEFT JOIN course c ON d.department_id = c.department_id
GROUP BY col.college_id, col.college_name
ORDER BY col.college_name;

-- 8. Total teaching capacity for each professor in Winter 2018, sorted descending
SELECT f.faculty_fname AS "First Name", f.faculty_lname AS "Last Name",
       SUM(sec.capacity) AS "Total Teaching Capacity (Winter 2018)"
FROM faculty f
JOIN section sec ON f.faculty_id = sec.faculty_id
WHERE sec.year = 2018 AND sec.term = 'Winter'
GROUP BY f.faculty_id, f.faculty_fname, f.faculty_lname
ORDER BY SUM(sec.capacity) DESC;

-- 9. Each student's total credit load for Fall 2019 (>3 credits), descending
SELECT s.first_name, s.last_name, SUM(c.credits) AS "Total Credits (Fall 2019)"
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN course c ON sec.course_id = c.course_id
WHERE sec.year = 2019 AND sec.term = 'Fall'
GROUP BY s.student_id, s.first_name, s.last_name
HAVING SUM(c.credits) > 3
ORDER BY SUM(c.credits) DESC;

-- 10. How many females work in each department, sorted by department name
SELECT d.department_name AS Department, COUNT(*) AS "Number of Female Employees"
FROM department d
JOIN course c ON d.department_id = c.department_id
JOIN section sec ON c.course_id = sec.course_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
WHERE f.gender = 'F'   
GROUP BY d.department_name
ORDER BY d.department_name;