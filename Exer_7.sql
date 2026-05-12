import psycopg

class Usuario:
    def __init__(self, login, senha):
        self.login = login
        self.senha = senha

def existe(usuario):
    try:
        with psycopg.connect(
            host="localhost",
            port=5432,
            dbname="20221_pessoal_db_login",
            user="postgres",
            password="postgres"
        ) as conexao:
            with conexao.cursor() as cursor:

                cursor.execute(
                    'SELECT * FROM tb_usuario WHERE login=%s AND senha=%s', 
                    (usuario.login, usuario.senha)
                )
                result = cursor.fetchone()
                return result is not None
    except Exception as e:
        print(f"Erro de conexão: {e}")
        return False

def inserir(usuario):
    try:
        with psycopg.connect(
            host="localhost",
            port=5432,
            dbname="20221_pessoal_db_login",
            user="postgres",
            password="postgres"
        ) as conexao:
            with conexao.cursor() as cursor:
                cursor.execute(
                    'INSERT INTO tb_usuario (login, senha) VALUES (%s, %s)', 
                    (usuario.login, usuario.senha)
                )

                return cursor.rowcount >= 1
    except Exception as e:
        print(f"Erro ao inserir: {e}")
        return False

def menu():
    texto = "0-Fechar Sistema\n1-Login\n2-Logoff\n3-Cadastrar novo usuário\n Escolha: "
    usuario_logado = None
    
    op = int(input(texto))
    
    while op != 0:
        if op == 1:
            login = input("Digite seu login: ")
            senha = input("Digite sua senha: ")
            usuario_temp = Usuario(login, senha)
            if existe(usuario_temp):
                usuario_logado = usuario_temp
                print("\n>>> Usuário OK!!! Login realizado.\n")
            else:
                print("\n>>> Usuário NOK!!! Credenciais inválidas.\n")
                
        elif op == 2:
            usuario_logado = None
            print("\n>>> Logoff realizado com sucesso.\n")
            
        elif op == 3:
            login = input("Digite o login do novo usuário: ")
            senha = input("Digite a senha do novo usuário: ")
            novo_usuario = Usuario(login, senha)
            if inserir(novo_usuario):
                print("\n>>> Inserção OK!!! Usuário cadastrado.\n")
            else:
                print("\n>>> Inserção NOK!!! Falha ao cadastrar.\n")
        
        else:
            print("\n>>> Opção inválida!\n")
            
        op = int(input(texto))
    
    print("Até mais!")

if __name__ == "__main__":
    menu()