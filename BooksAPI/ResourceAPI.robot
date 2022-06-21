*** Settings ***
Documentation       Documentacao da api: https://fakerestapi.azurewebsites.net/index.html
Library             RequestsLibrary         # referente a biblioteca HTTP RequestsLibrary (Python)
Library             Collections             # biblioteca nativa do Robot

*** Variables ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/      # URL Base da API

*** Keywords ***
##### Setup e Teardown
Conectar a minha API
    Create Session      fakerestAPI     ${URL_API}  ### criando a conexão com a API através de um ALIAS

#### Ações
Requisitar todos os livros
    ${RESPOSTA}     GET On Session        fakerestAPI     /v1/Books       # declarando método a URL + endpoit
    Log             ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}  ## declarando a variável como global para que seja reutilziada em outras KEYWORDS de testes

Conferir o status code
    [Arguments]     ${STATUSCODE_DESEJADO}  ### declarando através de argumento uma variável
    Should Be Equal As Strings    ${RESPOSTA.status_code}     ${STATUSCODE_DESEJADO}  ## verificando se o status que recebe é o mesmo esperado

Conferir o reason
    [Arguments]     ${REASON_DESEJADO}  ### declarando através de argumento uma variável
    Should Be Equal As Strings     ${RESPOSTA.reason}     ${REASON_DESEJADO}  ## verificando se o status que recebe é o mesmo esperado

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros  ### valor a verificar foi declarado com variável em "Test Cases"
    Length Should Be        ${RESPOSTA.json()}      ${QTDE_LIVROS}

