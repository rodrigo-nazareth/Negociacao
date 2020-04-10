inherited FormBuscarCaminhoBanco: TFormBuscarCaminhoBanco
  BorderIcons = [biSystemMenu]
  Caption = 'Buscar Caminho Banco'
  ClientHeight = 76
  ClientWidth = 356
  Position = poScreenCenter
  ExplicitWidth = 372
  ExplicitHeight = 115
  PixelsPerInch = 96
  TextHeight = 13
  object lbCaminho: TLabel [0]
    Left = 8
    Top = 4
    Width = 135
    Height = 13
    Caption = 'Caminho do banco de dados'
  end
  inherited pnBotoes: TPanel
    Top = 48
    Width = 356
    ExplicitTop = 48
    ExplicitWidth = 356
    inherited btnSair: TBitBtn
      Left = 273
      TabOrder = 1
      ExplicitLeft = 273
    end
    object btOk: TBitBtn
      Left = 8
      Top = 4
      Width = 56
      Height = 22
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object eCaminho: TEdit
    Left = 8
    Top = 21
    Width = 259
    Height = 21
    TabOrder = 1
    TextHint = 'Informe o caminho banco (.FDB)'
  end
  object bBuscar: TButton
    Left = 273
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 2
    OnClick = bBuscarClick
  end
  object opArquivo: TOpenDialog
    Filter = 'Arquivo de banco (*.FDB)|*.FDB'
    Title = 'Buscar Arquivo Banco'
    Left = 156
    Top = 48
  end
end
