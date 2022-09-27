unit BibliotecaPessoalAPI.Model.Service.Interfaces;

interface

uses
  BibliotecaPessoalAPI.Model.Entity.Usuario,
  Data.DB,
  System.Generics.Collections;

type
  iServiceUsuario = interface
    function ListarTodos: iServiceUsuario;
    function ListarPorId(pId: Integer): iServiceUsuario;
    function ListarPor(pChave: String; pValor: Variant): iServiceUsuario;
    function Inserir(pUsuario: TUsuario): iServiceUsuario;
    function Atualizar(pUsuario: TUsuario): iServiceUsuario;
    function Excluir: iServiceUsuario; overload;
    function Excluir(pCampo: String; pValor: String): iServiceUsuario; overload;
    function RetornaLista: TList<TUsuario>;
  end;

implementation

end.

