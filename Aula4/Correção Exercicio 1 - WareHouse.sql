create database warehouse;

create table productLines(
	id bigint not null auto_increment,
    textDescription varchar(200) not null,
    htmlDescription varchar(200) not null,
    image varchar(1000),
    primary key(id)
);

insert into productLines 
(textDescription,htmlDescription,image) values
("Limpeza", "<h1>Limpeza</h1>", "http://google.com"),
("Frutas", "<h1>Frutas</h1>", "http://google.com");

select *from productLines;

create table products(
	id bigint not null auto_increment,
    name varchar(200) not null,
    productLineFK bigint not null,
    scale float,
    vendor varchar(200) not null,
    description varchar(200) not null,
    quantity float not null,
    price float not null,
    msrp float,
    primary key(id),
    foreign key(productLineFK) references productLines(id)
);

insert into products 
(name, productLineFK, scale, vendor, description, quantity, price, msrp) 
values
("Sabonete",1,1.2,"Dove","Lavanda",150,2.75,2);

select *from products;


create table office(
	id bigint not null auto_increment,
    city varchar(150) not null,
    phone varchar(15) not null,
    addressLine1 varchar(150) not null,
    addressLine2 varchar(150),
    state varchar(100) not null,
    country varchar(100) not null,
    postalCode varchar(100),
    primary key(id)
);

insert into office 
(city, phone, addressLine1,state,country) 
values
("Americana", "5548884455", "Rua Santo Antônio, 235", 
"SP", "Brasil");

select *from office;


create table employee(
	id bigint not null auto_increment,
    lastName varchar(100) not null,
    firstName varchar(100) not null,
    email varchar(150) not null,
    jobTitle varchar(150),
    officeFK bigint not null,
    primary key(id),
    foreign key(officeFK) references office(id)
);

insert into employee 
(lastName, firstName, email, jobTitle, officeFK)
values 
("Castanho", "Joana", "joana@castanho", "Promotora", 1);

select *from employee;

create table customers(
	id bigint not null auto_increment,
    name varchar(150) not null,
	contactLastName varchar(100) not null,
    contactFirstName varchar(100) not null,
    phone varchar(15) not null,
    addressLine1 varchar(150) not null,
    addressLine2 varchar(150),
    city varchar(150) not null,
	state varchar(100) not null,
    country varchar(100) not null,
    creditLimit float not null,
    employeeFK bigint not null,
    primary key(id),
    foreign key(employeeFK) references employee(id)
);

create table payments(
	id bigint not null auto_increment,
    customerFK bigint not null,
    paymentDate datetime not null default now(),
    amount float,
    primary key(id),
    foreign key(customerFK) references customers(id)
);

create table orders(
	id bigint not null auto_increment,
    orderDate datetime not null default now(),
    requiredDate datetime,
    shippedDate datetime,
    status varchar(1) not null default 'P',
    comments varchar(200),
    customerFk bigint not null,
    primary key(id),
    foreign key(customerFK) references customers(id)
);

create table orderDetails(
	id bigint not null auto_increment,
    orderFK bigint not null,
    productFK bigint not null,
    quantityOrdered float not null,
    price float not null,
    primary key(id),
    foreign key(orderFK) references orders(id),
    foreign key(productFK) references products(id)    
);



select *from customers c 
join employee e on c.employeeFK = e.id
join office o on o.id = e.officeFK
join payments p on p.customerFK = c.id
join orders od on od.customerFk = c.id
join orderdetails odt on odt.orderFK = od.id
join products pr on pr.id = odt.productFK
join productlines pl on pl.id = pr.productLineFK;

select *from orders od 
join orderdetails odt on odt.orderFK = od.id
join products pr on pr.id = odt.productFK
where pr.name = 'Sabonete';

select c.name, count(*) as total 
from customers c 
join orders od on od.customerFk = c.id
group by c.name
having total > 10
order by c.name asc;
	
    
    







