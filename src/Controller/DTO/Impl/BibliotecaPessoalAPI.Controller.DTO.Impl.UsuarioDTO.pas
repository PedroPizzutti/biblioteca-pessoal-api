unit BibliotecaPessoalAPI.Controller.DTO.Impl.UsuarioDTO;

interface

uses
  BibliotecaPessoalAPI.Controller.DTO.Interfaces,
  BibliotecaPessoalAPI.Model.Service.Interfaces,
  BibliotecaPessoalAPI.Model.Entity.Usuario,
  BibliotecaPessoalAPI.Model.Service.Impl, System.SysUtils;

type
  TUsuarioDTO = class(TInterfacedObject, iUsuarioDTO)
    private
      FUsuario: TUsuario;
      FServiceUsuario: iServiceUsuario;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iUsuarioDTO;

      function Id(pId: Integer): iUsuarioDTO; overload;
      function Id: Integer; overload;
      function Usuario(pUsuario: String): iUsuarioDTO; overload;
      function Usuario: String; overload;
      function Senha(pSenha: String): iUsuarioDTO; overload;
      function Senha: String; overload;
      function DataCriacao(pDataCriacao: TDate): iUsuarioDTO; overload;
      function DataCriacao: TDate; overload;
      function Build: iServiceUsuario;
  end;

implementation

{ TUsuarioDTO }

function TUsuarioDTO.Build: iServiceUsuario;
begin
  Result := FServiceUsuario;
end;

constructor TUsuarioDTO.Create;
begin
  FUsuario := TUsuario.Create;
  FServiceUsuario := TServiceUsuario.New(FUsuario);
end;

function TUsuarioDTO.DataCriacao(pDataCriacao: TDate): iUsuarioDTO;
begin
  Result := Self;
  FUsuario.DtCriacao := pDataCriacao;
end;

function TUsuarioDTO.DataCriacao: TDate;
begin
  Result := FUsuario.DtCriacao;
end;

destructor TUsuarioDTO.Destroy;
begin
  FUsuario.DisposeOf;
  inherited;
end;

function TUsuarioDTO.Id(pId: Integer): iUsuarioDTO;
begin
  Result := Self;
  FUsuario.Id := pId;
end;

function TUsuarioDTO.Id: Integer;
begin
  Result := FUsuario.Id;
end;

class function TUsuarioDTO.New: iUsuarioDTO;
begin
  Result := Self.Create;
end;

function TUsuarioDTO.Senha(pSenha: String): iUsuarioDTO;
begin
  Result := Self;
  FUsuario.Senha := pSenha;
end;

function TUsuarioDTO.Senha: String;
begin
  Result := FUsuario.Senha;
end;

function TUsuarioDTO.Usuario(pUsuario: String): iUsuarioDTO;
begin
  Result := Self;
  FUsuario.Usuario := pUsuario;
end;

function TUsuarioDTO.Usuario: String;
begin
  Result := FUsuario.Usuario;
end;

end.

