program BibliotecaPessoalAPI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.SysUtils,
  Routes in 'src\Controller\Routes.pas';

var
  App: THorse;

begin
  App := THorse.Create;

  App.Use(Jhonson);

  Routes.Registry;

  App.Listen(9000,
    procedure(App: THorse) begin
      Writeln('--- API Executando ---');
      Writeln(Format('Servidor: %s',[App.Host]));
      Writeln(Format('Porta: %d',[App.Port]));
      {IFDEBUG}
        Writeln('Acesso: http://localhost:9000');
      {ENDIF}
      Readln;
    end
  );
end.
