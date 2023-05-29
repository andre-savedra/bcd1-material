use exercicio_licensas;

-- a) quantidade de clientes:
select count(*) as quantidadeClientes
from lcliente;

select count(idCLIENTE) as quantidadeClientes
from lcliente;


-- b) aquisições obtidas no mes do aniversario
select *from llicenca where month(DtAquisicao) = 6;


-- c) aquisições em maio de 2007:
select *from llicenca where month(DtAquisicao) = 5 and 
year(DtAquisicao) = 2007;

-- d) tipos de empresa, pegar id, descr. + 5 primeiras letras da descr. e crescente:
select idTIPO_Empresa, DescricaoTipo, 
substr(DescricaoTipo,1,5) as '5 Primeira Letras'
from ltipo_empresa order by DescricaoTipo asc;


-- e) tipos de empresa, pegar id, descr. + 5 ultimas letras da descr. e descrescente:
select idTIPO_Empresa, DescricaoTipo,
substr(DescricaoTipo,-5) as '5 Ultimas Letras'
from ltipo_empresa order by DescricaoTipo desc;

-- f) tipos de empresa, pegar id, descr. + 6ª-10ª pos. descr.:
select idTIPO_Empresa, DescricaoTipo,
substr(DescricaoTipo,6,5) as '6ª - 10ª Posicao'
from ltipo_empresa;


-- g) nome clientes, qtd de caracteres, ordem por nome:
select Nome_RazaoSocial, length(Nome_RazaoSocial) as tamanhoNome
from lcliente order by Nome_RazaoSocial;

-- h) numero licenca, dt aquisicao, qtos dias da aquisicao até hj:
select NumLicenca, DtAquisicao, datediff(now(), DtAquisicao) as 
'Dias decorridos' from llicenca;

-- i) exibir nome do setor em maiuscula e minuscula:
select upper(NomeSetor) as 'Nome_Maiuscula', 
lower(NomeSetor) as 'Nome_Minuscula' from lsetor;


-- j) todos os softwares c/ todas as versoes, ordem por nome e versao
select *from lversao lv join lsoftware ls 
on ls.idSOFTWARE = lv.idSOFTWARE_FK 
order by NomeSoftware, Versao;

-- k) clientes c/ descr. tipo e nome do setor, ordem por empresa e setor:
select c.Nome_RazaoSocial, t.DescricaoTipo, s.NomeSetor from lcliente c
join lsetor s on c.idSETOR_FK = s.idSETOR 
join ltipo_empresa t on t.idTIPO_Empresa = c.idTIPO_Empresa_FK
order by c.Nome_RazaoSocial, s.NomeSetor;


-- l) id + nome cliente, noLicenca, dtAquisicao e valor da licenca:
select c.idCLIENTE, c.Nome_RazaoSocial as Nome, l.NumLicenca as Licenca,
l.dtAquisicao as Data, l.ValorAquisicao as Valor from lcliente c
join llicenca l on l.idCLIENTE_FK = c.idCLIENTE;


-- m) clientes, nome dos softwares, ordem por cliente,software e s/ repeticao:
select distinct cl.Nome_RazaoSocial, sf.NomeSoftware 
from llicenca as l
inner join lcliente as cl on cl.idCLIENTE = l.idCLIENTE_FK 
inner join lsoftware as sf on sf.idSOFTWARE = l.idSOFTWARE_FK_FK
order by cl.Nome_RazaoSocial,sf.NomeSoftware;


-- n) clientes c/ descr. tipo + nome setor, das UF's SP,RS,PR,MG:
select cl.Nome_RazaoSocial, cl.UF, em.DescricaoTipo, se.NomeSetor 
from lcliente as cl 
inner join ltipo_empresa as em on em.idTIPO_EMPRESA = cl.idTIPO_EMPRESA_FK
inner join lsetor as se on se.idSETOR = cl.idSETOR_FK 
where cl.UF = 'SP' or cl.UF = 'RS' or cl.UF = 'PR' or cl.UF = 'MG';

select cl.Nome_RazaoSocial, cl.UF, em.DescricaoTipo, se.NomeSetor 
from lcliente as cl 
inner join ltipo_empresa as em on em.idTIPO_EMPRESA = cl.idTIPO_EMPRESA_FK
inner join lsetor as se on se.idSETOR = cl.idSETOR_FK 
where cl.UF in ('SP','RS','PR', 'MG');

