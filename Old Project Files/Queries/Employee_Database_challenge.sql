-- Active: 1666248580896@@localhost@5432@PH_EmployeeDB

-- Deliverable 1

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
-- INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
    ON (e.emp_no = t.emp_no)
    WHERE (e.birth_date BETWEEN '1952-01-01' and '1955-12-31');

SELECT DISTINCT ON (emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title

--INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT COUNT(emp_no), title
-- INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT((emp_no)) DESC;

-- Deliverable 2

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
-- INTO mentorship_ability
FROM employees as e
    INNER JOIN dept_emp as de
        ON (e.emp_no = de.emp_no)
            INNER JOIN titles as t
                ON (e.emp_no = t.emp_no)
WHERE de.to_date = '9999-01-01'
    AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

