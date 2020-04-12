unit Principal;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, System.ImageList, System.Actions, Data.FMTBcd, Data.DB,
  Data.SqlExpr, ADODB2000, _ConexaoBanco, Data.DBXFirebird, Ambiente, System.UITypes;

type
  TFormPrincipal = class(TForm)
    StatusBar: TStatusBar;
    mmPrincipal: TMainMenu;
    miCadastros: TMenuItem;
    miProdutor: TMenuItem;
    miDistribuidor: TMenuItem;
    miProduto: TMenuItem;
    miSair: TMenuItem;
    miNegociacao: TMenuItem;
    Relatrio1: TMenuItem;
    miCadastroNegociacao: TMenuItem;
    miManutencaoNegociacao: TMenuItem;
    miRelacaoNegociacao: TMenuItem;
    miAjuda: TMenuItem;
    miTestarConexao: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miProdutorClick(Sender: TObject);
    procedure miDistribuidorClick(Sender: TObject);
    procedure miProdutoClick(Sender: TObject);
    procedure miCadastroNegociacaoClick(Sender: TObject);
    procedure miManutencaoNegociacaoClick(Sender: TObject);
    procedure miRelacaoNegociacaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miTestarConexaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  Biblioteca, CadastroProduto, CadastroNegociacao, ManutencaoNegociacao, RelacaoNegociacoes, CadastroPessoa;

{$R *.dfm}

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Ambiente.con_banco.Destroy;
end;

procedure TFormPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  for i := 0 to Screen.FormCount - 1 do begin
    if Screen.Forms[i].Name <> Self.Name then begin
      MessageDlg('Ainda existem telas abertas na aplicação!', mtWarning, [mbOK], 0);
      Screen.Forms[i].WindowState := wsNormal;
      Screen.Forms[i].BringToFront;
      Screen.Forms[i].SetFocus;
      Abort;
    end;
  end;

  if Application.MessageBox('Tem certeza que deseja encerrar a aplicação?', 'Questionamento', MB_YESNO + MB_ICONQUESTION) = mrYes then
    Application.Terminate
  else
    Abort;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  StatusBar.Panels[0].Text := FormatDateTime('dd/mm/yyyy',Now);
  Biblioteca._tela_princial := Self;
end;

procedure TFormPrincipal.miCadastroNegociacaoClick(Sender: TObject);
begin
  AbrirForm(TFormCadastroNegociacao);
end;

procedure TFormPrincipal.miDistribuidorClick(Sender: TObject);
var
  form: TForm;
begin
  form := AbrirForm(TFormCadastroPessoa);
  TFormCadastroPessoa(form).SetarTipoPessoa('DIS');
end;

procedure TFormPrincipal.miManutencaoNegociacaoClick(Sender: TObject);
begin
  AbrirForm(TFormManutencaoNegociacao);
end;

procedure TFormPrincipal.miProdutoClick(Sender: TObject);
begin
  AbrirForm(TFormCadastroProduto);
end;

procedure TFormPrincipal.miProdutorClick(Sender: TObject);
var
  form: TForm;
begin
  form := AbrirForm(TFormCadastroPessoa);
  TFormCadastroPessoa(form).SetarTipoPessoa('PRO');
end;

procedure TFormPrincipal.miSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPrincipal.miTestarConexaoClick(Sender: TObject);
begin
  if Ambiente.con_banco.Conectado then
    MessageDlg('Conectado!', mtInformation, [mbOK], 0)
  else
    MessageDlg('Desconectado!', mtInformation, [mbOK], 0)
end;

procedure TFormPrincipal.miRelacaoNegociacaoClick(Sender: TObject);
begin
  AbrirForm(TFormRelacaoNegociacoes);
end;

end.
