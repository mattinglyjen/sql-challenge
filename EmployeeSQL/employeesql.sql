
-- create all tables and dependencies: 
CREATE TABLE titles (
	title_id VARCHAR (10) PRIMARY KEY,
	title VARCHAR (20) NOT NULL);
SELECT *
FROM titles;

CREATE TABLE employees (
	emp VARCHAR (30) PRIMARY KEY,
	emp_title_id VARCHAR (30),
	birth_date VARCHAR(10),
	first_name VARCHAR(20), 
	last_name VARCHAR (20),
	sex VARCHAR (5),
	hire_date VARCHAR (10),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id));


CREATE TABLE salaries (
	emp_no VARCHAR (15) PRIMARY KEY,
	salary INT NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp));

SELECT * 
FROM salaries;

CREATE TABLE departments (
	dept_no VARCHAR (15) PRIMARY KEY,
	dept_name VARCHAR (30) NOT NULL );

SELECT * 
FROM departments;

CREATE TABLE dept_emp(
	emp_no VARCHAR (15),
	dept_no VARCHAR (15) NOT NULL, 
	FOREIGN KEY (emp_no) REFERENCES employees(emp),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no));
	
SELECT *
FROM dept_emp;

CREATE TABLE dept_manager (
	dept_no VARCHAR (15) NOT NULL,
	emp_no VARCHAR (15) PRIMARY KEY,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp));
	
SELECT *
FROM employees;

-- join tables
SELECT employees.emp, employees.last_name, employees.first_name, employees.sex, salary.salary
FROM employees
INNER JOIN salaries AS salary
	ON employees.emp = salary.emp_no;

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE hire_date
LIKE '%1986';

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager 
	ON dept_manager.dept_no = departments.dept_no
JOIN employees
	ON employees.emp = dept_manager.emp_no;
	
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
	ON dept_emp.emp_no = employees.emp
JOIN departments
	ON departments.dept_no = dept_emp.dept_no;
	
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE employees.first_name = 'Hercules' 
AND employees.last_name 
LIKE 'B%';

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN departments
	ON departments.dept_no = dept_emp.dept_no
JOIN employees
	ON employees.emp = dept_emp.emp_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

SELECT last_name, COUNT(last_name) AS unique_last_name
FROM employees
GROUP BY last_name
ORDER BY unique_last_name DESC;
