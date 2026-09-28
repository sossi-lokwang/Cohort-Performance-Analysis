-- USE arel;



WITH att AS(
SELECT 
e. course_id,
e.cohort_id,
c.course_name,
ROUND(100.0 * SUM(a.status IN ('present', 
'late')) /
COUNT(*), 1) AS attendance_rate

FROM enrolments e
JOIN courses c USING(course_id)
JOIN attendance a USING(enrolment_id)
WHERE a.status != 'Not Recorded'
GROUP BY e.course_id, e.cohort_id,course_name
),
comp AS (
SELECT 
course_id,
cohort_id,
c.course_name,
ROUND(100-0 * SUM(e.status = 'completed') / COUNT( *), 1) AS completion_rate,
COUNT(*) AS enrolled
FROM enrolments e
JOIN courses c
USING(course_id)
GROUP BY course_id, cohort_id,  course_name
)
SELECT 
att.course_name,
att.cohort_id,
att.attendance_rate,
comp.completion_rate,
comp.enrolled
FROM att
JOIN comp USING(course_id, cohort_id)
ORDER BY att.attendance_rate ASC;
-- Result Data Analysis appear twice in the weakest five (cohort 4 and 
-- cohort 5), suggesting a course level partern rather than one bad cohort.alter.
-- complication rates for cohort 4, 5 read low across almost every row
-- have because of the unknown-status guality issue documented in 
-- 01_data_guality_checks.sql, not becuase those cohort genuinely performed
-- worse.