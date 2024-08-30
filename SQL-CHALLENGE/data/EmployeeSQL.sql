-- Departments Table
CREATE TABLE departments (
    dept_no VARCHAR(4) PRIMARY KEY,
    dept_name VARCHAR(40) NOT NULL
);

-- Titles Table
CREATE TABLE titles (
    title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);
-- Employees Table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(10),
    birth_date DATE,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    sex CHAR(1),
    hire_date DATE,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Dept_Emp Table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(4),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Dept_Manager Table
CREATE TABLE dept_manager (
    dept_no VARCHAR(4),
    emp_no INT,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Salaries Table
CREATE TABLE salaries (
    emp_no INT,
    salary INT,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
FROM employees AS e 
JOIN salaries AS s 
ON e.emp_no = s.emp_no; 

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name,e.first_name
FROM departments AS d 
JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no
JOIN employees AS e 
ON dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM departments AS d 
JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no
JOIN employees AS e 
ON dm.emp_no = e.emp_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex 
FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';
--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

