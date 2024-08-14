USE GestaoFinanceira;

SELECT * FROM recebimentos;
SELECT * FROM encargos;
SELECT * FROM vendas;
SELECT * FROM recebimentos AS r INNER JOIN caixa AS c ON r.id_caixa_fk = c.id_caixa;

SELECT * FROM servicos ORDER BY valor;
SELECT MAX(valor) AS valor FROM servicos;
SELECT SUM(valor) AS somaDosServicos FROM servicos;
SELECT AVG(valor) AS media FROM servicos;



SELECT * FROM servicos WHERE valor > 100;
SELECT * FROM servicos WHERE valor > 100 OR tempo < '00:30';
SELECT * FROM servicos WHERE descricao LIKE 'a%';

SELECT nome,cpf FROM clientes;
SELECT * FROM vendas WHERE id_cliente_fk IS NOT NULL;

SELECT * FROM vendas INNER JOIN cliente ON clientes.id_cliente = vendas.id_cliente_fk WHERE id_cliente_fk IS NOT NULL;


SELECT * FROM vendas LEFT JOIN clientes ON vendas.id_cliente_fk = clientes.id_cliente
UNION
SELECT * FROM vendas RIGHT JOIN clientes ON vendas.id_cliente_fk = clientes.id_cliente;

SELECT nome , cpf  FROM clientes
UNION
SELECT nome, cpf FROM funcionarios;

SELECT * FROM servicos WHERE valor = (SELECT MAX(valor) FROM servicos);

SELECT * FROM servicos WHERE valor > (SELECT AVG(valor) FROM servicos);

#essa parte eh
SELECT * FROM vendasservicos;
SELECT * FROM servicos AS s WHERE (SELECT COUNT(id_vendaServico) FROM vendasservicos WHERE id_servico_fk = s.id_servico)>1;

SELECT * FROM vendas;
SELECT * FROM recebimentos;
SELECT * FROM vendas AS v WHERE (SELECT COUNT(id_recebimento) FROM recebimentos WHERE id_venda_fk = v.id_venda)>1;
#ate aqui é pra saber quais vendas tem mais de um recebimento, é importante!!


SELECT * FROM recebimentos INNER JOIN caixas ON recebimentos.id_caixa_fk = caixas.id_caixa
					INNER JOIN funcionarios ON caixas.id_funcionario_fk = funcionarios.id_funcionario 
                    WHERE funcionarios.cpf = '53245234123' AND recebimentos.status_despesa = 'pago';
                    
SELECT * FROM recebimentos INNER JOIN vendas ON recebimentos.id_venda_fk = vendas.id_cliente_fk
						INNER JOIN clientes ON vendas.id_cliente_fk = clientes.id_cliente
                        WHERE clientes.cpf = '02514705207';


SELECT * FROM recebimentos WHERE id_caixa_fk = (SELECT id_funcionario_fk FROM caixas WHERE id_funcionario_fk = 
											  (SELECT id_funcionario FROM funcionarios WHERE id_funcionario='1'));


SELECT * FROM despesas AS d INNER JOIN fornecedores AS f ON d.id_fornecedores_fk = f.id_fornecedor;

SELECT * FROM servicos;

UPDATE servicos SET valor = 50 WHERE id_servico=1;

SELECT * FROM vendasservicos AS vs INNER JOIN servicos AS s ON vs.id_servico_fk = s.id_servico;

SELECT vs.id_vendaServico,vs.id_venda_fk,s.descricao FROM vendasservicos AS vs INNER JOIN servicos AS s ON vs.id_servico_fk = s.id_servico;

SELECT * FROM vendas;
SELECT v.id_venda, v.valorFinal, c.nome FROM vendas AS v LEFT JOIN clientes AS c ON v.id_cliente_fk = c.id_cliente;

SELECT * FROM despesas INNER JOIN fornecedores;


SELECT c.id_caixa,c.saldo_inicio,c.saldo_final,c.total_entradas,c.total_saidas,c.status_caixa,c.id_funcionario_fk,f.nome,f.cpf FROM caixas AS c LEFT JOIN funcionarios AS f ON c.id_funcionario_fk = f.id_funcionario;

SELECT id_venda_fk, COUNT(id_recebimento) FROM recebimentos GROUP BY id_venda_fk; 

SELECT id_venda_fk, SUM(valor) FROM recebimentos 
GROUP BY id_venda_fk;
SELECT id_venda_fk, SUM(valor) FROM recebimentos 
GROUP BY id_venda_fk HAVING COUNT(id_recebimento)>1; 

#VAI CAIR
#select aninhado, inner join, left join, right join
