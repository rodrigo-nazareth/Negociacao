inherited FormCadastroPessoa: TFormCadastroPessoa
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 342
  ClientWidth = 573
  ExplicitWidth = 579
  ExplicitHeight = 371
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotoes: TPanel
    Top = 312
    Width = 573
    ExplicitTop = 312
    ExplicitWidth = 573
    inherited btnSair: TBitBtn
      Left = 495
      ExplicitLeft = 495
    end
    inherited btnCancelar: TBitBtn
      Left = 154
      ExplicitLeft = 154
    end
    inherited btnGravar: TBitBtn
      Left = 78
      ExplicitLeft = 78
    end
    inherited btnPesquisar: TBitBtn
      Left = 1
      ExplicitLeft = 1
    end
    inherited btnExcluir: TBitBtn
      Left = 416
      ExplicitLeft = 416
    end
  end
  inherited stAtalhos: TStaticText
    Top = 297
    Width = 573
    ExplicitTop = 297
    ExplicitWidth = 573
  end
  object pcPessoa: TPageControl
    Left = 1
    Top = 8
    Width = 566
    Height = 284
    ActivePage = tsLimitesCredito
    TabOrder = 2
    object tsDadosPrincipais: TTabSheet
      Caption = 'Dados princiais'
      object lbCodigo: TLabel
        Left = 9
        Top = 3
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lblCpfCnpj: TLabel
        Left = 79
        Top = 3
        Width = 23
        Height = 13
        Caption = 'CPF:'
      end
      object eCodigo: TEdit
        Left = 9
        Top = 19
        Width = 63
        Height = 21
        NumbersOnly = True
        TabOrder = 0
        OnKeyDown = eCodigoKeyDown
        OnKeyPress = SoNumerosInt
      end
      object mskEdtCpfCnpj: TMaskEdit
        Left = 79
        Top = 19
        Width = 120
        Height = 21
        Enabled = False
        EditMask = '999.999.999-99;1;_'
        MaxLength = 14
        TabOrder = 1
        Text = '   .   .   -  '
        OnKeyDown = TeclaEnter
        OnKeyPress = mskEdtCpfCnpjKeyPress
      end
      object eNomeFantasia: TLabeledEdit
        Left = 9
        Top = 110
        Width = 235
        Height = 21
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome fantasia'
        Enabled = False
        TabOrder = 3
        OnKeyDown = TeclaEnter
      end
      object eNomeRazaoSocial: TLabeledEdit
        Left = 9
        Top = 63
        Width = 235
        Height = 21
        EditLabel.Width = 60
        EditLabel.Height = 13
        EditLabel.Caption = 'Raz'#227'o Social'
        Enabled = False
        TabOrder = 2
        OnKeyDown = TeclaEnter
      end
    end
    object tsLimitesCredito: TTabSheet
      Caption = 'Limites de cr'#233'dito'
      ImageIndex = 1
      object sgLimites: TStringGrid
        Left = 0
        Top = 66
        Width = 558
        Height = 136
        Align = alClient
        ColCount = 3
        DefaultRowHeight = 19
        DrawingStyle = gdsClassic
        Enabled = False
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        OnDblClick = sgLimitesDblClick
        OnKeyDown = sgLimitesKeyDown
        ColWidths = (
          64
          312
          139)
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 558
        Height = 66
        Align = alTop
        TabOrder = 1
        object Label3: TLabel
          Left = 290
          Top = 9
          Width = 63
          Height = 13
          Caption = 'Limite cr'#233'dito'
        end
        inline frDistribuidor: TFramePesquisa
          Left = 4
          Top = 8
          Width = 280
          Height = 39
          TabOrder = 0
          ExplicitLeft = 4
          ExplicitTop = 8
          ExplicitWidth = 280
          ExplicitHeight = 39
          inherited pnPesquisar: TPanel
            Left = 247
            Height = 23
            ExplicitLeft = 247
            ExplicitHeight = 23
            inherited btnPesquisar: TBitBtn
              Enabled = False
            end
          end
          inherited sgConsulta: TStringGrid
            Width = 247
            Height = 23
            Enabled = False
            ScrollBars = ssNone
            OnKeyDown = TeclaEnter
            ExplicitWidth = 247
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
        object eLimite: TEdit
          Left = 290
          Top = 25
          Width = 100
          Height = 21
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 1
          OnClick = eLimiteClick
          OnEnter = eLimiteEnter
          OnExit = FormatarCampoValorDbl
          OnKeyDown = eLimiteKeyDown
          OnKeyPress = SoNumerosDbl
        end
        object StaticText1: TStaticText
          Left = 1
          Top = 52
          Width = 556
          Height = 13
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 
            'Selecione um distribuidor, informe o limite de cr'#233'dito e navegue' +
            ' com o [Enter] para inserir'
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
      end
      object StaticText5: TStaticText
        Left = 0
        Top = 202
        Width = 558
        Height = 13
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Duplo clique para editar um limite ou tecla [Delete] para exclui' +
          'r um limite'
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
      object Panel2: TPanel
        Left = 0
        Top = 215
        Width = 558
        Height = 41
        Align = alBottom
        TabOrder = 3
        DesignSize = (
          558
          41)
        object StaticText6: TStaticText
          Left = 360
          Top = 5
          Width = 186
          Height = 15
          Alignment = taCenter
          Anchors = [akLeft, akBottom]
          AutoSize = False
          Caption = 'Limite Total'
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
        object stTotalLimite: TStaticText
          Left = 360
          Top = 20
          Width = 186
          Height = 15
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
          TabOrder = 1
          Transparent = False
        end
      end
    end
  end
end
