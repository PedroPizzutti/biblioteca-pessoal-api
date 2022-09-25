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
  System.Generics.Collections, System.SysUtils;

type
  TServiceUsuario = class(TInterfacedObject, iServiceUsuario)
    private
      FLista: TList<TUsuario>;
      FDataSource: TDataSource;
      FUsuario: TUsuario;
      FConexao: iConexao;
      FQuery: iSimpleQuery;
      FDAOUsuario: iSimpleDAO<TUsuario>;
    procedure PopulaEntidadeUsuario;
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
      function RetornaLista: TList<TUsuario>;
      function RetornaUsuario: TUsuario;
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
  FLista := TList<TUsuario>.Create;
  FDataSource := TDataSource.Create(nil);
  FUsuario := pUsuario;
  FConexao := TResourceFactory.New.Conexao;
  FQuery := TSimpleQueryFiredac.New(TFDConnection(FConexao.Conectar));
  FDAOUsuario := TSimpleDAO<TUsuario>.New(FQuery);
end;

destructor TServiceUsuario.Destroy;
begin
  FLista.DisposeOf;
  FDataSource.DisposeOf;
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
  FDAOUsuario.DataSource(FDataSource).Find('USUARIO', FUsuario.Usuario);
  FDAOUsuario.DataSource(FDataSource).Find('EMAIL', FUsuario.Email);
  if not FDataSource.DataSet.IsEmpty then begin
    raise Exception.Create('já existe um usuário com essas informações');
  end;
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
  FDAOUsuario.DataSource(FDataSource).Find(False);

  FDataSource.DataSet.First;
  while not (FDataSource.DataSet.Eof) do begin
    PopulaEntidadeUsuario;
    FLista.Add(FUsuario);
    FDataSource.DataSet.Next;
  end;
end;

class function TServiceUsuario.New(pUsuario: TUsuario): iServiceUsuario;
begin
  Result := Self.Create(pUsuario);
end;

function TServiceUsuario.RetornaLista: TList<TUsuario>;
begin
  Result := FLista;
end;

function TServiceUsuario.RetornaUsuario: TUsuario;
begin
  Result := FUsuario
end;

procedure TServiceUsuario.PopulaEntidadeUsuario;
begin
  FUsuario.Id := FDataSource.DataSet.FieldByName('ID').AsInteger;
  FUsuario.Usuario := FDataSource.DataSet.FieldByName('USUARIO').AsWideString;
  FUsuario.Senha := FDataSource.DataSet.FieldByName('SENHA').AsWideString;
  FUsuario.Email := FDataSource.DataSet.FieldByName('EMAIL').AsWideString;
  FUsuario.DtCriacao := FDataSource.DataSet.FieldByName('DT_CRIACAO_USUARIO').AsDateTime;
end;

end.
