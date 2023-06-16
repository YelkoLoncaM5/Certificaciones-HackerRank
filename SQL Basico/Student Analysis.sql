-- SOLUCIÓN EN SQL SERVER
SELECT s.roll_number, s.name
FROM student_information AS s
    INNER JOIN examination_marks AS e
    ON s.roll_number = e.roll_number
WHERE (e.subject_one+e.subject_two+e.subject_three) < 100 