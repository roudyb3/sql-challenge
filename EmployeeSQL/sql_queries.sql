-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


-- add in the 6 documents
CREATE TABLE titles (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);

CREATE TABLE departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (
        emp_no, dept_no
     )
);

CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (
        dept_no, emp_no
     )
);

CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees ("emp_no");

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_no FOREIGN KEY(emp_no)
REFERENCES salaries (emp_no);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

SELECT * FROM employees;

-- Question 1
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM salaries
INNER JOIN employees 
ON employees.emp_no=salaries.emp_no;

-- Question 2
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN to_date('1986-01-01', 'YYYY-MM-DD')
				AND to_date ('1986-12-31', 'YYYY-MM-DD');
				
-- Question 3
SELECT employees.first_name, employees.last_name, employees.emp_no, dept_manager.dept_no
FROM employees
INNER JOIN dept_manager
ON dept_manager.emp_no = employees.emp_no

SELECT dept_manager.dept_no, departments.dept_name
FROM dept_manager
INNER JOIN departments
ON departments.dept_no = dept_manager.dept_no

-- Only run this, the two codes above were to get organized for this one below

SELECT employees.first_name, employees.last_name, employees.emp_no, dept_manager.dept_no, departments.dept_name
FROM employees INNER JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
			INNER JOIN departments ON departments.dept_no = dept_manager.dept_no;
			
-- Question 4
SELECT employees.first_name, employees.last_name, employees.emp_no, dept_emp.dept_no
FROM employees
INNER JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no

SELECT dept_emp.dept_no, departments.dept_name
FROM dept_emp
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no

-- only run the code below, the two above were just to get organized before putting it all together

SELECT departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM employees INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
			INNER JOIN departments on departments.dept_no = dept_emp.dept_no;
			
-- Question 5
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- Question 6
SELECT departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM employees INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
			INNER JOIN departments on departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Sales';

-- Question 7
SELECT departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM employees INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
			INNER JOIN departments on departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- Question 8 
SELECT last_name, COUNT (DISTINCT emp_no)
FROM employees
GROUP BY last_name;