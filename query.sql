CREATE DATABASE HR_Analysis;
USE HR_Analysis;

# CREATE JOIN
SELECT * FROM absenteeism_at_work a
LEFT JOIN compensation b
ON a.ID = b.ID
LEFT JOIN reasons r
ON a.`Reason for absence` = r.Number;

# find healthiest employees for the bonus
SELECT * FROM absenteeism_at_work a
WHERE a.`Body mass index` < 25 and `Social smoker` = 0 and `Social drinker` = 0
AND `Absenteeism time in hours` < (SELECT AVG(`Absenteeism time in hours`) FROM absenteeism_at_work);

# compensation rate increase for non_smokers / budget $983.221 so .68 increase per hour / 1,414.4 per year
SELECT COUNT(*) AS nonsmokers FROM absenteeism_at_work
WHERE `Social smoker` = 0;

# optimize query

SELECT a.ID,
       r.Reason,
       a.`Month of absence`,
       a.`Body mass index`,
CASE WHEN a.`Body mass index` < 18.5 THEN 'Underweight'
     WHEN a.`Body mass index` BETWEEN  18.5 AND 25  THEN 'Healthy weight'
     WHEN a.`Body mass index` BETWEEN  25 AND 30  THEN 'Overweight'
     ELSE 'Obese' END AS  BMI_Category,
CASE WHEN a.`Month of absence` IN (12,1,2) THEN 'Winter'
     WHEN a.`Month of absence` IN (3,4,5) THEN 'Spring'
     WHEN a.`Month of absence` IN (6,7,8) THEN 'Summer'
     WHEN a.`Month of absence` IN (9,10,11) THEN 'Fall'
     ELSE 'Unknown' END AS season_names,
Seasons,
`Day of the week`,
`Transportation expense`,
`Social smoker`,
`Social drinker`,
Pet,
Education,
Son,
`Disciplinary failure`,
Age,`Work load Average day`,
`Absenteeism time in hours`
FROM absenteeism_at_work a
LEFT JOIN compensation b
ON a.ID = b.ID
LEFT JOIN reasons r
ON a.`Reason for absence` = r.Number;