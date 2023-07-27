*** Settings ***
Documentation       Documentacao da api: https://fakerestapi.azurewebsites.net/index.html

Resource            ../config/main.resource

*** Keywords ***

Conectar a minha API
    Create Session                     fakerestAPI    ### criando a conexão com a API através de um ALIAS
    ...                                ${URL_API}   
    ...                                verify=true   

# #### Ações
Requisitar todos os livros
    Get All Books
        
Requisitar o livro por id                                    ## buscando por um livro específico
    [Arguments]                        ${BOOK_ID}

    Get Book ID                        ${BOOK_ID}
    
Cadastrando um novo livro
    [Arguments]                        ${TITLE_NAME}
    ...                                ${DESCRIPTION}
    ...                                ${PAGE_COUNT}
    Set Test Variable                  ${TITLE_NAME}
    Set Test Variable                  ${DESCRIPTION}
    Set Test Variable                  ${PAGE_COUNT}
    
    Post New Book                      ${TITLE_NAME}
    ...                                ${DESCRIPTION}
    ...                                ${PAGE_COUNT}
    
Alterar um cadastro de um livro existente
    [Arguments]                        ${LIVRO_ESPERADO}
    ...                                ${TITLE_NAME}
    ...                                ${DESCRIPTION}
    ...                                ${PAGE_COUNT}
    Set Test VAriable                  ${LIVRO_ESPERADO}
    Set Test Variable                  ${TITLE_NAME}
    Set Test Variable                  ${DESCRIPTION}
    Set Test Variable                  ${PAGE_COUNT}
    
    Put A Book                         ${LIVRO_ESPERADO}
    ...                                ${TITLE_NAME}
    ...                                ${DESCRIPTION}
    ...                                ${PAGE_COUNT}

Deletar um livro existente
    [Arguments]                        ${LIVRO_ESPERADO}
    
    Delete A Book                      ${LIVRO_ESPERADO}
    
### Validações
Conferir o status code
    [Arguments]                        ${STATUSCODE_DESEJADO}                                                                                                                               ### declarando através de argumento uma variável
    Should Be Equal As Strings         ${RESPOSTA.status_code}                                                                                                                              ${STATUSCODE_DESEJADO}           ${STATUSCODE_DESEJADO}         ## verificando se o status que recebe é o mesmo esperado

Conferir o reason
    [Arguments]                        ${REASON_DESEJADO}                                                                                                                                   ### declarando através de argumento uma variável
    Should Be Equal As Strings         ${RESPOSTA.reason}                                                                                                                                   ${REASON_DESEJADO}               ${REASON_DESEJADO}             ## verificando se o status que recebe é o mesmo esperado

Conferir se retorna uma lista com com total livros    ### valor a verificar foi declarado com variável em "Test Cases"
    [Arguments]                        ${TOTAL_BOOKS}
    Length Should Be                   ${RESPOSTA.json()}
    ...                                ${TOTAL_BOOKS}                                      

Conferir se retorna os todos os dados corretos do livro 20
    Dictionary Should Contain Item     ${RESPOSTA.json()}
    ...                                id
    ...                                ${VALUES_DICTIONARY.id}                  ### verifica o "id" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item     ${RESPOSTA.json()}
    ...                                title
    ...                                ${VALUES_DICTIONARY.title}              ### verifica o "title" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item     ${RESPOSTA.json()} 
    ...                                pageCount
    ...                                ${VALUES_DICTIONARY.pageCount}           ### verifica o "pageCount" do response com do DICIONARIO_VARIÁVEL

Conferir se retorna dados corretos do livro cadastrado
    Dictionary Should Contain Item     ${RESPOSTA.json()}
    ...                                title 
    ...                                ${VALUES_DICTIONARY.title}               ### verifica o "title" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item     ${RESPOSTA.json()} 
    ...                                description
    ...                                ${VALUES_DICTIONARY.description}        ### verifica o "description" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item     ${RESPOSTA.json()}
    ...                                pageCount 
    ...                                ${VALUES_DICTIONARY.pageCount}          ### verifica o "pageCount" do response com do DICIONARIO_VARIÁVEL                                                                                                                                 excerpt                          ${POST_BOOK.excerpt}           ### verifica o "excerpt" do response com do DICIONARIO_VARIÁVEL

Conferir se retorna dados corretos do livro alterado
    Dictionary Should Contain Item     ${RESPOSTA.json()}
    ...                                title 
    ...                                ${VALUES_DICTIONARY.title}               ### verifica o "title" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item     ${RESPOSTA.json()} 
    ...                                description
    ...                                ${VALUES_DICTIONARY.description}        ### verifica o "description" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item     ${RESPOSTA.json()}
    ...                                pageCount 
    ...                                ${VALUES_DICTIONARY.pageCount}          ### verifica o "pageCount" do response com do DICIONARIO_VARIÁVEL
    