--1.1 Resolva cada exercício a seguir usando LOOP, WHILE, FOR e FOREACH
DO $$
DECLARE
    contador INT;
    valor INT;
    meu_array INT[];
    elemento INT;
BEGIN
    RAISE NOTICE '--- 1. Usando LOOP clássico: Intervalo [-50, 50] ---';
    contador := 1;
    LOOP
        EXIT WHEN contador > 5;
        -- Fórmula para [-50, 50]: random() * (50 - (-50) + 1) + (-50)
        valor := floor(random() * 101) - 50;
        RAISE NOTICE 'Iteração % | Valor gerado: %', contador, valor;
        contador := contador + 1;
    END LOOP;

    RAISE NOTICE ' ';
    RAISE NOTICE '--- 2. Usando WHILE: Intervalo [20, 50] ---';
    contador := 1;
    WHILE contador <= 5 LOOP
        -- Fórmula para [20, 50]: random() * (50 - 20 + 1) + 20
        valor := floor(random() * 31) + 20;
        RAISE NOTICE 'Iteração % | Valor gerado: %', contador, valor;
        contador := contador + 1;
    END LOOP;

    RAISE NOTICE ' ';
    RAISE NOTICE '--- 3. Usando FOR: Intervalo [1, 100] ---';
    FOR contador IN 1..5 LOOP
        -- Fórmula para [1, 100]: random() * (100 - 1 + 1) + 1
        valor := floor(random() * 100) + 1;
        RAISE NOTICE 'Iteração % | Valor gerado: %', contador, valor;
    END LOOP;

    RAISE NOTICE ' ';
    RAISE NOTICE '--- 4. Usando FOREACH (Iterando em Array) ---';
    -- Preenchendo um array com 3 valores aleatórios entre 1 e 100 para o teste
    meu_array := ARRAY[
        floor(random() * 100) + 1,
        floor(random() * 100) + 1,
        floor(random() * 100) + 1
    ];
    
    FOREACH elemento IN ARRAY meu_array LOOP
        RAISE NOTICE 'Elemento lido do array: %', elemento;
    END LOOP;
END $$;

--1.2 Determinante de Matriz 3x3 (Regra de Sarrus)

DO $$
DECLARE
    -- Declarando uma matriz 3x3 inicializada com zeros
    matriz INT[][] := ARRAY[
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
    ];
    i INT;
    j INT;
    diag_principal INT;
    diag_secundaria INT;
    determinante INT;
BEGIN
    -- 1. Preenchendo a matriz com valores aleatórios no intervalo [1, 12]
    FOR i IN 1..3 LOOP
        FOR j IN 1..3 LOOP
            matriz[i][j] := floor(random() * 12) + 1;
        END LOOP;
    END LOOP;

    -- 2. Exibindo a matriz no console para conferência visual
    RAISE NOTICE '=== MATRIZ 3x3 GERADA ===';
    RAISE NOTICE '[ % , % , % ]', matriz[1][1], matriz[1][2], matriz[1][3];
    RAISE NOTICE '[ % , % , % ]', matriz[2][1], matriz[2][2], matriz[2][3];
    RAISE NOTICE '[ % , % , % ]', matriz[3][1], matriz[3][2], matriz[3][3];
    RAISE NOTICE '=========================';

    -- 3. Aplicando a Regra de Sarrus
    -- Somatório dos produtos na direção da diagonal principal
    diag_principal := (matriz[1][1] * matriz[2][2] * matriz[3][3]) +
                      (matriz[1][2] * matriz[2][3] * matriz[3][1]) +
                      (matriz[1][3] * matriz[2][1] * matriz[3][2]);

    -- Somatório dos produtos na direção da diagonal secundária
    diag_secundaria := (matriz[1][3] * matriz[2][2] * matriz[3][1]) +
                       (matriz[1][1] * matriz[2][3] * matriz[3][2]) +
                       (matriz[1][2] * matriz[2][1] * matriz[3][3]);

    -- Cálculo final
    determinante := diag_principal - diag_secundaria;

    -- 4. Exibindo os resultados
    RAISE NOTICE 'Soma das Diagonais Principais (+): %', diag_principal;
    RAISE NOTICE 'Soma das Diagonais Secundárias (-): %', diag_secundaria;
    RAISE NOTICE 'Determinante (Δ) calculado: %', determinante;
END $$;