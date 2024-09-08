unit ECon24.model.service.impl.servicedata;

interface

uses
  DB,
  Datasnap.DBClient,
  ECon24.model.service.interfaces;

type
  TServiceData<T: class, constructor> = class(TInterfacedObject, IServiceData<T>)
    private
      FParent: T;
      FClientDataSet: TClientDataSet;
    public
      constructor Create(AParent: T);
      destructor Destroy; override;
      class function New(AParent: T): IServiceData<T>;

      function Insert: IServiceData<T>;
      function Retrieve: TDataset;
  end;

implementation

uses
  SysUtils,
  ECon24.model.pessoa;

{ TServiceData<T> }

constructor TServiceData<T>.Create(AParent: T);
begin
  FParent := AParent;
  FClientDataSet := TClientDataSet.Create(nil);
end;

destructor TServiceData<T>.Destroy;
begin
  FreeAndNil(FClientDataSet);
  inherited;
end;

function TServiceData<T>.Insert: IServiceData<T>;
begin
  Result := Self;

  //Aqui poderia usar algum objeto de ORM
  //Para fins didáticos deixarei dessa forma

  //Aqui existe um jeito muito melhor de tirar esse acoplamento
  if FParent.ClassName = 'TPessoa' then
  begin
    FClientDataSet.LoadFromFile('Pessoa.xml');

    FClientDataSet.Append;
    FClientDataSet.FieldByName('Codigo').AsInteger := TPessoa(FParent).Codigo;
    FClientDataSet.FieldByName('Nome').AsString := TPessoa(FParent).Nome;
    FClientDataSet.FieldByName('Sobrenome').AsString := TPessoa(FParent).Sobrenome;
    FClientDataSet.Post;

    FClientDataSet.SaveToFile('Pessoa.xml');
  end;
end;

class function TServiceData<T>.New(AParent: T): IServiceData<T>;
begin
  Result := Self.Create(AParent);
end;

function TServiceData<T>.Retrieve: TDataset;
begin
  //Aqui existe um jeito muito melhor de tirar esse acoplamento
  if FParent.ClassName = 'TPessoa' then
  begin
    if not FileExists('Pessoa.xml') then
    begin
      FClientDataSet.Close;
      FClientDataSet.FieldDefs.Clear;

      FClientDataSet.FieldDefs.Add('Codigo', ftInteger, 0, True);
      FClientDataSet.FieldDefs.Add('Nome', ftString, 100, True);
      FClientDataSet.FieldDefs.Add('Sobrenome', ftString, 255, True);

      FClientDataSet.CreateDataSet;
      FClientDataSet.SaveToFile('Pessoa.xml');
    end;

    FClientDataSet.LoadFromFile('Pessoa.xml');
  end;

  Result := FClientDataSet;
end;

end.
