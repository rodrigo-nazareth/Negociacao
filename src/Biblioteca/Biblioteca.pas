unit Biblioteca;

interface

uses System.SysUtils, Vcl.Forms;

var
  _tela_princial: TForm;

function AbrirForm(classe: TFormClass): TForm;

implementation

function AbrirForm(classe: TFormClass): TForm;
var
  i: Integer;
  form: TForm;
  existe_form: Boolean;
begin
  form := nil;

  existe_form := False;
  for i := 0 to _tela_princial.MDIChildCount - 1 do begin
    if _tela_princial.MDIChildren[i].ClassName <> classe.ClassName then
      Continue;

    form := _tela_princial.MDIChildren[i];
    existe_form := True;
    Break;
  end;

  if existe_form then begin
    form.WindowState := WsNormal;
    form.BringToFront;
    form.SetFocus;
  end
  else begin
    form := Classe.Create(Application);;
    form.Show;
  end;

  Result := form;
end;

end.
