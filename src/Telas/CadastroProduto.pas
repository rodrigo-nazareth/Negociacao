unit CadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CadastroBase, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Biblioteca, _Produto, Ambiente, System.UITypes;

type
  TFormCadastroProduto = class(TFormCadastroBase)
    lbCodigo: TLabel;
    eCodigo: TEdit;
    eNome: TLabeledEdit;
    ePreco: TLabeledEdit;
    procedure eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ePrecoExit(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ModoTela(editando: Boolean); override;
    procedure VerificarDados; override;
    function  Excluir: Boolean; override;
    function  Gravar: Boolean; override;
    procedure Pesquisar; override;
  end;

implementation

uses
  PesquisaProduto, PesquisaPessoa;

{$R *.dfm}

procedure TFormCadastroProduto.eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
 produto : TArrayOfWebProduto;
begin
  inherited;
  if Key <> VK_RETURN then
    Exit;

  novo_registro := ValorInt(eCodigo) = 0;
  if novo_registro then begin
    eCodigo.Text := '';
    ModoTela(True);
    Exit;
  end;

  produto := _Produto.BuscarProdutos(Ambiente.con_banco, 'where PRODUTO_ID = ' + eCodigo.Text);
  if produto = nil then begin
    MessageDlg(
      'Não foi possível encontrar os dados!',
      mtWarning,
      [mbOK],
      0
    );
    Exit;
  end;

  novo_registro := False;
  ModoTela(True);

  eNome.Text := produto[0].nome;
  ePreco.Text := FormatoMilharStr(produto[0].preco);

  ePrecoExit(nil);

  produto := nil;
end;

procedure TFormCadastroProduto.ePrecoExit(Sender: TObject);
begin
  inherited;
  ePreco.Text := FormatoMilharStr(Valor(ePreco.Text));
end;

function TFormCadastroProduto.Excluir: Boolean;
var
  retorno: TRetornoComunicaoBanco;
begin
  retorno := _Produto.DeletarProduto(Ambiente.con_banco, ValorInt(eCodigo));

  if not retorno.teve_erro then
    MensagemSucesso
  else begin
    MessageDlg(
      'Erro ao realizar a operação!' + #13 + retorno.mensagem_retorno,
      mtError,
      [mbOK],
      0
    );
  end;

  Result := not retorno.teve_erro;
end;

function TFormCadastroProduto.Gravar: Boolean;
var
  retorno: TRetornoComunicaoBanco;
begin
  retorno := _Produto.AtualizarProduto(
    Ambiente.con_banco,
    ValorInt(eCodigo.Text),
    eNome.Text,
    Valor(ePreco.Text)
  );

  if not retorno.teve_erro then
    Exclamar(retorno.mensagem_retorno)
  else
    MensagemErro(retorno.mensagem_retorno);

  Result := not retorno.teve_erro;
end;

procedure TFormCadastroProduto.ModoTela(editando: Boolean);
begin
  inherited;
  Habilitar([eCodigo], not editando, False);

	Habilitar(
    [
      eNome,
      ePreco
    ],
    editando,
    True
  );

  if editando then
    eNome.SetFocus
  else begin
    eCodigo.Clear;
    eCodigo.SetFocus;
  end;
end;

procedure TFormCadastroProduto.Pesquisar;
var
  codigo: Integer;
begin
  inherited;
  codigo := PesquisaProduto.PesquisarProduto;

  if codigo > 0 then begin
    eCodigo.SetFocus;
    eCodigo.Text := IntToStr(codigo);
    Keybd_Event(13, 0, 0, 0);
  end;
end;

procedure TFormCadastroProduto.VerificarDados;
begin
  inherited;
  eNome.Text := Trim(eNome.Text);
  ValidarCampo(
    eNome.Text = '',
    'É necessário informar Nome!',
    eNome
  );

  ValidarCampo(
    Valor(ePreco) = 0,
    'É necessário o preço!',
    ePreco
  );

  ValidarCampo(
    Valor(ePreco) < 0,
    'Preço inválido!',
    ePreco
  );
end;

end.
