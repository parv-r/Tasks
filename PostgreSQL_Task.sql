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
	orderId INT NOT NULL,
	purc_amt float(8), 
	order_date date,
	pid varchar(50) REFERENCES product(pid)
);

INSERT INTO category (cid, cname) VALUES
(100, 'Appliances'),
(200, 'Electronics'),
(300, 'Fashion'),
(400, 'Home');

INSERT INTO product (pid, pname, price, quantity, cid) VALUES
('E01','Oneplus 10 Pro', 64999, 1, 200),
('A51','IFB Microwave', 21500, 3, 100),
('F41','Nike Shoes', 2999, 6, 300),
('H91','Samsung Tv', 30368, 1, 400),
('E12','iPhone 12 Pro', 128099, 1, 200);

INSERT INTO orders (orderId, purc_amt, order_date, pid) VALUES
('111', 128500, '2022-01-14', 'E12'),
('222', 21500, '2022-02-13', 'A51'),
('333', 65000, '2022-01-12', 'E01'),
('444', 9000, '2022-02-11', 'F41'),
('555', 31000, '2022-01-10', 'H91'),
('666', 150000, '2022-02-09', 'E12');