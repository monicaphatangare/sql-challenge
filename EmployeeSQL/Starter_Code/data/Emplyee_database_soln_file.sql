DROP TABLE employees
DROP TABLE departments
DROP TABLE dept_emp
DROP TABLE dept_manager
DROP TABLE salaries
DROP TABLE titles

CREATE TABLE departments(
dept_no varchar not null,
dept_name varchar(30) not null,
primary key(dept_no)
);

CREATE TABLE dept_emp(
emp_no int not null,
foreign key (emp_no) references employees(emp_no),
dept_no varchar not null,
foreign key (dept_no) references departments(dept_no),
primary key(emp_no, dept_no)
);

CREATE TABLE dept_manager(
dept_no varchar not null,
foreign key (dept_no) references departments(dept_no),
emp_no int not null,
foreign key (emp_no) references employees(emp_no),
primary key(dept_no, emp_no)
);

CREATE TABLE employees(
emp_no int primary key not null,
emp_title varchar(30) not null,
birth_date date not null,
first_name varchar(30) not null,
last_name varchar(30) not null,
sex varchar(30) not null,
hire_date date not null
);

CREATE TABLE salaries(
emp_no int not null,
salary int not null,
foreign key (emp_no) references employees(emp_no),
primary key(emp_no, salary)
);

CREATE TABLE titles(
title_id varchar not null,
title varchar(30) not null,
primary key(title_id)
);

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

--1.List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name,  e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

--2.List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date  BETWEEN '1986-01-01' AND '1986-12-31';

--3.List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.

SELECT dm.dept_no, dp.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN departments dp ON dm.dept_no = dp.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

--4.List the department number for each employee along with that 
--employee’s employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments dp ON de.dept_no = dp.dept_no;

--5.List first name, last name, and sex of each employee whose first name is Hercules 
--and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6.List each employee in the Sales department, including their 
--employee number, last name, and first name.

SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments dp ON de.dept_no = dp.dept_no
WHERE dp.dept_name = 'Sales';

--7.List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments dp ON de.dept_no = dp.dept_no
WHERE dp.dept_name IN ('Sales', 'Development'); 

--8.List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
