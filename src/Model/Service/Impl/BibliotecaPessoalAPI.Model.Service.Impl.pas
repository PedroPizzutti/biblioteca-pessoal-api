unit BibliotecaPessoalAPI.Model.Service.Impl;

interface

uses
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
  TService<T: Class, constructor> = class(TInterfacedObject, iService<T>)
    private
      FParent: T;
      FConexao: iConexao;
      FQuery: iSimpleQuery;
      FDAO: iSimpleDAO<T>;
      FDataSource: TDataSource;
    public
      constructor Create(Parent: T);
      destructor Destroy; override;
      class function New(Parent: T): iService<T>;

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

{ TService<T> }


function TService<T>.Atualizar: iService<T>;
begin
  Result := Self;
  FDAO.Update(FParent);
end;

constructor TService<T>.Create(Parent: T);
begin
  FParent := Parent;
  FConexao := TResourceFactory.New.Conexao;
  FQuery := TSimpleQueryFiredac.New(TFDConnection(FConexao.Conectar));
  FDAO := TSimpleDAO<T>.New(FQuery);
end;

function TService<T>.DataSource(pDataSource: TDataSource): iService<T>;
begin
  Result := Self;
  FDAO.DataSource(pDataSource);
end;

destructor TService<T>.Destroy;
begin

  inherited;
end;

function TService<T>.Excluir(pCampo, pValor: String): iService<T>;
begin
  Result := Self;
  FDAO.Delete(pCampo, pValor);
end;

function TService<T>.Excluir: iService<T>;
begin
  Result := Self;
  FDAO.Delete(FParent);
end;

function TService<T>.Inserir: iService<T>;
begin
  Result := Self;
  FDAO.Insert(FParent);
end;

function TService<T>.ListarPor(pChave: String; pValor: Variant): iService<T>;
begin
  Result := Self;
  FDAO.Find(pChave, pValor);
end;

function TService<T>.ListarPorId(pId: Integer): iService<T>;
begin
  Result := Self;
  FDAO.Find(pId);
end;

function TService<T>.ListarTodos: iService<T>;
begin
  Result := Self;
  FDAO.Find(False);
end;

class function TService<T>.New(Parent: T): iService<T>;
begin
  Result := Self.Create(Parent);
end;

function TService<T>.This: T;
begin
  Result := FParent;
end;

end.
