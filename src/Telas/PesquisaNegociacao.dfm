inherited FormPesquisaNegociacao: TFormPesquisaNegociacao
  Caption = 'Pesquisa de Negocia'#231#227'o'
  ClientWidth = 579
  ExplicitWidth = 585
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotoes: TPanel
    Width = 579
    inherited btnSair: TBitBtn
      Left = 497
    end
  end
  inherited cbFiltros: TComboBox
    ItemIndex = 1
    Text = 'Nome produtor'
    Items.Strings = (
      'C'#243'digo'
      'Nome produtor'
      'Nome distribuidor')
  end
  inherited sgPesquisa: TStringGrid
    Top = 56
    Width = 579
    Height = 212
    ColCount = 4
    ExplicitTop = 56
    ExplicitHeight = 212
    ColWidths = (
      45
      178
      204
      118)
  end
  inherited stAtalhos: TStaticText
    Width = 579
  end
end
