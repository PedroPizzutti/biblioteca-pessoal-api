unit BibliotecaPessoalAPI.Controller.DTO.Impl.UsuarioDTO;

interface

uses
  BibliotecaPessoalAPI.Controller.DTO.Interfaces,
  BibliotecaPessoalAPI.Model.Entity.Usuario,
  BibliotecaPessoalAPI.Model.Service.Impl,
  BibliotecaPessoalAPI.Model.Service.Interfaces,
  System.SysUtils;

type
  TUsuarioDTO = class(TInterfacedObject, iUsuarioDTO)
    private
      FUsuario: TUsuario;
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
      function Email(pEmail: String): iUsuarioDTO; overload;
      function Email: String; overload;
      function DataCriacao(pDataCriacao: TDate): iUsuarioDTO; overload;
      function DataCriacao: TDate; overload;
      function CriaUsuario: TUsuario;
  end;

implementation

{ TUsuarioDTO }

function TUsuarioDTO.CriaUsuario: TUsuario;
begin
  Result := FUsuario;
end;

constructor TUsuarioDTO.Create;
begin
  FUsuario := TUsuario.Create;
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

function TUsuarioDTO.Email: String;
begin
  Result := FUsuario.Email;
end;

function TUsuarioDTO.Email(pEmail: String): iUsuarioDTO;
begin
  Result := Self;
  FUsuario.Email := pEmail;
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

