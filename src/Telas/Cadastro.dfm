object FormCadastro: TFormCadastro
  Left = 0
  Top = 0
  Caption = 'Cadastro'
  ClientHeight = 284
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnBotoes: TPanel
    Left = 0
    Top = 253
    Width = 480
    Height = 31
    Align = alBottom
    Color = clCream
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object sbPesquisar: TSpeedButton
      Left = 5
      Top = 4
      Width = 68
      Height = 22
      Caption = 'Pesquisar'
      OnClick = sbPesquisarClick
    end
    object sbGravar: TSpeedButton
      Left = 91
      Top = 4
      Width = 68
      Height = 22
      Caption = 'Gravar'
      Enabled = False
      OnClick = sbGravarClick
    end
    object sbExcluir: TSpeedButton
      Left = 324
      Top = 4
      Width = 68
      Height = 22
      Caption = 'Excluir'
      Enabled = False
      OnClick = sbExcluirClick
    end
    object sbCancelar: TSpeedButton
      Left = 241
      Top = 4
      Width = 68
      Height = 22
      Caption = 'Cancelar'
      Enabled = False
      OnClick = sbCancelarClick
    end
  end
end
