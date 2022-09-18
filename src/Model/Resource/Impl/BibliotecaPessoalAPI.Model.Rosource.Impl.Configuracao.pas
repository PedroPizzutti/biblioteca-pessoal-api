unit BibliotecaPessoalAPI.Model.Rosource.Impl.Configuracao;

interface

uses
  System.SysUtils,
  LocalCache4D,
  BibliotecaPessoalAPI.Model.Resource.Interfaces;

type
  TConfiguracao = class(TInterfacedObject, iConfiguracao)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iConfiguracao;

      function DriverID(pIdDriver: String): iConfiguracao; overload;
      function DriverID: String; overload;
      function DataBase(pDataBase: String): iConfiguracao; overload;
      function Database: String; overload;
      function UserName(pUserName: String): iConfiguracao; overload;
      function UserName: String; overload;
      function Password(pPassword: String): iConfiguracao; overload;
      function Password: String; overload;
      function Port(pPort: String): iConfiguracao; overload;
      function Port: String; overload;
      function Server(pServer: String): iConfiguracao; overload;
      function Server: String; overload;
      function Schema(pSchema: String): iConfiguracao; overload;
      function Schema: String; overload;
      function Locking(pLocking: String): iConfiguracao; overload;
      function Locking: String; overload;
  end;

implementation

{ TConfiguracao }

constructor TConfiguracao.Create;
begin
  if not (FileExists('bibliotecaPessoalAPI.lc4')) then begin
    LocalCache.SaveToStorage('bibliotecaPessoalAPI.lc4');
  end;

  LocalCache.LoadDatabase('bibliotecaPessoalAPI.lc4');
  LocalCache.Instance('Configuracao');
end;

function TConfiguracao.DataBase: String;
begin
  Result := LocalCache.GetItem('Database');
end;

function TConfiguracao.DataBase(pDataBase: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Database', pDataBase);
end;

destructor TConfiguracao.Destroy;
begin
  LocalCache.SaveToStorage('bibliotecaPessoalAPI.lc4');
  inherited;
end;

function TConfiguracao.DriverID: String;
begin
  Result := LocalCache.GetItem('DriverID');
end;

function TConfiguracao.DriverID(pIdDriver: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('DriverID', pIdDriver);
end;

function TConfiguracao.Locking: String;
begin
  Result := LocalCache.GetItem('Locking');
end;

function TConfiguracao.Locking(pLocking: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Locking', pLocking);
end;

class function TConfiguracao.New: iConfiguracao;
begin
  Result := Self.Create;
end;

function TConfiguracao.Password: String;
begin
  Result := LocalCache.GetItem('Password');
end;

function TConfiguracao.Password(pPassword: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Password', pPassword);
end;

function TConfiguracao.Port(pPort: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Port', pPort);
end;

function TConfiguracao.Port: String;
begin
  Result := LocalCache.GetItem('Port');
end;

function TConfiguracao.Schema: String;
begin
  Result := LocalCache.GetItem('Schema');
end;

function TConfiguracao.Schema(pSchema: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Schema', pSchema);
end;

function TConfiguracao.Server(pServer: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Server', pServer);
end;

function TConfiguracao.Server: String;
begin
  Result := LocalCache.GetItem('Server');
end;

function TConfiguracao.UserName(pUserName: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('UserName', pUserName);
end;

function TConfiguracao.UserName: String;
begin
  Result := LocalCache.GetItem('UserName');
end;

end.
