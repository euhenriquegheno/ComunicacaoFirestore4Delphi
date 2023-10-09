unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, uLkJSON;

type
  TfrmPrincipal = class(TForm)
    EdtUserEmail: TEdit;
    EdtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MmToken: TMemo;
    BtnLogin: TButton;
    BtnGet: TButton;
    BtnPost: TButton;
    BtnDelete: TButton;
    MmRetornoApi: TMemo;
    EdtIdDocumento: TEdit;
    Label3: TLabel;
    EdtChaveApiWeb: TEdit;
    Label4: TLabel;
    EdtCodigoProjeto: TEdit;
    Label5: TLabel;
    EdtColecaoGet: TEdit;
    Label6: TLabel;
    EdtColecaoPost: TEdit;
    Label7: TLabel;
    EdtColecaoDelete: TEdit;
    Label8: TLabel;
    BtnRenovaToken: TButton;
    MmRefreshToken: TMemo;
    procedure BtnGetClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure BtnPostClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnRenovaTokenClick(Sender: TObject);
  private
    function ExtractFieldFromJson(const JsonString: WideString; Field: string): string;
  public
    //Fun��o de autentica��o do usuario e captura de token e refresh token
    function AutenticarUsuario(const Email, Password : string): string;
    //Fun��o POST
    function PostHttp(pUrl, pToken, pPayload : WideString) : WideString;
    //Fun��o POST FORM DATA
    function PostHttpFormData(pUrl, pToken : WideString; pPayload : String) : WideString; stdcall;
    //Fun��o GET
    function GetHttp(pUrl, pToken : WideString) : WideString;
    //Fun��o DELETE
    function DeleteHttp(pUrl, pToken : WideString): WideString;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.BtnDeleteClick(Sender: TObject);
var Response, Url : WideString;
begin
  //DELETA COBRANCA GERADA
  Url := 'https://firestore.googleapis.com/v1/projects/'+Trim(EdtCodigoProjeto.Text)+'/databases/(default)/documents/'+Trim(EdtColecaoDelete.Text)+'/' + edtIdDocumento.Text;
  Response := DeleteHttp(Url, MmToken.Text);
  MmRetornoApi.Text := Response;
end;

procedure TfrmPrincipal.BtnGetClick(Sender: TObject);
var response, url : WideString;
begin
  //PUXA TODAS AS COBRANCAS PAGAS, PARA FILTRAR UMA ESPECIFICA COLOCAR NO FINAL DO LINK O ID DO DOCUMENTO
  Url := 'https://firestore.googleapis.com/v1/projects/'+Trim(EdtCodigoProjeto.Text)+'/databases/(default)/documents/'+Trim(EdtColecaoGet.Text);
  Response := GetHttp(Url, MmToken.Text);
  MmRetornoApi.Text := Response;
end;

procedure TfrmPrincipal.BtnPostClick(Sender: TObject);
var Response, JsonRequest : WideString;
  Url, FieldName, IdDocument: String;
  LastSlashPos : Integer;
begin
  //CRIA UMA COBRAN�A

  //MODELO DO JSON
  JsonRequest := '{' +
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

  Url := 'https://firestore.googleapis.com/v1/projects/'+Trim(EdtCodigoProjeto.Text)+'/databases/(default)/documents/'+Trim(EdtColecaoPost.Text)+'/';
  Response := PostHttp(Url, MmToken.Text, JsonRequest);

  //Pega o valor que esta no json retornado na field passada de parametro
  FieldName := ExtractFieldFromJson(Response, 'name');

  // Encontra a posi��o da �ltima barra na string
  LastSlashPos := LastDelimiter('/', FieldName);

  if (LastSlashPos > 0) then
    IdDocument := Copy(FieldName, LastSlashPos + 1, Length(FieldName) - LastSlashPos) // Extrai o conte�do ap�s a �ltima barra
  else
    IdDocument := FieldName; // Se n�o houver barra na string, o resultado � a pr�pria string

  EdtIdDocumento.Text := IdDocument;
  MmRetornoApi.Text := Response;
end;

procedure TfrmPrincipal.BtnRenovaTokenClick(Sender: TObject);
var UrlPost, RetornoTokenAtualizado : WideString;
begin
  UrlPost := 'https://securetoken.googleapis.com/v1/token?key=' + EdtChaveApiWeb.Text;
  RetornoTokenAtualizado := PostHttpFormData(UrlPost, '', '&grant_type=refresh_token&refresh_token=' + MmRefreshToken.Text);
end;

function TfrmPrincipal.AutenticarUsuario(const Email,
  Password: string): string;
var Response, JsonRequest : WideString;
  UrlPost, IdToken : string;
begin
  //LOGAR COM O USUARIO E CAPTURAR O TOKEN
  JsonRequest := '{"email":"' + Email + '","password":"' + Password + '","returnSecureToken":true}';

  UrlPost := 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=' + Trim(EdtChaveApiWeb.Text);
  Response := PostHttp(UrlPost, '', JsonRequest);

  IdToken := ExtractFieldFromJson(Response, 'idToken');
  MmRefreshToken.Text := ExtractFieldFromJson(Response, 'refreshToken');
  MmToken.Text := IdToken;
