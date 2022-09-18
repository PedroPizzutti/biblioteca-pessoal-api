unit BibliotecaPessoalAPI.Model.Rosource.Impl.ConeoxaoFireDACSQLite;

interface

uses
  BibliotecaPessoalAPI.Model.Resource.Interfaces,
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
  System.SysUtils;

type
  TConexaoFireDACSQLite = class(TInterfacedObject, iConexao)
    private
      FConfiguracao: iConfiguracao;
      FConexao: TFDConnection;
    public
      constructor Create(pConfiguracao: iConfiguracao);
      destructor Destroy; override;
      class function New(pConfiguracao: iConfiguracao): iConexao;

      procedure SetaConfiguracao;
      function Conectar: TCustomConnection;
  end;

implementation

{ TConexaoFireDACSQLite }

function TConexaoFireDACSQLite.Conectar: TCustomConnection;
begin
  try
    FConexao.Params.DriverID := FConfiguracao.DriverID;
    FConexao.Params.Database := FConfiguracao.DataBase;
    FConexao.Params.UserName := FConfiguracao.UserName;
    FConexao.Params.Password := FConfiguracao.Password;
    FConexao.Params.Add('Port=' + FConfiguracao.Port);
    FConexao.Params.Add('Server=' + FConfiguracao.Server);

    if not (FConfiguracao.Schema.IsEmpty) then begin
      FConexao.Params.Add('MetaCurSchema=' + FConfiguracao.Schema);
      FConexao.Params.Add('MetaDefSchema=' + FConfiguracao.Schema);
    end;

    if not (FConfiguracao.Locking.IsEmpty) then begin
      FConexao.Params.Add('LockingMode=' + FConfiguracao.Locking);
    end;

    FConexao.Connected := True;

    Result := FConexao;

  except on E: Exception do
    raise Exception.Create('Não foi possível conectar... Erro: ' + E.Message);
  end;
end;

constructor TConexaoFireDACSQLite.Create(pConfiguracao: iConfiguracao);
begin
   FConexao := TFDConnection.Create(nil);
   FConfiguracao := pConfiguracao;
end;

destructor TConexaoFireDACSQLite.Destroy;
begin
  FConexao.DisposeOf;
  inherited;
end;

class function TConexaoFireDACSQLite.New(pConfiguracao: iConfiguracao): iConexao;
begin
  Result := Self.Create(pConfiguracao);
end;

procedure TConexaoFireDACSQLite.SetaConfiguracao;
begin
  try
    FConfiguracao
        .DriverID('SQLite')
        .DataBase('D:\Meus Documentos\Documentos\Fontes\MeusProjetos\biblioteca_pessoal_api\database\bibliotecaPessoalBD.sdb')
        .UserName('')
        .Password('')
        .Port('')
        .Server('')
        .Schema('')
        .Locking('normal');  
  except on E: Exception do
    raise Exception.Create('Não foi possível configurar o banco de dados... Erro: ' + E.Message);
  end;
end;

end.
