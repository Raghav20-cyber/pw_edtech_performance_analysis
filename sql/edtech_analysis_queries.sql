USE startersql;
DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    Student_id INT,
    Student_name VARCHAR(100),
    Age INT,
    City VARCHAR(100),
    Course_name VARCHAR(150),
    Instructor VARCHAR(100),
    Course_price INT,
    Enrollment_date DATE,
    Watch_hours DECIMAL(5,2),
    Completion_rate DECIMAL(5,2),
    Rating DECIMAL(3,2),
    Device VARCHAR(50),
    Payment_status VARCHAR(50)
);
DROP TABLE IF EXISTS Instructors;
CREATE TABLE Instructors (
    Instructor_ID INT PRIMARY KEY,
    Instructor_Name VARCHAR(100),
    Department VARCHAR(100),
    Experience_Years INT
);
INSERT INTO Instructors VALUES
(1,'Alakh Pandey','Physics',10),
(2,'Amit Gupta','Mathematics',7),
(3,'Anjali Sharma','Chemistry',6),
(4,'Prateek Maheshwari','Physics',8),
(5,'Rohit Mishra','Biology',5),
(6,'Vivek Singh','Mathematics',9);
DROP TABLE IF EXISTS Courses;
CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Category VARCHAR(100),
    Duration_Months INT
);
INSERT INTO Courses VALUES
(101,'Biology NEET Ultimate','Medical',6),
(102,'JEE Advanced Mechanics','Engineering',6),
(103,'Organic Chemistry Mastery','Medical',5),
(104,'Maththematics for JEE Mains','Engineering',6),
(105,'Physics Wallah Rank Booster','Engineering',4),
(106,'Class 10 Science Foundation','Science',4),
(107,'Class 12 Board Physics','Non-Medical',4),
(108,'NEET Physics Crash Course','Engineering',4);

-- How many total enrollments exist on the platform?
 SELECT COUNT(*) AS total_enrollments
 FROM Students;

-- What is the total revenue generated from paid enrollments?
 SELECT SUM(Course_price) AS total_revenue
 FROM Students
 WHERE Payment_status = 'Paid';

-- Which courses generate the most revenue?
SELECT Course_name, SUM(Course_price) AS revenue
FROM Students
WHERE Payment_status = 'Paid'
GROUP BY Course_name
ORDER BY revenue DESC;

-- Which cities have the highest number of enrollments?
SELECT City, COUNT(*) AS total_enrollments
FROM Students
WHERE City != 'Unknown'
GROUP BY City
ORDER BY total_enrollments DESC

-- Which courses have the lowest completion rate?
SELECT 
Course_name,
AVG(Completion_rate) AS Avg_Completion
FROM Students
GROUP BY Course_name
ORDER BY Avg_Completion ASC;

-- What percentage of enrollments were refunded?
SELECT COUNT(CASE WHEN Payment_status = 'Refunded' THEN 1 END) * 100.0 / COUNT(*) 
AS Refund_Percentage
FROM Students;

-- Which device is most commonly used by students?
SELECT Device, COUNT(*) AS Users
FROM Students
WHERE Device != 'Unknown'
GROUP BY Device
ORDER BY Users DESC
LIMIT 1;

-- How many students does each instructor teach?
SELECT i.Instructor_Name,
COUNT(s.Student_id) AS Total_Students
FROM Students s
JOIN Instructors i
ON s.Instructor = i.Instructor_Name
GROUP BY i.Instructor_Name
ORDER BY Total_Students DESC;

-- Which instructors receive the highest student ratings?
SELECT i.Instructor_Name,
AVG(s.Rating) AS Avg_Rating
FROM Students s
JOIN Instructors i
ON s.Instructor = i.Instructor_Name
GROUP BY i.Instructor_Name
ORDER BY Avg_Rating DESC;

-- Which course category has the most enrollments?
SELECT c.Category,
COUNT(s.Student_id) AS Enrollments
FROM Students s
JOIN Courses c
ON s.Course_name = c.Course_Name
GROUP BY c.Category
ORDER BY Enrollments DESC;

-- Which courses have the highest average watch hours?
SELECT c.Course_Name,
AVG(s.Watch_hours) AS avg_watch_hours
FROM Students s
JOIN Courses c
ON s.Course_name = c.Course_Name
GROUP BY c.Course_Name
ORDER BY avg_watch_hours DESC;

-- What is the distribution of Paid, Pending, and Refunded payments?
SELECT Payment_status,
COUNT(*) AS Total
FROM Students
GROUP BY Payment_status;







