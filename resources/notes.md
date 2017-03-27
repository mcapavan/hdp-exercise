#### Task 2 – Data Pipelines in Hive

1.	Install the MySQL Employees sample database (available from Employees DB on Launchpad) within Hive’s MySQL instance

wget https://launchpad.net/test-db/employees-db-1/1.0.6/+download/employees_db-full-1.0.6.tar.bz2

2.	Perform a full import of the ‘employees’ and ‘salaries’ tables into HDP
3.	Create Hive tables out of them using a suitable Storage Format
4.	Perform some cleansing using either Pig, Hive or other tool set
5.	The ‘to_date’ column overlaps with the ‘from_date’ column in the ‘salaries’ table.  This results in the employee having two salary records on the day of the ‘to_date’ column. Fix it by decrementing the ‘to_date’ column by one day (e.g. from ‘1987-06-18’ to ‘1987-06-17’) to make each salary record exclusive.
[ to_date -1 as new date]
6.	The first salary record for an employee should reflect the day they joined the company.  However, the ‘employees.hire_date’ column doesn’t always reflect this. Clean the data by replacing the ‘employees.hire_date’ column with the first salary record for an employee.
7.	Determine which employee lasted less than two weeks in the job in May 1985?


Sqoop Reference:
https://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.4.3/bk_dataintegration/content/using_sqoop_to_move_data_into_hive.html

