unit ECon24.view.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,

  ECon24.controller.interfaces, Vcl.Mask;

type
  TfrmCadastroPessoa = class(TForm)
    edtCodigo: TDBEdit;
    edtNome: TDBEdit;
    edtSobrenome: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    lblVersao: TLabel;
    dsPessoa: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
    FController: IController;
  public
    { Public declarations }
  end;

var
  frmCadastroPessoa: TfrmCadastroPessoa;

implementation

uses
  ECon24.controller.impl.controller,
  ECon24.constantes.Version;

{$R *.dfm}

procedure TfrmCadastroPessoa.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbPost then
  begin
    FController.Pessoa
      .Codigo(dsPessoa.DataSet.FieldByName('Codigo').AsInteger)
      .Nome(dsPessoa.DataSet.FieldByName('Nome').AsString)
      .Sobrenome(dsPessoa.DataSet.FieldByName('Sobrenome').AsString)
      .Build
        .Insert;

    ShowMessage('Registro salvo com sucesso!');
  end;
end;

procedure TfrmCadastroPessoa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TfrmCadastroPessoa.FormCreate(Sender: TObject);
begin
  FController := TController.New;
  lblVersao.Caption := VERSION;

  try
    dsPessoa.DataSet := FController.Pessoa.Build.Retrieve;
  except
    on E: Exception do
      raise Exception.Create('AVISO: ' + E.Message);
  end;
end;

end.
