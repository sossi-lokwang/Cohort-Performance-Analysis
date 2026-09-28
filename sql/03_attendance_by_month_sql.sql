USE arel;

SHOW TABLES;

-- 03_attendance-by_month_sql
-- Question:
-- Does attendance decline as the courses progress?

SELECT 
	DATE_FORMAT(session_date, '%Y-%m') AS MONTH,
    ROUND(
		100 * SUM(status IN ('prsenet', 'late')) / COUNT(*), 1) AS attendance_rate,
        COUNT(*) AS total_sessions
        FROM attendance
        WHERE status <> 'Not Record'
        GROUP BY month;
        
-- Attendance starts high at the beginning of the program
-- and declines as the courses progress.