CREATE TABLE student (
  id INT,
  name VARCHAR(50),
  marks INT 
);

INSERT INTO student VALUES
(1, 'Aman', 85),
(2, 'Dhruv' 78),
(3, 'Madhur' 92);

SELECT *  FROM students;
SELECT AVG(marks) FROM students;
