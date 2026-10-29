-- Əlavə tapşırıqlar
-- Hamısı universitet sxemi ilə yazılıb.


-- Exercise 3.26
-- Kursu ən azı 3 dəfə götürən tələbələr (yəni ən azı 2 dəfə təkrar).
SELECT DISTINCT course_id, ID
FROM takes
GROUP BY ID, course_id
HAVING COUNT(*) >= 3
ORDER BY course_id;


-- Exercise 3.27
-- Ən azı 3 fərqli kursu təkrar götürən tələbələr.
-- İçəridə hər tələbənin 2 və daha çox dəfə götürdüyü kurslar tapılır.
SELECT ID
FROM (
    SELECT ID, course_id
    FROM takes
    GROUP BY ID, course_id
    HAVING COUNT(*) >= 2
) AS retaken
GROUP BY ID
HAVING COUNT(*) >= 3;


-- Exercise 3.28
-- Öz departamentinin bütün kurslarını tədris edən müəllimlər, ada görə sıralı.
-- Departamentin kurslarından müəllimin dərs demədiyi kurs qalmamalıdır.
SELECT i.ID, i.name
FROM instructor i
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM course c
    WHERE c.dept_name = i.dept_name
    EXCEPT
    SELECT t.course_id
    FROM teaches t
    WHERE t.ID = i.ID
)
ORDER BY i.name;


-- Exercise 3.31
-- Dərs dediyi kurslarda heç vaxt A qiyməti verməyən müəllimlər.
-- Heç dərs deməyən müəllimlər də nəticəyə düşür.
SELECT ID, name
FROM instructor
WHERE ID NOT IN (
    SELECT te.ID
    FROM teaches te
    JOIN takes ta
      ON te.course_id = ta.course_id
     AND te.sec_id = ta.sec_id
     AND te.semester = ta.semester
     AND te.year = ta.year
    WHERE ta.grade = 'A'
);


-- Exercise 3.32
-- Əvvəlki sorğu, amma yalnız ən azı bir başqa (null olmayan) qiymət verən müəllimlər.
SELECT ID, name
FROM instructor
WHERE ID NOT IN (
    SELECT te.ID
    FROM teaches te
    JOIN takes ta
      ON te.course_id = ta.course_id
     AND te.sec_id = ta.sec_id
     AND te.semester = ta.semester
     AND te.year = ta.year
    WHERE ta.grade = 'A'
)
AND ID IN (
    SELECT te.ID
    FROM teaches te
    JOIN takes ta
      ON te.course_id = ta.course_id
     AND te.sec_id = ta.sec_id
     AND te.semester = ta.semester
     AND te.year = ta.year
    WHERE ta.grade IS NOT NULL
);


-- Exercise 3.33
-- Saat 12:00 və ya daha gec bitən bölməsi olan Comp. Sci. kursları.
SELECT DISTINCT c.course_id, c.title
FROM course c
JOIN section s ON c.course_id = s.course_id
JOIN time_slot ts ON s.time_slot_id = ts.time_slot_id
WHERE c.dept_name = 'Comp. Sci.'
  AND ts.end_hr >= 12;


-- Exercise 3.34
-- Hər bölmədəki tələbə sayı.
SELECT course_id, sec_id, year, semester, COUNT(*) AS num
FROM takes
GROUP BY course_id, sec_id, year, semester
ORDER BY course_id, sec_id;


-- Exercise 3.35
-- Ən çox tələbəsi olan bölmə və ya bölmələr.
WITH sec_count AS (
    SELECT course_id, sec_id, year, semester, COUNT(*) AS num
    FROM takes
    GROUP BY course_id, sec_id, year, semester
)
SELECT course_id, sec_id, year, semester, num
FROM sec_count
WHERE num = (SELECT MAX(num) FROM sec_count);
