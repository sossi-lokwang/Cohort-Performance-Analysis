-- 05_schedule_comparison.sql
--
-- Question:
-- Does the number of the training days per week affect attendance?
--
-- Cohorts 1 to 5 used a three-day week (MWF), while cohort 6
-- used a five_day week (MTMTF).

SELECT
	c.schedule,
    ROUND(100 * SUM(a.status IN ('present', 'Late')) / COUNT(*), 1
    ) AS attendance_rate,
    COUNT(*) AS sessions
    
    FROM attendance a
    JOIN enrolments e ON  a.enrolment_id = e.enrolment_id
    JOIN cohorts c ON e.cohort_id = c.cohort_id
    
    WHERE a.status <> 'Not Recorded'
    GROUP BY c.schedule;