*** Settings ***
Documentation       Documentacao da api: https://fakerestapi.azurewebsites.net/index.html
Library             RequestsLibrary         # referente a biblioteca HTTP RequestsLibrary (Python)
Library             Collections             # biblioteca nativa do Robot

*** Variables ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/      # URL Base da API
&{BOOK_20}      id=20
...             title=Book 20
...             pageCount=2000

&{POST_BOOK}     title=TestName
...             description=Test
...             pageCount=222
...             excerpt=Test

&{PUT_BOOK}     title=TestName-PUT
...             description=Test-PUT
...             pageCount=222
...             excerpt=Test-PUT

*** Keywords ***
##### Setup e Teardown
Conectar a minha API
    Create Session      fakerestAPI     ${URL_API}  ### criando a conexão com a API através de um ALIAS
    
#### Ações
Requisitar todos os livros
    ${RESPOSTA}             GET On Session        fakerestAPI     /v1/Books       # declarando método a URL + endpoit
    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}  ## declarando a variável como global para que seja reutilziada em outras KEYWORDS de testes

Requisitar o livro "${ID_LIVRO}"    ## buscando por um livro específico
    ${RESPOSTA}             GET On Session          fakerestAPI     /v1/Books/${ID_LIVRO}
    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}  ## declarando a variável como global para que seja reutilziada em outras KEYWORDS de testes

Cadastrando um novo livro
    ${HEADERS}              Create Dictionary       content-type=application/json
    
    ${RESPOSTA}             POST On Session         fakerestAPI     /v1/Books       # declarando método a URL + endpoit
    ...                                             headers=${HEADERS}
    ...                                             data={"id": 0,"title": "TestName","description": "Test","pageCount": 222,"excerpt": "Test","publishDate": "2022-06-26T15:03:09.866Z"}
    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}  ## declarando a variável como global para que seja reutilziada em outras KEYWORDS de testes

Alterar um cadastro de um livro existente
    [Arguments]             ${LIVRO_ESPERADO}

    ${HEADERS}              Create Dictionary       content-type=application/json
      
    ${RESPOSTA}             PUT On Session          fakerestAPI     /v1/Books/${LIVRO_ESPERADO}      # declarando método a URL + endpoit
    ...                                             headers=${HEADERS}
    ...                                             data={"id": 0,"title": "TestName-PUT","description": "Test-PUT","pageCount": 222,"excerpt": "Test-PUT","publishDate": "2022-06-26T15:03:09.866Z"}
    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}  ## declarando a variável como global para que seja reutilziada em outras KEYWORDS de testes

Deletar um livro existente
    [Arguments]             ${LIVRO_ESPERADO}
    ${RESPOSTA}             DELETE On Session          fakerestAPI     /v1/Books/${LIVRO_ESPERADO}
    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}  ## declarando a variável como global para que seja reutilziada em outras KEYWORDS de testes

### Validações
Conferir o status code
    [Arguments]                     ${STATUSCODE_DESEJADO}  ### declarando através de argumento uma variável
    Should Be Equal As Strings      ${RESPOSTA.status_code}     ${STATUSCODE_DESEJADO}  ## verificando se o status que recebe é o mesmo esperado

Conferir o reason
    [Arguments]                      ${REASON_DESEJADO}  ### declarando através de argumento uma variável
    Should Be Equal As Strings       ${RESPOSTA.reason}     ${REASON_DESEJADO}  ## verificando se o status que recebe é o mesmo esperado

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros  ### valor a verificar foi declarado com variável em "Test Cases"
    Length Should Be        ${RESPOSTA.json()}      ${QTDE_LIVROS}

Conferir se retorna os todos os dados corretos do livro 20
    Dictionary Should Contain Item       ${RESPOSTA.json()}      id             ${BOOK_20.id}    ### verifica o "id" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item       ${RESPOSTA.json()}      title          ${BOOK_20.title}    ### verifica o "title" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item       ${RESPOSTA.json()}      pageCount      ${BOOK_20.pageCount}    ### verifica o "pageCount" do response com do DICIONARIO_VARIÁVEL

Conferir se retorna dados corretos do livro cadastrado
    Dictionary Should Contain Item       ${RESPOSTA.json()}      title              ${POST_BOOK.title}    ### verifica o "title" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item       ${RESPOSTA.json()}      description        ${POST_BOOK.description}    ### verifica o "description" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item       ${RESPOSTA.json()}      pageCount          ${POST_BOOK.pageCount}    ### verifica o "pageCount" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item       ${RESPOSTA.json()}      excerpt            ${POST_BOOK.excerpt}    ### verifica o "excerpt" do response com do DICIONARIO_VARIÁVEL

Conferir se retorna dados corretos do livro alterado
    Dictionary Should Contain Item       ${RESPOSTA.json()}      title              ${PUT_BOOK.title}    ### verifica o "title" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item       ${RESPOSTA.json()}      description        ${PUT_BOOK.description}    ### verifica o "description" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item       ${RESPOSTA.json()}      pageCount          ${PUT_BOOK.pageCount}    ### verifica o "pageCount" do response com do DICIONARIO_VARIÁVEL
    Dictionary Should Contain Item       ${RESPOSTA.json()}      excerpt            ${PUT_BOOK.excerpt}    ### verifica o "excerpt" do response com do DICIONARIO_VARIÁVEL
