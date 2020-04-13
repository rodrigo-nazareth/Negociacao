inherited FormPesquisaProduto: TFormPesquisaProduto
  Caption = 'Pesquisa de Produto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited cbFiltros: TComboBox
    ItemIndex = 0
    Text = 'Nome produto'
    Items.Strings = (
      'Nome produto')
  end
  inherited sgPesquisa: TStringGrid
    ColWidths = (
      64
      403)
  end
end
