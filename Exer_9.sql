---1.1 Exibir se um número inteiro é múltiplo de 3
--Solução com IF:

DO $$
DECLARE
    valor INT := valor_aleatorio_entre(1, 100);
BEGIN
    IF valor % 3 = 0 THEN
        RAISE NOTICE 'O valor % É múltiplo de 3.', valor;
    ELSE
        RAISE NOTICE 'O valor % NÃO é múltiplo de 3.', valor;
    END IF;
END $$;

--Solução com CASE:

DO $$
DECLARE
    valor INT := valor_aleatorio_entre(1, 100);
BEGIN
    CASE 
        WHEN valor % 3 = 0 THEN
            RAISE NOTICE 'O valor % É múltiplo de 3.', valor;
        ELSE
            RAISE NOTICE 'O valor % NÃO é múltiplo de 3.', valor;
    END CASE;
END $$;

--1.2 Exibir se um número inteiro é múltiplo de 3 ou de 5
--Solução com IF:

DO $$
DECLARE
    valor INT := valor_aleatorio_entre(1, 100);
BEGIN
    IF valor % 3 = 0 OR valor % 5 = 0 THEN
        RAISE NOTICE 'O valor % É múltiplo de 3 ou 5.', valor;
    ELSE
        RAISE NOTICE 'O valor % NÃO é múltiplo de 3 ou 5.', valor;
    END IF;
END $$;

--Solução com CASE:
DO $$
DECLARE
    valor INT := valor_aleatorio_entre(1, 100);
BEGIN
    CASE 
        WHEN valor % 3 = 0 OR valor % 5 = 0 THEN
            RAISE NOTICE 'O valor % É múltiplo de 3 ou 5.', valor;
        ELSE
            RAISE NOTICE 'O valor % NÃO é múltiplo de 3 ou 5.', valor;
    END CASE;
END $$; 
--1.3 Menu de Operações Matemáticas
--Solução com IF:

DO $$
DECLARE
    opcao INT := valor_aleatorio_entre(1, 4);
    op1 INT := valor_aleatorio_entre(1, 10);
    op2 INT := valor_aleatorio_entre(1, 10);
    resultado NUMERIC(10, 2);
    sinal CHAR(1);
BEGIN
    IF opcao = 1 THEN
        resultado := op1 + op2;
        sinal := '+';
    ELSIF opcao = 2 THEN
        resultado := op1 - op2;
        sinal := '-';
    ELSIF opcao = 3 THEN
        resultado := op1 * op2;
        sinal := '*';
    ELSE
        -- Usando cast (::NUMERIC) para garantir a precisão decimal na divisão
        resultado := op1::NUMERIC / op2;
        sinal := '/';
    END IF;
    
    RAISE NOTICE 'Opção escolhida: % -> % % % = %', opcao, op1, sinal, op2, resultado;
END $$;

--Solução com CASE:
DO $$
DECLARE
    opcao INT := valor_aleatorio_entre(1, 4);
    op1 INT := valor_aleatorio_entre(1, 10);
    op2 INT := valor_aleatorio_entre(1, 10);
    resultado NUMERIC(10, 2);
    sinal CHAR(1);
BEGIN
    CASE opcao
        WHEN 1 THEN
            resultado := op1 + op2;
            sinal := '+';
        WHEN 2 THEN
            resultado := op1 - op2;
            sinal := '-';
        WHEN 3 THEN
            resultado := op1 * op2;
            sinal := '*';
        WHEN 4 THEN
            resultado := op1::NUMERIC / op2;
            sinal := '/';
    END CASE;
    
    RAISE NOTICE 'Opção escolhida: % -> % % % = %', opcao, op1, sinal, op2, resultado;
END $$;

--1.4 Cálculo de lucro do comerciante
--Solução com IF:
DO $$
DECLARE
    valor_compra INT := valor_aleatorio_entre(10, 30);
    valor_venda NUMERIC(10, 2);
BEGIN
    IF valor_compra < 20 THEN
        valor_venda := valor_compra * 1.45; -- Lucro de 45%
    ELSE
        valor_venda := valor_compra * 1.30; -- Lucro de 30%
    END IF;
    
    RAISE NOTICE 'Valor de Compra: R$ % | Valor de Venda: R$ %', valor_compra, valor_venda;
END $$;

--Solução com CASE:
DO $$
DECLARE
    valor_compra INT := valor_aleatorio_entre(10, 30);
    valor_venda NUMERIC(10, 2);
BEGIN
    CASE 
        WHEN valor_compra < 20 THEN
            valor_venda := valor_compra * 1.45;
        ELSE
            valor_venda := valor_compra * 1.30;
    END CASE;
    
    RAISE NOTICE 'Valor de Compra: R$ % | Valor de Venda: R$ %', valor_compra, valor_venda;
END $$;

--1.5 Não esta disponivel no site da beecrowd
