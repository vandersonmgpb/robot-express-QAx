*** Settings ***
Documentation        Cenários de cadastro de tarefas

Resource        ../../resources/base.resource

Test Setup           Start session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder Cadastrar uma nova tarefa
    [Tags]    cadastro

    ${data}    Get fixture    tasks    create

    Reset user from database    ${data}[user]

    Do login    ${data}[user]

    Go to task form
    Submit task form             ${data}[task]
    Task should be registered    ${data}[task][name]

Não deve cadastrar tarefa com nome duplicado
    [Tags]    dup

    ${data}    Get fixture    tasks    duplicate

    Reset user from database      ${data}[user]
    Create a new task from API    ${data}
    
    Do login    ${data}[user]

    # Quando tento cadastrar essa tarefa que já foi cadastrada
    Go to task form
    Submit task form            ${data}[task]

    # Então devo ver uma notificação de duplicidade
    Notice should be            Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atingir o limite de Tags
    [Tags]    tags_limit

    ${data}    Get fixture    tasks    tags_limit

    Reset user from database    ${data}[user]

    Do login    ${data}[user]

    Go to task form
    Submit task form            ${data}[task]

    Notice should be            Oops! Limite de tags atingido.

    