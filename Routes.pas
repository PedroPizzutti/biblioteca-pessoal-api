unit Routes;

interface

uses
  Horse, BibliotecaPessoalAPI.Model.Entity.Usuario, System.SysUtils, BibliotecaPessoalAPI.Model.Service.Impl;

  procedure Registry;

implementation

procedure Registry;

begin
  THorse.Get('/',
    procedure (Req: THorseRequest; Res: THorseResponse) begin
      Res.Send('Rota Home Registrada!')
    end
  )
end;

end.
