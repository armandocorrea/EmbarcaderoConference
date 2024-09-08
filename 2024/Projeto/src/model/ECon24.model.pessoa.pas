unit ECon24.model.pessoa;

interface

type
  TPessoa = class
    private
      FCodigo: Integer;
      FNome: string;
      FSobrenome: string;

      function GetCodigo: Integer;
      function GetNome: string;
      function GetSobrenome: string;

      procedure SetCodigo(const AValue: Integer);
      procedure SetNome(const AValue: string);
      procedure SetSobrenome(const AValue: string);
    public
      constructor Create;

      property Codigo: Integer read GetCodigo write SetCodigo;
      property Nome: string read GetNome write SetNome;
      property Sobrenome: string read GetSobrenome write SetSobrenome;
  end;

implementation

uses
  SysUtils;

{ TPessoa }

constructor TPessoa.Create;
begin
  FCodigo := 0;
  FNome := EmptyStr;
  FSobrenome := EmptyStr;
end;

function TPessoa.GetCodigo: Integer;
begin
  Result := FCodigo;
end;

function TPessoa.GetNome: string;
begin
  Result := FNome;
end;

function TPessoa.GetSobrenome: string;
begin
  Result := FSobrenome;
end;

procedure TPessoa.SetCodigo(const AValue: Integer);
begin
  FCodigo := AValue;
end;

procedure TPessoa.SetNome(const AValue: string);
begin
  FNome := AValue;
end;

procedure TPessoa.SetSobrenome(const AValue: string);
begin
  FSobrenome := AValue;
end;

end.