end;

procedure TfrmPrincipal.BtnLoginClick(Sender: TObject);
begin
  AutenticarUsuario(EdtUserEmail.Text, EdtSenha.Text);
end;

function TfrmPrincipal.ExtractFieldFromJson(
  const JsonString: WideString; Field: String): String;
var
  JsonObject: TlkJSONobject;
  FieldObject: TlkJSONbase;
  FieldContent: String;
begin
  Result := '';

  // Cria um objeto JSON a partir da string WideString
  JsonObject := TlkJSON.ParseText(JsonString) as TlkJSONobject;
  try
    // Verifica se o objeto JSON � atribu�do e cont�m o campo recebido de parametro
    if Assigned(JsonObject) then
    begin
      FieldObject := JsonObject.Field[Field];
      if Assigned(FieldObject) and (FieldObject is TlkJSONstring) then
      begin
        // Converte o objeto para TlkJSONstring e obt�m o valor
        FieldContent := TlkJSONstring(FieldObject).Value;
        Result := FieldContent;
      end;
    end;
  finally
    // Libera o objeto JSON
    JsonObject.Free;
  end;
end;

function TfrmPrincipal.GetHttp(pUrl, pToken: WideString): WideString;
var Http : THTTPClient;
    Resp, Response : TStringStream;
    Ret : IHTTPResponse;
begin
  result := '';
  if (pUrl = '') then
    exit;

  Http := THTTPClient.Create;
  Resp := TStringStream.Create;
  Response := TStringStream.Create;
  try
    if (pToken <> '') then
      Http.CustomHeaders['Authorization'] := 'Bearer '+ pToken;

    Ret := Http.Get(pUrl, Response);

    if (Ret.StatusCode.ToString.Contains('20')) then
      result := Response.DataString
    else
      result := 'erro';
  finally
    Response.Free;
    Resp.Free;
    Http.Free;
  end;
end;

function TfrmPrincipal.PostHttp(pUrl, pToken, pPayload: WideString): WideString;
var Http : THTTPClient;
  Resp, Payload : TStringStream;
  Ret : IHTTPResponse;
begin
  result := '';
  if (pUrl = '') then
    exit;

  Payload := nil;
  Http := THTTPClient.Create;
  Resp := TStringStream.Create;
  try
    if (pToken <> '') then
      Http.CustomHeaders['Authorization'] := 'Bearer '+ pToken;

    if (trim(pPayload) <> '') then
    begin
      Payload := TStringStream.Create(pPayload, TEncoding.UTF8);
      Payload.Position := 0;
    end;
    Ret := Http.Post(pUrl, Payload, Resp);

    if (Ret.StatusCode.ToString.Contains('20')) then
      result := Resp.DataString
    else
      result := Resp.DataString;
  finally
    if (Payload <> nil) then
      Payload.Free;

    Resp.Free;
    Http.Free;
  end;
end;

function TfrmPrincipal.DeleteHttp(pUrl, pToken : WideString): WideString;
var Http : THTTPClient;
    Resp : TStringStream;
    Ret : IHTTPResponse;
begin
  result := '';
  if (pUrl = '') then
    exit;

  Http := THTTPClient.Create;
  Resp := TStringStream.Create;
  try
    if (pToken <> '') then
      Http.CustomHeaders['Authorization'] := 'Bearer '+ pToken;
    ret := Http.Delete(pUrl, Resp);

    if (ret.StatusCode.ToString.Contains('20')) then
      result := Resp.DataString
    else
      result := 'erro';
  finally
    Resp.Free;
    Http.Free;
  end;
end;

function TfrmPrincipal.PostHttpFormData(pUrl, pToken : WideString; pPayload : String) : WideString; stdcall;
var Http : THTTPClient;
    Resp, Payload : TStringStream;
    Ret : IHTTPResponse;
    Params : TStringList;
    KeyValuePairs: TArray<string>;
    Pair: string;
begin
  result := '';
  if (pUrl = '') then
    exit;

  Payload := nil;
  Http := THTTPClient.Create;
  Resp := TStringStream.Create;
  try
    if (pToken <> '') then
      Http.CustomHeaders['Authorization'] := 'Bearer '+ pToken;

    Http.ContentType := 'application/x-www-form-urlencoded';

    if (trim(pPayload) <> '') then
    begin
      Params := TStringList.Create;

      // Remover o primeiro caractere "&" da string de entrada e dividir em pares "chave=valor"
      KeyValuePairs := pPayload.Substring(1).Split(['&']);

      // Dividir cada par em chave e valor e adicionar ao TStringList
      for Pair in KeyValuePairs do
      begin
        Params.Add(Pair);
      end;

    end;
    Ret := Http.Post(pUrl, Params, Resp);

    if (ret.StatusCode.ToString.Contains('20')) then
      result := Resp.DataString
    else
      result := 'erro';
  finally
    if (Payload <> nil) then
      Payload.Free;

    Resp.Free;
    Http.Free;
  end;
end;

end.
