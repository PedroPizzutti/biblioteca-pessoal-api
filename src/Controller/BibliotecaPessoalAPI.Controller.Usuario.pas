unit BibliotecaPessoalAPI.Controller.Usuario;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Attributes,
  Horse.Jhonson,
  Horse.Commons,
  Rest.Json,
  System.JSON,
  System.SysUtils, BibliotecaPessoalAPI.Controller.DTO.Impl.UsuarioDTO,
  BibliotecaPessoalAPI.Model.Service.Interfaces,
  BibliotecaPessoalAPI.Model.Entity.Usuario,
  BibliotecaPessoalAPI.Model.Service.Impl;

type
  [SwagPath('login', 'Login')]
  TControllerUsuario = class(THorseGBSwagger)

    [SwagPOST('novoUsuario', 'Cria um novo usuário')]
    [SwagResponse(201, 'Criado novo usuário!')]
    [SwagResponse(400, 'Erro ao criar novo usuário...')]
    procedure PostUsuario;
  end;

implementation

procedure Teste(Req: THorseRequest; Res: THorseResponse);
begin
  Res.Send('FUNCIONA!!');
end;

{ TControllerUsuario }

procedure TControllerUsuario.PostUsuario;
var
  vBodyRequest: TJSONObject;
  vBodyResponse: TJSONObject;
  vId: Integer;
  vNome: String;
  vSenha: String;
  vEmail: String;
  vMsg: String;
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
    vBodyResponse.AddPair('erro:', E.Message);
    FResponse.Send(vBodyResponse).Status(THTTPStatus.BadRequest);
  end;
  end;
end;

end.
