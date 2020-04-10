object FormBase: TFormBase
  Left = 0
  Top = 0
  Caption = 'Forme Base'
  ClientHeight = 153
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnBotoes: TPanel
    Left = 0
    Top = 123
    Width = 301
    Height = 30
    Align = alBottom
    BevelInner = bvLowered
    Color = clSilver
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      301
      30)
    object btnSair: TBitBtn
      Left = 220
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Sair'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnSairClick
    end
  end
end
