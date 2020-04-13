object FramePesquisa: TFramePesquisa
  Left = 0
  Top = 0
  Width = 345
  Height = 62
  TabOrder = 0
  OnResize = FrameResize
  object pnPesquisar: TPanel
    Left = 312
    Top = 16
    Width = 33
    Height = 46
    Align = alRight
    BevelOuter = bvLowered
    ParentShowHint = False
    ShowCaption = False
    ShowHint = False
    TabOrder = 0
    object btnPesquisar: TBitBtn
      Left = 2
      Top = 0
      Width = 30
      Height = 24
      Hint = 'Pesquisar cadastro'
      Caption = ' '
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnPesquisarClick
    end
  end
  object sgConsulta: TStringGrid
    Left = 0
    Top = 16
    Width = 312
    Height = 46
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 1
    Align = alClient
    ColCount = 2
    DefaultRowHeight = 19
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goRowSelect, goThumbTracking]
    ScrollBars = ssVertical
    TabOrder = 1
    ColWidths = (
      54
      317)
  end
  object PnTitulos: TPanel
    Left = 0
    Top = 0
    Width = 345
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lbCampo: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 1
      Width = 42
      Height = 13
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Consulta'
    end
    object Panel2: TPanel
      Left = 320
      Top = 0
      Width = 25
      Height = 16
      Align = alRight
      BevelOuter = bvNone
      Enabled = False
      ParentColor = True
      ShowCaption = False
      TabOrder = 0
    end
    object CkChaveUnica: TCheckBox
      Left = 73
      Top = 0
      Width = 97
      Height = 17
      Caption = 'Chave '#218'nica'
      TabOrder = 1
      Visible = False
    end
    object ckSomenteLeitura: TCheckBox
      Left = 195
      Top = 0
      Width = 97
      Height = 17
      Caption = 'Somente leitura'
      TabOrder = 2
      Visible = False
    end
  end
end
