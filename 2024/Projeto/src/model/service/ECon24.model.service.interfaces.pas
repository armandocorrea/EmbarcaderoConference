unit ECon24.model.service.interfaces;

interface

uses
  DB;

type
  IServiceData<T: class> = interface
    ['{BB37A527-7437-4182-889C-7D6D51970AFE}']
    function Insert: IServiceData<T>;
    function Retrieve: TDataset;
  end;

implementation

end.
