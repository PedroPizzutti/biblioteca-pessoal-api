program BibliotecaPessoalAPI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.SysUtils;

var
  App: THorse;

begin
  App := THorse.Create;

  App.Use(Jhonson);

  App.Listen(9000,
    procedure(Horse: THorse) begin
      Writeln(Format('Servidor rodando em %s, porta: %d',[Horse.Host, Horse.Port]));
      Readln;
    end
  );
end.
