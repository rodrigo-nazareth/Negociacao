unit Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, TelaBase;

type
  TFormCadastro = class(TFormBase)
    pnBotoes: TPanel;
    sbPesquisar: TSpeedButton;
    sbGravar: TSpeedButton;
    sbExcluir: TSpeedButton;
    sbCancelar: TSpeedButton;

    procedure TeclaEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbGravarClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure sbPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  FormCadastro: TFormCadastro;

implementation

{$R *.dfm}

procedure TFormCadastro.Cancelar;
begin
  //
end;

function TFormCadastro.Excluir: Boolean;
begin
  Result := True;
end;

procedure TFormCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFormCadastro.Gravar: Boolean;
begin
  Result := True;
end;

procedure TFormCadastro.Pesquisar;
begin
  //
end;

procedure TFormCadastro.sbCancelarClick(Sender: TObject);
begin
  if Application.MessageBox(
    'Deseja cancelar a edição?',
    'Questionamento',
    MB_YESNO + MB_ICONQUESTION
  ) = mrYes then
    Abort;

  Cancelar;
	ModoTela(False);
end;

procedure TFormCadastro.sbExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(
    'Deseja realmente excluir?',
    'Questionamento',
    MB_YESNO + MB_ICONQUESTION
  ) = mrYes then
    Abort;

	if Excluir then
	 	ModoTela(False);
end;

procedure TFormCadastro.sbGravarClick(Sender: TObject);
begin
	VerificarDados;

	if Gravar then
    ModoTela(False);
end;

procedure TFormCadastro.sbPesquisarClick(Sender: TObject);
begin
	Pesquisar;
end;

procedure TFormCadastro.VerificarDados;
begin
  //
end;

procedure TFormCadastro.ModoTela(editando: Boolean);
begin
  sbGravar.Enabled := editando;
  sbCancelar.Enabled := editando;
  sbExcluir.Enabled := editando and not novo_registro;
  sbPesquisar.Enabled := not editando;
end;

procedure TFormCadastro.TeclaEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    PerForm(40,0,0);
end;

end.
