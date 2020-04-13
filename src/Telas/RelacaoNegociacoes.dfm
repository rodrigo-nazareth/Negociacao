inherited FormRelacaoNegociacoes: TFormRelacaoNegociacoes
  Caption = 'Rela'#231#227'o de Negocia'#231#245'es'
  ClientHeight = 625
  ClientWidth = 956
  FormStyle = fsMDIChild
  Visible = True
  ExplicitWidth = 972
  ExplicitHeight = 664
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotoes: TPanel
    Top = 595
    Width = 956
    ExplicitTop = 486
    ExplicitWidth = 956
    object sbImprimir: TSpeedButton [0]
      Left = 405
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Imprimir'
      OnClick = sbImprimirClick
    end
    inherited btnSair: TBitBtn
      Left = 877
      ExplicitLeft = 877
    end
    object btnProcessar: TBitBtn
      Left = 4
      Top = 2
      Width = 109
      Height = 25
      Caption = 'Processar'
      Kind = bkRetry
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnProcessarClick
    end
  end
  object pcRelacaoNegociacao: TPageControl
    Left = 0
    Top = 0
    Width = 956
    Height = 595
    ActivePage = tsFiltros
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 486
    object tsFiltros: TTabSheet
      Caption = 'Filtros'
      ExplicitLeft = -47
      ExplicitTop = -5
      ExplicitHeight = 458
      object Label1: TLabel
        Left = 4
        Top = 10
        Width = 31
        Height = 13
        Caption = 'Status'
      end
      inline frProdutor: TFramePesquisa
        Left = 4
        Top = 60
        Width = 280
        Height = 40
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 60
        ExplicitWidth = 280
        ExplicitHeight = 40
        inherited pnPesquisar: TPanel
          Left = 245
          Width = 35
          Height = 24
          ExplicitLeft = 245
          ExplicitWidth = 35
          ExplicitHeight = 24
        end
        inherited sgConsulta: TStringGrid
          Width = 245
          Height = 24
          ScrollBars = ssNone
          ExplicitWidth = 245
          ExplicitHeight = 24
        end
        inherited PnTitulos: TPanel
          Width = 280
          ExplicitWidth = 280
          inherited lbCampo: TLabel
            Height = 15
            Caption = 'Produtor'
          end
          inherited Panel2: TPanel
            Left = 255
            ExplicitLeft = 255
          end
          inherited CkChaveUnica: TCheckBox
            Left = 75
            Top = 3
            Checked = True
            State = cbChecked
            ExplicitLeft = 75
            ExplicitTop = 3
          end
          inherited ckSomenteLeitura: TCheckBox
            Checked = True
            State = cbChecked
          end
        end
      end
      inline frDistribuidor: TFramePesquisa
        Left = 4
        Top = 110
        Width = 280
        Height = 39
        TabOrder = 1
        ExplicitLeft = 4
        ExplicitTop = 110
        ExplicitWidth = 280
        ExplicitHeight = 39
        inherited pnPesquisar: TPanel
          Left = 245
          Width = 35
          Height = 23
          ExplicitLeft = 245
          ExplicitWidth = 35
          ExplicitHeight = 23
        end
        inherited sgConsulta: TStringGrid
          Width = 245
          Height = 23
          ScrollBars = ssNone
          ExplicitWidth = 245
          ExplicitHeight = 23
        end
        inherited PnTitulos: TPanel
          Width = 280
          ExplicitWidth = 280
          inherited lbCampo: TLabel
            Width = 54
            Height = 15
            Caption = 'Distribuidor'
            ExplicitWidth = 54
          end
          inherited Panel2: TPanel
            Left = 255
            ExplicitLeft = 255
          end
          inherited CkChaveUnica: TCheckBox
            Left = 74
            Top = 1
            Checked = True
            State = cbChecked
            ExplicitLeft = 74
            ExplicitTop = 1
          end
          inherited ckSomenteLeitura: TCheckBox
            Checked = True
            State = cbChecked
          end
        end
      end
      object cbFiltros: TComboBox
        Left = 4
        Top = 29
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 4
        TabOrder = 2
        Text = 'N'#227'o filtrar'
        Items.Strings = (
          'Pendente'
          'Aprovada'
          'Conclu'#237'da'
          'Cancelada'
          'N'#227'o filtrar')
      end
    end
    object tsResultado: TTabSheet
      Caption = 'Resultado'
      ImageIndex = 1
      ExplicitHeight = 458
      object sgResultado: TStringGrid
        Left = 0
        Top = 15
        Width = 948
        Height = 552
        Align = alClient
        ColCount = 8
        DefaultRowHeight = 19
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goHorzLine]
        TabOrder = 0
        ExplicitHeight = 443
        ColWidths = (
          125
          144
          83
          110
          110
          110
          110
          110)
      end
      object stAtalhos: TStaticText
        Left = 0
        Top = 0
        Width = 948
        Height = 15
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Dados negocia'#231#227'o'
        Color = 15395562
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        Transparent = False
      end
    end
  end
end
