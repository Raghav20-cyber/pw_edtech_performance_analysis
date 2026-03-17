/*
EDTECH PERFORMANCE ANALYSIS (SQL)
Author: Raghav Sharma
Description: Business analysis queries for revenue,
students, courses, and performance
 */


-- 1. TOTAL REVENUE (From Paid Orders)

SELECT 
    SUM(Course_price) AS total_revenue
FROM Students
WHERE Payment_status = 'Paid';



-- 2. TOTAL ENROLLMENTS BY PAYMENT STATUS

SELECT 
    Payment_status,
    COUNT(*) AS total_students
FROM Students
GROUP BY Payment_status;



-- 3. REFUND PERCENTAGE

SELECT 
    ROUND(
        COUNT(CASE WHEN Payment_status = 'Refunded' THEN 1 END) * 100.0 
        / COUNT(*), 
    2) AS refund_percentage
FROM Students;



-- 4. REVENUE BY COURSE

SELECT 
    Course_name,
    SUM(Course_price) AS total_revenue
FROM Students
WHERE Payment_status = 'Paid'
GROUP BY Course_name
ORDER BY total_revenue DESC;



-- 5. TOP PERFORMING COURSES (BY ENROLLMENTS)

SELECT 
    Course_name,
    COUNT(*) AS total_enrollments
FROM Students
GROUP BY Course_name
ORDER BY total_enrollments DESC;



-- 6. COURSE-WISE REFUND RATE

SELECT 
    Course_name,
    ROUND(
        COUNT(CASE WHEN Payment_status = 'Refunded' THEN 1 END) * 100.0 
        / COUNT(*), 
    2) AS refund_rate
FROM Students
GROUP BY Course_name
ORDER BY refund_rate DESC;



-- 7. MONTHLY ENROLLMENT TREND

SELECT 
    MONTH(Enrollment_date) AS month,
    COUNT(*) AS total_enrollments
FROM Students
GROUP BY MONTH(Enrollment_date)
ORDER BY month;



-- 8. STUDENT DISTRIBUTION BY AGE

SELECT 
    age,
    COUNT(*) AS Student_count
FROM Students
GROUP BY Age
ORDER BY Age;



-- 9. STUDENT DISTRIBUTION BY CITY

SELECT 
    City,
    COUNT(*) AS total_students
FROM Students
GROUP BY City
ORDER BY total_students DESC;



-- 10. INSTRUCTOR PERFORMANCE (STUDENTS HANDLED)

SELECT 
    Instructor,
    COUNT(*) AS total_students
FROM Students
GROUP BY Instructor
ORDER BY total_students DESC;



-- 11. COURSE COMPLETION ANALYSIS

SELECT 
    Course_name,
    AVG(Completion_rate) AS avg_completion_rate
FROM Students
GROUP BY Course_name
ORDER BY avg_completion_rate DESC;



-- 12. DEVICE USAGE ANALYSIS

SELECT 
    Device,
    COUNT(*) AS total_users
FROM Students
GROUP BY Device
ORDER BY total_users DESC;



-- 13. REVENUE PER STUDENT 

SELECT 
    ROUND(SUM(Course_price) * 1.0 / COUNT(*), 2) AS revenue_per_student
FROM Students
WHERE Payment_status = 'Paid';



-- 14. TOP 5 CITIES BY REVENUE

SELECT 
    City,
    SUM(Course_price) AS revenue
FROM Students
WHERE Payment_status = 'Paid'
GROUP BY City
ORDER BY revenue DESC
LIMIT 5;



-- 15. HIGH RISK COURSES (HIGH REFUND + LOW COMPLETION)

SELECT 
    Course_name,
    ROUND(
        COUNT(CASE WHEN Payment_status = 'Refunded' THEN 1 END) * 100.0 
        / COUNT(*), 2
    ) AS refund_rate,
    AVG(Completion_rate) AS avg_completion
FROM Students
GROUP BY Course_name
HAVING refund_rate > 30 AND avg_completion < 60
ORDER BY refund_rate DESC;