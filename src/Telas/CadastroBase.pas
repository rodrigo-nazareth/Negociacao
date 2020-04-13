unit CadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, _FormBase,
  Vcl.StdCtrls;

type
  TFormCadastroBase = class(TFormBase)
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnExcluir: TBitBtn;
    stAtalhos: TStaticText;

    procedure TeclaEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private

  protected
    novo_registro: Boolean;
    procedure VerificarDados; virtual;
    procedure ModoTela(editando: Boolean); virtual;
    procedure Cancelar; virtual;
    function  Excluir: Boolean; virtual;
    function  Gravar: Boolean; virtual;
    procedure Pesquisar; virtual;
  end;

var
  FormCadastroBase: TFormCadastroBase;

implementation

{$R *.dfm}

procedure TFormCadastroBase.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox(
    'Deseja cancelar a edição?',
    'Questionamento',
    MB_YESNO + MB_ICONQUESTION
  ) = mrNo then
    Abort;

  Cancelar;
	ModoTela(False);
end;

procedure TFormCadastroBase.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox(
    'Deseja realmente excluir?',
    'Questionamento',
    MB_YESNO + MB_ICONQUESTION
  ) = mrNo then
    Abort;

	if Excluir then
	 	ModoTela(False);
end;

procedure TFormCadastroBase.btnGravarClick(Sender: TObject);
begin
  inherited;
	VerificarDados;

	if Gravar then
    ModoTela(False);
end;

procedure TFormCadastroBase.btnPesquisarClick(Sender: TObject);
begin
  inherited;
	Pesquisar;
end;

procedure TFormCadastroBase.Cancelar;
begin
  ModalResult := MrCancel;
end;

function TFormCadastroBase.Excluir: Boolean;
begin
  Result := True;
end;

procedure TFormCadastroBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormCadastroBase.FormCreate(Sender: TObject);
var
  i : Integer;
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

function TFormCadastroBase.Gravar: Boolean;
begin
  Result := True;
end;

procedure TFormCadastroBase.Pesquisar;
begin
  //
end;

procedure TFormCadastroBase.VerificarDados;
begin
  //
end;

procedure TFormCadastroBase.ModoTela(editando: Boolean);
begin
  btnGravar.Enabled := editando;
  btnCancelar.Enabled := editando;
  btnExcluir.Enabled := editando and not novo_registro;
  btnPesquisar.Enabled := not editando;
end;

procedure TFormCadastroBase.TeclaEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    PerForm(40,0,0);
end;

end.
