--Question 1: List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON e.emp_no = s.emp_no;

--Question 2: List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT e.first_name, e.last_name, e.hire_date
FROM employees as e
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31';

--Question 3: List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.

SELECT depmgr.emp_no, e.first_name, e.last_name, depmgr.dept_no, dept.dept_name
FROM dept_manager as depmgr
INNER JOIN employees as e ON depmgr.emp_no = e.emp_no
INNER JOIN departments as dept ON depmgr.dept_no = dept.dept_no;

--Question 4: List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name.

SELECT empdep.dept_no, empdep.emp_no, e.first_name, e.last_name, dept.dept_name
FROM dept_emp as empdep
INNER JOIN employees as e on empdep.emp_no = e.emp_no
INNER JOIN departments as dept on empdep.dept_no = dept.dept_no;

--QUestion 5: List first name, last name, and sex of each employee 
--whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND left(last_name,1) = 'B';

--Question 6: List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.first_name, e.last_name
FROM employees AS e
INNER JOIN dept_emp AS empdep on empdep.emp_no = e.emp_no
INNER JOIN departments AS dept on dept.dept_no = empdep.dept_no
WHERE dept.dept_name = 'Sales';

--Question 7: List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, dept.dept_name
FROM employees AS e
INNER JOIN dept_emp AS empdep ON empdep.emp_no = e.emp_no
INNER JOIN departments AS dept ON dept.dept_no = empdep.dept_no
WHERE dept.dept_name = 'Sales' OR dept.dept_name = 'Development';

--Question 8: List the frequency counts, in descending order, 
--of all the employee last names (that is, how many employees share each last name).

SELECT e.last_name, COUNT(e.last_name)
FROM employees as e
GROUP BY e.last_name
ORDER BY COUNT(e.last_name) DESC;