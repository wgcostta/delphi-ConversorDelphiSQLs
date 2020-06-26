object sqlForDelphi: TsqlForDelphi
  Left = 0
  Top = 0
  Caption = 'VSMConversorUtils 2.0'
  ClientHeight = 599
  ClientWidth = 1196
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1196
    Height = 599
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label2: TLabel
      Left = 12
      Top = 552
      Width = 55
      Height = 15
      Caption = 'Resultado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblArquivo: TLabel
      Left = 69
      Top = 553
      Width = 9
      Height = 15
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel4: TPanel
      Left = 5
      Top = 330
      Width = 1184
      Height = 218
      Caption = 'Panel4'
      TabOrder = 0
      object MemoResultado: TMemo
        Left = 1
        Top = 1
        Width = 1182
        Height = 216
        Align = alClient
        Color = clBtnFace
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object pgSQLDelphi: TPageControl
      Left = 1
      Top = 1
      Width = 1194
      Height = 312
      ActivePage = pgHexToColor
      Align = alTop
      Style = tsFlatButtons
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Conversor SQL e Delphi'
        object Label7: TLabel
          Left = 12
          Top = 264
          Width = 55
          Height = 15
          Caption = 'Resultado:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 1186
          Height = 279
          Align = alClient
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object Label1: TLabel
            Left = 10
            Top = 236
            Width = 169
            Height = 30
            Caption = 'Necess'#225'rio trocar os Par'#226'metros'#13#10' do Delphi para execu'#231#227'o'
          end
          object Label3: TLabel
            Left = 9
            Top = 2
            Width = 73
            Height = 15
            Caption = 'Texto Original'
          end
          object chkFullScrean: TCheckBox
            Left = 517
            Top = 263
            Width = 97
            Height = 17
            Caption = 'FullScreen'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            OnClick = chkFullScreanClick
          end
          object chkGerarArquivo: TCheckBox
            Left = 600
            Top = 263
            Width = 97
            Height = 17
            Caption = 'Gerar Arquivo'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            State = cbChecked
            TabOrder = 5
          end
          object chkUpper: TCheckBox
            Left = 400
            Top = 263
            Width = 97
            Height = 17
            Caption = 'Case Sensitive'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
          end
          object chkFormatarSQL: TCheckBox
            Left = 238
            Top = 263
            Width = 133
            Height = 17
            Caption = 'Formatar SQL (Beta)'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            State = cbChecked
            TabOrder = 2
            OnClick = chkFullScreanClick
          end
          object MemoSQL: TMemo
            Left = 5
            Top = 17
            Width = 1176
            Height = 214
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object chkRemoverX: TCheckBox
            Left = 238
            Top = 236
            Width = 659
            Height = 21
            Caption = 
              'REMOVER: "+" (Em caso de  pegar a SQL do Executor, '#13'pode desmarc' +
              'ar a op'#231#227'o pois j'#225' ter'#225' removido os + pelo Debug)'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 1
          end
          object btnDelphi: TButton
            Left = 935
            Top = 237
            Width = 120
            Height = 40
            Action = ACT_DELPHISQL
            TabOrder = 6
          end
          object btnSQL: TButton
            Left = 1061
            Top = 237
            Width = 120
            Height = 40
            Action = ACT_SQLDELPHI
            TabOrder = 7
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Gerador de Templates'
        ImageIndex = 1
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 1186
          Height = 279
          Align = alClient
          Caption = 'Panel3'
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object Label4: TLabel
            Left = 6
            Top = 6
            Width = 99
            Height = 13
            Caption = 'Nome do Template:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 8
            Top = 29
            Width = 52
            Height = 13
            Caption = 'Descri'#231#227'o:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 6
            Top = 53
            Width = 78
            Height = 13
            Caption = 'C'#243'digo Delphi:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblDesc: TLabel
            Left = 5
            Top = 178
            Width = 440
            Height = 52
            Caption = 
              'Os nomes ou variaveis que deseja que seja subsituido ao Inserir,' +
              ' colocar no c'#243'digo'#13#10' como |classname|, exemplo: class MyClass, c' +
              'olocar class |classname|.'#13#10'Salvar o conte'#250'do do resultado com o ' +
              'nome gerado e .xml, na pasta:'#13#10'C:\Program Files (x86)\Embarcader' +
              'o\Studio\18.0\ObjRepos\en\Code_Templates\Delphi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object memoCodigoTemplate: TMemo
            Left = 3
            Top = 72
            Width = 960
            Height = 97
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object edtDescricaoTemplate: TEdit
            Left = 144
            Top = 28
            Width = 295
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 70
            ParentFont = False
            TabOrder = 1
          end
          object edtNomeTemplate: TEdit
            Left = 143
            Top = 2
            Width = 121
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 0
          end
          object RzButton5: TButton
            Left = 1088
            Top = 246
            Width = 75
            Height = 25
            Action = ACT_TEMPLATE
            TabOrder = 3
          end
        end
      end
      object pgHexToColor: TTabSheet
        Caption = 'pgHexToColor'
        ImageIndex = 2
        object lblColorWeb: TLabel
          Left = 14
          Top = 44
          Width = 60
          Height = 15
          Caption = 'Cor (Hexa):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7884599
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblTColor: TLabel
          Left = 14
          Top = 73
          Width = 104
          Height = 15
          Caption = 'Cor Delphi (TColor):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7884599
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object separador: TLabel
          Left = 456
          Top = 75
          Width = 52
          Height = 15
          Caption = 'separador'
          Color = 15963681
          ParentColor = False
        end
        object LinkLabel1: TLinkLabel
          Left = 14
          Top = 99
          Width = 261
          Height = 19
          Caption = 
            '<a href="https://encycolorpedia.pt">Exemplo de Paolhetas: https:' +
            '//encycolorpedia.pt</a>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7884599
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object edtCorWeb: TEdit
          Left = 152
          Top = 36
          Width = 295
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7884599
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 70
          ParentFont = False
          TabOrder = 0
        end
        object edtTColor: TEdit
          Left = 152
          Top = 71
          Width = 295
          Height = 23
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7884599
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 70
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object Button1: TButton
          Left = 514
          Top = 63
          Width = 75
          Height = 25
          Action = ACT_COLOR
          TabOrder = 3
        end
      end
    end
    object btnClear: TButton
      Left = 940
      Top = 553
      Width = 120
      Height = 40
      Action = ACT_CLEAR
      TabOrder = 2
    end
    object btnCopy: TButton
      Left = 1066
      Top = 553
      Width = 120
      Height = 40
      Action = ACT_COPY
      TabOrder = 3
    end
  end
  object ActionList1: TActionList
    Left = 277
    Top = 65523
    object ACT_CLEAR: TAction
      Caption = 'Limpar[Del]'
      ShortCut = 46
      OnExecute = ACT_CLEARExecute
    end
    object ACT_COPY: TAction
      Caption = 'Copiar [CTRL+C]'
      ShortCut = 16451
      OnExecute = ACT_COPYExecute
    end
    object ACT_DELPHISQL: TAction
      Caption = 'Delphi -> SQL'
      OnExecute = ACT_DELPHISQLExecute
    end
    object ACT_SQLDELPHI: TAction
      Caption = 'SQL -> Delphi'
      OnExecute = ACT_SQLDELPHIExecute
    end
    object ACT_TEMPLATE: TAction
      Caption = 'Template'
      OnExecute = ACT_TEMPLATEExecute
    end
    object ACT_COLOR: TAction
      Caption = 'Converter Cor'
      OnExecute = ACT_COLORExecute
    end
  end
end