-- o) software, versao, nome cliente, descr. tipo, nome setor, licencas
--    adquiridas c/ numero, dta e valor aquisicao, ordem 
--    por sw,versao,data,cliente
select sw.NomeSoftware, v.Versao, cl.Nome_RazaoSocial,
em.DescricaoTipo, se.NomeSetor, l.NumLicenca, 
l.DtAquisicao, l.ValorAquisicao
from lcliente as cl 
inner join ltipo_empresa as em on em.idTIPO_EMPRESA = cl.idTIPO_EMPRESA_FK
inner join lsetor as se on se.idSETOR = cl.idSETOR_FK 
inner join llicenca as l on l.idCLIENTE_FK = cl.idCLIENTE
inner join lversao as v on v.Versao = l.Versao_FK
inner join lsoftware sw on sw.idSOFTWARE = v.idSOFTWARE_FK
order by sw.NomeSoftware,v.Versao,l.DtAquisicao,cl.Nome_RazaoSocial;


-- p) qtd de licencas vendidas:
select count(*) totalLicencas from llicenca;

-- q) valor total licencas, media, maior e menor valor:
select sum(valorAquisicao) as 'valor total', 
avg(valorAquisicao) as media, max(valorAquisicao) as maior,
min(valorAquisicao) as menor from llicenca;


-- r) total clientes setor Farmacautica:
select count(*) clientesFarmaceutica from lcliente c
inner join lsetor s on s.idSETOR = c.idSETOR_FK 
where s.NomeSetor = 'Farmacautica';


-- s) total licencas por cliente + nome cliente, ordem por nome:
select c.Nome_RazaoSocial, count(l.idSOFTWARE_FK_FK) as 'total licenças'
from llicenca l
inner join lcliente c on l.idCLIENTE_FK = c.idCLIENTE 
group by c.idCLIENTE order by c.Nome_RazaoSocial asc;


-- t) total aquisicoes, valor medio por cliente, ordem por cliente
select c.Nome_RazaoSocial, sum(ValorAquisicao) as ValorTotal,
avg(ValorAquisicao) as ValorMedio from lcliente c
inner join llicenca l on c.idCLIENTE = l.idCLIENTE_FK
group by c.idCLIENTE order by c.Nome_RazaoSocial;


-- u) total licencas por setor, ordem por setor:
select st.NomeSetor, sum(lc.ValorAquisicao) as 'Valor total'
from llicenca as lc 
inner join lcliente as cl on cl.idCLIENTE = lc.idCLIENTE_FK
inner join lsetor as st on st.idSETOR = cl.idSETOR_FK
group by st.NomeSetor order by st.NomeSetor;

select st.NomeSetor, count(lc.NumLicenca) as 'Numero de Aquisicoes'
from llicenca as lc 
inner join lcliente as cl on cl.idCLIENTE = lc.idCLIENTE_FK
inner join lsetor as st on st.idSETOR = cl.idSETOR_FK
group by st.NomeSetor order by st.NomeSetor;

-- v) total de licencas por tipo de empresa, ordem por tipo
select t.DescricaoTipo, count(lc.NumLicenca) as 'Numero de Aquisicoes'
from llicenca as lc 
inner join lcliente as cl on cl.idCLIENTE = lc.idCLIENTE_FK
inner join ltipo_empresa as t on t.idTIPO_Empresa = cl.idTIPO_Empresa_FK
group by t.idTIPO_Empresa order by t.DescricaoTipo;

-- w) total licencas por sw/versao, ordem por sw/versao
select count(l.NumLicenca) as 'Numero de Aquisicoes',
sw.NomeSoftware, v.Versao from llicenca l
join lsoftware sw on l.idSOFTWARE_FK_FK = sw.idSOFTWARE
join lversao v on v.Versao = l.Versao_FK
group by sw.idSOFTWARE,v.Versao 
order by sw.NomeSoftware, v.Versao;

-- x) nome sw, nome empresa,total licencas:
select l.NomeSoftware, c.Nome_RazaoSocial, count(*) as total
from llicenca li 
join lcliente c on c.idCLIENTE = li.idCLIENTE_FK
join lversao v on v.idSOFTWARE_FK = li.idSOFTWARE_FK_FK and v.Versao = li.Versao_FK
join lsoftware l on l.idSOFTWARE = v.idSOFTWARE_FK
group by l.NomeSoftware, c.Nome_RazaoSocial 
order by c.Nome_RazaoSocial, l.NomeSoftware;


-- y) nome do cliente, total licencas adquiridas > 10:
select c.Nome_RazaoSocial, count(l.NumLicenca) as 'total'
from lcliente c 
join llicenca l on c.idCLIENTE = l.idCLIENTE_FK
group by c.Nome_RazaoSocial
having count(l.NumLicenca) > 10;






































































