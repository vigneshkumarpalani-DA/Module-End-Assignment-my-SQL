🛠️ Database Architecture
The project utilizes a relational database named elearning_db built with 3 normalized tables:
erDiagram
    LEARNERS ||--o{ PURCHASES : places
    COURSES ||--o{ PURCHASES : bought_in

    LEARNERS {
        int learner_id PK
        string full_name
        string Country
    }
    COURSES {
        int course_id PK
        string course_name
        string category
        decimal unit_price
    }
    PURCHASES {
        int purchase_id PK
        int learner_id FK
        int course_id FK
        int Quantity
        date purchase_date
    }

Table Definitions
 * learners: Primary user demographic profiles (learner_id, full_name, Country).
 * courses: Course catalog with individual unit pricing (course_id, course_name, category, unit_price).
 * purchases: Transaction records linking learners and courses with quantities (purchase_id, learner_id, course_id, Quantity, purchase_date).
💻 Key SQL Implementations & Queries
| Question / Task | Focus Area | SQL Concepts Applied |
|---|---|---|
| Task 1: Setup | Schema & Data Entry | CREATE TABLE, FOREIGN KEY, ON DELETE CASCADE, INSERT INTO |
| Task 2: Joins | Multi-Table Exploration | INNER JOIN, LEFT JOIN, RIGHT JOIN |
| Q1: Total Spending | Learner Spending Analysis | SUM(Quantity * unit_price), ROUND(), GROUP BY, ORDER BY DESC |
| Q2: Top Courses | Best Selling Catalog | SUM(Quantity), GROUP BY, ORDER BY DESC, LIMIT 3 |
| Q3: Category Revenue | Domain Performance | SUM(), COUNT(DISTINCT learner_id), GROUP BY |
| Q4: Multi-Category | Cross-Domain Learners | COUNT(DISTINCT category), HAVING COUNT() > 1 |
| Q5: Audit | Unpurchased Courses | LEFT JOIN, WHERE purchases.purchase_id IS NULL |
💡 Key Analytical Insights & Recommendations
 * Top Revenue Drivers: Robotics (₹17,996.00) and Data Analytics are the highest revenue-generating domains.
 * Course Popularity: Technical modules such as Fanuc Robot Programming Masterclass and Industrial Robotics & Automation achieved maximum sales volume.
 * Learner Behavior: Active learners exhibit cross-disciplinary purchasing trends (combining automation with analytics).
 * Catalog Optimization: LEFT JOIN analysis identified unpurchased niche courses (e.g., Advanced Robotics Troubleshooting), signaling prime candidates for targeted promotional outreach.
🚀 How to Run the Project
 * Clone the repository:
   git clone [https://github.com/vigneshkumarpalani-DA/elearning-purchases-analysis.git](https://github.com/vigneshkumarpalani-DA/elearning-purchases-analysis.git)
cd elearning-purchases-analysis

 
