--.1 Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.
DO $$
DECLARE
    cur_youtubers REFCURSOR;
    v_rank INT;
    v_youtuber VARCHAR(200);
BEGIN
    -- Abertura do cursor com a query filtrada
    OPEN cur_youtubers FOR
        SELECT rank, youtuber
        FROM tb_top_youtubers
        WHERE video_count >= 1000 
          AND category IN ('Sports', 'Music');

    LOOP
        -- Recuperação dos dados
        FETCH cur_youtubers INTO v_rank, v_youtuber;
        
        EXIT WHEN NOT FOUND;
        
        RAISE NOTICE 'Rank: % | YouTuber: %', v_rank, v_youtuber;
    END LOOP;

    -- Fechamento do cursor
    CLOSE cur_youtubers;
END;
$$;

--1.2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. Para tal
-- O SELECT deverá ordenar em ordem não reversa
-- O Cursor deverá ser movido para a última tupla
-- Os dados deverão ser exibidos de baixo para cima

DO $$
DECLARE
    cur_reverso REFCURSOR;
    v_youtuber VARCHAR(200);
BEGIN
    -- Abertura do cursor explicitando SCROLL para permitir navegação bidirecional
    OPEN cur_reverso SCROLL FOR
        SELECT youtuber
        FROM tb_top_youtubers
        ORDER BY youtuber ASC; -- Ordem normal (não reversa), conforme exigido

    -- Move o cursor para a ÚLTIMA tupla e já recupera o valor
    FETCH LAST FROM cur_reverso INTO v_youtuber;

    LOOP
        EXIT WHEN NOT FOUND;
        
        RAISE NOTICE '%', v_youtuber;
        
        -- Move o cursor para a tupla ANTERIOR (de baixo para cima)
        FETCH PRIOR FROM cur_reverso INTO v_youtuber;
    END LOOP;

    -- Fechamento do cursor
    CLOSE cur_reverso;
END;
$$;

--1.3 Faça uma pesquisa sobre o anti-pattern chamado RBAR - Row By Agonizing Row. Explique com suas palavras do que se trata

---O RBAR (Processamento "Linha por Linha") é a má prática de usar loops ou cursores para processar dados um por um, em vez de usar comandos SQL tradicionais que afetam várias linhas de uma só vez (como um UPDATE ou DELETE com WHERE).
---Isso pode ser ruim por alguns motivos: entre eles entra a extrema lentidão e Desperdiço de Recursos
