unit ECon24.controller.dto.impl.pessoa;

interface

uses
  ECon24.controller.dto.interfaces,
  ECon24.model.service.interfaces,
  ECon24.model.pessoa;

type
  TPessoaDTO = class(TInterfacedObject, IPessoa)
    private
      FPessoa: TPessoa;
      FService: IServiceData<TPessoa>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IPessoa;

      function Codigo: Integer; overload;
      function Codigo(AValue: Integer): IPessoa; overload;
      function Nome: string; overload;
      function Nome(AValue: string): IPessoa; overload;
      function Sobrenome: string; overload;
      function Sobrenome(AValue: string): IPessoa; overload;

      function Build: IServiceData<TPessoa>;
  end;

implementation

uses
  SysUtils,
  ECon24.model.service.impl.servicedata;

{ TPessoaDTO }

function TPessoaDTO.Codigo: Integer;
begin
  Result := FPessoa.Codigo;
end;

function TPessoaDTO.Build: IServiceData<TPessoa>;
begin
  Result := FService;
end;

function TPessoaDTO.Codigo(AValue: Integer): IPessoa;
begin
  Result := Self;
  FPessoa.Codigo := AValue;
end;

constructor TPessoaDTO.Create;
begin
  FPessoa := TPessoa.Create;
  FService := TServiceData<TPessoa>.New(FPessoa);
end;

destructor TPessoaDTO.Destroy;
begin
  FreeAndNil(FPessoa);
  inherited;
end;

class function TPessoaDTO.New: IPessoa;
begin
  Result := Self.Create;
end;

function TPessoaDTO.Nome: string;
begin
  Result := FPessoa.Nome;
end;

function TPessoaDTO.Nome(AValue: string): IPessoa;
begin
  Result := Self;
  FPessoa.Nome := AValue;
end;

function TPessoaDTO.Sobrenome(AValue: string): IPessoa;
begin
  Result := Self;
  FPessoa.Sobrenome := AValue;
end;

function TPessoaDTO.Sobrenome: string;
begin
  Result := FPessoa.Sobrenome;
end;

end.
