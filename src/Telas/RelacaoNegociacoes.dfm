inherited FormRelacaoNegociacoes: TFormRelacaoNegociacoes
  Caption = 'Rela'#231#227'o de Negocia'#231#245'es'
  ClientHeight = 516
  ClientWidth = 748
  FormStyle = fsMDIChild
  Visible = True
  ExplicitWidth = 764
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotoes: TPanel
    Top = 486
    Width = 748
    ExplicitTop = 486
    ExplicitWidth = 748
    inherited btnSair: TBitBtn
      Left = 669
      ExplicitLeft = 669
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 748
    Height = 486
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Filtros'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet2: TTabSheet
      Caption = 'Resultado'
      ImageIndex = 1
    end
  end
end
