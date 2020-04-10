object FormPrincipal: TFormPrincipal
  Left = 194
  Top = 111
  Caption = 'Principal'
  ClientHeight = 419
  ClientWidth = 662
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmPrincipal
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 400
    Width = 662
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoHint = True
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = True
  end
  object mmPrincipal: TMainMenu
    Left = 16
    Top = 23
    object miCadastros: TMenuItem
      Caption = 'Cadastros'
      object miProdutor: TMenuItem
        Caption = 'Produtor'
        OnClick = miProdutorClick
      end
      object miDistribuidor: TMenuItem
        Caption = 'Distribuidor'
        OnClick = miDistribuidorClick
      end
      object miProduto: TMenuItem
        Caption = 'Produto'
        OnClick = miProdutoClick
      end
    end
    object miNegociacao: TMenuItem
      Caption = 'Negocia'#231#227'o'
      object miCadastroNegociacao: TMenuItem
        Caption = 'Cadastro de negocia'#231#227'o'
        OnClick = miCadastroNegociacaoClick
      end
      object miManutencaoNegociacao: TMenuItem
        Caption = 'Manuten'#231#227'o de negocia'#231#227'o'
        OnClick = miManutencaoNegociacaoClick
      end
    end
    object Relatrio1: TMenuItem
      Caption = 'Relat'#243'rio'
      object miRelacaoNegociacao: TMenuItem
        Caption = 'Relat'#243'rio de negocia'#231#227'o'
        OnClick = miRelacaoNegociacaoClick
      end
    end
    object miAjuda: TMenuItem
      Caption = 'Ajuda'
      object miTestarConexao: TMenuItem
        Caption = 'Testar conex'#227'o'
        OnClick = miTestarConexaoClick
      end
    end
    object miSair: TMenuItem
      Caption = 'Sair'
      OnClick = miSairClick
    end
  end
end
