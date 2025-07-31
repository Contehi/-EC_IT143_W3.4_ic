/*****************************************************************************************************************
NAME:    My Communities Analysis – College_Student_Placement
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
Question 1 (From other student):
What is the average CGPA of students who got placed?
----------------------------------------------------------- */
SELECT AVG(CGPA) AS Avg_CGPA_Placed
FROM college_student_placement_dataset
WHERE CAST(Placement AS VARCHAR) IN ('Yes', '1');


/* -----------------------------------------------------------
Question 2 (By Me):
How many students completed more than 3 projects?
----------------------------------------------------------- */
SELECT COUNT(*) AS Students_More_Than_3_Projects
FROM college_student_placement_dataset
WHERE Projects_Completed > 3;


/* -----------------------------------------------------------
Question 3 (By Me):
What is the average IQ of students with internships?
----------------------------------------------------------- */
SELECT AVG(IQ) AS Avg_IQ_Internship
FROM college_student_placement_dataset
WHERE CAST(Internship_Experience AS VARCHAR) IN ('Yes', '1');


/* -----------------------------------------------------------
Question 4 (By Me):
What percentage of students got placed vs not placed?
----------------------------------------------------------- */
SELECT 
    CASE 
        WHEN CAST(Placement AS VARCHAR) IN ('Yes', '1') THEN 'Placed'
        WHEN CAST(Placement AS VARCHAR) IN ('No', '0') THEN 'Not Placed'
        ELSE 'Unknown'
    END AS Placement_Status,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM college_student_placement_dataset) AS Percentage
FROM college_student_placement_dataset
GROUP BY 
    CASE 
        WHEN CAST(Placement AS VARCHAR) IN ('Yes', '1') THEN 'Placed'
        WHEN CAST(Placement AS VARCHAR) IN ('No', '0') THEN 'Not Placed'
        ELSE 'Unknown'
    END;
