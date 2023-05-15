create database company_ex2;
use company_ex2;

create table jobs(
	id bigint not null auto_increment,
    name varchar(150) not null,
    primary key(id)
);


insert into jobs(name) 
values 
("Dev Frontend Pl"), ("Dev Frontend Sr"),
("Dev Backend Jr"), ("Dev Backend Pl"), 
("Dev Backend Sr");

select *from jobs;


create table employees(
	id bigint not null auto_increment,
    birthDate date not null,
    cpf varchar(11) not null,
    name varchar(150) not null,
    gender enum('M','F') not null,
    hiredDate date not null,
    primary key(id)
);

insert into employees (birthDate, cpf, name, gender, hiredDate) 
values 
("2000-01-01", "1234567889", "Joãozinho", "M", "2019-01-02"),
("1995-02-01", "1234233889", "Maria", "F", "2018-02-02"),
("2001-04-01", "1234233889", "Larissa", "F", "2018-12-02"),
("2002-03-01", "1234233855", "Matheus", "M", "2022-12-02");

select *from employees;

insert into employees (birthDate, cpf, name, gender, hiredDate) 
values 
("2000-01-01", "1234567889", "Marcelo", "M", "2019-01-02");

create table job_employee(
	id bigint not null auto_increment,
    employeeFK bigint not null,
    jobFK bigint not null,
    startDate date not null,
    endDate date,
	primary key(id),
    foreign key(employeeFK) references employees(id),
    foreign key(jobFK) references jobs(id)
);
insert into job_employee (employeeFK, jobFK, 
startDate, endDate)
values 
(1, 1, "2020-01-01", null),
(2, 1, "2021-01-01", "2022-02-02"),
(2, 2, "2022-02-03", null),
(3, 2, "2002-02-03", "2012-01-01"),
(3, 3, "2012-01-02", null);

select *from job_employee;

create table salary(
	id bigint not null auto_increment,
    employeeFK bigint not null,
    amount float not null,
    startDate date not null,
    endDate date,
    primary key(id),
    foreign key(employeeFK) references employees(id)
);

insert into salary (employeeFK, amount, startDate, endDate)
values 
(1, 2500, "2022-01-01", "2022-05-05"),
(1, 2900, "2022-05-06", null),
(2, 9000, "2002-05-06", null),
(3, 4500, "2020-01-01", null),
(4, 10500, "2023-01-01", null);

insert into salary (employeeFK, amount, startDate, endDate)
values 
(2, 15500, "2023-01-01", null);

select *from salary;

create table departments(
	id bigint not null auto_increment,
    name varchar(150) not null,
    primary key(id)
);

insert into departments (name) 
values ("Suporte"), ("Desenvolv. Web"), 
("Desenvolv. Mobile");

select *from departments;

create table department_employee(
	id bigint not null auto_increment,
    departmentFK bigint not null,
    employeeFK bigint not null,
    startDate date not null,
    endDate date,
	primary key(id),
    foreign key(departmentFK) references departments(id),
    foreign key(employeeFK) references employees(id)
);

insert into department_employee 
(departmentFK, employeeFK, startDate, endDate)
values (1, 1, '2022-01-01', null),
(1, 2, '2002-01-01', '2021-01-01'),
(1, 2, '2021-01-02', null),
(1, 3, '2020-01-01', null);

insert into department_employee 
(departmentFK, employeeFK, startDate, endDate)
values (2, 1, '2015-01-01', '2021-12-31');

select *from department_employee;

create table managers(
	id bigint not null auto_increment,
    employeeFK bigint not null,
    departmentFK bigint not null,
    startDate date not null,
    endDate date,
    primary key(id),
    foreign key(employeeFK) references employees(id),
    foreign key(departmentFK) references departments(id)
);

insert into managers (employeeFK, departmentFK, 
startDate, endDate) 
values(5,2,'2015-01-01',null);

select *from managers;



select *from employees e 
join salary s on e.id = s.employeeFK
where s.amount > 5000;



select * from employees e 
join salary s on e.id = s.employeeFK;

select max(amount) from salary;

select * from employees e 
join salary s on e.id = s.employeeFK
where s.amount in (
	select max(amount) from salary
);

select * from employees e 
join salary s on e.id = s.employeeFK;


select *from employees e 
join department_employee de on de.employeeFK = e.id
join departments d on d.id = de.departmentFK
join managers m on m.departmentFK = d.id
where m.employeeFK = 4;


select *from job_employee je
join employees e on e.id = je.employeeFK
join jobs j on j.id = je.jobFK
where e.name = "Maria";

select *from managers m
join departments d on d.id = m.departmentFK
where d.name = "Suporte";


select amount from salary group by amount;












