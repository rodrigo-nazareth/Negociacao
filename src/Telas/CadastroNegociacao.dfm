inherited FormCadastroNegociacao: TFormCadastroNegociacao
  Caption = 'Cadastro de Negocia'#231#227'o'
  ClientHeight = 496
  ClientWidth = 590
  ExplicitWidth = 596
  ExplicitHeight = 525
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 302
    Top = 175
    Width = 27
    Height = 13
    Caption = 'Pre'#231'o'
  end
  object Label2: TLabel [1]
    Left = 392
    Top = 175
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label3: TLabel [2]
    Left = 482
    Top = 175
    Width = 24
    Height = 13
    Caption = 'Total'
  end
  object lbCodigo: TLabel [3]
    Left = 4
    Top = 10
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  inherited pnBotoes: TPanel
    Top = 466
    Width = 590
    TabOrder = 12
    ExplicitTop = 466
    ExplicitWidth = 590
    inherited btnSair: TBitBtn
      Left = 509
      ExplicitLeft = 509
    end
    inherited btnExcluir: TBitBtn
      Left = 428
      ExplicitLeft = 428
    end
  end
  inherited stAtalhos: TStaticText
    Top = 451
    Width = 590
    TabOrder = 13
    ExplicitTop = 451
    ExplicitWidth = 590
  end
  inline frProdutor: TFramePesquisa
    Left = 4
    Top = 101
    Width = 280
    Height = 40
    TabOrder = 4
    ExplicitLeft = 4
    ExplicitTop = 101
    ExplicitWidth = 280
    ExplicitHeight = 40
    inherited pnPesquisar: TPanel
      Left = 245
      Width = 35
      Height = 24
      ExplicitLeft = 245
      ExplicitWidth = 35
      ExplicitHeight = 24
      inherited btnPesquisar: TBitBtn
        Enabled = False
        OnClick = frProdutorbtnPesquisarClick
      end
    end
    inherited sgConsulta: TStringGrid
      Width = 245
      Height = 24
      Enabled = False
      ScrollBars = ssNone
      OnKeyDown = TeclaEnter
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
        Checked = True
        State = cbChecked
      end
    end
  end
  inline frDistribuidor: TFramePesquisa
    Left = 302
    Top = 101
    Width = 280
    Height = 39
    TabOrder = 5
    ExplicitLeft = 302
    ExplicitTop = 101
    ExplicitWidth = 280
    ExplicitHeight = 39
    inherited pnPesquisar: TPanel
      Left = 245
      Width = 35
      Height = 23
      ExplicitLeft = 245
      ExplicitWidth = 35
      ExplicitHeight = 23
      inherited btnPesquisar: TBitBtn
        Enabled = False
        OnClick = frDistribuidorbtnPesquisarClick
      end
    end
    inherited sgConsulta: TStringGrid
      Width = 245
      Height = 23
      Enabled = False
      ScrollBars = ssNone
      OnKeyDown = TeclaEnter
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
        Checked = True
        State = cbChecked
      end
    end
  end
  object StaticText1: TStaticText
    Left = 98
    Top = 10
    Width = 186
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Status'
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 14
    Transparent = False
  end
  object stStatus: TStaticText
    Left = 98
    Top = 27
    Width = 186
    Height = 18
    Alignment = taCenter
    AutoSize = False
    Caption = '-'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    Transparent = False
  end
  object gpLimites: TGridPanel
    Left = 302
    Top = 10
    Width = 280
    Height = 35
    ColumnCollection = <
      item
        Value = 27.428019588417840000
      end
      item
        Value = 36.327621742181340000
      end
      item
        Value = 36.244358669400820000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = stTitLimite
        Row = 0
      end
      item
        Column = 1
        Control = stTitLimiteUtilizado
        Row = 0
      end
      item
        Column = 2
        Control = stTitLimiteDisponivel
        Row = 0
      end
      item
        Column = 0
        Control = stLimite
        Row = 1
      end
      item
        Column = 1
        Control = stLimiteUtilizado
        Row = 1
      end
      item
        Column = 2
        Control = stLimiteDisponivel
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 2
    object stTitLimite: TStaticText
      Left = 1
      Top = 1
      Width = 76
      Height = 16
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Limite'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
    object stTitLimiteUtilizado: TStaticText
      Left = 77
      Top = 1
      Width = 100
      Height = 16
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Limite utilziado'
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
    object stTitLimiteDisponivel: TStaticText
      Left = 177
      Top = 1
      Width = 102
      Height = 16
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Limite dispon'#237'vel'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      Transparent = False
    end
    object stLimite: TStaticText
      Left = 1
      Top = 17
      Width = 76
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      Transparent = False
    end
    object stLimiteUtilizado: TStaticText
      Left = 77
      Top = 17
      Width = 100
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Color = clWhite
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
    object stLimiteDisponivel: TStaticText
      Left = 177
      Top = 17
      Width = 102
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 5
      Transparent = False
    end
  end
  object StaticText3: TStaticText
    Left = 4
    Top = 152
    Width = 578
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Itens'
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 15
    Transparent = False
  end
  object sgItens: TStringGrid
    Left = 4
    Top = 240
    Width = 578
    Height = 147
    DefaultRowHeight = 19
    DrawingStyle = gdsClassic
    Enabled = False
    FixedCols = 0
    RowCount = 2
    TabOrder = 10
    OnDblClick = sgItensDblClick
    OnKeyDown = sgItensKeyDown
    ColWidths = (
      64
      179
      104
      88
      99)
  end
  inline frProduto: TFramePesquisa
    Left = 4
    Top = 174
    Width = 280
    Height = 39
    TabOrder = 6
    ExplicitLeft = 4
    ExplicitTop = 174
    ExplicitWidth = 280
    ExplicitHeight = 39
    inherited pnPesquisar: TPanel
      Left = 245
      Width = 35
      Height = 23
      ExplicitLeft = 245
      ExplicitWidth = 35
      ExplicitHeight = 23
      inherited btnPesquisar: TBitBtn
        Enabled = False
        OnClick = frProdutobtnPesquisarClick
      end
    end
    inherited sgConsulta: TStringGrid
      Width = 245
      Height = 23
      Enabled = False
      ScrollBars = ssNone
      OnKeyDown = TeclaEnter
      ExplicitWidth = 245
      ExplicitHeight = 23
    end
    inherited PnTitulos: TPanel
      Width = 280
      ExplicitWidth = 280
      inherited lbCampo: TLabel
        Width = 38
        Height = 15
        Caption = 'Produto'
        ExplicitWidth = 38
      end
      inherited Panel2: TPanel
        Left = 255
        ExplicitLeft = 255
      end
      inherited CkChaveUnica: TCheckBox
        Checked = True
        State = cbChecked
      end
    end
  end
  object ePreco: TEdit
    Left = 302
    Top = 192
    Width = 77
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    ReadOnly = True
    TabOrder = 7
    OnKeyDown = TeclaEnter
    OnKeyPress = SoNumerosDbl
  end
  object eQuantidade: TEdit
    Left = 392
    Top = 192
    Width = 73
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 8
    OnChange = eQuantidadeChange
    OnClick = eQuantidadeClick
    OnEnter = eQuantidadeEnter
    OnKeyDown = TeclaEnter
    OnKeyPress = SoNumerosDbl
  end
  object eTotal: TEdit
    Left = 482
    Top = 192
    Width = 100
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    OEMConvert = True
    ReadOnly = True
    TabOrder = 9
    OnKeyDown = eTotalKeyDown
    OnKeyPress = SoNumerosDbl
  end
  object StaticText5: TStaticText
    AlignWithMargins = True
    Left = 4
    Top = 213
    Width = 578
    Height = 26
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Selecione um produto, informe a quantidade e navegue pelos campo' +
      's com o [Enter] at'#233' inserir os dados'
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 16
    Transparent = False
  end
  object StaticText6: TStaticText
    Left = 396
    Top = 409
    Width = 186
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Total negocia'#231#227'o'
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 17
    Transparent = False
  end
  object stTotalNegociacao: TStaticText
    Left = 396
    Top = 426
    Width = 186
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = '-'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 11
    Transparent = False
  end
  object GridPanel1: TGridPanel
    Left = 4
    Top = 54
    Width = 578
    Height = 37
    ColumnCollection = <
      item
        Value = 24.999999968615440000
      end
      item
        Value = 25.000000013015970000
      end
      item
        Value = 25.000000019510110000
      end
      item
        Value = 24.999999998858480000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = StaticText2
        Row = 0
      end
      item
        Column = 1
        Control = StaticText4
        Row = 0
      end
      item
        Column = 2
        Control = StaticText7
        Row = 0
      end
      item
        Column = 0
        Control = stDataCadastro
        Row = 1
      end
      item
        Column = 1
        Control = stDataAprovacao
        Row = 1
      end
      item
        Column = 2
        Control = stDataConclusao
        Row = 1
      end
      item
        Column = 3
        Control = StaticText11
        Row = 0
      end
      item
        Column = 3
        Control = stDataCancelamento
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end
      item
      end>
    TabOrder = 3
    object StaticText2: TStaticText
      Left = 1
      Top = 1
      Width = 143
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Data cadastro'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
    object StaticText4: TStaticText
      Left = 144
      Top = 1
      Width = 144
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Data aprova'#231#227'o'
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
    object StaticText7: TStaticText
      Left = 288
      Top = 1
      Width = 144
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Data conclus'#227'o'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      Transparent = False
    end
    object stDataCadastro: TStaticText
      Left = 1
      Top = 18
      Width = 143
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      Transparent = False
    end
    object stDataAprovacao: TStaticText
      Left = 144
      Top = 18
      Width = 144
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Color = clWhite
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
    object stDataConclusao: TStaticText
      Left = 288
      Top = 18
      Width = 144
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 5
      Transparent = False
    end
    object StaticText11: TStaticText
      Left = 432
      Top = 1
      Width = 145
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Data cancelamento'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 6
      Transparent = False
    end
    object stDataCancelamento: TStaticText
      Left = 432
      Top = 18
      Width = 145
      Height = 17
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 7
      Transparent = False
    end
  end
  object StaticText8: TStaticText
    Left = 5
    Top = 387
    Width = 577
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Duplo clique para editar um item ou tecla [Delete] para excluir ' +
      'um item'
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 18
    Transparent = False
  end
  object eCodigo: TEdit
    Left = 4
    Top = 24
    Width = 75
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnKeyDown = eCodigoKeyDown
    OnKeyPress = SoNumerosInt
  end
end
