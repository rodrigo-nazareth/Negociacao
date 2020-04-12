inherited FormCadastroPessoa: TFormCadastroPessoa
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 193
  ClientWidth = 401
  ExplicitWidth = 407
  ExplicitHeight = 222
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel [0]
    Left = 9
    Top = 3
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object lblCpfCnpj: TLabel [1]
    Left = 79
    Top = 3
    Width = 23
    Height = 13
    Caption = 'CPF:'
  end
  inherited pnBotoes: TPanel
    Top = 163
    Width = 401
    TabOrder = 4
    inherited btnSair: TBitBtn
      Left = 323
      ExplicitLeft = 323
    end
    inherited btnCancelar: TBitBtn
      Left = 154
      ExplicitLeft = 154
    end
    inherited btnGravar: TBitBtn
      Left = 78
      ExplicitLeft = 78
    end
    inherited btnPesquisar: TBitBtn
      Left = 1
      ExplicitLeft = 1
    end
    inherited btnExcluir: TBitBtn
      Left = 244
      ExplicitLeft = 244
    end
  end
  object eCodigo: TEdit [3]
    Left = 9
    Top = 19
    Width = 64
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnKeyDown = eCodigoKeyDown
  end
  object mskEdtCpfCnpj: TMaskEdit [4]
    Left = 79
    Top = 19
    Width = 120
    Height = 21
    Enabled = False
    EditMask = '999.999.999-99;1;_'
    MaxLength = 14
    TabOrder = 1
    Text = '   .   .   -  '
    OnKeyDown = TeclaEnter
    OnKeyPress = mskEdtCpfCnpjKeyPress
  end
  object eNomeRazaoSocial: TLabeledEdit [5]
    Left = 9
    Top = 63
    Width = 235
    Height = 21
    EditLabel.Width = 60
    EditLabel.Height = 13
    EditLabel.Caption = 'Raz'#227'o Social'
    Enabled = False
    TabOrder = 2
    OnKeyDown = TeclaEnter
  end
  object eNomeFantasia: TLabeledEdit [6]
    Left = 9
    Top = 110
    Width = 235
    Height = 21
    EditLabel.Width = 69
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome fantasia'
    Enabled = False
    TabOrder = 3
    OnKeyDown = TeclaEnter
  end
  inherited stAtalhos: TStaticText
    Top = 148
    Width = 401
    TabOrder = 5
    ExplicitTop = 128
  end
end
