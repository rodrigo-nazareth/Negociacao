unit CadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, _FormBase,
  Vcl.StdCtrls;

type
  TFormCadastroPadrao = class(TFormBase)
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnExcluir: TBitBtn;

    procedure TeclaEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  protected
    novo_registro: Boolean;
    procedure VerificarDados; virtual;
    procedure ModoTela(editando: Boolean); virtual;
    procedure Cancelar; virtual;
    function  Excluir: Boolean; virtual;
    function  Gravar: Boolean; virtual;
    procedure Pesquisar; virtual;
  public
    { Public declarations }
  end;

var
  FormCadastroPadrao: TFormCadastroPadrao;

implementation

{$R *.dfm}

procedure TFormCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox(
    'Deseja cancelar a edição?',
    'Questionamento',
    MB_YESNO + MB_ICONQUESTION
  ) = mrYes then
    Abort;

  Cancelar;
	ModoTela(False);
end;

procedure TFormCadastroPadrao.btnGravarClick(Sender: TObject);
begin
  inherited;
	VerificarDados;

	if Gravar then
    ModoTela(False);
end;

procedure TFormCadastroPadrao.btnPesquisarClick(Sender: TObject);
begin
  inherited;
	Pesquisar;
end;

procedure TFormCadastroPadrao.btnSairClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox(
    'Deseja realmente excluir?',
    'Questionamento',
    MB_YESNO + MB_ICONQUESTION
  ) = mrYes then
    Abort;

	if Excluir then
	 	ModoTela(False);
end;

procedure TFormCadastroPadrao.Cancelar;
begin
  //
end;

function TFormCadastroPadrao.Excluir: Boolean;
begin
  Result := True;
end;

procedure TFormCadastroPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormCadastroPadrao.FormCreate(Sender: TObject);
var
  i : integer;
begin
  inherited;

  for i := 0 to Self.ComponentCount - 1 do begin
    if self.Components[i] is TEdit then begin
      if TEdit(self.Components[i]).Name <> 'eCodigo' then
        Continue;

      ActiveControl := TEdit(self.Components[i]);
    end;
  end;
end;

function TFormCadastroPadrao.Gravar: Boolean;
begin
  Result := True;
end;

procedure TFormCadastroPadrao.Pesquisar;
begin
  //
end;

procedure TFormCadastroPadrao.VerificarDados;
begin
  //
end;

procedure TFormCadastroPadrao.ModoTela(editando: Boolean);
begin
  btnGravar.Enabled := editando;
  btnCancelar.Enabled := editando;
  btnExcluir.Enabled := editando and not novo_registro;
  btnPesquisar.Enabled := not editando;
end;

procedure TFormCadastroPadrao.TeclaEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    PerForm(40,0,0);
end;

end.
