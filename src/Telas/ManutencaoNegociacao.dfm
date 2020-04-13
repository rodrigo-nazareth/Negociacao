inherited FormManutencaoNegociacao: TFormManutencaoNegociacao
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o Negocia'#231#227'o'
  ClientHeight = 197
  ClientWidth = 573
  FormStyle = fsMDIChild
  Visible = True
  ExplicitWidth = 579
  ExplicitHeight = 226
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel [0]
    Left = 4
    Top = 10
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  inherited pnBotoes: TPanel
    Top = 167
    Width = 573
    TabOrder = 7
    ExplicitTop = 167
    ExplicitWidth = 573
    inherited btnSair: TBitBtn
      Left = 520
      Width = 51
      TabOrder = 4
      ExplicitLeft = 520
      ExplicitWidth = 51
    end
    object btnAprovar: TBitBtn
      Left = 4
      Top = 2
      Width = 129
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Aprovar negocia'#231#227'o'
      Enabled = False
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnAprovarClick
    end
    object btnConcluir: TBitBtn
      Left = 133
      Top = 2
      Width = 128
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Concluir negocia'#231#227'o'
      Enabled = False
      Kind = bkAll
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnConcluirClick
    end
    object btnCancelar: TBitBtn
      Left = 261
      Top = 2
      Width = 137
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Cancelar negocia'#231#227'o'
      Enabled = False
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnCancelarEdicao: TBitBtn
      Left = 413
      Top = 2
      Width = 106
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancelar edi'#231#227'o'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333FFFFF333333000033333388888833333333333F888888FFF333
        000033338811111188333333338833FFF388FF33000033381119999111833333
        38F338888F338FF30000339119933331111833338F388333383338F300003391
        13333381111833338F8F3333833F38F3000039118333381119118338F38F3338
        33F8F38F000039183333811193918338F8F333833F838F8F0000391833381119
        33918338F8F33833F8338F8F000039183381119333918338F8F3833F83338F8F
        000039183811193333918338F8F833F83333838F000039118111933339118338
        F3833F83333833830000339111193333391833338F33F8333FF838F300003391
        11833338111833338F338FFFF883F83300003339111888811183333338FF3888
        83FF83330000333399111111993333333388FFFFFF8833330000333333999999
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnCancelarEdicaoClick
    end
  end
  object eCodigo: TEdit
    Left = 4
    Top = 24
    Width = 75
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnKeyDown = eCodigoKeyDown
  end
  object StaticText1: TStaticText
    Left = 127
    Top = 10
    Width = 193
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Status atual'
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 8
    Transparent = False
  end
  object stStatus: TStaticText
    Left = 127
    Top = 26
    Width = 193
    Height = 19
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
    TabOrder = 2
    Transparent = False
  end
  inline frProdutor: TFramePesquisa
    Left = 4
    Top = 101
    Width = 276
    Height = 40
    TabOrder = 5
    ExplicitLeft = 4
    ExplicitTop = 101
    ExplicitWidth = 276
    ExplicitHeight = 40
    inherited pnPesquisar: TPanel
      Left = 241
      Width = 35
      Height = 24
      ExplicitLeft = 245
      ExplicitWidth = 35
      ExplicitHeight = 24
      inherited btnPesquisar: TBitBtn
        Enabled = False
      end
    end
    inherited sgConsulta: TStringGrid
      Width = 241
      Height = 24
      Enabled = False
      ScrollBars = ssNone
      ExplicitWidth = 245
      ExplicitHeight = 24
    end
    inherited PnTitulos: TPanel
      Width = 276
      ExplicitWidth = 280
      inherited lbCampo: TLabel
        Height = 15
        Caption = 'Produtor'
      end
      inherited Panel2: TPanel
        Left = 251
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
    Left = 289
    Top = 102
    Width = 276
    Height = 39
    TabOrder = 6
    ExplicitLeft = 289
    ExplicitTop = 102
    ExplicitWidth = 276
    ExplicitHeight = 39
    inherited pnPesquisar: TPanel
      Left = 241
      Width = 35
      Height = 23
      ExplicitLeft = 245
      ExplicitWidth = 35
      ExplicitHeight = 23
      inherited btnPesquisar: TBitBtn
        Enabled = False
      end
    end
    inherited sgConsulta: TStringGrid
      Width = 241
      Height = 23
      Enabled = False
      ScrollBars = ssNone
      ExplicitWidth = 245
      ExplicitHeight = 23
    end
    inherited PnTitulos: TPanel
      Width = 276
      ExplicitWidth = 280
      inherited lbCampo: TLabel
        Width = 54
        Height = 15
        Caption = 'Distribuidor'
        ExplicitWidth = 54
      end
      inherited Panel2: TPanel
        Left = 251
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
  object GridPanel1: TGridPanel
    Left = 4
    Top = 54
    Width = 567
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
    TabOrder = 4
    object StaticText2: TStaticText
      Left = 1
      Top = 1
      Width = 141
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
      Left = 142
      Top = 1
      Width = 141
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
      Left = 283
      Top = 1
      Width = 141
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
      Width = 141
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
      Left = 142
      Top = 18
      Width = 141
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
      Left = 283
      Top = 18
      Width = 141
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
      Left = 424
      Top = 1
      Width = 142
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
      Left = 424
      Top = 18
      Width = 142
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
  object StaticText6: TStaticText
    Left = 335
    Top = 10
    Width = 199
    Height = 15
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
    TabOrder = 9
    Transparent = False
  end
  object stTotalNegociacao: TStaticText
    Left = 335
    Top = 29
    Width = 199
    Height = 19
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
    TabOrder = 3
    Transparent = False
  end
  object btnPesquisar: TBitBtn
    Left = 81
    Top = 18
    Width = 30
    Height = 27
    Hint = 'Pesquisar negocia'#231#227'o'
    Caption = ' '
    Kind = bkRetry
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnPesquisarClick
  end
end
