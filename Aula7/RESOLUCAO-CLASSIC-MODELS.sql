-- a)todos os employees que já venderam:
select count(*) as 'total employees' from (
select distinct e.employeeNumber from customers c
inner join employees e on e.employeeNumber = c.salesRepEmployeeNumber
order by e.employeeNumber) t;

-- b)numero cliente, nome cliente, total compras:
select c.customerNumber, c.customerName, count(*) as 'total compras'
from orders o
inner join customers c on c.customerNumber = o.customerNumber
group by c.customerNumber;

-- c) numero cliente, nome cliente, média de valor de compras:
select c.customerNumber, c.customerName, avg(p.amount) as 'média compras'
from payments p
inner join customers c on c.customerNumber = p.customerNumber
group by c.customerNumber;

-- d) cod. depto, endereco, totalFuncionarios:
select o.officeCode, o.addressLine1, count(*) as totalFuncionarios
from employees e 
inner join offices o on o.officeCode = e.officeCode
group by o.officeCode;

-- e) qtd de vendas por employee:
select e.employeeNumber, e.firstName, 
count(e.employeeNumber) as 'Qtd de Vendas'
from employees e
join customers c on c.salesRepEmployeeNumber = e.employeeNumber
join orders o on o.customerNumber = c.customerNumber
group by e.employeeNumber;

-- f) os 5 produtos mais vendidos:
select p.productCode, p.productName, 
sum(od.quantityOrdered) as 'total vendidos'
from products p
join orderdetails od on od.productCode = p.productCode
group by p.productCode
order by sum(od.quantityOrdered) desc limit 5;

-- g) subquery no from:
select textDescription from (
	select *from productlines
) t;

-- h) subquery no where:
select * from employees e where
e.employeeNumber in (
	select c.salesRepEmployeeNumber from customers c 
);

select count(*) from employees e where
e.employeeNumber in (
	select c.salesRepEmployeeNumber from customers c 
);












































 