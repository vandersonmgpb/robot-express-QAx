*** Settings ***
Documentation        Cenários de autenticação do usuário
Library           Collections
Resource          ../resources/base.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    
    ${user}        Create Dictionary
    ...            name=Fulano de Tall
    ...            email=fulanodetall@email.com
    ...            password=0123456
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submit login form            ${user}
    User should be logged in     ${user}[name]

Não deve logar com senha inválida

    ${user}        Create Dictionary
    ...            name=Steve Woz
    ...            email=woz@pple.com
    ...            password=0123
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}        password=12340

    Submit login form            ${user}
    Notice should be             Ocorreu um erro ao fazer login, verifique suas credenciais.