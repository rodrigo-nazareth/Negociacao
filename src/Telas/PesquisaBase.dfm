inherited FormPesquisaBase: TFormPesquisaBase
  Caption = 'Pesquisa Base'
  ClientHeight = 303
  ClientWidth = 499
  OnKeyDown = FormKeyDown
  ExplicitWidth = 515
  ExplicitHeight = 342
  PixelsPerInch = 96
  TextHeight = 13
  object LbFiltros: TLabel [0]
    Left = 8
    Top = 7
    Width = 29
    Height = 13
    Caption = 'Filtros'
  end
  object LbChave: TLabel [1]
    Left = 159
    Top = 7
    Width = 101
    Height = 13
    Caption = 'Chave para pesquisa'
  end
  inherited pnBotoes: TPanel
    Top = 273
    Width = 499
    ExplicitTop = 273
    ExplicitWidth = 499
    DesignSize = (
      499
      30)
    inherited btnSair: TBitBtn
      Left = 417
      Top = 3
      ExplicitLeft = 417
      ExplicitTop = 3
    end
    object btnOk: TBitBtn
      Left = 6
      Top = 3
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object cbFiltros: TComboBox
    Left = 8
    Top = 23
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 1
  end
  object eChave: TEdit
    Left = 159
    Top = 23
    Width = 333
    Height = 21
    AutoSize = False
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object sgPesquisa: TStringGrid
    Left = 0
    Top = 51
    Width = 499
    Height = 205
    Align = alBottom
    ColCount = 2
    DefaultRowHeight = 19
    DrawingStyle = gdsClassic
    FixedColor = 15395562
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goHorzLine, goColSizing, goRowSelect]
    TabOrder = 3
    OnKeyDown = sgPesquisaKeyDown
    ColWidths = (
      64
      385)
  end
  object stAtalhos: TStaticText
    Left = 0
    Top = 256
    Width = 499
    Height = 17
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'Duplo clique ou [Enter] para selecionar | [ESC] para sair'
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 4
    Transparent = False
  end
end
