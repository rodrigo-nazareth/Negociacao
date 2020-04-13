inherited FormPesquisaGenericaFrame: TFormPesquisaGenericaFrame
  Caption = 'Pesquisa Gen'#233'rica'
  PixelsPerInch = 96
  TextHeight = 13
  inherited cbFiltros: TComboBox
    ItemIndex = 0
    Text = 'Nome'
    Items.Strings = (
      'Nome')
  end
  inherited sgPesquisa: TStringGrid
    Top = 50
    Height = 203
    ColCount = 3
    ExplicitTop = 50
    ExplicitHeight = 203
    ColWidths = (
      41
      71
      369)
  end
  inherited stAtalhos: TStaticText
    ExplicitLeft = 29
    ExplicitTop = 274
  end
  object stAtalhos2: TStaticText
    Left = 0
    Top = 253
    Width = 509
    Height = 15
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Tecle [Espa'#231'o] para selecionar um registro ou [Ctrl + T] para se' +
      'lecionar todos'
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 5
    Transparent = False
    ExplicitLeft = -8
    ExplicitTop = 259
  end
end
