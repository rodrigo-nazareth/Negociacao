inherited FormCadastroProdutor: TFormCadastroProdutor
  Caption = 'Cadastro de Produtor'
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel [0]
    Left = 9
    Top = 5
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object lbRazaoSocial: TLabel [1]
    Left = 79
    Top = 5
    Width = 60
    Height = 13
    Caption = 'Raz'#227'o Social'
  end
  object lbNomeFantasia: TLabel [2]
    Left = 9
    Top = 52
    Width = 69
    Height = 13
    Caption = 'Nome fantasia'
  end
  object lbCpfCnpj: TLabel [3]
    Left = 261
    Top = 52
    Width = 48
    Height = 13
    Caption = 'CPF/CPNJ'
  end
  inherited pnBotoes: TPanel
    TabOrder = 4
  end
  object eCodigo: TEdit
    Left = 9
    Top = 21
    Width = 64
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnKeyDown = TeclaEnter
  end
  object eRazaoSocial: TEdit
    Left = 79
    Top = 21
    Width = 393
    Height = 21
    MaxLength = 150
    NumbersOnly = True
    TabOrder = 1
    OnKeyDown = TeclaEnter
  end
  object eNomeFantasia: TEdit
    Left = 9
    Top = 68
    Width = 246
    Height = 21
    MaxLength = 50
    NumbersOnly = True
    TabOrder = 2
    OnKeyDown = TeclaEnter
  end
  object eCpfCnpj: TEdit
    Left = 261
    Top = 68
    Width = 211
    Height = 21
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 3
    OnKeyDown = TeclaEnter
  end
end
