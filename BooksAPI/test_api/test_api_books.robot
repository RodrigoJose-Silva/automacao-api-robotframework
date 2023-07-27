*** Settings ***
Documentation    Documentacao da api: https://fakerestapi.azurewebsites.net/index.html
Resource         ../config/main.resource

Suite Setup      Conectar a minha API

***Test Cases***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code                                        200
    Conferir o reason                                             OK
    Conferir se retorna uma lista com com total livros            200

Buscar por um livro específico (GET by ID)
    Requisitar o livro por id                                     20
    Conferir o status code                                        200
    Conferir o reason                                             OK
    Conferir se retorna os todos os dados corretos do livro 20

Cadastrar um novo livro (POST)
    Cadastrando um novo livro                                     POST A NEW BOOK AUTOMATED
    ...                                                           DESCRIPTION ATUOMATED
    ...                                                           222
    Conferir o status code                                        200
    Conferir o reason                                             OK
    Conferir se retorna dados corretos do livro cadastrado

Alterar um livro cadastrado (PUT)
    Alterar um cadastro de um livro existente                     0
    ...                                                           TEST NAME - AUTOMATED EDIT
    ...                                                           DESCRIPTION - AUTOMATED EDIT
    ...                                                           123
    Conferir o status code                                        200
    Conferir o reason                                             OK
    Conferir se retorna dados corretos do livro alterado

Deletando um livro existente (DELETE)
    Deletar um livro existente                                    0
    Conferir o status code                                        200
    Conferir o reason                                             OK
