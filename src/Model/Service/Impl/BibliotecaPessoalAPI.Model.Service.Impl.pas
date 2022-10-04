unit BibliotecaPessoalAPI.Model.Service.Impl;

interface

uses
  Bcrypt,
  BibliotecaPessoalAPI.Model.Entity.Usuario,
  BibliotecaPessoalAPI.Model.Exception.ExcecaoService, 
  BibliotecaPessoalAPI.Model.Resource.Interfaces,
  BibliotecaPessoalAPI.Model.Rosource.Impl.ResourceFactory,
  BibliotecaPessoalAPI.Model.Service.Interfaces,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  SimpleDAO,
  SimpleInterface,
  SimpleQueryFiredac,
  System.Classes,
  System.Generics.Collections, 
  System.SysUtils; 

type
  TServiceUsuario = class(TInterfacedObject, iServiceUsuario)
    private
      FConexao: iConexao;       
      FDAOUsuario: iSimpleDAO<TUsuario>;       
      FDataSource: TDataSource;
      FLista: TList<TUsuario>;       
      FQuery: iSimpleQuery;       
      FUsuario: TUsuario;

      procedure CriptografaSenhaUsuario(var pUsuario: TUsuario);
      procedure PopulaEntidadeUsuario;       
      procedure ValidaDadosUsuario(pUsuario: TUsuario);       
      procedure ValidaSecuridadeSenha(pSenha: String);       
      procedure ValidaUnicidadeUsuario(pUsuario: TUsuario);
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iServiceUsuario;

      function Atualizar(pUsuario: TUsuario): iServiceUsuario;
      function Excluir: iServiceUsuario; overload;
      function Excluir(pCampo: String; pValor: String): iServiceUsuario; overload;
      function Inserir(pUsuario: TUsuario): iServiceUsuario;
      function ListarTodos: iServiceUsuario;
      function ListarPor(pChave: String; pValor: Variant): iServiceUsuario;
      function ListarPorId(pId: Integer): iServiceUsuario;
      function RetornaLista: TList<TUsuario>;
  end;

implementation

{ TServiceUsuario }


function TServiceUsuario.Atualizar(pUsuario: TUsuario): iServiceUsuario;
begin
  Result := Self;
  FDAOUsuario.Update(pUsuario);
end;

constructor TServiceUsuario.Create;
begin
  FLista := TList<TUsuario>.Create;
  FDataSource := TDataSource.Create(nil);
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

function TServiceUsuario.Inserir(pUsuario: TUsuario): iServiceUsuario;
begin
  Result := Self;
  
  ValidaDadosUsuario(pUsuario);
  ValidaUnicidadeUsuario(pUsuario);
  ValidaSecuridadeSenha(pUsuario.Senha);
  CriptografaSenhaUsuario(pUsuario);
  
  FDAOUsuario.Insert(pUsuario);
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
  FUsuario := TUsuario.Create;
  try
    FDAOUsuario.DataSource(FDataSource).Find(False);
    FDataSource.DataSet.First;
    while not (FDataSource.DataSet.Eof) do begin
      PopulaEntidadeUsuario;
      FLista.Add(FUsuario);
      FDataSource.DataSet.Next;
    end;  
  finally
    FUsuario.DisposeOf;
  end;
end;

class function TServiceUsuario.New: iServiceUsuario;
begin
  Result := Self.Create;
end;

function TServiceUsuario.RetornaLista: TList<TUsuario>;
begin
  Result := FLista;
end;

procedure TServiceUsuario.CriptografaSenhaUsuario(var pUsuario: TUsuario);
begin
  pUsuario.Senha := TBCrypt.HashPassword(pUsuario.Senha);
end;

procedure TServiceUsuario.ValidaDadosUsuario(pUsuario: TUsuario);
var
  vListaMensagensErros: TStringList;
begin
  vListaMensagensErros := TStringList.Create;
  try
    if pUsuario.Usuario.IsEmpty then begin
      vListaMensagensErros.Add('campo usuário é obrigatório.');
    end;
    if pUsuario.Senha.IsEmpty then begin
      vListaMensagensErros.Add('campo senha é obrigatório.');
    end;
    if pUsuario.Email.IsEmpty then begin
      vListaMensagensErros.Add('campo email é obrigatório.');
    end;

    if vListaMensagensErros.Count > 0 then begin
      ExcecaoService.Create(vListaMensagensErros);
    end;      
  finally
  vListaMensagensErros.DisposeOf;
  end;

