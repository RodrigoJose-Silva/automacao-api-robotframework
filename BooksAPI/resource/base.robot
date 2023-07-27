*** Settings ***
Documentation         This file has all the keywords and variables

Resource              ../config/main.resource

*** Variable ***
${URL_API}            https://fakerestapi.azurewebsites.net    # URL Base da API

*** Keywords ***
Get All Books
    ${RESPOSTA}             GET On Session
    ...                     fakerestAPI
    ...                     /api/v1/Books
    Set Test Variable       ${RESPOSTA}

Get Book ID
    [Arguments]             ${BOOK_ID}
    Set Test Variable       ${BOOK_ID}

    ${RESPOSTA}             GET On Session
    ...                     fakerestAPI
    ...                     /api/v1/Books/${BOOK_ID}

    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}

    ${VALUES_DICTIONARY}    Create Dictionary
    ...                     id=${RESPOSTA.json()["id"]}
    ...                     title=${RESPOSTA.json()["title"]}
    ...                     pageCount=${RESPOSTA.json()["pageCount"]}
    Set Test Variable       ${VALUES_DICTIONARY}

Post New Book

    [Arguments]             ${TITLE_NAME}
    ...                     ${DESCRIPTION}
    ...                     ${PAGE_COUNT}
    Set Test Variable       ${TITLE_NAME}
    Set Test Variable       ${DESCRIPTION}
    Set Test Variable       ${PAGE_COUNT}

    ${HEADERS}              Create Dictionary
    ...                     Content-type=application/json
    ...                     v=1.0


    ${RESPOSTA}             POST On Session
    ...                     fakerestAPI
    ...                     /api/v1/Books   # declarando método a URL + endpoit
    ...                     headers=${HEADERS}
    ...                     data={"id": 0,"title": "${TITLE_NAME}","description": "${DESCRIPTION}","pageCount": ${PAGE_COUNT},"excerpt": "Test","publishDate": "2022-06-26T15:03:09.866Z"}

    Set Test Variable       ${RESPOSTA}

    ${VALUES_DICTIONARY}    Create Dictionary
    ...                     title=${RESPOSTA.json()["title"]}
    ...                     description=${RESPOSTA.json()["description"]}
    ...                     pageCount=${RESPOSTA.json()["pageCount"]}
    Set Test Variable       ${VALUES_DICTIONARY}

Put A Book

    [Arguments]             ${LIVRO_ESPERADO}
    ...                     ${TITLE_NAME}
    ...                     ${DESCRIPTION}
    ...                     ${PAGE_COUNT}
    Set Test Variable       ${LIVRO_ESPERADO}
    Set Test Variable       ${TITLE_NAME}
    Set Test Variable       ${DESCRIPTION}
    Set Test Variable       ${PAGE_COUNT}

    ${HEADERS}              Create Dictionary
    ...                     Content-type=application/json
    ...                     v=1.0

    ${RESPOSTA}             PUT On Session
    ...                     fakerestAPI
    ...                     /api/v1/Books/${LIVRO_ESPERADO}   # declarando método a URL + endpoit
    ...                     headers=${HEADERS}
    ...                     data={"id": 0,"title": "${TITLE_NAME}","description": "${DESCRIPTION}","pageCount": ${PAGE_COUNT},"excerpt": "Test-PUT","publishDate": "2022-06-26T15:03:09.866Z"}
    Log                     ${RESPOSTA.text}

    Set Test Variable       ${RESPOSTA}

    ${VALUES_DICTIONARY}    Create Dictionary
    ...                     title=${RESPOSTA.json()["title"]}
    ...                     description=${RESPOSTA.json()["description"]}
    ...                     pageCount=${RESPOSTA.json()["pageCount"]}
    Set Test Variable       ${VALUES_DICTIONARY}

Delete A Book
    [Arguments]             ${LIVRO_ESPERADO}
    ${RESPOSTA}             DELETE On Session
    ...                     fakerestAPI
    ...                     api/v1/Books/${LIVRO_ESPERADO}
    Set Test Variable       ${RESPOSTA}
