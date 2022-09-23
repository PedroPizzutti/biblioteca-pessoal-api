unit BibliotecaPessoalAPI.Model.Service.Impl;

interface

uses
  BibliotecaPessoalAPI.Model.Entity.Usuario,
  BibliotecaPessoalAPI.Model.Resource.Interfaces,
  BibliotecaPessoalAPI.Model.Rosource.Impl.ResourceFactory,
  BibliotecaPessoalAPI.Model.Service.Interfaces,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  SimpleInterface,
  SimpleDAO,
  SimpleQueryFiredac,
  System.Generics.Collections;

type
  TServiceUsuario = class(TInterfacedObject, iServiceUsuario)
    private
      FUsuario: TUsuario;
      FConexao: iConexao;
      FQuery: iSimpleQuery;
      FDAOUsuario: iSimpleDAO<TUsuario>;
    public
      constructor Create(pUsuario: TUsuario);
      destructor Destroy; override;
      class function New(pUsuario: TUsuario): iServiceUsuario;

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

{ TServiceUsuario }


function TServiceUsuario.Atualizar: iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.Update(FUsuario);
end;

constructor TServiceUsuario.Create(pUsuario: TUsuario);
begin
  FUsuario := pUsuario;
  FConexao := TResourceFactory.New.Conexao;
  FQuery := TSimpleQueryFiredac.New(TFDConnection(FConexao.Conectar));
  FDAOUsuario := TSimpleDAO<TUsuario>.New(FQuery);
end;

function TServiceUsuario.DataSource(pDataSource: TDataSource): iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.DataSource(pDataSource);
end;

destructor TServiceUsuario.Destroy;
begin

  inherited;
end;

function TServiceUsuario.Excluir(pCampo, pValor: String): iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.Delete(pCampo, pValor);
end;

function TServiceUsuario.Excluir: iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.Delete(FUsuario);
end;

function TServiceUsuario.Inserir: iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.Insert(FUsuario);
end;

function TServiceUsuario.ListarPor(pChave: String; pValor: Variant): iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.Find(pChave, pValor);
end;

function TServiceUsuario.ListarPorId(pId: Integer): iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.Find(pId);
end;

function TServiceUsuario.ListarTodos: iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.Find(False);
end;

class function TServiceUsuario.New(pUsuario: TUsuario): iServiceUsuario;
begin
  Result := Self.Create(pUsuario);
end;

function TServiceUsuario.&End: TUsuario;
begin
  Result := FUsuario;
end;

end.
