Create Schema Hounslow_Homelessness;

USE Hounslow_Homelessness;

SELECT * FROM homeless_assessment;

-- 1.) I dropped these three columns as they wouldn't be of use for future analysis.

ALTER TABLE homeless_assessment
DROP COLUMN `Publisher Label`,
DROP COLUMN `Publisher URI`,
DROP COLUMN DecisionCode
;

-- 2.) Here, I wanted to clean RegistrationDate and DecisionDate by first getting rid of all characters starting from "T" as the timestamp was not needed.

UPDATE homeless_assessment
SET RegistrationDate = SUBSTRING(RegistrationDate, 1, 10);


UPDATE homeless_assessment
SET DecisionDate = SUBSTRING(DecisionDate, 1, 10);


-- 3.) Had a look at the Nationality column and noticed there were a lot of "not rec". Decided to drop the column.

SELECT DISTINCT Nationality,COUNT(*)
FROM homeless_assessment
GROUP BY Nationality
;

SELECT COUNT(*)
FROM homeless_assessment
;

ALTER TABLE homeless_assessment
DROP COLUMN Nationality
;

-- 4.) Categorize the Ethnicity column. Decided to just get rid of the rows with no information provided.

SELECT DISTINCT Ethnicity
FROM homeless_assessment
;

SELECT COUNT(*),Ethnicity
FROM homeless_assessment
GROUP BY Ethnicity
;

DELETE FROM homeless_assessment
WHERE Ethnicity = 'No information provided'
;

-- Here, I corrected the spellings of some abbreviated ethnic categories.

UPDATE homeless_assessment
SET Ethnicity =
    CASE 
        WHEN Ethnicity = 'Mixed: White/Black Caribn' THEN 'Mixed: White/Black Caribbean'
        WHEN Ethnicity = 'Mixed: White/Black Africn' THEN 'Mixed: White/Black African'
        ELSE Ethnicity
    END
    ;



-- 5.) Categorize the Reason column. Wanted to look at the reasons that had the least count to see if I could possibly categorize them with some of the other reasons.

SELECT COUNT(*) AS count, Reason
FROM homeless_assessment
GROUP BY Reason
HAVING count <= 20
ORDER BY count
;

UPDATE homeless_assessment
SET Reason = 'Eviction'
WHERE Reason LIKE '%eviction%'
;

UPDATE homeless_assessment
SET Reason = 'Rent Arrears'
WHERE Reason LIKE '%rent arrears%'
;

UPDATE homeless_assessment
SET Reason = 'Racial'
WHERE Reason LIKE '%racial%'
;

UPDATE homeless_assessment
SET Reason = CONCAT(UPPER(SUBSTRING(Reason, 1, 1)), LOWER(SUBSTRING(Reason, 2)))
;
-- Wanted to capitalize the start of all rows.

DELETE FROM homeless_assessment
WHERE reason = 'other'
;

-- Got rid of 'other' rows just because the Reason column is very important as it affects how it correlates to the decisions made of being homeless or not homeless.

SELECT DISTINCT Reason
FROM homeless_assessment
;

-- Later realized that when connected to Power BI, the casing after some spaces and slashes weren't as visually appealing.
UPDATE homeless_assessment
SET Reason =
    CASE
        WHEN Reason = 'Eviction' THEN 'Eviction'
        WHEN Reason = 'Other harassment' THEN 'Other Harassment'
        WHEN Reason = 'End tied accommodation' THEN 'End Tied Accommodation'
        WHEN Reason = 'Emergency e.g. fire' THEN 'Emergency e.g. Fire'
        WHEN Reason = 'End ast not arrears' THEN 'End AST Not Arrears'
        WHEN Reason = 'Relationshp brkdwn not dv' THEN 'Relationshp Breakdown Not DV'
        WHEN Reason = 'Rent arrears' THEN 'Rent Arrears'
        WHEN Reason = 'End nass accommodation' THEN 'End Nass Accommodation'
        WHEN Reason = 'Leaving hospital' THEN 'Leaving Hospital'
        WHEN Reason = 'Sleeping rough' THEN 'Sleeping Rough'
        WHEN Reason = 'Dv - partner' THEN 'DV - Partner'
        WHEN Reason = 'Mortgage arrears' THEN 'Mortgage Arrears'
        WHEN Reason = 'Loss of rented - other' THEN 'Loss Of Rented - Other'
        WHEN Reason = 'Leaving prison' THEN 'Leaving Prison'
        WHEN Reason = 'Unsuitable, unfit proprty' THEN 'Unsuitable, Unfit Property'
        WHEN Reason = 'Returned from abroad' THEN 'Returned From Abroad'
        WHEN Reason = 'Changed immigration circs' THEN 'Changed Immigration Circs'
        WHEN Reason = 'Dv - assoc pers not partn' THEN 'DV - Assoc Pers Not Partner'
        WHEN Reason = 'Other violence' THEN 'Other Violence'
        WHEN Reason = 'Racial' THEN 'Racial'
        WHEN Reason = 'Left hostel/shelter' THEN 'Left Hostel/Shelter'
        WHEN Reason = 'Leaving care' THEN 'Leaving Care'
        WHEN Reason = 'Management transfer' THEN 'Management Transfer'
        WHEN Reason = 'Affordability' THEN 'Affordability'
        WHEN Reason = 'Leaving hm forces' THEN 'Leaving HM Forces'
        ELSE Reason
    END
    ;

