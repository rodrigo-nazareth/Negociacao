program Negociacao;

uses
  Forms,
  Principal in 'Telas\Principal.pas' {FormPrincipal},
  _ConexaoBanco in 'Biblioteca\_ConexaoBanco.pas',
  Ambiente in 'Biblioteca\Ambiente.pas',
  Biblioteca in 'Biblioteca\Biblioteca.pas';

{$R *.RES}

begin
//  Ambiente.IniciarAplicacao;

  Application.Initialize;
  Application.MainFormOnTaskBar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
