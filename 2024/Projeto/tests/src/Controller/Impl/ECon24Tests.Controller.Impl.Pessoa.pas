unit ECon24Tests.Controller.Impl.Pessoa;

interface

uses
  DUnitX.TestFramework,
  ECon24.controller.interfaces;

type
  [TestFixture]
  TPessoaDTOTest = class
    public
      FController: IController;

    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    [TestCase('TestCodigo','1,1')]
    procedure TestCodigo(const AValueTest, AValueExpected: Integer);

    [Test]
    [TestCase('TestNome','Armando,Armando')]
    procedure TestNome(const AValueTest, AValueExpected: String);

    [Test]
    [TestCase('TestSobrenome','Neto,Neto')]
    procedure TestSobrenome(const AValueTest, AValueExpected: String);

    [Test]
    procedure TestRetrieve;
  end;

implementation

uses
  ECon24.controller.impl.controller;

{ TPessoaDTOTest }

procedure TPessoaDTOTest.Setup;
begin
  FController := TController.New;
end;

procedure TPessoaDTOTest.TearDown;
begin
end;

procedure TPessoaDTOTest.TestRetrieve;
begin
  var LDataSet := FController.Pessoa.Build.Retrieve;
  Assert.IsTrue(Assigned(LDataSet));
end;

procedure TPessoaDTOTest.TestCodigo(const AValueTest, AValueExpected: Integer);
begin
  FController.Pessoa.Codigo(AValueTest);
  Assert.AreEqual(AValueExpected, FController.Pessoa.Codigo);
end;

procedure TPessoaDTOTest.TestNome(const AValueTest, AValueExpected: String);
begin
  FController.Pessoa.Nome(AValueTest);
  Assert.AreEqual(AValueExpected, FController.Pessoa.Nome);
end;

procedure TPessoaDTOTest.TestSobrenome(const AValueTest,
  AValueExpected: String);
begin
  FController.Pessoa.Sobrenome(AValueTest);
  Assert.AreEqual(AValueExpected, FController.Pessoa.Sobrenome);
end;

end.
