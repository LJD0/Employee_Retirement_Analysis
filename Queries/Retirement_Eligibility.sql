-- Active: 1683147920985@@127.0.0.1@5432@Employee_Retirement

-- Determine eligible retiring employees
-- Criteria will be age and time with the company

-- Create a table that summarizes the number of potential retirees

SELECT
    -- get employee count for each birth year 1952 to 1955
    (SELECT COUNT(*) FROM employees WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31') AS total_employees,
    (SELECT COUNT(*) FROM employees WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31') AS employees_1952,
    (SELECT COUNT(*) FROM employees WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31') AS employees_1953,
    (SELECT COUNT(*) FROM employees WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31') AS employees_1954,
    (SELECT COUNT(*) FROM employees WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31') AS employees_1955,
    -- get employee count that age and hire year meet requirements
    (SELECT COUNT(*) FROM employees WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')) AS eligible_employees;





-- Create a table to hold the eligible retirees
SELECT e.emp_no,
    de.dept_no,
    e.first_name,
    e.last_name,
    t.title,
    d.dept_name,
    s.salary
INTO Retirement_Eligible_Employees
FROM employees as e
INNER Join dept_employees as de -- inner join ensures that current departments are selected
on e.emp_no = de.emp_no
AND de.to_date = ('9999-01-01') -- selects only current employees' positions
left join departments as d
on de.dept_no = d.dept_no
left Join salaries as s
on e.emp_no = s.emp_no
left join titles as t
on e.emp_no = t.emp_no
AND t.to_date = ('9999-01-01') -- this selects only current titles
where (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')-- this selects our retirement eligibility
AND (e.hire_date BETWEEN '1985-01-01' and '1988-12-31')
;


-- Determine department retirement counts
SELECT dept_name, COUNT(*) AS count
INTO dept_retirement_count
FROM Retirement_Eligible_Employees
GROUP BY dept_name
ORDER BY count DESC;

-- Determine Title retirement counts 
SELECT title, COUNT(*) AS count
INTO title_retirement_count
FROM Retirement_Eligible_Employees
GROUP BY title
ORDER BY count DESC;


-- Create a table of eligible management
SELECT ree.dept_no,
    ree.dept_name,
    ree.emp_no,
    ree.first_name,
    ree.last_name,
    dm.from_date,
    dm.to_date,
    ree.salary
-- INTO Retiring_Management
FROM dept_manager AS dm
INNER JOIN Retirement_Eligible_Employees AS ree
ON dm.emp_no = ree.emp_no;


-- Create a Sales/Development table for mentorship program
SELECT ree.emp_no,
    ree.first_name,
    ree.last_name,
    ree.dept_name
INTO Mentorship_Eligible_Employees
From Retirement_Eligible_Employees as ree
WHERE dept_name in ('Sales','Development');


