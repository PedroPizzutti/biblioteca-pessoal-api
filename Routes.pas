unit Routes;

interface

uses
  Horse, BibliotecaPessoalAPI.Model.Resource.Interfaces;

  procedure Registry;

implementation

procedure Registry;
var
  Conexao: iConexao;
begin
  THorse.Get('/',
    procedure (Req: THorseRequest; Res: THorseResponse) begin
      Res.Send('Rota Home Registrada!');
    end
  )
end;

end.
