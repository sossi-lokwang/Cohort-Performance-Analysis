USE arel;

SHOW TABLES;

-- 01_data_guality checks
-- Purpose: checks the underflying record before trusting any analysis built
-- on them

-- Attendance data guality checksum table
-- Enrollments per status - Unknown Records
SELECT status, COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY status;