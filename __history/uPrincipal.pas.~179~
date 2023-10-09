unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, uLkJSON;

type
  TfrmPrincipal = class(TForm)
    edtUserEmail: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    mmToken: TMemo;
    btnLogin: TButton;
    btnGet: TButton;
    btnPost: TButton;
    btnDelete: TButton;
    Memo1: TMemo;
    edtIdDocumento: TEdit;
    Label3: TLabel;
    edtChaveApiWeb: TEdit;
    Label4: TLabel;
    edtCodigoProjeto: TEdit;
    Label5: TLabel;
    edtColecaoGet: TEdit;
    Label6: TLabel;
    edtColecaoPost: TEdit;
    Label7: TLabel;
    edtColecaoDelete: TEdit;
    Label8: TLabel;
    btnRenovaToken: TButton;
    mmRefreshToken: TMemo;
    procedure btnGetClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnRenovaTokenClick(Sender: TObject);
  private
    function ExtractFieldFromJson(const jsonString: WideString; field: string): string;
  public
    function autenticarUsuario(const email, password : string): string;
    function PostHttp(pUrl, pToken, pPayload : WideString) : WideString;
    function PostHttpFormData(pUrl, pToken : WideString; pPayload : String) : WideString; stdcall;
    function GetHttp(pUrl, pToken : WideString) : WideString;
    function DeleteHttp(pUrl, pToken : WideString): WideString;
  end;

var
  frmPrincipal: TfrmPrincipal;

//  function PostHttp(pUrl, pToken, pPayload : WideString) : WideString; stdcall; external 'metodosHttp.dll';

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnDeleteClick(Sender: TObject);
var response, url : WideString;
begin
  //DELETA COBRANCA GERADA
  url := 'https://firestore.googleapis.com/v1/projects/'+Trim(edtCodigoProjeto.Text)+'/databases/(default)/documents/'+Trim(edtColecaoDelete.Text)+'/' + edtIdDocumento.Text;
  response := DeleteHttp(url, mmToken.Text);
  Memo1.Text := response;
end;

procedure TfrmPrincipal.btnGetClick(Sender: TObject);
var response, url : WideString;
begin
  //PUXA TODAS AS COBRANCAS PAGAS, PARA FILTRAR UMA ESPECIFICA COLOCAR NO FINAL DO LINK O ID DO DOCUMENTO
  url := 'https://firestore.googleapis.com/v1/projects/'+Trim(edtCodigoProjeto.Text)+'/databases/(default)/documents/'+Trim(edtColecaoGet.Text);
  response := GetHttp(url, mmToken.Text);
  Memo1.Text := response;
end;

procedure TfrmPrincipal.btnPostClick(Sender: TObject);
var response, jsonRequest : WideString;
  url, fieldName, idDocument: string;
  lastSlashPos : Integer;
begin
  //CRIA UMA COBRANÇA

  //MODELO DO JSON
  jsonRequest := '{' +
    '"fields":{' +
      '"formaPagamento":{' +
        '"stringValue":"debito"' +
      '},' +
      '"parcelas":{' +
        '"integerValue":"1"' +
      '},' +
      '"identificador":{' +
        '"stringValue":"abc"' +
      '},' +
      '"cnpj":{' +
        '"stringValue":"18832921000186"' +
      '},' +
      '"valor":{' +
        '"integerValue":"150"'+
      '},'+
      '"nome":{'+
        '"stringValue":"Alfa Sistemas"'+
      '},'+
      '"codigo":{'+
        '"integerValue":"123"'+
      '},' +
      '"emailCliente":{'+
        '"stringValue":"suporte@alfasistemas.com.br"'+
      '}' +
    '},' +
    '"createTime":"2023-10-03T20:36:53.684801Z",' +
    '"updateTime":"2023-10-03T20:36:53.684801Z"' +
    '}';

  url := 'https://firestore.googleapis.com/v1/projects/'+Trim(edtCodigoProjeto.Text)+'/databases/(default)/documents/'+Trim(edtColecaoPost.Text)+'/';
  response := PostHttp(url, mmToken.Text, jsonRequest);

  //Pega o valor que esta no json retornado na field passada de parametro
  fieldName := ExtractFieldFromJson(response, 'name');

  // Encontra a posição da última barra na string
  lastSlashPos := LastDelimiter('/', fieldName);

  if lastSlashPos > 0 then
    idDocument := Copy(fieldName, LastSlashPos + 1, Length(fieldName) - LastSlashPos) // Extrai o conteúdo após a última barra
  else
    idDocument := fieldName; // Se não houver barra na string, o resultado é a própria string

  edtIdDocumento.Text := idDocument;
  Memo1.Text := response;
end;

procedure TfrmPrincipal.btnRenovaTokenClick(Sender: TObject);
var urlPost, retornoTokenAtualizado : WideString;
begin
  urlPost := 'https://securetoken.googleapis.com/v1/token?key=AIzaSyCHI2Cqm5FowD-mJbRPrKPoVidH_CZHF74';
  retornoTokenAtualizado := PostHttpFormData(urlPost, '', '&grant_type=refresh_token&refresh_token=' + mmRefreshToken.Text);
end;

function TfrmPrincipal.autenticarUsuario(const email,
  password: string): string;
var response, jsonRequest : WideString;
  url, idToken : string;
