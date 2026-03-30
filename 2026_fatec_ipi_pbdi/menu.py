#1.2 Crie um arquivo chamado menu.py.
#1.3 Implemente uma função chamada menu que ofereça as seguintes opções ao usuário:
#1. Somar
#2. Subtrair
#3. Multiplicar
#4 . Dividir
#0. Sair


def menu():

    print("Boa tarde, quais das opções deseja escolher?  ")
    print("1. Somar")
    print("2. Subtrair")
    print("3. Multiplicar")
    print("4. Dividir")
    print("0. Sair do programa")

escolha_usuario = int(input("Digite a opção desejada:"))
if escolha_usuario == 1:
    print("Você escolheu a opção de somar")
    n1= float(input("Digite o primeiro número: "))
    n2= float(input("Digite o segundo número: "))
    print(f"A soma dos números é {n1 + n2}")
elif escolha_usuario == 2:
    print("Você escolheu a opção de subtrair")
    n1= float(input("Digite o primeiro número: "))
    n2= float(input("Digite o segundo número: "))
    print(f"A subtração dos números é {n1 - n2}")
elif escolha_usuario == 3:
    print("Você escolheu a opção de multiplicar")
    n1= float(input("Digite o primeiro número: "))
    n2= float(input("Digite o segundo número: "))
    print(f"A multipicação dos números é {n1 * n2}")
elif escolha_usuario == 4:
    print("Você escolheu a opção de dividir")
    n1= float(input("Digite o primeiro número: "))
    n2= float(input("Digite o segundo número: "))
    print(f"A divisão dos números é {n1 / n2}")
    
elif escolha_usuario == 0:
    print("Você escolheu a opção de sair do programa")
    
else:
    print("Opção inválida, por favor escolha uma opção válida")

