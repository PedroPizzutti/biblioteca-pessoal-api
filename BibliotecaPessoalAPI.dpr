program BibliotecaPessoalAPI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.SysUtils,
  Routes in 'Routes.pas',
  BibliotecaPessoalAPI.Model.Resource.Interfaces in 'src\Model\Resource\BibliotecaPessoalAPI.Model.Resource.Interfaces.pas',
  BibliotecaPessoalAPI.Model.Rosource.Impl.Configuracao in 'src\Model\Resource\Impl\BibliotecaPessoalAPI.Model.Rosource.Impl.Configuracao.pas',
  BibliotecaPessoalAPI.Model.Rosource.Impl.ResourceFactory in 'src\Model\Resource\Impl\BibliotecaPessoalAPI.Model.Rosource.Impl.ResourceFactory.pas',
  BibliotecaPessoalAPI.Model.Rosource.Impl.ConexaoFireDACSQLite in 'src\Model\Resource\Impl\BibliotecaPessoalAPI.Model.Rosource.Impl.ConexaoFireDACSQLite.pas',
  BibliotecaPessoalAPI.Model.Entity.Usuario in 'src\Model\Entity\BibliotecaPessoalAPI.Model.Entity.Usuario.pas';

var
  App: THorse;
  Conexao: iConexao;

begin
  App := THorse.Create;
  Conexao := TResourceFactory.New.Conexao;

  App.Use(Jhonson);

  Routes.Registry;
  Conexao.Conectar;

  App.Listen(9000,
    procedure(App: THorse) begin
      Writeln('--- API Biblioteca Pessoal ---');
      Writeln(Format('Servidor: %s',[App.Host]));
      Writeln(Format('Porta: %d',[App.Port]));
      {IFDEBUG}
        Writeln('Acesso: http://localhost:' + App.Port.ToString);
      {ENDIF}
      Readln;
    end
    );
end.
