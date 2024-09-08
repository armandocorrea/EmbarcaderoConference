object frmCadastroPessoa: TfrmCadastroPessoa
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 419
  ClientWidth = 599
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 10
    Top = 16
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 10
    Top = 72
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 10
    Top = 131
    Width = 61
    Height = 15
    Caption = 'Sobrenome'
  end
  object lblVersao: TLabel
    Left = 549
    Top = 16
    Width = 40
    Height = 17
    Alignment = taRightJustify
    Caption = 'Vers'#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object edtCodigo: TDBEdit
    Left = 10
    Top = 37
    Width = 81
    Height = 23
    DataField = 'Codigo'
    DataSource = dsPessoa
    TabOrder = 0
    TextHint = 'C'#243'digo'
  end
  object edtNome: TDBEdit
    Left = 10
    Top = 93
    Width = 217
    Height = 23
    DataField = 'Nome'
    DataSource = dsPessoa
    TabOrder = 1
    TextHint = 'Nome'
  end
  object edtSobrenome: TDBEdit
    Left = 10
    Top = 152
    Width = 417
    Height = 23
    DataField = 'Sobrenome'
    DataSource = dsPessoa
    TabOrder = 2
    TextHint = 'Sobrenome'
  end
  object DBGrid1: TDBGrid
    Left = 10
    Top = 200
    Width = 583
    Height = 185
    DataSource = dsPessoa
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Nome'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sobrenome'
        Title.Caption = 'Sobrenome'
        Width = 200
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 391
    Width = 582
    Height = 25
    DataSource = dsPessoa
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbPost]
    TabOrder = 4
    OnClick = DBNavigator1Click
  end
  object dsPessoa: TDataSource
    Left = 512
    Top = 96
  end
end
