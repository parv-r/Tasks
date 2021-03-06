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

create table roles(
	roleId varchar(50) PRIMARY KEY,
	rolename varchar(100)
);

create table employees(
	empId varchar(50) PRIMARY KEY,
	emp_name varchar(100),
	date_of_joining date,
	roleId varchar(50) REFERENCES roles(roleId)
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

INSERT INTO roles (roleId, rolename) VALUES
('1037', 'Super Admin'),
('2048', 'Admin'),
('3056', 'Manager'),
('4096', 'Developer'),
('6020', 'Tester');

INSERT INTO employees (empId, emp_name, date_of_joining, roleId) VALUES
('IN01', 'Abhishek', '2019-01-21', '2048'),
('IN05', 'Aditya', '2019-03-26', '4096'),
('IN11', 'Devansh', '2018-09-24', '1037'),
('IN18', 'Harsh', '2020-04-16', '3056'),
('IN21', 'Prakhar', '2020-06-10', '6020'),
('IN45', 'Akansha', '2021-05-07', '2048');

create or replace view orderinfo as
select p.pid, p.pname, o.orderId, o.purc_amt, o.order_date
from product p inner join orders o
on p.pid = o.pid;

select * from orderinfo;

create or replace view empinfo as
select e.*, r.rolename
from roles r inner join employees e
on r.roleId = e.roleId;

select * from empinfo;

create or replace function fn_quant_chck()
returns trigger
language plpgsql
as $$
begin
if new.order_date <> old.order_date then
insert into prod_quan_audit(order_date, audit_date) values (old.order_date,now());
update product set quantity = quantity - 1 where pid = new.orderId;
end if;
return new;
end;
$$


create trigger trigger_quan_chck
after insert
on orders
for each row 
execute procedure fn_quant_chck(); 
