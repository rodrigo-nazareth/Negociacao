unit CadastroPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CadastroBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids, Biblioteca, PesquisaPessoa, Vcl.Mask, System.UITypes,
  FrameBasePesquisa, Vcl.ComCtrls;

type
  TAuxGrid = class(TStringGrid);

  TFormCadastroPessoa = class(TFormCadastroBase)
    pcPessoa: TPageControl;
    tsDadosPrincipais: TTabSheet;
    tsLimitesCredito: TTabSheet;
    sgLimites: TStringGrid;
    Panel1: TPanel;
    frDistribuidor: TFramePesquisa;
    Label3: TLabel;
    eLimite: TEdit;
    StaticText1: TStaticText;
    StaticText5: TStaticText;
    lbCodigo: TLabel;
    lblCpfCnpj: TLabel;
    eCodigo: TEdit;
    mskEdtCpfCnpj: TMaskEdit;
    eNomeFantasia: TLabeledEdit;
    eNomeRazaoSocial: TLabeledEdit;
    Panel2: TPanel;
    StaticText6: TStaticText;
    stTotalLimite: TStaticText;
    procedure eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mskEdtCpfCnpjKeyPress(Sender: TObject; var Key: Char);
    procedure sgLimitesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgLimitesDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eLimiteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eLimiteEnter(Sender: TObject);
    procedure eLimiteClick(Sender: TObject);  private
    procedure ConfigurarCampoCpfCnpj(cpf_cnpj: string);
  private
    tipo_pessoa: string;
    procedure InserirItem(
      distribuidor_id: Integer;
      nome: string;
      limite: Double
    );

    procedure TotalizarLimite;
  public
    procedure SetarTipoPessoa(tp_pessoa: string);
    function  GetTipoPessoa: string;
  protected
    procedure VerificarDados; override;
    procedure ModoTela(editando: Boolean); override;
    function  Excluir: Boolean; override;
    function  Gravar: Boolean; override;
    procedure Pesquisar; override;
  end;

implementation

uses _Pessoa, Ambiente, _LimiteCreditoProdutor;

const
  cDistribuidor_Id = 0;
  cNome            = 1;
  cLimite          = 2;

{$R *.dfm}

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
  i: Integer;
  pessoa: TArrayOfWebPessoa;
  limites: TArrayOfWebLimiteCreditoProdutor;
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

  pessoa := _Pessoa.BuscarPessoas(Ambiente.con_banco, 'where PESSOA_ID = ' + eCodigo.Text + ' and TIPO_PESSOA = ' + QuotedStr(tipo_pessoa));
  if pessoa = nil then begin
    Application.MessageBox(
      'Não foi possível encontrar os dados!',
      'Erro',
      MB_OK + MB_ICONWARNING
    );
    Exit;
  end;

  novo_registro := False;
  ModoTela(True);

  ConfigurarCampoCpfCnpj(SomenteNumeros(pessoa[0].cpf_cnpj));
  mskEdtCpfCnpj.Text := pessoa[0].cpf_cnpj;

  eNomeRazaoSocial.Text := pessoa[0].razao_social;
  eNomeFantasia.Text := pessoa[0].nome_fantasia;

  limites := _LimiteCreditoProdutor.BuscarLimitesProdutor(Ambiente.con_banco, ValorInt(eCodigo.Text));
  for i := Low(limites) to High(limites) do begin
    InserirItem(
      limites[i].distribuidor_id,
      limites[i].nome_distribuidor,
      limites[i].limite_credito
    );
  end;

  TotalizarLimite;
  pessoa := nil;
end;

procedure TFormCadastroPessoa.eLimiteClick(Sender: TObject);
begin
  inherited;
  eLimite.SelectAll;
end;

procedure TFormCadastroPessoa.eLimiteEnter(Sender: TObject);
begin
  inherited;
  eLimite.SelectAll;
end;

procedure TFormCadastroPessoa.eLimiteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then begin
    if frDistribuidor.EstaVazio then begin
      MessageDlg(
        'É necessário informar o distribuidor!',
        mtWarning,
        [mbOK],
        0
      );

      frDistribuidor.sgConsulta.SetFocus;
      Abort;
    end;

    if Valor(eLimite.Text) = 0 then begin
      MessageDlg(
        'É necessário informar o limite!',
        mtWarning,
        [mbOK],
        0
      );

      eLimite.SetFocus;
      Abort;
    end;

    InserirItem(
      frDistribuidor.GetCodigo,
      frDistribuidor.GetNome,
      Valor(eLimite.Text)
    );

    frDistribuidor.Clear;
    eLimite.Clear;

    TotalizarLimite;
    frDistribuidor.sgConsulta.SetFocus;
  end;
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
      'Erro ao realizar a operação!' + #13 + retorno.mensagem_retorno,
      mtError,
      [mbOK],
      0
    );
  end;

  Result := not retorno.teve_erro;
end;

procedure TFormCadastroPessoa.FormCreate(Sender: TObject);
begin
  pcPessoa.ActivePage := tsDadosPrincipais;

  inherited;
  IniciarGrid(
    sgLimites,
    [
      'Codigo',
      'Distribuidor',
      'Limite'
    ]
  );

  frDistribuidor.SetarBaseFrame(
    'select ' +
    '  PESSOA_ID as CODIGO, ' +
    '  RAZAO_SOCIAL as NOME ' +
    'from ' +
    '  PESSOAS ',
    'where TIPO_PESSOA = ''DIS'' and RAZAO_SOCIAL',
    'PESSOA_ID'
  );
