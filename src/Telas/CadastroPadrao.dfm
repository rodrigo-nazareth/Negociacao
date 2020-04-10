inherited FormCadastroPadrao: TFormCadastroPadrao
  Caption = 'Cadastro Padr'#227'o'
  ClientHeight = 304
  ClientWidth = 558
  FormStyle = fsMDIChild
  Position = poMainFormCenter
  Visible = True
  ExplicitWidth = 574
  ExplicitHeight = 343
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotoes: TPanel
    Top = 274
    Width = 558
    ExplicitTop = 274
    ExplicitWidth = 558
    DesignSize = (
      558
      30)
    inherited btnSair: TBitBtn
      Left = 477
      Top = 3
      ExplicitLeft = 477
      ExplicitTop = 3
    end
    object btnCancelar: TBitBtn
      Left = 174
      Top = 3
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      Enabled = False
      Kind = bkNo
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnGravar: TBitBtn
      Left = 90
      Top = 3
      Width = 75
      Height = 25
      Caption = '&Gravar'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 6
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnGravarClick
    end
    object btnPesquisar: TBitBtn
      Left = 7
      Top = 3
      Width = 75
      Height = 25
      Caption = '&Pesquisar'
      Kind = bkRetry
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnPesquisarClick
    end
    object btnExcluir: TBitBtn
      Left = 377
      Top = 3
      Width = 75
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Excluir'
      Enabled = False
      Kind = bkAbort
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnSairClick
    end
  end
end
