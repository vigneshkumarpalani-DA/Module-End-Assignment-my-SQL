-- 1. Create and Use Database
CREATE DATABASE IF NOT EXISTS elearning_db;
USE elearning_db;

-- 2. Create learners Table
CREATE TABLE learners (
    learner_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

-- 3. Create courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

-- 4. Create purchases Table (with Foreign Keys & Relationships)
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    learner_id INT NOT NULL,
    course_id INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    purchase_date DATE NOT NULL,
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);



-- 5. Insert Sample Data (5 Learners, 5 Courses, 7 Purchases)
INSERT INTO learners (full_name, Country) VALUES
('Vicky', 'India'),
('kathir', 'India'),
('jayashree', 'USA'),
('santhosh', 'India'),
('devi', 'UK');

INSERT INTO courses (course_id, course_name, category, unit_price) VALUES
(1, 'Industrial Robotics & Automation', 'Robotics', 4999.00),
(2, 'Fanuc Robot Programming Masterclass', 'Robotics', 3999.00),
(3, 'SQL for Data Analytics', 'Data Analytics', 2499.00),
(4, 'Power BI & DAX Complete Guide', 'Data Analytics', 3499.00),
(5, 'AI & Machine Learning Foundations', 'Data Science', 4499.00);


INSERT INTO courses (course_name, category, unit_price) 
VALUES ('Advanced Robotics Troubleshooting', 'Robotics', 5999.00);





-- Updated Purchases data mapped with new courses
INSERT INTO purchases (learner_id, course_id, Quantity, purchase_date) VALUES
(1, 1, 1, '2024-01-12'),
(1, 4, 1, '2024-01-20'),
(2, 2, 2, '2024-01-18'),
(3, 3, 1, '2024-02-05'),
(4, 5, 1, '2024-02-12'),
(5, 1, 1, '2024-03-10'),
(2, 3, 1, '2024-03-15');


-- data exploration--


SELECT 
    l.full_name AS learner_name,
    l.Country AS country,
    c.course_name AS course_name,
    c.category AS course_category,
    p.Quantity AS quantity,
    ROUND(p.Quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date AS purchase_date
FROM purchases p
INNER JOIN learners l ON p.learner_id = l.learner_id
INNER JOIN courses c ON p.course_id = c.course_id
ORDER BY total_amount DESC;


-- ANALYTICAL QUIRES--

 Q1. Display each learner’s total spending (quantity × unit_price) along with their country.

SELECT 
    l.full_name AS learner_name,
    l.Country AS country,
    ROUND(SUM(p.Quantity * c.unit_price), 2) AS total_spending
FROM learners l
JOIN purchases p ON l.learner_id = p.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.Country
ORDER BY total_spending DESC;

Q2. Find the top 3 most purchased courses based on total quantity sold.

SELECT 
    c.course_name AS course_name,
    c.category AS category,
    SUM(p.Quantity) AS total_quantity_sold
FROM courses c
JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.course_id, c.course_name, c.category
ORDER BY total_quantity_sold DESC
LIMIT 3;

Q3. Show each course category’s total revenue and the number of unique learners who purchased from that category.


SELECT 
    c.category AS course_category,
    ROUND(SUM(p.Quantity * c.unit_price), 2) AS total_revenue,
    COUNT(DISTINCT p.learner_id) AS unique_learners_count
FROM courses c
JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.category
ORDER BY total_revenue DESC;


Q4. List all learners who have purchased courses from more than one category.



SELECT 
    c.category AS course_category,
    ROUND(SUM(p.Quantity * c.unit_price), 2) AS total_revenue,
    COUNT(DISTINCT p.learner_id) AS unique_learners_count
FROM courses c
JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.category
ORDER BY total_revenue DESC;

Q5. Identify courses that have not been purchased at all.


SELECT 
    c.course_id AS course_id,
    c.course_name AS course_name,
    c.category AS category,
    c.unit_price AS unit_price
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;























