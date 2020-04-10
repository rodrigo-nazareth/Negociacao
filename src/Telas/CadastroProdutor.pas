unit CadastroProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CadastroPadrao, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids, Biblioteca, PesquisaPessoa;

type
  TFormCadastroProdutor = class(TFormCadastroPadrao)
    lbCodigo: TLabel;
    eCodigo: TEdit;
    lbRazaoSocial: TLabel;
    eRazaoSocial: TEdit;
    lbNomeFantasia: TLabel;
    eNomeFantasia: TEdit;
    lbCpfCnpj: TLabel;
    eCpfCnpj: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure VerificarDados; override;
    procedure ModoTela(editando: Boolean); override;
    function Excluir: Boolean; override;
    function Gravar: Boolean; override;
    procedure Pesquisar; override;
  end;

implementation

{$R *.dfm}

function TFormCadastroProdutor.Excluir: Boolean;
begin
//
end;

procedure TFormCadastroProdutor.FormCreate(Sender: TObject);
begin
  inherited;
//  Self.ActiveControl := eCodigo;
end;

function TFormCadastroProdutor.Gravar: Boolean;
begin
//
end;

procedure TFormCadastroProdutor.ModoTela(editando: Boolean);
begin
  inherited;
//
end;

procedure TFormCadastroProdutor.Pesquisar;
var
  codigo: Integer;
begin
  inherited;
  codigo := PesquisaPessoa.PesquisarPessoa('PRO');
end;

procedure TFormCadastroProdutor.VerificarDados;
begin
  inherited;
//
end;

end.
