# Comunicação com Firebase Firestore em Delphi

Ola... Este é um projeto que ajuda na comunicação com Firebase Firestore.
A baixo explicarei como configurar e usar para testes.


# Como utilizar?

## Campo de preenchimento obrigatório

 1. Chave de API da Web;
 2. Código do projeto;
 3. E-mail e Senha para autenticação e captura do TOKEN;

## Autenticação e Captura de Token
O autenticação é necessário para recebermos o "Token" de comunicação com a API. La receberemos também o "Refresh Token" que será utilizado para renovação de token quando ele é vencido.

## Renovação de Token
A renovação de "Token" é necessária, pois após 1 hora ele vence. Para continuar mandando requisições, terá q ter o Token sempre valido.
Com a função de renovação de Token, não é necessário ficar fazendo login toda vez, apenas chamar essa função.

## Métodos HTTP

**GET**: Para efetuar um get, é necessário preencher no campo "Coleção GET" o nome da coleção que deseja buscar. 
Para capturar um registro específico dentro dessa coleção, é necessário preencher o campo "Id do Documento".

**POST**: Para efetuar o post, é necessário preencher o campo "Coleção POST" e ter feito o login, com isso, será guardado o "Id Token".
No método post é enviado um .JSON, deixei um modelo de exemplo de como ele deve ser gerado, é necessário apenas mudar os campos para os da sua coleção.
Após o post ter dado sucesso, o "Id do Documento" aparecera no campo "Id do Documento".

**DELETE**: Para efetuar um delete, é necessário preencher o campo "Coleção DELETE" e ter feito o login para ter o Token guardado. Será necessário ter preenchido o "Id do Documento" que deseja que seja excluído.

