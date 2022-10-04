unit BibliotecaPessoalAPI.Controller.Usuario;

interface

uses
  BibliotecaPessoalAPI.Controller.DTO.Impl.UsuarioDTO,
  BibliotecaPessoalAPI.Model.Service.Impl,
  BibliotecaPessoalAPI.Model.Service.Interfaces,
  BibliotecaPessoalAPI.Model.Entity.Usuario,
  GBSwagger.Path.Attributes,
  Horse,
  Horse.GBSwagger,
  Horse.Jhonson,
  Horse.Commons,
  Rest.Json,
  System.Classes,
  System.JSON,
  System.StrUtils,
  System.SysUtils,
  System.Types;




type
  [SwagPath('login', 'Login')]
  TControllerUsuario = class(THorseGBSwagger)

    [SwagPOST('novoUsuario', 'Cria um novo usuário')]
    [SwagResponse(201, 'Criado novo usuário!')]
    [SwagResponse(400, 'Erro ao criar novo usuário...')]
    procedure PostUsuario;
  end;

implementation

{ TControllerUsuario }

procedure TControllerUsuario.PostUsuario;
var
  vBodyRequest: TJSONObject;
  vBodyResponse: TJSONObject;
  vId: Integer;
  vContador: Integer;
  vQuantidadeMsgErro: Integer;
  vNome: String;
  vSenha: String;
  vEmail: String;
  vMsgs: TStringDynArray;
  vUsuario : TUsuario;
begin
  vBodyRequest := TJSONObject.Create;
  vBodyResponse:= TJSONObject.Create;
  try
    vBodyRequest := TJSONObject.ParseJSONValue(FRequest.Body) as TJSONObject;
    vBodyRequest.TryGetValue('usuario', vNome);
    vBodyRequest.TryGetValue('senha', vSenha);
    vBodyRequest.TryGetValue('email', vEmail);

    vUsuario := TUsuarioDTO.New
                  .Usuario(vNome)
                  .Senha(vSenha)
                  .Email(vEmail)
                  .DataCriacao(Now)
                  .CriaUsuario;

    TServiceUsuario.New.Inserir(vUsuario);

    vBodyResponse.AddPair('mensagem', 'usuário cadastrado com sucesso.');

    FResponse.Send(vBodyResponse).Status(THTTPStatus.Created);

  except on E: Exception do begin

    if E.Message.Contains('/') then begin
      vMsgs := SplitString(E.Message, '/');
      vQuantidadeMsgErro := E.Message.CountChar('/');

      for vContador := 0 to (vQuantidadeMsgErro) do begin
        vBodyResponse.AddPair('erro' + (vContador + 1).ToString + ':', vMsgs[vContador].Trim);
      end;

    end
    else begin
       vBodyResponse.AddPair('erro:', E.Message);
    end;

    FResponse.Send(vBodyResponse).Status(THTTPStatus.BadRequest);
  end;
  end;
end;

end.
