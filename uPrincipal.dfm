object frmPrincipal: TfrmPrincipal
  Left = 192
  Top = 145
  Caption = 'Comunica'#231#227'o com Firestore'
  ClientHeight = 591
  ClientWidth = 687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 141
    Width = 52
    Height = 13
    Caption = 'User email:'
  end
  object Label2: TLabel
    Left = 328
    Top = 141
    Width = 31
    Height = 13
    Caption = 'Senha'
  end
  object Label3: TLabel
    Left = 213
    Top = 217
    Width = 265
    Height = 13
    Caption = 'Id do Documento salvo ou preencher para filtrar no GET'
  end
  object Label4: TLabel
    Left = 15
    Top = 13
    Width = 107
    Height = 13
    Caption = 'Chave de API da Web'
  end
  object Label5: TLabel
    Left = 39
    Top = 40
    Width = 83
    Height = 13
    Caption = 'C'#243'digo do projeto'
  end
  object Label6: TLabel
    Left = 25
    Top = 83
    Width = 64
    Height = 13
    Caption = 'Cole'#231#227'o GET'
  end
  object Label7: TLabel
    Left = 241
    Top = 83
    Width = 71
    Height = 13
    Caption = 'Cole'#231#227'o POST'
  end
  object Label8: TLabel
    Left = 462
    Top = 83
    Width = 84
    Height = 13
    Caption = 'Cole'#231#227'o DELETE'
  end
  object EdtUserEmail: TEdit
    Left = 88
    Top = 136
    Width = 232
    Height = 21
    TabOrder = 0
    TextHint = 'uses@user.com'
  end
  object EdtSenha: TEdit
    Left = 368
    Top = 136
    Width = 217
    Height = 21
    TabOrder = 1
    TextHint = 'password'
  end
  object MmToken: TMemo
    Left = 0
    Top = 336
    Width = 687
    Height = 113
    Align = alBottom
    Lines.Strings = (
      'ID TOKEN')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object BtnLogin: TButton
    Left = 600
    Top = 131
    Width = 73
    Height = 25
    Caption = 'Login'
    TabOrder = 3
    OnClick = BtnLoginClick
  end
  object BtnGet: TButton
    Left = 96
    Top = 176
    Width = 105
    Height = 25
    Caption = 'Get'
    TabOrder = 4
    OnClick = BtnGetClick
  end
  object BtnPost: TButton
    Left = 224
    Top = 176
    Width = 105
    Height = 25
    Caption = 'Post'
    TabOrder = 5
    OnClick = BtnPostClick
  end
  object BtnDelete: TButton
    Left = 360
    Top = 176
    Width = 105
    Height = 25
    Caption = 'Delete'
    TabOrder = 6
    OnClick = BtnDeleteClick
  end
  object MmRetornoApi: TMemo
    Left = 0
    Top = 449
    Width = 687
    Height = 142
    Align = alBottom
    Lines.Strings = (
      'RETORNOS API')
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object EdtIdDocumento: TEdit
    Left = 227
    Top = 236
    Width = 232
    Height = 21
    TabOrder = 8
  end
  object EdtChaveApiWeb: TEdit
    Left = 128
    Top = 10
    Width = 545
    Height = 21
    TabOrder = 9
  end
  object EdtCodigoProjeto: TEdit
    Left = 128
    Top = 37
    Width = 545
    Height = 21
    TabOrder = 10
  end
  object EdtColecaoGet: TEdit
    Left = 95
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 11
    TextHint = 'VendasPagas'
  end
  object EdtColecaoPost: TEdit
    Left = 318
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 12
    TextHint = 'Vendas'
  end
  object EdtColecaoDelete: TEdit
    Left = 552
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 13
    TextHint = 'Vendas'
  end
  object BtnRenovaToken: TButton
    Left = 496
    Top = 176
    Width = 105
    Height = 25
    Caption = 'Renova Token'
    TabOrder = 14
    OnClick = BtnRenovaTokenClick
  end
  object MmRefreshToken: TMemo
    Left = 0
    Top = 272
    Width = 687
    Height = 64
    Align = alBottom
    Lines.Strings = (
      'TOKEN REFRESH')
    ScrollBars = ssVertical
    TabOrder = 15
  end
end
