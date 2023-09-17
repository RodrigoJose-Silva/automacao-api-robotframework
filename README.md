Necessário ter o Python (https://www.python.org/downloads/) instalado na máquina e configurado no PATH (versão superior sugerida 3.10.*)

Ter instalado o "robotframework" na máquina:
- para verificar ser já possui instalado executar o comando: <b>pip freeze</b> - este comando lista todas e quaisquer biblioteca Python instalada na máquina
- caso não tiver instalado, executar este comando para instalação: <b>pip install robotframework</b>

Utilizado a library HTTP RequestsLibrary (Python): <b>pip install robotframework-requests</b><br><br>

<h2><b>Comando de execução do teste / suite</b></h2>

<b>robot -d ./reports BooksAPI/test_api/test_api_books.robot</b><br>
<br>
<b>robot</b>= default<br>
<b>-d .\ reports</b>= informa o diretório onde salvará os LOGS / REPORTS<br>
<b>BooksAPI/test_api/test_api_books.robot</b>= suite de teste a ser executado.

