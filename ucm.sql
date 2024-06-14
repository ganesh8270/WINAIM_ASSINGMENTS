-- Exercise 3: University Course Management

-- Create tables for `students`, `courses`, `enrollments`, and `professors`.

-- `students` table should include: `student_id`, `first_name`, `last_name`, `enrollment_date`.
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    enrollment_date DATE
    );
    
-- `courses` table should include: `course_id`, `course_name`, `professor_id`.   
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

-- `enrollments` table should include: `enrollment_id`, `student_id`, `course_id`, `grade`.
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- `professors` table should include: `professor_id`, `first_name`, `last_name`, `department`.
CREATE TABLE professors (
    professor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);

-- Inserting sample values:
INSERT INTO students (student_id, first_name, last_name, enrollment_date) VALUES
(1, 'GANESH', 'R', '2023-03-18'),
(2, 'KARTHICK', 'THAIYARAJA', '2021-09-01'),
(3, 'AISHWARYA', 'R', '2020-03-23'),
(4, 'JAYANTH', 'VIGNESH', '2022-07-10'),
(5, 'SANJAY', 'SEKAR', '2021-04-09'),
(6,'MUKESH', 'V','2024-06-24'),
(7, 'SURYA', 'G', '2021-02-27');

INSERT INTO professors (professor_id, first_name, last_name, department) VALUES
(1, 'PRAKESH', 'RAJ', 'Computer Science'),
(2, 'VIGNESH', 'S', 'Mathematics'),
(3, 'Sarah', 'R', 'Database Management'),
(4, 'VINITHA', 'M', 'Engineering'),
(5, 'SARAN', 'RAJ', 'Computer Science'),
(6, 'KUMAR', 'C', 'Computer Science'),
(7, 'RAVI', 'VARMA', 'Placement Training');

INSERT INTO courses (course_id, course_name, professor_id) VALUES
(1, 'Introduction to Programming', 1),
(2, 'Data Structures', 5),
(3, 'Calculus I', 2),
(4, 'Algorithms', 1),
(5, 'Principles Of Programming', 5),
(6, 'Algebre', 2),
(7, 'Java Programming', 6),
(8, 'Ethics Of Engineering', 4),
(9, 'Database Systems', 3);

INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES
(1, 2, 9, 85.5),
(2, 1, 2, 90.0),
(3, 5, 7, 78.0),
(4, 1, 3, 88.5),
(5, 6, 1, 92.0),
(6, 3, 4, 85.0),
(7, 4, 6, 70.5),
(8, 5, 2, 75.0),
(9, 4, 5, 80.0);

-- 2. **SQL Queries**:
-- Write a query to find the total number of students enrolled in each course.
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_students
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name order by c.course_id;

-- Write a query to list the courses taught by professors in the 'Computer Science' department.
SELECT c.course_name ,p.department
FROM courses c
JOIN professors p ON c.professor_id = p.professor_id
WHERE p.department = 'Computer Science';

-- Write a query to calculate the average grade for each course.
SELECT c.course_id, c.course_name, round( AVG(e.grade),2) AS average_grade
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name
order by c.course_id;

-- Write a query to find students who are enrolled in more than three courses.
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS total_courses
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 3;








