--1.1Adicione uma tabela de log ao sistema do restaurante. Ajuste cada procedimento para que ele registre
-- a data em que a operação aconteceu
-- o nome do procedimento executado

CREATE TABLE IF NOT EXISTS tb_cliente (
    cod_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS tb_pedido (
    cod_pedido SERIAL PRIMARY KEY,
    cod_cliente INT REFERENCES tb_cliente(cod_cliente)
);

-- EXERCÍCIO 1.1: Tabela de Log
CREATE TABLE IF NOT EXISTS tb_log (
    id_log SERIAL PRIMARY KEY,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nome_procedimento VARCHAR(100)
);

-- Inserindo dados de teste para podermos brincar
INSERT INTO tb_cliente (nome) VALUES ('Carlos'), ('Maria');
INSERT INTO tb_pedido (cod_cliente) VALUES (1), (1), (2);

1.2
CREATE OR REPLACE PROCEDURE sp_total_pedidos_notice (IN p_cod_cliente INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_pedidos INT;
BEGIN
    -- 1.1 Registrando o log
    INSERT INTO tb_log (nome_procedimento) VALUES ('sp_total_pedidos_notice');
    
    -- Lógica do procedimento
    SELECT COUNT(*) INTO v_total_pedidos 
    FROM tb_pedido 
    WHERE cod_cliente = p_cod_cliente;
    
    RAISE NOTICE 'O cliente de código % tem % pedido(s).', p_cod_cliente, v_total_pedidos;
END;
$$;

--1.3 
CREATE OR REPLACE PROCEDURE sp_total_pedidos_out (IN p_cod_cliente INT, OUT p_total_pedidos INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- 1.1 Registrando o log
    INSERT INTO tb_log (nome_procedimento) VALUES ('sp_total_pedidos_out');
    
    -- Lógica (o COUNT vai direto para a variável OUT)
    SELECT COUNT(*) INTO p_total_pedidos 
    FROM tb_pedido 
    WHERE cod_cliente = p_cod_cliente;
END;
$$;

----1.4
CREATE OR REPLACE PROCEDURE sp_total_pedidos_inout (INOUT p_codigo_e_total INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- 1.1 Registrando o log
    INSERT INTO tb_log (nome_procedimento) VALUES ('sp_total_pedidos_inout');
    
    -- Lógica (a variável recebe o COUNT baseado no seu próprio valor de entrada)
    SELECT COUNT(*) INTO p_codigo_e_total 
    FROM tb_pedido 
    WHERE cod_cliente = p_codigo_e_total;
END;
$$;

--1.5
CREATE OR REPLACE PROCEDURE sp_cadastrar_clientes (OUT p_mensagem TEXT, VARIADIC p_nomes VARCHAR[])
LANGUAGE plpgsql
AS $$
DECLARE
    v_nome VARCHAR;
    v_nomes_concatenados TEXT;
BEGIN
    -- 1.1 Registrando o log
    INSERT INTO tb_log (nome_procedimento) VALUES ('sp_cadastrar_clientes');
    
    -- Lógica: Loop para inserir cada cliente do Array
    FOREACH v_nome IN ARRAY p_nomes LOOP
        INSERT INTO tb_cliente (nome) VALUES (v_nome);
    END LOOP;
    
    -- array_to_string transforma o array em um texto separado por vírgulas
    v_nomes_concatenados := array_to_string(p_nomes, ', ');
    p_mensagem := 'Os clientes: ' || v_nomes_concatenados || ' foram cadastrados.';
END;
$$;

--1.6
--Testando 1.2 (Apenas IN):
DO 
$$
BEGIN
    -- Passando o código 1 (Carlos, que inserimos lá no começo e tem 2 pedidos)
    CALL sp_total_pedidos_notice(1);
END;
$$;

--Testando 1.3 (IN e OUT):

DO $$
DECLARE
    v_resultado INT;
BEGIN
    -- O segundo parâmetro é a variável que vai capturar o OUT
    CALL sp_total_pedidos_out(1, v_resultado);
    RAISE NOTICE 'Resultado capturado do OUT: %', v_resultado;
END;
$$;

--Testando 1.4 (INOUT):

DO $$
DECLARE
    -- Inicializamos com 2 (Código da cliente Maria)
    v_in_out INT := 2; 
BEGIN
    RAISE NOTICE 'Valor antes da chamada (Código do Cliente): %', v_in_out;
    CALL sp_total_pedidos_inout(v_in_out);
    RAISE NOTICE 'Valor depois da chamada (Total de Pedidos): %', v_in_out;
END;
$$;

--Testando 1.5 (OUT e VARIADIC):

DO $$
DECLARE
    v_mensagem_retorno TEXT;
BEGIN
    -- O primeiro é o OUT, os demais formam o array VARIADIC
    CALL sp_cadastrar_clientes(v_mensagem_retorno, 'Pedro', 'Ana', 'João', 'Beatriz');
    RAISE NOTICE '%', v_mensagem_retorno;
END;
$$;