object frmPrincipal: TfrmPrincipal
  Left = 192
  Top = 145
  Caption = 'Principal'
  ClientHeight = 592
  ClientWidth = 691
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
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
    Left = 15
    Top = 222
    Width = 67
    Height = 13
    Caption = 'Id Documento'
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
  object edtUserEmail: TEdit
    Left = 88
    Top = 136
    Width = 232
    Height = 21
    TabOrder = 0
    Text = 'suporte@alfasistemas.com.br'
  end
  object edtSenha: TEdit
    Left = 368
    Top = 136
    Width = 217
    Height = 21
    TabOrder = 1
    Text = '#123alfa321@'
  end
  object mmToken: TMemo
    Left = 0
    Top = 328
    Width = 691
    Height = 122
    Align = alBottom
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 2
    ExplicitTop = 358
  end
  object btnLogin: TButton
    Left = 600
    Top = 131
    Width = 73
    Height = 25
    Caption = 'Login'
    TabOrder = 3
    OnClick = btnLoginClick
  end
  object btnGet: TButton
    Left = 96
    Top = 176
    Width = 105
    Height = 25
    Caption = 'Get'
    TabOrder = 4
    OnClick = btnGetClick
  end
  object btnPost: TButton
    Left = 224
    Top = 176
    Width = 105
    Height = 25
    Caption = 'Post'
    TabOrder = 5
    OnClick = btnPostClick
  end
  object btnDelete: TButton
    Left = 360
    Top = 176
    Width = 105
    Height = 25
    Caption = 'Delete'
    TabOrder = 6
    OnClick = btnDeleteClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 450
    Width = 691
    Height = 142
    Align = alBottom
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object edtIdDocumento: TEdit
    Left = 88
    Top = 219
    Width = 232
    Height = 21
    TabOrder = 8
  end
  object edtChaveApiWeb: TEdit
    Left = 128
    Top = 10
    Width = 545
    Height = 21
    TabOrder = 9
  end
  object edtCodigoProjeto: TEdit
    Left = 128
    Top = 37
    Width = 545
    Height = 21
    TabOrder = 10
  end
  object edtColecaoGet: TEdit
    Left = 95
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 11
    TextHint = 'VendasPagas'
  end
  object edtColecaoPost: TEdit
    Left = 318
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 12
    TextHint = 'Vendas'
  end
  object edtColecaoDelete: TEdit
    Left = 552
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 13
    TextHint = 'Vendas'
  end
  object btnRenovaToken: TButton
    Left = 496
    Top = 176
    Width = 105
    Height = 25
    Caption = 'Renova Token'
    TabOrder = 14
    OnClick = btnRenovaTokenClick
  end
  object mmRefreshToken: TMemo
    Left = 0
    Top = 264
    Width = 691
    Height = 64
    Align = alBottom
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 15
  end
end
