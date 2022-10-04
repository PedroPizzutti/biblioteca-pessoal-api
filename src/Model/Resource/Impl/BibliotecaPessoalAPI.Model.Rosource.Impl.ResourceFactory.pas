unit BibliotecaPessoalAPI.Model.Rosource.Impl.ResourceFactory;

interface

uses
  BibliotecaPessoalAPI.Model.Resource.Interfaces,
  BibliotecaPessoalAPI.Model.Rosource.Impl.ConexaoFireDACSQLite,
  BibliotecaPessoalAPI.Model.Rosource.Impl.Configuracao;

type
  TResourceFactory = class(TInterfacedObject, iResourceFactory)
    private
      FConexao: iConexao;
      FConfiguracao: iConfiguracao;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iResourceFactory;

      function Conexao: iConexao;
      function Configuracao: iConfiguracao;
  end;

implementation

{ TResourceFactory }

function TResourceFactory.Conexao: iConexao;
begin
  Result := FConexao;
end;

function TResourceFactory.Configuracao: iConfiguracao;
begin
  Result := FConfiguracao;
end;

constructor TResourceFactory.Create;
begin
  FConfiguracao := TConfiguracao.New;
  FConexao := TConexaoFireDACSQLite.New(FConfiguracao);
end;

destructor TResourceFactory.Destroy;
begin

  inherited;
end;

class function TResourceFactory.New: iResourceFactory;
begin
  Result := Self.Create;
end;

end.
