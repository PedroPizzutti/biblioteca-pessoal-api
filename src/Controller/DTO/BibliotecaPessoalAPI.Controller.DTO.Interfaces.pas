unit BibliotecaPessoalAPI.Controller.DTO.Interfaces;

interface

uses
  BibliotecaPessoalAPI.Model.Service.Interfaces,
  BibliotecaPessoalAPI.Model.Entity.Usuario;

type
  iUsuarioDTO = interface
    function Id(pId: Integer): iUsuarioDTO; overload;
    function Id: Integer; overload;
    function Usuario(pUsuario: String): iUsuarioDTO; overload;
    function Usuario: String; overload;
    function Senha(pSenha: String): iUsuarioDTO; overload;
    function Senha: String; overload;
    function DataCriacao(pDataCriacao: TDate): iUsuarioDTO; overload;
    function DataCriancao: TDate; overload;
    function Build: iServiceUsuario;
  end;

implementation

end.