end;

procedure TServiceUsuario.ValidaSecuridadeSenha(pSenha: String);
var
  Algarismos: Set of '0'..'9';
  LetrasMaiusculas: Set of 'A'..'Z';
  LetrasMinusculas: Set of 'a'..'z';
  CaracteresEspeciais: Set of Char;
  vContador: Integer;
  vTamanhoSenha: Integer;
  vCaracter: Char;
  vContemAlgarismo: Boolean;
  vContemLetraMaiuscula: Boolean;
  vContemLetraMinuscula: Boolean;
  vContemCaracterEspecial: Boolean;
  vMensagensErros: TStringList;
begin
  vMensagensErros := TStringList.Create;
  try
    Algarismos := ['0'..'9'];
    LetrasMaiusculas := ['A'..'Z'];
    LetrasMinusculas := ['a'..'z'];
    CaracteresEspeciais := ['-','(',')','}','{','[',']',',',';',':','|','!','"','#','$','%','&','/','=','?','~','^','>','<','ª','º','@','*'];

    vContemAlgarismo := False;
    vContemLetraMaiuscula := False;
    vContemLetraMinuscula := False;
    vContemCaracterEspecial := False;

    vTamanhoSenha := pSenha.Length;
    vContador := 0;

    while vContador < vTamanhoSenha do begin
      vCaracter := pSenha.ToCharArray[vContador];

      if vCaracter in Algarismos then begin
        vContemAlgarismo := True;
      end;
      if vCaracter in LetrasMaiusculas then begin
        vContemLetraMaiuscula := True;
      end;
      if vCaracter in LetrasMinusculas then begin
        vContemLetraMinuscula := True;
      end;
      if vCaracter in CaracteresEspeciais then begin
        vContemCaracterEspecial := True;
      end;

      Inc(vContador);
    end;

    if not vContemAlgarismo then begin
      vMensagensErros.Add('a senha deve conter ao menos um algarismo.');
    end;
    if not vContemLetraMaiuscula then begin
      vMensagensErros.Add('a senha deve conter ao menos uma letra maiúscula.');
    end;
    if not vContemLetraMinuscula then begin
      vMensagensErros.Add('a senha deve conter ao menos uma letra minúscula.');
    end;
    if not vContemCaracterEspecial then begin
      vMensagensErros.Add('a senha deve conter ao menos um caracter especial.');
    end;
    if (vTamanhoSenha < 5) or (vTamanhoSenha > 25) then begin
      vMensagensErros.Add('a senha deve ter entre 5 e 25 caracteres');
    end;

    if vMensagensErros.Count > 0 then begin
      ExcecaoService.Create(vMensagensErros);
    end;
    
  finally
    vMensagensErros.DisposeOf;
  end;


end;

procedure TServiceUsuario.ValidaUnicidadeUsuario(pUsuario: TUsuario);
var
  vUsuarioCadastrado: String;
  vEmailCadastrado: String;
  vListaMensagensErros: TStringList;
begin
  vListaMensagensErros := TStringList.Create;
  try
    ListarTodos;
    FDataSource.DataSet.First;
    while not FDataSource.DataSet.Eof do begin
      vUsuarioCadastrado := FDataSource.DataSet.FieldByName('USUARIO').AsWideString;
      if vUsuarioCadastrado.Equals(pUsuario.Usuario) then begin
        vListaMensagensErros.Add('usuário já cadastrado com esse nome.')
      end;

      vEmailCadastrado := FDataSource.DataSet.FieldByName('EMAIL').AsWideString;
      if vEmailCadastrado.Equals(pUsuario.Email) then begin
        vListaMensagensErros.Add('email já cadastrado.')
      end;

      FDataSource.DataSet.Next;
    end;

    if vListaMensagensErros.Count > 0 then begin
      ExcecaoService.Create(vListaMensagensErros);
    end;
    
  finally
    vListaMensagensErros.DisposeOf;
  end;
  FDAOUsuario.DataSource(FDataSource).Find(False);
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
