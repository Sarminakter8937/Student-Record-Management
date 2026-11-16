-- ============================================================
-- Student Record Management System (MySQL script)
-- ============================================================
CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS department;

-- ---------- CREATE ----------
CREATE TABLE department (
  dept_id   INT AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE student (
  student_id VARCHAR(20) PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  email      VARCHAR(100),
  dept_id    INT NOT NULL,
  cgpa       DECIMAL(3,2) CHECK (cgpa BETWEEN 0 AND 4),
  year       INT,
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

-- ---------- INSERT ----------
INSERT INTO department (dept_name) VALUES
('Computer Science & Engineering'),('Electrical & Electronic Engineering'),
('Business Administration'),('English'),('Civil Engineering');

INSERT INTO student (student_id,name,email,dept_id,cgpa,year) VALUES
('2023-1-60-001','Arafat Rahman','arafat@example.edu',1,3.85,2023),
('2023-1-60-002','Nusrat Jahan','nusrat@example.edu',1,3.95,2023),
('2023-1-60-003','Imran Hossain','imran@example.edu',1,3.20,2023),
('2022-1-55-004','Tanvir Ahmed','tanvir@example.edu',2,2.85,2022),
('2024-1-55-005','Sadia Islam','sadia@example.edu',2,3.45,2024),
('2023-1-10-006','Sabrina Akter','sabrina@example.edu',3,3.60,2023),
('2021-1-10-007','Mahmud Hasan','mahmud@example.edu',3,3.10,2021),
('2024-1-30-008','Ayesha Siddika','ayesha@example.edu',4,3.50,2024),
('2022-1-30-009','Kamal Hossain','kamal@example.edu',4,2.40,2022),
('2023-1-40-010','Shamim Reza','shamim@example.edu',5,3.75,2023),
('2021-1-40-011','Mitu Rani','mitu@example.edu',5,3.35,2021),
('2024-1-60-012','Rafi Chowdhury','rafi@example.edu',1,3.55,2024);

-- ============================================================
-- KEY QUERIES
-- ============================================================
-- View all (JOIN)
SELECT s.student_id, s.name, s.email, d.dept_name, s.cgpa, s.year
FROM student s JOIN department d ON s.dept_id = d.dept_id;

-- Search by ID, name or department
SELECT s.*, d.dept_name FROM student s JOIN department d ON s.dept_id = d.dept_id
WHERE s.student_id LIKE '%Arafat%' OR s.name LIKE '%Arafat%' OR d.dept_name LIKE '%Arafat%';

-- Update
UPDATE student SET cgpa = 3.90, year = 2024 WHERE student_id = '2023-1-60-001';

-- Delete
DELETE FROM student WHERE student_id = '2024-1-60-012';

-- Summary (aggregate functions)
SELECT COUNT(*) AS total, AVG(cgpa) AS avg_cgpa, MAX(cgpa) AS max_cgpa, MIN(cgpa) AS min_cgpa FROM student;

-- Department-wise summary
SELECT d.dept_name, COUNT(s.student_id) AS total, AVG(s.cgpa) AS avg_cgpa
FROM department d LEFT JOIN student s ON s.dept_id = d.dept_id
GROUP BY d.dept_name;
