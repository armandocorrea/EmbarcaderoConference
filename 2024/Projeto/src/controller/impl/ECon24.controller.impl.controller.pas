unit ECon24.controller.impl.controller;

interface

uses
  ECon24.controller.interfaces,
  ECon24.controller.dto.interfaces;

type
  TController = class(TInterfacedObject, IController)
    private
      FPessoa: IPessoa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IController;

      function Pessoa: IPessoa;
  end;

implementation

uses
  ECon24.controller.dto.impl.pessoa;

{ TController }

constructor TController.Create;
begin
end;

destructor TController.Destroy;
begin
  inherited;
end;

class function TController.New: IController;
begin
  Result := Self.Create;
end;

function TController.Pessoa: IPessoa;
begin
  if not Assigned(FPessoa) then
    FPessoa := TPessoaDTO.New;

  Result := FPessoa;
end;

end.
