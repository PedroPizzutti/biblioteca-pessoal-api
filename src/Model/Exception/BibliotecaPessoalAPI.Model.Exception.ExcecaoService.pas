unit BibliotecaPessoalAPI.Model.Exception.ExcecaoService;

interface

uses
  System.SysUtils;

type
  ExcecaoService = class(Exception)
    public
      constructor Create(pMensagem: String);
  end;

implementation

{ ExcecaoService }

constructor ExcecaoService.Create(pMensagem: String);
begin
  raise Exception.Create(pMensagem);
end;

end.
