*** Settings ***
Documentation       Documentacao da api: https://fakerestapi.azurewebsites.net/index.html
Resource            ResourceAPI.robot  ## declarando o arquivo onde contém as Keywords
Suite Setup         Conectar a minha API

*** Test Cases ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code      200
    Conferir o reason       OK
    Conferir se retorna uma lista com "200" livros

Buscar por um livro específico (GET com parametro ID)
    Requisitar o livro "20"
    Conferir o status code      200
    Conferir o reason       OK
    Conferir se retorna os todos os dados corretos do livro 20
    