program BibliotecaPessoalAPI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.SysUtils,
  Routes in 'Routes.pas',
  BibliotecaPessoalAPI.Model.Resource.Interfaces in 'src\Model\Resource\BibliotecaPessoalAPI.Model.Resource.Interfaces.pas',
  BibliotecaPessoalAPI.Model.Rosource.Impl.Configuracao in 'src\Model\Resource\Impl\BibliotecaPessoalAPI.Model.Rosource.Impl.Configuracao.pas';

var
  App: THorse;

begin
  App := THorse.Create;

  Routes.Registry;

  App.Use(Jhonson);

  App.Listen(9000,
    procedure(App: THorse) begin
      Writeln('--- API Executando ---');
      Writeln(Format('Servidor: %s',[App.Host]));
      Writeln(Format('Porta: %d',[App.Port]));
      {IFDEBUG}
        Writeln('Acesso: http://localhost:' + App.Port.ToString);
      {ENDIF}
      Readln;
    end
  );
end.
