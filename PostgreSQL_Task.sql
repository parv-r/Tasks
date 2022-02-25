-- Database: E-Commerce

-- DROP DATABASE IF EXISTS "E-Commerce";

create table category(
	cid int PRIMARY KEY,
	cname varchar(255)
);

create table product(
	pid varchar(50) PRIMARY KEY,
	pname varchar(255),
	price float(8),
	quantity int,
	cid int REFERENCES category(cid)
);

create table orders(
	orderId int NOT NULL,
	purc_amt float(8), 
	order_date date,
	pid varchar(50) REFERENCES product(pid)
);

create table prod_quan_audit(
	pqid SERIAL PRIMARY KEY,
	order_date date,
	audit_date date
);

create table employees(
	empId varchar(50) PRIMARY KEY,
	emp_name varchar(100),
	date_of_joining date
);

create table roles(
	roleId varchar(50) PRIMARY KEY,
	rolename varchar(100),
	empId varchar(50) REFERENCES employees(empId)
);

create table emp_role_audit(
	erid SERIAL PRIMARY KEY,
	empId varchar(50) NOT NULL,
	emp_name varchar(100),
	rolename varchar(100) NOT NULL,
	date_modified date
);

INSERT INTO category (cid, cname) VALUES
(123, 'Appliances'),
(234, 'Electronics'),
(456, 'Fashion'),
(789, 'Home');

INSERT INTO product (pid, pname, price, quantity, cid) VALUES
('A01','IFB Microwave', 21500, 543, 123),
('E11','Oneplus 10 Pro', 64999, 100, 234),
('F21','Nike Shoes', 2999, 1250, 456),
('H31','Samsung Tv', 50899, 202, 789),
('A41','Bosch Washing Machine', 40500, 145, 123),
('E51','iPhone 13 Pro', 128099, 50, 234);

INSERT INTO orders (orderId, purc_amt, order_date, pid) VALUES
('149', 128500, '2022-01-14', 'E51'),
('832', 22000, '2022-02-13', 'A01'),
('472', 65000, '2022-01-12', 'E11'),
('218', 9000, '2022-02-11', 'F21'),
('523', 52000, '2022-01-10', 'H31'),
('692', 150000, '2022-02-09', 'E51'),
('719', 43000, '2022-01-07', 'A41');

INSERT INTO employees (empId, emp_name, date_of_joining) VALUES
('IN05', 'Aditya', '2019-03-26'),
('IN11', 'Devansh', '2018-09-24'),
('IN18', 'Harsh', '2020-04-16'),
('IN21', 'Prakhar', '2020-06-10'),
('IN45', 'Akansha', '2021-05-07');

INSERT INTO roles (roleId, rolename, empId) VALUES
('1037', 'Super Admin', 'IN05'),
('2048', 'Admin', 'IN21'),
('3056', 'Manager', 'IN11'),
('4096', 'Developer', 'IN18'),
('6020', 'Tester', 'IN45');

create or replace view orderinfo as
select p.pid, p.pname, o.orderId, o.purc_amt, o.order_date
from product p inner join orders o
on p.pid = o.pid;

select * from orderinfo;

create or replace view empinfo as
select e.*, r.rolename
from employees e inner join roles r
on e.empId = r.empId;

select * from empinfo;

create or replace function fn_quant_chck()
returns trigger
language plpgsql
as $$
begin
if new.order_date <> old.order_date then
insert into prod_quan_audit(order_date, audit_date) values (old.order_date,now());
update product set quantity = quantity - 1 where pid = new.pid;
end if;
return new;
end;
$$

create trigger trigger_quan_chck
before update
on orders
for each row 
execute procedure fn_quant_chck();

update orders set order_date = '2022-02-22' where pid = 'E11';

create or replace function fn_role_chng()
returns trigger
language plpgsql
as $$
begin
if new.rolename <> old.rolename then
insert into emp_role_audit(empId, emp_name, rolename, date_modified) values
(old.empId, old.emp_name, new.rolename, now());
update roles set rolename = new.rolename where roles.roleId = employees.roleId;
end if;
return new;
end;
$$

create trigger trigger_role_updt
before update
on employees
for each row 
execute procedure fn_role_chng(); 

update roles set rolename = 'Admin' where empId = 'IN21';