unit ECon24.controller.dto.interfaces;

interface

uses
  ECon24.model.service.interfaces,
  ECon24.model.pessoa;

type
  IPessoa = interface
    ['{365D8015-A669-4B92-8A52-CA441D590AAF}']
    function Codigo: Integer; overload;
    function Codigo(AValue: Integer): IPessoa; overload;
    function Nome: string; overload;
    function Nome(AValue: string): IPessoa; overload;
    function Sobrenome: string; overload;
    function Sobrenome(AValue: string): IPessoa; overload;

    function Build: IServiceData<TPessoa>;
  end;

implementation

end.