end;

function TFormCadastroPessoa.GetTipoPessoa: string;
begin
  Result := tipo_pessoa;
end;

function TFormCadastroPessoa.Gravar: Boolean;
var
  i: Integer;
  posic: Integer;
  retorno: TRetornoComunicaoBanco;
  limites: TArrayOfWebLimiteCreditoProdutor;
begin
  limites := nil;
  if Trim(sgLimites.Cells[cDistribuidor_Id, sgLimites.FixedRows]) <> '' then begin
    for i := sgLimites.FixedRows to sgLimites.RowCount - 1 do begin
      SetLength(limites, Length(limites) + 1);

      posic := High(limites);
      limites[posic].produtor_id := ValorInt(eCodigo.Text);
      limites[posic].distribuidor_id := ValorInt(sgLimites.Cells[cDistribuidor_Id, i]);
      limites[posic].limite_credito := Valor(sgLimites.Cells[cLimite, i]);
    end;
  end;

  retorno := _Pessoa.AtualizarPessoa(
    Ambiente.con_banco,
    ValorInt(eCodigo.Text),
    eNomeRazaoSocial.Text,
    eNomeFantasia.Text,
    mskEdtCpfCnpj.Text,
    tipo_pessoa,
    limites
  );

  if not retorno.teve_erro then
    Exclamar(retorno.mensagem_retorno)
  else
    MensagemErro(retorno.mensagem_retorno);

  Result := not retorno.teve_erro;
end;

procedure TFormCadastroPessoa.InserirItem(
  distribuidor_id: Integer;
  nome: string;
  limite: Double
);
var
  i: Integer;
  linha: Integer;
begin
  linha := -1;

  for i := sgLimites.FixedRows to sgLimites.RowCount - 1 do begin
    if ValorInt(sgLimites.Cells[cDistribuidor_Id, i]) <> distribuidor_id then
      Continue;

    if not Questionar('O limite deste distribuidor já foi inserido! Deseja Sobrescrever?') then begin
      sgLimites.Row := i;
      Abort;
    end
    else begin
      linha := i;
      Break;
    end;
  end;

  if linha = -1 then begin
    if sgLimites.Cells[cDistribuidor_Id, sgLimites.FixedRows] <> '' then
      sgLimites.RowCount := sgLimites.RowCount + 1;

    linha := sgLimites.RowCount - 1;
  end;

  sgLimites.Cells[cDistribuidor_Id, linha] := FormatoMilharStr(distribuidor_id, 0);
  sgLimites.Cells[cNome, linha] := nome;
  sgLimites.Cells[cLimite, linha] := FormatoMilharStr(limite);
end;

procedure TFormCadastroPessoa.ModoTela(editando: Boolean);
begin
  inherited;
  Habilitar([eCodigo], not editando, False);

	Habilitar(
    [
      eNomeRazaoSocial,
      eNomeFantasia,
      mskEdtCpfCnpj,
      frDistribuidor,
      eLimite,
      sgLimites
    ],
    editando,
    True
  );

  if editando then
    mskEdtCpfCnpj.SetFocus
  else begin
    pcPessoa.ActivePage := tsDadosPrincipais;
    eCodigo.Clear;
    eCodigo.SetFocus;
  end;

  TotalizarLimite;
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
    pcPessoa.ActivePage := tsDadosPrincipais;
    eCodigo.SetFocus;
    eCodigo.Text := IntToStr(codigo);
    Keybd_Event(13, 0, 0, 0);
  end;
end;

procedure TFormCadastroPessoa.SetarTipoPessoa(tp_pessoa: string);
begin
  tipo_pessoa := tp_pessoa;

  if tipo_pessoa = 'PRO' then begin
    Caption := 'Cadastro de Produtor';
    tsLimitesCredito.TabVisible := True;
  end
  else begin
    Caption := 'Cadastro de Distribuidor';
    tsLimitesCredito.TabVisible := False;
  end;
end;

procedure TFormCadastroPessoa.sgLimitesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vkDelete then begin
    if sgLimites.FixedRows = sgLimites.RowCount - 1 then
      LimparGrid(sgLimites)
    else
      TAuxGrid(sgLimites).DeleteRow(sgLimites.Row);

    sgLimites.Refresh;
  end;
end;

procedure TFormCadastroPessoa.TotalizarLimite;
var
  i: Integer;
  total: Double;
begin
  total := 0;
  for i := sgLimites.FixedRows to sgLimites.RowCount - 1 do
    total := total + Valor(sgLimites.Cells[cLimite, i]);

  if total > 0 then
    stTotalLimite.Caption := FormatoMilharStr(total)
  else
    stTotalLimite.Caption := '-';
end;

procedure TFormCadastroPessoa.VerificarDados;
begin
  inherited;
  pcPessoa.ActivePage := tsDadosPrincipais;

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

procedure TFormCadastroPessoa.sgLimitesDblClick(Sender: TObject);
begin
  inherited;
  if Trim(sgLimites.Cells[cDistribuidor_Id, sgLimites.Row]) = '' then
    Exit;

  frDistribuidor.sgConsulta.Cells[0, 0] := sgLimites.Cells[cDistribuidor_Id, sgLimites.Row];
  frDistribuidor.sgConsulta.Cells[1, 0] := sgLimites.Cells[cNome, sgLimites.Row];
  eLimite.Text := sgLimites.Cells[cLimite, sgLimites.Row];

  frDistribuidor.sgConsulta.SetFocus;
end;

end.
