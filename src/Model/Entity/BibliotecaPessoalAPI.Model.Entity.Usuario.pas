unit BibliotecaPessoalAPI.Model.Entity.Usuario;

interface

uses
  SimpleAttributes;

type
  [Tabela('USUARIO')]
  TUsuario = class
    private
    FId: Integer;
    FUsuario: String;
    FSenha: String;
    FEmail: String;
    FDtCriacao: TDate;
    public
      [Campo('ID'), PK, AutoInc]
      property Id: Integer read FId write FId;
      [Campo('USUARIO'), NotNull]
      property Usuario: String read FUsuario write FUsuario;
      [Campo('SENHA'), NotNull]
      property Senha: String read FSenha write FSenha;
      [Campo('EMAIL'), NotNull]
      property Email: String read FEmail write FEmail;
      [Campo('DT_CRIACAO_USUARIO'), NotNull]
      property DtCriacao: TDate read FDtCriacao write FDtCriacao;
  end;

implementation

{ TUsuario }

end.