-- 6.) Categorizing the Need column. Decided to leave it as it is and just capitalize the first letter.

SELECT DISTINCT Need, COUNT(*) AS Count
FROM homeless_assessment
GROUP BY Need
;

UPDATE homeless_assessment
SET Need = CONCAT(UPPER(SUBSTRING(Need, 1, 1)), LOWER(SUBSTRING(Need, 2)))
;

-- Again I  realized that when connected to Power BI, the casing after some spaces and slashes weren't as visually appealing.
UPDATE homeless_assessment
SET Need =
    CASE
        WHEN Need = 'Pregnant' THEN 'Pregnant'
        WHEN Need = 'Vulnerable - physical' THEN 'Vulnerable - Physical'
        WHEN Need = 'Dependent children' THEN 'Dependent Children'
        WHEN Need = 'Vulnerable - old age' THEN 'Vulnerable - Old Age'
        WHEN Need = 'Young person 16/17 yrs' THEN 'Young Person 16/17 yrs'
        WHEN Need = 'Vulnerable-mental illness' THEN 'Vulnerable - Mental Illness'
        WHEN Need = 'Vulnerable - other' THEN 'Vulnerable - Other'
        WHEN Need = 'Domestic violence/ threat' THEN 'Domestic Violence/ Threat'
        WHEN Need = 'Emergency-fire/flood etc' THEN 'Emergency - Fire/Flood etc.'
        WHEN Need = 'No priority need' THEN 'No Priority Need'
        WHEN Need = 'Care leaver under 21 yrs' THEN 'Care Leaver Under 21 yrs'
        WHEN Need = 'Former refugee/ex-asylum' THEN 'Former Refugee/Ex-Asylum'
        WHEN Need = 'Vulnerable-custody/remand' THEN 'Vulnerable - Custody/Remand'
        WHEN Need = 'Violence/harassmnt not dv' THEN 'Violence/Harassment Not DV'
        WHEN Need = 'Drug dependency' THEN 'Drug Dependency'
        WHEN Need = 'Alcohol dependency' THEN 'Alcohol Dependency'
        WHEN Need = 'Vulnerable - in care 21+' THEN 'Vulnerable - In Care 21+'
        WHEN Need = 'Vulnerable - hm forces' THEN 'Vulnerable - HM Forces'
        ELSE Need
    END
    ;



 -- 7.) Categorizing the Decision column.
 
 SELECT DISTINCT Decision, COUNT(*) AS Count
FROM homeless_assessment
GROUP BY Decision
;

UPDATE homeless_assessment
SET Decision = 
    CASE
        WHEN Decision IN ('Resettlement case', 'Approved permanent rehous', 'Management transfer', 'Elig asylum home off appt', 'Successful review/appeal') THEN 'Approved Housing/Successful Appeal'
        ELSE 'Not Deemed Homeless/Application Rejected'
    END
    ;
    
-- 8.) I specifically wanted to only look at data from registrations from 2005-2015. When I noticed there were some older ones, I wanted to get rid of those rows.

SELECT DISTINCT(YEAR(RegistrationDate))
FROM homeless_assessment
WHERE YEAR(RegistrationDate) < 2005
;

 DELETE FROM homeless_assessment
WHERE YEAR(RegistrationDate) < 2005
;

-- 9.) Here I found that there were rows where the Decision Date was earlier than the Registration Date, so I deleted them as it would affect my future analysis. Also got rid of rows where age was less than 0.

SELECT *, 
    DATEDIFF(DecisionDate, RegistrationDate) AS DaysDifference
FROM 
    homeless_assessment
    ;

-- Added the new column to the table.
ALTER TABLE homeless_assessment
ADD decision_wait_time INT
;

-- Updated the new column with the calculated difference in days.
UPDATE homeless_assessment
SET decision_wait_time = DATEDIFF(DecisionDate, RegistrationDate)
;

-- Deleted the rows with negative or 0 decison time.
DELETE FROM homeless_assessment
WHERE decision_wait_time < 0
;

-- 9.) I wanted to categorise the ages to gain insights into patterns or trends within different age groups more easily.
-- deleted ages less than 0
DELETE FROM homeless_assessment
WHERE Age <= 0
;

-- added an age category column to categorise the ages 
ALTER TABLE homeless_assessment
ADD COLUMN age_category VARCHAR(20)
;

UPDATE homeless_assessment
SET Age_Category =
    CASE
        WHEN age < 18 THEN 'Under 18s'
        WHEN age BETWEEN 18 AND 29 THEN '18-29'
        WHEN age BETWEEN 30 AND 44 THEN '30-44'
        WHEN age BETWEEN 45 AND 64 THEN '45-64'
        ELSE '65 and above'
    END
    ;





