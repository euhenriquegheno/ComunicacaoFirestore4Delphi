# ENGLISH
# Communication with Firebase Firestore in Delphi

Hello... This is a project that helps in communicating with Firebase Firestore.
Below I will explain how to configure and use it for testing.


# How to use?

## Mandatory field

 1. Web API Key;
 2. Project code;
 3. Email and Password for authentication and TOKEN capture;

## Authentication and Token Capture
Authentication is necessary to receive the "Token" for communicating with the API. There we will also receive the "Refresh Token" which will be used to renew the token when it expires.

## Token Renewal
"Token" renewal is necessary, as after 1 hour it expires. To continue sending requests, the Token must always be valid.
With the Token renewal function, there is no need to log in every time, just call this function.

## HTTP Methods

**GET**: To perform a get, you must fill in the name of the collection you want to search in the "GET Collection" field. 
To capture a specific record within this collection, it is necessary to fill in the "Document Id" field.

**POST**: To post, you must fill in the "POST Collection" field and have logged in, thus, the "Id Token" will be saved.
In the post method a .JSON is sent, I left an example model of how it should be generated, you just need to change the fields to those in your collection.
After the post is successful, the "Document Id" will appear in the "Document Id" field.

**DELETE**: To perform a delete, you must fill in the "DELETE Collection" field and be logged in to have the Token saved. You will need to have filled in the "Document Id" that you want to be deleted.

-

# PORTUGUES
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

