unit BibliotecaPessoalAPI.Model.Resource.Interfaces;

interface

uses
  Data.DB;

type
  iConexao = interface
    ['{BC304AAC-64CE-4C76-8E19-C6526C3F4229}']
    function Conectar: TCustomConnection;
  end;

  iConfiguracao = interface
    ['{E5D533C5-F712-4111-A456-A77742AC04A0}']
    function DataBase(pDataBase: String): iConfiguracao; overload;
    function Database: String; overload;
    function DriverID(pIdDriver: String): iConfiguracao; overload;
    function DriverID: String; overload;
    function Locking(pLocking: String): iConfiguracao; overload;
    function Locking: String; overload;
    function Password(pPassword: String): iConfiguracao; overload;
    function Password: String; overload;
    function Port(pPort: String): iConfiguracao; overload;
    function Port: String; overload;
    function UserName(pUserName: String): iConfiguracao; overload;
    function UserName: String; overload;
    function Schema(pSchema: String): iConfiguracao; overload;
    function Schema: String; overload;
    function Server(pServer: String): iConfiguracao; overload;
    function Server: String; overload;
  end;

  iResourceFactory = interface
    function Conexao: iConexao;
    function Configuracao: iConfiguracao;
  end;

implementation

end.
