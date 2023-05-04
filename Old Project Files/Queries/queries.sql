-- Active: 1666222897622@@127.0.0.1@5432@PH_EmployeeDB
SELECT first_name, last_name
from employees
where birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
where birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
where birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
where birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
where birth_date BETWEEN '1955-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' and '1988-12-31');

SELECT COUNT(first_name)
FROM employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' and '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' and '1988-12-31');

select * from retirement_info;

DROP TABLE retiremnt_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' and '1988-12-31');

select * from retirement_info;

SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
from departments
inner join dept_manager
on departments.dept_no = dept_manager.dept_no;

SELECT ret.emp_no,ret.first_name,ret.last_name,de.to_date
From retirement_info as ret
left join dept_emp as de
on ret.emp_no = de.emp_no;

select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT COUNT(ce.emp_no), de.dept_no
INTO current_emp_by_department
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * from current_emp_by_department;

select * from salaries
order by to_date DESC;

SELECT emp_no,
    first_name,
last_name,
    gender
--INTO emp_info
FROM employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' and '1988-12-31');

select * from emp_info;

SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
FROM employees as e
inner join  salaries as s
ON (e.emp_no = s.emp_no)
inner join dept_emp as de
on (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');

SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

SELECT ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
--INTO dept_info
FROM current_emp as ce
inner join dept_emp as de
on (ce.emp_no =de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no);

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
from emp_info as e
inner join dept_emp as de
on (e.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no)
WHERE dept_name = 'Sales';

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
from emp_info as e
inner join dept_emp as de
on (e.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no)
WHERE dept_name in ('Sales','Development');

