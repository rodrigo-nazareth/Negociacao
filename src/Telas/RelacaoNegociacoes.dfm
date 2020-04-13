inherited FormRelacaoNegociacoes: TFormRelacaoNegociacoes
  Caption = 'Rela'#231#227'o de Negocia'#231#245'es'
  ClientHeight = 516
  ClientWidth = 956
  FormStyle = fsMDIChild
  Visible = True
  ExplicitWidth = 972
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotoes: TPanel
    Top = 486
    Width = 956
    ExplicitTop = 486
    ExplicitWidth = 956
    inherited btnSair: TBitBtn
      Left = 877
      ExplicitLeft = 877
    end
    object BitBtn1: TBitBtn
      Left = 4
      Top = 2
      Width = 119
      Height = 25
      Caption = 'Imprimir'
      Kind = bkAll
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object pcRelacaoNegociacao: TPageControl
    Left = 0
    Top = 0
    Width = 956
    Height = 486
    ActivePage = tsResultado
    Align = alClient
    TabOrder = 1
    object tsFiltros: TTabSheet
      Caption = 'Filtros'
    end
    object tsResultado: TTabSheet
      Caption = 'Resultado'
      ImageIndex = 1
      object sgResultado: TStringGrid
        Left = 0
        Top = 15
        Width = 948
        Height = 443
        Align = alClient
        ColCount = 8
        DefaultRowHeight = 19
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goHorzLine]
        TabOrder = 0
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
