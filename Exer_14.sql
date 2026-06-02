---1.1 Adicione uma coluna à tabela tb_pessoa chamada ativo. Ela indica se a pessoa está ativa no sistema ou não. Ela deve ser capaz de armazenar um valor booleano. Por padrão, toda pessoa cadastrada no sistema está ativa.
ALTER TABLE tb_pessoa 
ADD COLUMN ativo BOOLEAN DEFAULT TRUE;


---1.2 Associe um trigger de DELETE à tabela. Quando um DELETE for executado, o trigger deve atribuir FALSE à coluna ativo das linhas envolvidas. Além disso, o trigger não deve permitir que nenhuma pessoa seja removida.

CREATE OR REPLACE FUNCTION fn_inativar_pessoa()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE tb_pessoa 
    SET ativo = FALSE 
    WHERE cod_pessoa = OLD.cod_pessoa;
    
    RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER tg_delete_pessoa
BEFORE DELETE ON tb_pessoa
FOR EACH ROW
EXECUTE FUNCTION fn_inativar_pessoa();