unit BibliotecaPessoalAPI.Model.Service.Interfaces;

interface

uses
  Data.DB, BibliotecaPessoalAPI.Model.Entity.Usuario;

type
  iServiceUsuario = interface
    function ListarTodos: iServiceUsuario;
    function ListarPorId(pId: Integer): iServiceUsuario;
    function ListarPor(pChave: String; pValor: Variant): iServiceUsuario;
    function Inserir: iServiceUsuario;
    function Atualizar: iServiceUsuario;
    function Excluir: iServiceUsuario; overload;
    function Excluir(pCampo: String; pValor: String): iServiceUsuario; overload;
    function DataSource(pDataSource: TDataSource): iServiceUsuario;
    function &End: TUsuario;
  end;

implementation

end.

