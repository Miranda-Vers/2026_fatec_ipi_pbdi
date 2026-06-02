--1.1 Escreva a seguinte função
--nome: fn_consultar_saldo
--recebe: código de cliente, código de conta
--devolve: o saldo da conta especificad

-- Criação da tabela base
CREATE TABLE IF NOT EXISTS tb_conta (
    cod_conta SERIAL PRIMARY KEY,
    cod_cliente INT,
    saldo NUMERIC(10, 2),
    cod_tipo_conta INT
);

-- Limpando a tabela e inserindo dados de teste
TRUNCATE tb_conta RESTART IDENTITY;

-- Cliente 1 (Conta 1) tem R$ 1000.00
INSERT INTO tb_conta (cod_cliente, saldo, cod_tipo_conta) VALUES (1, 1000.00, 1);
-- Cliente 2 (Conta 2) tem R$ 500.00
INSERT INTO tb_conta (cod_cliente, saldo, cod_tipo_conta) VALUES (2, 500.00, 1);

--1.1
DROP FUNCTION IF EXISTS fn_consultar_saldo;

CREATE OR REPLACE FUNCTION fn_consultar_saldo (
    p_cod_cli INT, 
    p_cod_conta INT
) RETURNS NUMERIC(10, 2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_saldo NUMERIC(10, 2);
BEGIN
    SELECT saldo INTO v_saldo
    FROM tb_conta
    WHERE cod_cliente = p_cod_cli AND cod_conta = p_cod_conta;
    
    RETURN v_saldo;
END;
$$;

--1.2
DROP FUNCTION IF EXISTS fn_transferir;

CREATE OR REPLACE FUNCTION fn_transferir (
    p_cod_cli_remetente INT, 
    p_cod_conta_remetente INT,
    p_cod_cli_destinatario INT, 
    p_cod_conta_destinatario INT,
    p_valor NUMERIC(10, 2)
) RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_saldo_remetente NUMERIC(10, 2);
BEGIN
    -- 1. Verifica o saldo atual do remetente
    SELECT saldo INTO v_saldo_remetente
    FROM tb_conta
    WHERE cod_cliente = p_cod_cli_remetente AND cod_conta = p_cod_conta_remetente;
    
    -- 2. Regra de negócio: Se a conta não existir ou o saldo for menor que o valor da transferência, cancela
    IF v_saldo_remetente IS NULL OR v_saldo_remetente < p_valor THEN
        RETURN FALSE;
    END IF;
    
    -- 3. Debita do remetente
    UPDATE tb_conta
    SET saldo = saldo - p_valor
    WHERE cod_cliente = p_cod_cli_remetente AND cod_conta = p_cod_conta_remetente;
    
    -- 4. Credita no destinatário
    UPDATE tb_conta
    SET saldo = saldo + p_valor
    WHERE cod_cliente = p_cod_cli_destinatario AND cod_conta = p_cod_conta_destinatario;
    
    RETURN TRUE;
    
EXCEPTION WHEN OTHERS THEN
    -- Em caso de qualquer erro no banco de dados, cancela a operação
    RETURN FALSE;
END;
$$;

--1.3
DO $$
DECLARE
    v_saldo_atual NUMERIC(10, 2);
BEGIN
    -- Consultando o saldo do Cliente 1 na Conta 1
    v_saldo_atual := fn_consultar_saldo(1, 1);
    
    IF v_saldo_atual IS NOT NULL THEN
        RAISE NOTICE 'O saldo da conta é: R$ %', v_saldo_atual;
    ELSE
        RAISE NOTICE 'Conta não encontrada.';
    END IF;
END;
$$;