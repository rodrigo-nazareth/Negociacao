inherited FormPesquisaBase: TFormPesquisaBase
  ActiveControl = eChave
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pesquisa Base'
  ClientHeight = 313
  ClientWidth = 509
  OldCreateOrder = True
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
    Top = 283
    Width = 509
    TabOrder = 3
    ExplicitTop = 283
    ExplicitWidth = 509
    DesignSize = (
      509
      30)
    inherited btnSair: TBitBtn
      Left = 427
      Top = 3
      ExplicitLeft = 427
      ExplicitTop = 3
    end
    object btnOk: TBitBtn
      Left = 6
      Top = 3
      Width = 75
      Height = 25
      Caption = 'OK'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
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
    TabOrder = 0
    OnKeyDown = TeclaEnter
  end
  object eChave: TEdit
    Left = 159
    Top = 23
    Width = 333
    Height = 21
    AutoSize = False
    CharCase = ecUpperCase
    TabOrder = 1
    OnKeyDown = TeclaEnter
  end
  object sgPesquisa: TStringGrid
    Left = 0
    Top = 55
    Width = 509
    Height = 213
    Align = alBottom
    ColCount = 2
    DefaultRowHeight = 19
    DrawingStyle = gdsClassic
    FixedColor = 15395562
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goHorzLine, goColSizing, goRowSelect]
    TabOrder = 2
    OnDblClick = sgPesquisaDblClick
    OnEnter = sgPesquisaEnter
    OnKeyDown = sgPesquisaKeyDown
    ColWidths = (
      64
      385)
  end
  object stAtalhos: TStaticText
    Left = 0
    Top = 268
    Width = 509
    Height = 15
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Clique em OK, Duplo clique ou [Enter] para selecionar | [ESC] pa' +
      'ra sair'
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
