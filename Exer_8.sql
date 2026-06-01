-- 1.1 Faça um programa que gere um valor inteiro e o exiba.
DO $$
DECLARE
    v_inteiro INTEGER;
BEGIN
    -- Intervalo: 1 <= v_inteiro <= 100
    v_inteiro := floor(random() * 100 + 1)::int;
    RAISE NOTICE 'Exercício 1.1 - Valor inteiro gerado: %', v_inteiro;
END $$;

--1.2 Gerar e exibir um valor real [1, 10]
DO $$
DECLARE
    v_real NUMERIC(10, 2);
BEGIN
    -- Intervalo: 1 <= v_real < 10 (multiplicamos por 9, que é a diferença entre 10 e 1)
    v_real := random() * 9 + 1;
    RAISE NOTICE 'Exercício 1.2 - Valor real gerado: %', v_real;
END $$;

--1.3 Conversão de Celsius para Fahrenheit
---Gerar um valor real no intervalo [20, 30] para Celsius e converte.

DO $$
DECLARE
    temp_celsius NUMERIC(10, 2);
    temp_fahrenheit NUMERIC(10, 2);
BEGIN
    -- Intervalo: 20 <= temp_celsius < 30 (diferença é 10)
    temp_celsius := random() * 10 + 20;
    -- Fórmula: (C * 1.8) + 32
    temp_fahrenheit := (temp_celsius * 1.8) + 32;
    RAISE NOTICE 'Exercício 1.3 - Temperatura gerada: % °C | Convertida: % °F', temp_celsius, temp_fahrenheit;
END $$;

--1.4 Cálculo do Delta (Equação de 2º Grau)
DO $$
DECLARE
    a NUMERIC(10, 2);
    b NUMERIC(10, 2);
    c NUMERIC(10, 2);
    delta NUMERIC(10, 2);
BEGIN
    -- Intervalos [1, 10]
    a := random() * 9 + 1;
    b := random() * 9 + 1;
    c := random() * 9 + 1;
    
    -- Fórmula: Δ = b² - 4ac
    delta := (b * b) - (4 * a * c);
    RAISE NOTICE 'Exercício 1.4 - a: %, b: %, c: % | Valor de Delta: %', a, b, c, delta;
END $$;

--1.5 Raiz cúbica do antecessor e raiz quadrada do sucessor

DO $$
DECLARE
    v_inteiro INTEGER;
    raiz_cubica NUMERIC(10, 2);
    raiz_quadrada NUMERIC(10, 2);
BEGIN
    -- Intervalo [1, 100]
    v_inteiro := floor(random() * 100 + 1)::int;
    
    raiz_cubica := cbrt(v_inteiro - 1);
    raiz_quadrada := sqrt(v_inteiro + 1);
    
    RAISE NOTICE 'Exercício 1.5 - Número gerado: %', v_inteiro;
    RAISE NOTICE '  -> Raiz cúbica do antecessor (%): %', (v_inteiro - 1), raiz_cubica;
    RAISE NOTICE '  -> Raiz quadrada do sucessor (%): %', (v_inteiro + 1), raiz_quadrada;
END $$;


--1.6 Valor de um terreno retangular

DO $$
DECLARE
    largura NUMERIC(10, 2);
    comprimento NUMERIC(10, 2);
    preco_m2 NUMERIC(10, 2);
    valor_total NUMERIC(15, 2);
BEGIN
    -- Medidas em [1, 10]
    largura := random() * 9 + 1;
    comprimento := random() * 9 + 1;
    
    -- Preço m2 em [60, 70] (diferença é 10)
    preco_m2 := random() * 10 + 60;
    
    -- Área total * preco do m2
    valor_total := (largura * comprimento) * preco_m2;
    
    RAISE NOTICE 'Exercício 1.6 - Terreno de %m x %m', largura, comprimento;
    RAISE NOTICE '  -> Preço por m²: R$ %', preco_m2;
    RAISE NOTICE '  -> Valor Total do Terreno: R$ %', valor_total;
END $$;

--1.7 Cálculo de Idade

DO $$
DECLARE
    ano_nasc INTEGER;
    ano_atual INTEGER;
    idade INTEGER;
BEGIN
    -- [1980, 2000] -> max - min + 1 = 2000 - 1980 + 1 = 21
    ano_nasc := floor(random() * 21 + 1980)::int;
    
    -- [2010, 2020] -> max - min + 1 = 2020 - 2010 + 1 = 11
    ano_atual := floor(random() * 11 + 2010)::int;
    
    idade := ano_atual - ano_nasc;
    
    RAISE NOTICE 'Exercício 1.7 - Ano Nasc: % | Ano Atual (simulado): % | Idade: % anos', ano_nasc, ano_atual, idade;
END $$;