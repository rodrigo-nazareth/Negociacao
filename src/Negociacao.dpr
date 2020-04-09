program Negociacao;

uses
  Forms,
  HOME in 'HOME.PAS' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
