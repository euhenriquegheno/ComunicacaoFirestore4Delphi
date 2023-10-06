# Comunicação com Firebase Firestore com Delphi

Ola... Este é um projeto que ajuda na comunicação com Firebase Firestore.
A baixo explicarei como configurar e usar para testes.


# Como utilizar?

## Campo de preenchimento obrigatório

Chave de API da Web;
Código do projeto;
Email e Senha para autenticação e captura do TOKEN;


## Métodos HTTP

**GET**: Para efetuar um get, é necessário preencher no campo "Coleção GET" o nome da coleção que deseja buscar. 
Para capturar um registro específico dentro dessa coleção, é necessário preencher o campo "Id do Documento".

**POST**: Para efetuar o post, é necessário preencher o campo "Coleção POST" e ter feito o login, com isso, será guardado o "Id Token".
No método post é enviado um .JSON, deixei um modelo de exemplo de como ele deve ser gerado, é necessário apenas mudar os campos para os da sua coleção.
Após o post ter dado sucesso, o "Id do Documento" aparecera no campo "Id do Documento".

**DELETE**: Para efetuar um delete, é necessário preencher o campo "Coleção DELETE" e ter feito o login para ter o Token guardado. Será necessário ter preenchido o "Id do Documento" que deseja que seja excluído.
