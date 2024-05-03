DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE titles(
	title_id VARCHAR PRIMARY KEY NOT NULL,
	title VARCHAR
);

CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title VARCHAR,
	FOREIGN KEY (emp_title) REFERENCES titles(title_id),
	birth_date VARCHAR, 
	first_name VARCHAR(25),
	last_name VARCHAR(25),
	sex VARCHAR(1),
	hire_date VARCHAR
);

CREATE TABLE salaries(
	emp_no INT PRIMARY KEY NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT
);

CREATE TABLE departments(
	dept_no VARCHAR(10) PRIMARY KEY NOT NULL,
	dept_name VARCHAR
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT PRIMARY KEY NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

--This ALTER TABLE/ALTER COLUMN Query needs to be run after creating the employees table and importing the CSV
--I took this issue to professor Bharat - creating birth_date and hire_date as date would cause a failure at
--import data section. Also tried CAST() to convert as a date would not work - altering the table post-import was only way
--Trying to calculate the string/VARCHAR as a date (ie >'1986-01-01') would not work when it was formatted as a String
ALTER TABLE employees 
ALTER COLUMN birth_date TYPE DATE using to_date(birth_date, 'MM/DD/YYYY');

ALTER TABLE employees 
ALTER COLUMN hire_date TYPE DATE using to_date(hire_date, 'MM/DD/YYYY');

--This piece of the code must be run AFTER importing data to respective tables, otherwise it will fail trying to import
--data to this created column (does not exist in CSV). Cannot create a Primary Key on duplicates
--This query creates a new column and updates the value to be concatenation of other two columns
--Makes new concatenated column Primary Key as each is a unique value
ALTER TABLE dept_emp
ADD COLUMN emp_dept_no VARCHAR(30);

UPDATE dept_emp
SET emp_dept_no = CONCAT(emp_no, '', dept_no);

ALTER TABLE dept_emp
ADD PRIMARY KEY (emp_dept_no);