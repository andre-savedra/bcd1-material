use exercicio_licensas;

-- a) clientes cadastrados:
select count(*) from lcliente;
select count(idCliente) from lcliente;

-- b) aquisições no mes q nasceu:
select *from llicenca where month(DtAquisicao) = 6;

-- c) aquisições no mes 5 e ano 2007:
select *from llicenca where month(DtAquisicao) = 5 
and year(DtAquisicao) =  2007;

-- d) tipo de empresa: identif. + descricao + 5letras da descricao:
select idTIPO_Empresa as identificacao, DescricaoTipo as descricao,  
left(DescricaoTipo,5) as '5 primeiras letras' from ltipo_empresa order by
DescricaoTipo asc;

select substr(DescricaoTipo,1,5) as '5 primeiras letras', tm.* from ltipo_empresa tm order by
DescricaoTipo asc;


-- e) tipo de empresa: identif. + descricao + 5 ultimas letras da descricao:
select idTIPO_Empresa as identificacao, DescricaoTipo as descricao,  
right(DescricaoTipo,5) as '5 ultimas letras' from ltipo_empresa order by
DescricaoTipo desc;

-- f) tipo de empresa: identif. + descricao + letras 6ª à 10ª da descricao:
select idTIPO_Empresa as identificacao, DescricaoTipo as descricao,
substr(DescricaoTipo,6,5) as 'letras 6ª-10ª' from ltipo_empresa;


-- g) clientes e qtd de caracteres do nome, ordenado por nome
select Nome_RazaoSocial, length(Nome_RazaoSocial) as 'Qtd caracteres'
from lcliente order by Nome_RazaoSocial asc;

-- h) numero da licença, dt aquisicao, dias até data atual:
select NumLicenca as 'licença', DtAquisicao as 'data', 
datediff(now(), DtAquisicao) as 'dias_atras' from llicenca;

-- i) nome setor letra maiuscula, nome setor letra minuscula:
select upper(NomeSetor), lower(NomeSetor) from lsetor;

-- j) sw's + versoes, ordem por nome e versao
select ls.idSOFTWARE, ls.NomeSoftware, lv.Versao
from lsoftware as ls join 
lversao lv on lv.idSOFTWARE_FK = ls.idSOFTWARE
order by ls.NomeSoftware, lv.Versao;

-- k) clientes com descr. tipo + nome setor, ordem tipo e setor:
select ls.NomeSetor, le.DescricaoTipo from lcliente lc 
join lsetor ls on lc.idSETOR_FK = ls.idSETOR 
join ltipo_empresa le on lc.idTIPO_Empresa_FK = le.idTIPO_Empresa
order by le.DescricaoTipo, ls.NomeSetor;

select distinct ls.NomeSetor, le.DescricaoTipo from lcliente lc 
join lsetor ls on lc.idSETOR_FK = ls.idSETOR 
join ltipo_empresa le on lc.idTIPO_Empresa_FK = le.idTIPO_Empresa
order by le.DescricaoTipo, ls.NomeSetor;

-- l) clientes(ident. + nome), licensas (numero, dtAquis., valor):
select idCLIENTE as identificador, Nome_RazaoSocial as nome,
NumLicenca as 'licença', DtAquisicao as data, ValorAquisicao as valor
from lcliente c join llicenca l on l.idCLIENTE_FK = c.idCLIENTE;

-- m) clientes, nome software, ordem por cliente s/ repetir
select distinct c.*, s.NomeSoftware from lcliente c 
join llicenca l on c.idCLIENTE = l.idCLIENTE_FK
join lsoftware s on s.idSOFTWARE = l.idSOFTWARE_FK_FK
order by c.idCLIENTE desc, s.NomeSoftware desc;

-- n) clientes(nome), nome tipo, nome setor e apenas UF SP,RS,PR,MG:
select Nome_RazaoSocial, DescricaoTipo, NomeSetor, UF from lcliente c 
join ltipo_empresa t on c.idTIPO_Empresa_FK = t.idTIPO_Empresa
join lsetor s on s.idSETOR = c.idSETOR_FK
where UF = 'SP' or UF = 'RS' or UF = 'PR' or UF = 'MG';

select Nome_RazaoSocial, DescricaoTipo, NomeSetor, UF from lcliente c 
join ltipo_empresa t on c.idTIPO_Empresa_FK = t.idTIPO_Empresa
join lsetor s on s.idSETOR = c.idSETOR_FK
where UF in ('SP','RS','PR','MG');

