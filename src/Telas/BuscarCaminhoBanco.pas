unit BuscarCaminhoBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, _FormBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFormBuscarCaminhoBanco = class(TFormBase)
    eCaminho: TEdit;
    opArquivo: TOpenDialog;
    bBuscar: TButton;
    lbCaminho: TLabel;
    btOk: TBitBtn;
    procedure bBuscarClick(Sender: TObject);
  end;

var
  _cancelou: Boolean;

function BuscaCaminhoBanco: string;

implementation

{$R *.dfm}

function BuscaCaminhoBanco: string;
var
  form: TFormBuscarCaminhoBanco;
begin
  Result := '';
  form := TFormBuscarCaminhoBanco.Create(Application);
  _cancelou := False;

  if form.ShowModal = mrOk then
    Result := form.eCaminho.Text
  else
    _cancelou := True;

  form.Free;
end;

procedure TFormBuscarCaminhoBanco.bBuscarClick(Sender: TObject);
begin
  inherited;
  opArquivo.InitialDir := ExtractFilePath(Application.ExeName);

  if opArquivo.Execute then
    eCaminho.Text := opArquivo.FileName;
end;

end.