begin
  //LOGAR COM O USUARIO E CAPTURAR O TOKEN
  jsonRequest := '{"email":"' + Email + '","password":"' + Password + '","returnSecureToken":true}';

  url := 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=' + Trim(edtChaveApiWeb.Text);
  response := PostHttp(url, '', jsonRequest);

  idToken := ExtractFieldFromJson(response, 'idToken');
  mmRefreshToken.Text := ExtractFieldFromJson(response, 'refreshToken');
  mmToken.Text := idToken;
end;

procedure TfrmPrincipal.btnLoginClick(Sender: TObject);
begin
  autenticarUsuario(edtUserEmail.Text, edtSenha.Text);
end;

function TfrmPrincipal.ExtractFieldFromJson(
  const jsonString: WideString; field: string): string;
var
  jsonObject: TlkJSONobject;
  fieldObject: TlkJSONbase;
  fieldContent: string;
begin
  Result := '';

  // Cria um objeto JSON a partir da string WideString
  jsonObject := TlkJSON.ParseText(jsonString) as TlkJSONobject;
  try
    // Verifica se o objeto JSON é atribuído e contém o campo recebido de parametro
    if Assigned(jsonObject) then
    begin
      fieldObject := jsonObject.Field[field];
      if Assigned(fieldObject) and (fieldObject is TlkJSONstring) then
      begin
        // Converte o objeto para TlkJSONstring e obtém o valor
        fieldContent := TlkJSONstring(fieldObject).Value;
        Result := fieldContent;
      end;
    end;
  finally
    // Libera o objeto JSON
    jsonObject.Free;
  end;
end;

function TfrmPrincipal.GetHttp(pUrl, pToken: WideString): WideString;
var http : THTTPClient;
    resp, response : TStringStream;
    ret : IHTTPResponse;
begin
  result := '';
  if (pUrl = '') then
    exit;

  http := THTTPClient.Create;
  resp := TStringStream.Create;
  response := TStringStream.Create;
  try
    if (pToken <> '') then
      http.CustomHeaders['Authorization'] := 'Bearer '+ pToken;

    ret := http.Get(pUrl, response);

    if (ret.StatusCode.ToString.Contains('20')) then
      result := response.DataString
    else
      result := 'erro';
  finally
    response.Free;
    resp.Free;
    http.Free;
  end;
end;

function TfrmPrincipal.PostHttp(pUrl, pToken, pPayload: WideString): WideString;
var http : THTTPClient;
  resp, payload : TStringStream;
  ret : IHTTPResponse;
begin
  result := '';
  if (pUrl = '') then
    exit;

  payload := nil;
  http := THTTPClient.Create;
  resp := TStringStream.Create;
  try
    if (pToken <> '') then
      http.CustomHeaders['Authorization'] := 'Bearer '+ pToken;

    if (trim(pPayload) <> '') then
    begin
      payload := TStringStream.Create(pPayload, TEncoding.UTF8);
      payload.Position := 0;
    end;
    ret := http.Post(pUrl, payload, resp);

    if (ret.StatusCode.ToString.Contains('20')) then
      result := resp.DataString
    else
      result := resp.DataString;
  finally
    if (payload <> nil) then
      payload.Free;

    resp.Free;
    http.Free;
  end;
end;

function TfrmPrincipal.DeleteHttp(pUrl, pToken : WideString): WideString;
var http : THTTPClient;
    resp : TStringStream;
    ret : IHTTPResponse;
begin
  result := '';
  if (pUrl = '') then
    exit;

  http := THTTPClient.Create;
  resp := TStringStream.Create;
  try
    if (pToken <> '') then
      http.CustomHeaders['Authorization'] := 'Bearer '+ pToken;
    ret := http.Delete(pUrl, resp);

    if (ret.StatusCode.ToString.Contains('20')) then
      result := resp.DataString
    else
      result := 'erro';
  finally
    resp.Free;
    http.Free;
  end;
end;

function TfrmPrincipal.PostHttpFormData(pUrl, pToken : WideString; pPayload : String) : WideString; stdcall;
var http : THTTPClient;
    resp, payload : TStringStream;
    ret : IHTTPResponse;
    Params : TStringList;
    keyValuePairs: TArray<string>;
    pair: string;
begin
  result := '';
  if (pUrl = '') then
    exit;

  payload := nil;
  http := THTTPClient.Create;
  resp := TStringStream.Create;
  try
    if (pToken <> '') then
      http.CustomHeaders['Authorization'] := 'Bearer '+ pToken;

    http.ContentType := 'application/x-www-form-urlencoded';

    if (trim(pPayload) <> '') then
    begin
      Params := TStringList.Create;

      // Remover o primeiro caractere "&" da string de entrada e dividir em pares "chave=valor"
      keyValuePairs := pPayload.Substring(1).Split(['&']);

      // Dividir cada par em chave e valor e adicionar ao TStringList
      for pair in keyValuePairs do
      begin
        Params.Add(pair);
      end;

    end;
    ret := http.Post(pUrl, Params, resp);

    if (ret.StatusCode.ToString.Contains('20')) then
      result := resp.DataString
    else
      result := 'erro';
  finally
    if (payload <> nil) then
      payload.Free;

    resp.Free;
    http.Free;
  end;
end;

end.