-- o) sw,versao,nome cliente, tipo cliente, setor cliente, 
--   licencas (numero, dataAquisicao, valor) ordem por sw,versao,data,cliente
select sw.NomeSoftware, v.Versao, c.Nome_RazaoSocial, t.DescricaoTipo,
s.NomeSetor, l.NumLicenca, l.DtAquisicao, l.ValorAquisicao 
from lcliente c 
join ltipo_empresa t on c.idTIPO_Empresa_FK = t.idTIPO_Empresa
join lsetor s on c.idSETOR_FK = s.idSETOR
join llicenca l on c.idCLIENTE = l.idCLIENTE_FK
join lversao v on l.Versao_FK = v.Versao
join lsoftware sw on v.idSOFTWARE_FK = sw.idSOFTWARE
order by sw.NomeSoftware, v.Versao, l.DtAquisicao, c.Nome_RazaoSocial;

-- p) qtd de licenças vendidas:
select count(*) as 'Quantidade Vendidas' from llicenca;
select count(NumLicenca) as 'Quantidade Vendidas' from llicenca;

-- q) valor total das licencas, valor medio, maior valor, menor valor:
select sum(ValorAquisicao) valorTotal, 
avg(ValorAquisicao) mediaValores, min(ValorAquisicao) menorValor,
max(ValorAquisicao) maiorValor from llicenca; 

-- r) qtd clientes cadastrados apenas do setor Farmacautica
select count(idCLIENTE) as 'Total Clientes Cadastrados'
from lcliente 
join lsetor on idSETOR_FK = idSETOR
where nomeSetor = 'Farmacautica';

-- s) qtd licencas por cliente, nome cliente, ordem por nome cliente:
select c.Nome_RazaoSocial as nome, 
count(l.idCLIENTE_FK) as 'Qtd de Licenças'
from llicenca l 
join lcliente c on c.idCLIENTE = l.idCLIENTE_FK
group by l.idCLIENTE_FK order by c.Nome_RazaoSocial asc;

-- t) valor total aquis, média da aquisi., ordem por nome cliente:
select c.Nome_RazaoSocial as nome, 
sum(l.ValorAquisicao) as 'Total Aquisições',
avg(l.ValorAquisicao) as 'Média Aquisições'
from llicenca l 
join lcliente c on c.idCLIENTE = l.idCLIENTE_FK
group by l.idCLIENTE_FK order by c.Nome_RazaoSocial asc;

-- u) total de licenças por setor, ordem por setor
select s.NomeSetor as setor,
count(l.NumLicenca) as 'total de licenças'
from llicenca l 
join lcliente c on c.idCLIENTE = l.idCLIENTE_FK
join lsetor s on c.idSETOR_FK = s.idSETOR
group by s.idSETOR order by s.NomeSetor asc;

-- v) total de licenças por tipo, ordem por tipo
select t.DescricaoTipo as 'tipo empresa',
count(l.NumLicenca) as 'total de licenças'
from llicenca l 
join lcliente c on c.idCLIENTE = l.idCLIENTE_FK
join ltipo_empresa t on c.idTIPO_Empresa_FK = t.idTIPO_Empresa
group by t.idTIPO_Empresa order by t.DescricaoTipo asc;


-- w) total de licenças por sw/versao, ordem por sw/versao
select count(l.NumLicenca) as 'total de licenças',
s.NomeSoftware, v.Versao
from llicenca l 
join lversao v on l.Versao_FK = v.Versao
join lsoftware s on v.idSOFTWARE_FK = s.idSOFTWARE
group by v.Versao, s.idSOFTWARE order by s.NomeSoftware, v.Versao;

-- x) nome sw, nome empresa, total licenças por nome de empresa
select s.NomeSoftware, c.Nome_RazaoSocial as nomeEmpresa, 
count(l.NumLicenca) as 'total de licenças'
from llicenca l 
join lcliente c on c.idCLIENTE = l.idCLIENTE_FK
join lsoftware s on l.idSOFTWARE_FK_FK = s.idSOFTWARE
group by c.Nome_RazaoSocial, s.idSOFTWARE 
order by c.Nome_RazaoSocial asc;

-- y) nome cliente, licenças adquiridas filtro por > 10 licenças:
select c.Nome_RazaoSocial as nome, 
count(l.NumLicenca) as 'total de licenças'
from llicenca l 
join lcliente c on c.idCLIENTE = l.idCLIENTE_FK
group by l.idCLIENTE_FK
having count(l.NumLicenca) > 10;








