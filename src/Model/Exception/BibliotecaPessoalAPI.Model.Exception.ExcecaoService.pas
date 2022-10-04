unit BibliotecaPessoalAPI.Model.Exception.ExcecaoService;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.SysUtils;

type
  ExcecaoService = class(Exception)
    public
      constructor Create(pMensagem: String); overload;
      constructor Create(pListaMensagem: TStringList); overload;
  end;

implementation

{ ExcecaoService }

constructor ExcecaoService.Create(pMensagem: String);
begin
  raise Exception.Create(pMensagem);
end;

constructor ExcecaoService.Create(pListaMensagem: TStringList);
var
  vMensagemErro: String;
  contador: Integer;
begin
  for contador := 0 to pListaMensagem.Count - 1 do begin
    if not (contador = pListaMensagem.Count - 1) then begin
      vMensagemErro := vMensagemErro + pListaMensagem.Strings[contador] + ' / ';
    end
    else begin
      vMensagemErro := vMensagemErro + pListaMensagem.Strings[contador]; 
    end;
  end;
  raise Exception.Create(vMensagemErro);
end;

end.
