inherited FormRelacaoNegociacoes: TFormRelacaoNegociacoes
  Caption = 'Rela'#231#227'o de Negocia'#231#245'es'
  ClientHeight = 514
  ClientWidth = 940
  FormStyle = fsMDIChild
  Visible = True
  ExplicitWidth = 956
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotoes: TPanel
    Top = 484
    Width = 940
    ExplicitTop = 484
    ExplicitWidth = 940
    object sbImprimir: TSpeedButton [0]
      Left = 425
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Imprimir'
      OnClick = sbImprimirClick
    end
    inherited btnSair: TBitBtn
      Left = 861
      ExplicitLeft = 861
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
    Width = 940
    Height = 484
    ActivePage = tsFiltros
    Align = alClient
    TabOrder = 1
    object tsFiltros: TTabSheet
      Caption = 'Filtros'
      ExplicitLeft = -18
      ExplicitTop = -22
      object Label1: TLabel
        Left = 4
        Top = 10
        Width = 31
        Height = 13
        Caption = 'Status'
      end
      object Label2: TLabel
        Left = 0
        Top = 440
        Width = 184
        Height = 13
        Caption = '*Tecle [Delete] para limpar o filtro'
      end
      inline frProdutor: TFramePesquisa
        Left = 4
        Top = 60
        Width = 280
        Height = 40
        TabOrder = 1
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
          OnKeyDown = frProdutorsgConsultaKeyDown
          ExplicitWidth = 245
          ExplicitHeight = 24
        end
        inherited PnTitulos: TPanel
          Width = 280
          ExplicitWidth = 280
          inherited lbCampo: TLabel
            Width = 48
            Height = 15
            Caption = 'Produtor*'
            ExplicitWidth = 48
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
        Top = 120
        Width = 280
        Height = 39
        TabOrder = 2
        ExplicitLeft = 4
        ExplicitTop = 120
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
          OnKeyDown = frDistribuidorsgConsultaKeyDown
          ExplicitWidth = 245
          ExplicitHeight = 23
        end
        inherited PnTitulos: TPanel
          Width = 280
          ExplicitWidth = 280
          inherited lbCampo: TLabel
            Width = 60
            Height = 15
            Caption = 'Distribuidor*'
            ExplicitWidth = 60
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
        TabOrder = 0
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
      object sgResultado: TStringGrid
        Left = 0
        Top = 15
        Width = 932
        Height = 441
        Align = alClient
        ColCount = 9
        DefaultRowHeight = 19
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goHorzLine]
        TabOrder = 0
        ColWidths = (
          68
          90
          160
          134
          96
          92
          84
          80
          94)
      end
      object stAtalhos: TStaticText
        Left = 0
        Top = 0
        Width = 932
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
  object frxRelatorio: TfrxReport
    Version = '5.1.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43934.895337013900000000
    ReportOptions.LastChange = 43935.595271099500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 649
    Top = 263
    Datasets = <
      item
        DataSet = frxDataSetRelatorio
        DataSetName = 'frxDataSetRelatorio'
      end>
    Variables = <>
    Style = <
      item
        Name = 'Style1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 154.960730000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 274.015925000000000000
          Top = 41.574830000000000000
          Width = 498.897960000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -40
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Relat'#243'rio de Negocia'#231#245'es')
          ParentFont = False
        end
        object SysMemo2: TfrxSysMemoView
          Left = 978.898270000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[DATE]')
        end
        object SysMemo1: TfrxSysMemoView
          Left = 1005.354980000000000000
          Top = 22.677180000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PAGE#]')
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 147.401670000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object SysMemo4: TfrxSysMemoView
          Left = 963.780150000000000000
          Top = 22.677180000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'g.:')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 283.464750000000000000
        Width = 1046.929810000000000000
        Columns = 1
        DataSet = frxDataSetRelatorio
        DataSetName = 'frxDataSetRelatorio'
        RowCount = 0
        object frxDataSetRelatorioNEGOCIACAO_ID: TfrxMemoView
          Width = 79.370078740000000000
          Height = 18.897650000000000000
          DataField = 'NEGOCIACAO_ID'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetRelatorio."NEGOCIACAO_ID"]')
        end
        object frxDataSetRelatorioNOME_PRODUTOR: TfrxMemoView
          Left = 166.299320000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          DataField = 'NOME_PRODUTOR'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          Memo.UTF8W = (
            '[frxDataSetRelatorio."NOME_PRODUTOR"]')
        end
        object frxDataSetRelatorioNOME_DISTRIBUIDOR: TfrxMemoView
          Left = 377.173470000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          DataField = 'NOME_DISTRIBUIDOR'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          Memo.UTF8W = (
            '[frxDataSetRelatorio."NOME_DISTRIBUIDOR"]')
        end
        object frxDataSetRelatorioTOTAL: TfrxMemoView
          Left = 593.386210000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'TOTAL'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetRelatorio."TOTAL"]')
        end
        object frxDataSetRelatorioDATA_CADASTRO: TfrxMemoView
          Left = 672.756340000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'DATA_CADASTRO'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          Memo.UTF8W = (
            '[frxDataSetRelatorio."DATA_CADASTRO"]')
        end
        object frxDataSetRelatorioDATA_APROVACAO: TfrxMemoView
          Left = 755.905514250000000000
          Width = 90.708658980000000000
          Height = 18.897650000000000000
          DataField = 'DATA_APROVACAO'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          Memo.UTF8W = (
            '[frxDataSetRelatorio."DATA_APROVACAO"]')
        end
        object frxDataSetRelatorioDATA_CONCLUSAO: TfrxMemoView
          Left = 846.614173228346000000
          Width = 86.929133858267700000
          Height = 18.897650000000000000
          DataField = 'DATA_CONCLUSAO'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          Memo.UTF8W = (
            '[frxDataSetRelatorio."DATA_CONCLUSAO"]')
        end
        object frxDataSetRelatorioDATA_CANCELAMENTO: TfrxMemoView
          Left = 937.322834650000000000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
          DataField = 'DATA_CANCELAMENTO'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          Memo.UTF8W = (
            '[frxDataSetRelatorio."DATA_CANCELAMENTO"]')
        end
        object frxDataSetRelatorioSTATUS_ANALITICO: TfrxMemoView
          Left = 79.370130000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataField = 'STATUS_ANALITICO'
          DataSet = frxDataSetRelatorio
          DataSetName = 'frxDataSetRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDataSetRelatorio."STATUS_ANALITICO"]')
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          Description = 'Negocia'#231#227'o'
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Negocia'#231#227'o')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 79.370130000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Status')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 166.299320000000000000
          Width = 207.874018190000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produtor')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 377.196840630000000000
          Width = 211.653543310000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Distribuidor')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 597.165354330709000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 672.755881100000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dt cadastro')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 755.905484960000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dt aprova'#231#227'o')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 846.614151260000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dt conclus'#227'o')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 937.322815120000000000
          Width = 109.606318740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dt cancelamento')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 366.614410000000000000
        Width = 1046.929810000000000000
        object SysMemo3: TfrxSysMemoView
          Left = 944.882500000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataSetRelatorio."TOTAL">,MasterData1)]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 801.260360000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total negocia'#231#245'es:')
          ParentFont = False
        end
      end
    end
  end
  object query: TSQLDataSet
    CommandText = 
      'select'#13#10'  NEG.NEGOCIACAO_ID,'#13#10'  case'#13#10'    NEG.STATUS'#13#10'    when '#39 +
      'PEN'#39' then '#39'Pendente'#39#13#10'    when '#39'APR'#39' then '#39'Aprovada'#39#13#10'    when '#39 +
      'CON'#39' then '#39'Conclu'#237'da'#39#13#10'    when '#39'CAN'#39' then '#39'Cancelada'#39#13#10'    else' +
      ' '#39'-'#39#13#10'  end as STATUS_ANALITICO,'#13#10'  PRO.RAZAO_SOCIAL as NOME_PRO' +
      'DUTOR,'#13#10'  DIS.RAZAO_SOCIAL as NOME_DISTRIBUIDOR,'#13#10'  NEG.TOTAL,'#13#10 +
      '  NEG.DATA_CADASTRO,'#13#10'  NEG.DATA_APROVACAO,'#13#10'  NEG.DATA_CONCLUSA' +
      'O,'#13#10'  NEG.DATA_CANCELAMENTO'#13#10'from'#13#10'  NEGOCIACOES NEG'#13#10#13#10'inner jo' +
      'in PESSOAS PRO'#13#10'on NEG.PRODUTOR_ID = PRO.PESSOA_ID'#13#10#13#10'inner join' +
      ' PESSOAS DIS'#13#10'on NEG.DISTRIBUIDOR_ID = DIS.PESSOA_ID'#13#10#13#10'where 1=' +
      '1'
    MaxBlobSize = -1
    ParamCheck = False
    Params = <>
    Left = 649
    Top = 142
    object queryNEGOCIACAO_ID: TIntegerField
      FieldName = 'NEGOCIACAO_ID'
      Required = True
    end
    object stfSTATUS_ANALITICO: TStringField
      FieldName = 'STATUS_ANALITICO'
      Required = True
      FixedChar = True
      Size = 9
    end
    object infNOME_PRODUTOR: TStringField
      FieldName = 'NOME_PRODUTOR'
      Required = True
      Size = 150
    end
    object infNOME_DISTRIBUIDOR: TStringField
      FieldName = 'NOME_DISTRIBUIDOR'
      Required = True
      Size = 150
    end
    object infTOTAL: TFMTBCDField
      FieldName = 'TOTAL'
      Required = True
      Precision = 18
      Size = 2
    end
    object infDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Required = True
    end
    object infDATA_APROVACAO: TDateField
      FieldName = 'DATA_APROVACAO'
    end
    object infDATA_CONCLUSAO: TDateField
      FieldName = 'DATA_CONCLUSAO'
    end
    object infDATA_CANCELAMENTO: TDateField
      FieldName = 'DATA_CANCELAMENTO'
    end
  end
  object frxDataSetRelatorio: TfrxDBDataset
    UserName = 'frxDataSetRelatorio'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NEGOCIACAO_ID=NEGOCIACAO_ID'
      'STATUS_ANALITICO=STATUS_ANALITICO'
      'NOME_PRODUTOR=NOME_PRODUTOR'
      'NOME_DISTRIBUIDOR=NOME_DISTRIBUIDOR'
      'TOTAL=TOTAL'
      'DATA_CADASTRO=DATA_CADASTRO'
      'DATA_APROVACAO=DATA_APROVACAO'
      'DATA_CONCLUSAO=DATA_CONCLUSAO'
      'DATA_CANCELAMENTO=DATA_CANCELAMENTO')
    BCDToCurrency = False
    Left = 649
    Top = 205
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 646
    Top = 318
  end
end
