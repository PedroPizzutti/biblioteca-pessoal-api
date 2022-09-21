unit BibliotecaPessoalAPI.Model.Service.Interfaces;

interface

uses
  Data.DB;

type
  iService<T: Class> = interface
    function ListarTodos: iService<T>;
    function ListarPorId(pId: Integer): iService<T>;
    function ListarPor(pChave: String; pValor: Variant): iService<T>;
    function Inserir: iService<T>;
    function Atualizar: iService<T>;
    function Excluir: iService<T>; overload;
    function Excluir(pCampo: String; pValor: String): iService<T>; overload;
    function DataSource(pDataSource: TDataSource): iService<T>;
    function This: T;
  end;

implementation

end.

