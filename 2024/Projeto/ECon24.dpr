program ECon24;

uses
  Vcl.Forms,
  ECon24.view.Pessoa in 'src\view\ECon24.view.Pessoa.pas' {frmCadastroPessoa},
  ECon24.model.pessoa in 'src\model\ECon24.model.pessoa.pas',
  ECon24.controller.interfaces in 'src\controller\ECon24.controller.interfaces.pas',
  ECon24.controller.dto.interfaces in 'src\controller\dto\ECon24.controller.dto.interfaces.pas',
  ECon24.controller.dto.impl.pessoa in 'src\controller\dto\impl\ECon24.controller.dto.impl.pessoa.pas',
  ECon24.controller.impl.controller in 'src\controller\impl\ECon24.controller.impl.controller.pas',
  ECon24.model.service.interfaces in 'src\model\service\ECon24.model.service.interfaces.pas',
  ECon24.model.service.impl.servicedata in 'src\model\service\impl\ECon24.model.service.impl.servicedata.pas',
  ECon24.constantes.Version in 'src\constantes\ECon24.constantes.Version.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastroPessoa, frmCadastroPessoa);
  Application.Run;
end.
