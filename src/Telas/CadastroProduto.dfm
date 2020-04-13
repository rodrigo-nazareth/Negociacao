inherited FormCadastroProduto: TFormCadastroProduto
  ActiveControl = eCodigo
  Caption = 'Cadastro de Produto'
  ClientHeight = 144
  ClientWidth = 426
  ExplicitWidth = 432
  ExplicitHeight = 173
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel [0]
    Left = 9
    Top = 3
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  inherited pnBotoes: TPanel
    Top = 114
    Width = 426
    TabOrder = 3
    ExplicitTop = 114
    ExplicitWidth = 426
    inherited btnSair: TBitBtn
      Left = 345
      ExplicitLeft = 345
    end
    inherited btnExcluir: TBitBtn
      Left = 264
      ExplicitLeft = 264
    end
  end
  inherited stAtalhos: TStaticText
    Top = 99
    Width = 426
    TabOrder = 4
    ExplicitTop = 99
    ExplicitWidth = 426
  end
  object eCodigo: TEdit
    Left = 9
    Top = 19
    Width = 63
    Height = 21
    Alignment = taRightJustify
    NumbersOnly = True
    TabOrder = 0
    OnKeyDown = eCodigoKeyDown
    OnKeyPress = SoNumerosInt
  end
  object eNome: TLabeledEdit
    Left = 9
    Top = 63
    Width = 235
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    Enabled = False
    MaxLength = 150
    TabOrder = 1
    OnKeyDown = TeclaEnter
  end
  object ePreco: TLabeledEdit
    Left = 261
    Top = 63
    Width = 135
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Pre'#231'o'
    EditLabel.ParentBiDiMode = False
    Enabled = False
    MaxLength = 20
    TabOrder = 2
    OnExit = ePrecoExit
    OnKeyDown = TeclaEnter
    OnKeyPress = SoNumerosDbl
  end
end
