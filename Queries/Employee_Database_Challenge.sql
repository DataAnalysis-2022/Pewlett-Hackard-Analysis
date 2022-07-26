--Deliverable 1 The Number of Retiring Employees by Title
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
	
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no

-- export retirement_titles
COPY retirement_titles
TO 'D:\Data_Analysis_Visualization\Module-7\Pewlett-Hackard-Analysis\Data\retirement_titles.csv'
DELIMITER ','
CSV HEADER;

-- use DISTINCT ON to have latest title only
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name,  rt.title 

INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no ASC,
		 rt.title DESC;

-- export unique_titles
COPY unique_titles
TO 'D:\Data_Analysis_Visualization\Module-7\Pewlett-Hackard-Analysis\Data\unique_titles.csv'
DELIMITER ','
CSV HEADER;


-- to have count of unique retiring titles
SELECT  COUNT (ut.emp_no), ut.title

INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT (ut.emp_no) DESC;

-- export unique_titles
COPY retiring_titles
TO 'D:\Data_Analysis_Visualization\Module-7\Pewlett-Hackard-Analysis\Data\retiring_titles.csv'
DELIMITER ','
CSV HEADER;



--Deliverable 2: The Employees Eligible for the Mentorship
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    de.from_date,
    de.to_date,
	ti.title
	
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)

INNER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
	
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	
ORDER BY emp_no ASC

-- export mentorship_eligibilty
COPY mentorship_eligibilty
TO 'D:\Data_Analysis_Visualization\Module-7\Pewlett-Hackard-Analysis\Data\mentorship_eligibilty.csv'
DELIMITER ','
CSV HEADER;

--to find how many roles need to be filled
SELECT SUM(count)
FROM retiring_titles

--to find how many tmployees are eligible to mentorship program
SELECT COUNT(emp_no), title
FROM mentorship_eligibilty
GROUP BY title








