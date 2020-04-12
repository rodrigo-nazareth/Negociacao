unit CadastroPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CadastroBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids, Biblioteca, PesquisaPessoa, Vcl.Mask, System.UITypes;

type
  TFormCadastroPessoa = class(TFormCadastroBase)
    lbCodigo: TLabel;
    eCodigo: TEdit;
    mskEdtCpfCnpj: TMaskEdit;
    lblCpfCnpj: TLabel;
    eNomeRazaoSocial: TLabeledEdit;
    eNomeFantasia: TLabeledEdit;
    procedure eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mskEdtCpfCnpjKeyPress(Sender: TObject; var Key: Char);
  private
    tipo_pessoa: string;
    procedure ConfigurarCampoCpfCnpj(cpf_cnpj: string);
  public
    procedure SetarTipoPessoa(tp_pessoa: string);
  protected
    procedure VerificarDados; override;
    procedure ModoTela(editando: Boolean); override;
    function  Excluir: Boolean; override;
    function  Gravar: Boolean; override;
    procedure Pesquisar; override;
  end;

implementation

{$R *.dfm}

uses _Pessoa, Ambiente;

procedure TFormCadastroPessoa.ConfigurarCampoCpfCnpj(cpf_cnpj: string);
var
  tamanho: Integer;
begin
  tamanho := Length(cpf_cnpj);
  if tamanho <= 11 then begin
    mskEdtCpfCnpj.EditMask := '999.999.999-99;1;_';
    eNomeRazaoSocial.EditLabel.Caption := 'Nome';
  end
  else begin
    mskEdtCpfCnpj.EditMask := '99.999.999/9999-99;1;_';
    eNomeRazaoSocial.EditLabel.Caption := 'Razão Social';
  end;
end;

procedure TFormCadastroPessoa.eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
 pessoa: TArrayOfWebPessoa;
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

  pessoa := _Pessoa.BuscarPessoa(Ambiente.con_banco, 'where PESSOA_ID = ' + eCodigo.Text + ' and TIPO_PESSOA = ' + QuotedStr(tipo_pessoa));
  if pessoa = nil then begin
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

  ConfigurarCampoCpfCnpj(SomenteNumeros(pessoa[0].cpf_cnpj));
  mskEdtCpfCnpj.Text := pessoa[0].cpf_cnpj;

  eNomeRazaoSocial.Text := pessoa[0].razao_social;
  eNomeFantasia.Text := pessoa[0].nome_fantasia;

  pessoa := nil;
end;

function TFormCadastroPessoa.Excluir: Boolean;
var
  retorno: TRetornoComunicaoBanco;
begin
  retorno := _Pessoa.DeletarPessoa(Ambiente.con_banco, ValorInt(eCodigo));

  if not retorno.teve_erro then
    MensagemSucesso
  else begin
    MessageDlg(
      'Erro ao realizar a operação!' + #13 + retorno.mensagem_erro,
      mtError,
      [mbOK],
      0
    );
  end;

  Result := not retorno.teve_erro;
end;

function TFormCadastroPessoa.Gravar: Boolean;
var
  retorno: TRetornoComunicaoBanco;
begin
  retorno := _Pessoa.AtualizarPessoa(
    Ambiente.con_banco,
    ValorInt(eCodigo.Text),
    eNomeRazaoSocial.Text,
    eNomeFantasia.Text,
    mskEdtCpfCnpj.Text,
    tipo_pessoa
  );

  if not retorno.teve_erro then
    MensagemSucesso
  else
    MensagemErro(retorno.mensagem_erro);

  Result := not retorno.teve_erro;
end;

procedure TFormCadastroPessoa.ModoTela(editando: Boolean);
begin
  inherited;
  Habilitar([eCodigo], not editando, False);

	Habilitar(
    [
      eNomeRazaoSocial,
      eNomeFantasia,
      mskEdtCpfCnpj
    ],
    editando,
    True
  );

  if editando then
    mskEdtCpfCnpj.SetFocus
  else begin
    eCodigo.Clear;
    eCodigo.SetFocus;
  end;
end;

procedure TFormCadastroPessoa.mskEdtCpfCnpjKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if CharInSet(Key, ['0'..'9']) then
    ConfigurarCampoCpfCnpj(SomenteNumeros(mskEdtCpfCnpj.Text) + Key);
end;

procedure TFormCadastroPessoa.Pesquisar;
var
  codigo: Integer;
begin
  inherited;
  codigo := PesquisaPessoa.PesquisarPessoa(tipo_pessoa);

  if codigo > 0 then begin
    eCodigo.SetFocus;
    eCodigo.Text := IntToStr(codigo);
    Keybd_Event(13, 0, 0, 0);
  end;
end;

procedure TFormCadastroPessoa.SetarTipoPessoa(tp_pessoa: string);
begin
  tipo_pessoa := tp_pessoa;

  if tipo_pessoa = 'PRO' then
    Caption := 'Cadastro de Produtor'
  else
    Caption := 'Cadastro de Distribuidor';
end;

procedure TFormCadastroPessoa.VerificarDados;
begin
  inherited;
  ValidarCampo(
    (not (Length(SomenteNumeros(mskEdtCpfCnpj.Text)) in [11, 14])),
    'O CPF/CNPJ está incompleto!',
    mskEdtCpfCnpj
  );

  eNomeRazaoSocial.Text := Trim(eNomeRazaoSocial.Text);
  ValidarCampo(
    eNomeRazaoSocial.Text = '',
    'É necessário informar a Razão Social!',
    eNomeRazaoSocial
  );

  eNomeFantasia.Text := Trim(eNomeFantasia.Text);
  ValidarCampo(
    (Length(SomenteNumeros(mskEdtCpfCnpj.Text)) = 14) and (eNomeFantasia.Text = ''),
    'É necessário informar o Nome Fantasia!',
    eNomeFantasia
  );
end;

end.
