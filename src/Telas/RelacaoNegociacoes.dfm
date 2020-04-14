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
      Left = 405
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
    ActivePage = tsResultado
    Align = alClient
    TabOrder = 1
    object tsFiltros: TTabSheet
      Caption = 'Filtros'
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
        TabOrder = 2
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
        ExplicitLeft = -269
        ExplicitTop = 213
        ExplicitWidth = 910
        ExplicitHeight = 312
        ColWidths = (
          53
          101
          166
          142
          96
          92
          84
          80
          81)
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
    ReportOptions.LastChange = 43935.059921585600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 109
    Top = 292
    Datasets = <>
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
        object SysMemo1: TfrxSysMemoView
          Left = 211.653680000000000000
          Top = 109.606370000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'asfasdf')
        end
        object Memo1: TfrxMemoView
          Left = 120.944960000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
        end
        object SysMemo2: TfrxSysMemoView
          Left = 865.512370000000000000
          Top = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[DATE]')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 298.582870000000000000
        Width = 1046.929810000000000000
        Columns = 1
        DataSetName = 'frxTeste'
        RowCount = 1
        object frxTesteNEGOCIACAO_ID: TfrxMemoView
          Left = 34.015770000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          DataField = 'NEGOCIACAO_ID'
          DataSetName = 'frxTeste'
          Memo.UTF8W = (
            '[frxTeste."NEGOCIACAO_ID"]')
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          Left = 11.338590000000000000
          Top = 15.118120000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'saa')
        end
        object Memo3: TfrxMemoView
          Left = 158.740260000000000000
          Top = 11.338590000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'safd')
        end
      end
    end
  end
  object scConexao: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver220.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=22.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver220.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=22.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'TrimChar=False'
      'DriverName=Firebird'
      'Database=localhost:E:\Projetos\SIAGRI\data\DADOS.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    Connected = True
    Left = 118
    Top = 109
  end
  object query: TSQLDataSet
    CommandText = 'LIMITES_CREDITO_PRODUTOR'
    MaxBlobSize = -1
    ParamCheck = False
    Params = <>
    SQLConnection = scConexao
    Left = 117
    Top = 168
  end
  object frxDataSetRelatorio: TfrxDBDataset
    UserName = 'frxDataSetRelatorio'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NEGOCIACAO_ID=NEGOCIACAO_ID'
      'PRODUTOR_ID=PRODUTOR_ID'
      'DISTRIBUIDOR_ID=DISTRIBUIDOR_ID'
      'STATUS=STATUS'
      'TOTAL=TOTAL'
      'DATA_CADASTRO=DATA_CADASTRO'
      'DATA_APROVACAO=DATA_APROVACAO'
      'DATA_CONCLUSAO=DATA_CONCLUSAO'
      'DATA_CANCELAMENTO=DATA_CANCELAMENTO'
      'NOME_PRODUTOR=NOME_PRODUTOR'
      'NOME_DISTRIBUIDOR=NOME_DISTRIBUIDOR')
    DataSet = query
    BCDToCurrency = False
    Left = 119
    Top = 233
  end
  object DataSource1: TDataSource
    DataSet = query
    Left = 768
    Top = 87
  end
end
