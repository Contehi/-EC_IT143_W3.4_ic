/*****************************************************************************************************************
NAME:    My Communities Analysis – Student_Study_Habits
PURPOSE: My script purpose...Answer My Communities data set questions into SQL statements?

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     07/31/2025   IJConteh       1. Built this script for EC IT143


RUNTIME: 
Xs

NOTES: 
finding answers to my questions and that of other students about My Communities data sets.
 
******************************************************************************************************************/



/* -----------------------------------------------------------
Question 1 (From other Student):
What is the average final grade of students with internet access?
----------------------------------------------------------- */
SELECT AVG(final_grade) AS Avg_Final_Grade_Internet
FROM StudentStudyHabits
WHERE CAST(internet_access_Yes AS VARCHAR) IN ('Yes', '1');


/* -----------------------------------------------------------
Question 2 (By Me):
How many students have attendance above 80% and final grade above 70?
----------------------------------------------------------- */
SELECT COUNT(*) AS High_Performance_Students
FROM studentStudyHabits
WHERE attendance_percentage > 0.80 
  AND final_grade > 70;


/* -----------------------------------------------------------
Question 3 (By Me):
What is the average study hours of students with extracurricular activities?
----------------------------------------------------------- */
SELECT AVG(study_hours_per_week) AS Avg_Study_Hours_Extracurricular
FROM StudentStudyHabits
WHERE CAST(extracurricular_Yes AS VARCHAR) IN ('Yes', '1');


/* -----------------------------------------------------------
Question 4 (By Me):
Does participation level (Low/Medium) affect final grades?
----------------------------------------------------------- */
SELECT 
    CASE 
        WHEN participation_level_Low = 1 THEN 'Low'
        WHEN participation_level_Medium = 1 THEN 'Medium'
        ELSE 'High'
    END AS Participation_Level,
    AVG(final_grade) AS Avg_Final_Grade
FROM studentStudyHabits
GROUP BY 
    CASE 
        WHEN participation_level_Low = 1 THEN 'Low'
        WHEN participation_level_Medium = 1 THEN 'Medium'
        ELSE 'High'
    END;
