USE GestaoFinanceira;

SELECT * FROM recebimento;
SELECT * FROM encargo;
SELECT * FROM venda;
SELECT * FROM recebimento AS r INNER JOIN caixa AS c ON r.id_caixa_fk = c.id_caixa;

SELECT * FROM servico ORDER BY valor;
SELECT MAX(valor) AS valor FROM servico;
SELECT SUM(valor) AS somaDosServicos FROM servico;
SELECT AVG(valor) AS media FROM servico;

SELECT * FROM servico WHERE valor > 100;
SELECT * FROM servico WHERE valor > 100 OR tempo < '00:30';
SELECT * FROM servico WHERE descricao LIKE 'a%';

SELECT nome,cpf FROM cliente;
SELECT * FROM venda WHERE id_cliente_fk IS NOT NULL;

SELECT * FROM venda INNER JOIN cliente ON cliente.id_cliente = venda.id_cliente_fk WHERE id_cliente_fk IS NOT NULL;


SELECT * FROM venda LEFT JOIN cliente ON venda.id_cliente_fk = cliente.id_cliente
UNION
SELECT * FROM venda RIGHT JOIN cliente ON venda.id_cliente_fk = cliente.id_cliente;

SELECT nome , cpf  FROM cliente 
UNION
SELECT nome, cpf FROM funcionario;

SELECT * FROM servico WHERE valor = (SELECT MAX(valor) FROM servico);

SELECT * FROM servico WHERE valor > (SELECT AVG(valor) FROM servico);

SELECT * FROM recebimento INNER JOIN caixa ON recebimento.id_caixa_fk = caixa.id_caixa
					INNER JOIN funcionario ON caixa.id_funcionario_fk = funcionario.id_funcionario 
                    WHERE funcionario.cpf = '53245234123' AND recebimento.status_despesa = 'pago';
                    
SELECT * FROM recebimento INNER JOIN venda ON recebimento.id_venda_fk = venda.id_cliente_fk
						INNER JOIN cliente ON venda.id_cliente_fk = cliente.id_cliente
                        WHERE cliente.cpf = '02514705207';


SELECT * FROM recebimento WHERE id_caixa_fk = (SELECT id_funcionario_fk FROM caixa WHERE id_funcionario_fk = 
											  (SELECT id_funcionario FROM funcionario WHERE id_funcionario='1'));
