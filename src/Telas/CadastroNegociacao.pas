unit CadastroNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CadastroBase, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, FrameBasePesquisa, Vcl.Grids, Biblioteca, _Negociacao, System.UITypes;

type
  TAuxGrid = class(TStringGrid);

  TFormCadastroNegociacao = class(TFormCadastroBase)
    frProdutor: TFramePesquisa;
    frDistribuidor: TFramePesquisa;
    StaticText1: TStaticText;
    stStatus: TStaticText;
    gpLimites: TGridPanel;
    stTitLimite: TStaticText;
    stTitLimiteUtilizado: TStaticText;
    stTitLimiteDisponivel: TStaticText;
    stLimite: TStaticText;
    stLimiteUtilizado: TStaticText;
    stLimiteDisponivel: TStaticText;
    StaticText3: TStaticText;
    sgItens: TStringGrid;
    frProduto: TFramePesquisa;
    Label1: TLabel;
    ePreco: TEdit;
    eQuantidade: TEdit;
    Label2: TLabel;
    eTotal: TEdit;
    Label3: TLabel;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    stTotalNegociacao: TStaticText;
    GridPanel1: TGridPanel;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    StaticText7: TStaticText;
    stDataCadastro: TStaticText;
    stDataAprovacao: TStaticText;
    stDataConclusao: TStaticText;
    StaticText11: TStaticText;
    stDataCancelamento: TStaticText;
    StaticText8: TStaticText;
    lbCodigo: TLabel;
    eCodigo: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure eTotalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eQuantidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eQuantidadeChange(Sender: TObject);
    procedure sgItensDblClick(Sender: TObject);
    procedure frProdutobtnPesquisarClick(Sender: TObject);
    procedure sgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frProdutorbtnPesquisarClick(Sender: TObject);
    procedure frDistribuidorbtnPesquisarClick(Sender: TObject);
    procedure eQuantidadeEnter(Sender: TObject);
    procedure eQuantidadeClick(Sender: TObject);
  private
    status: string;

    procedure InserirItem(
      produto_id: Integer;
      nome: string;
      preco: Double;
      quantidade: Double;
      total_produto: Double
    );

    procedure TotalizarNegociacao;
    procedure BuscarLimites;
    procedure DefinicaoStatus;
  public
    procedure ModoTela(editando: Boolean); override;
    procedure VerificarDados; override;
    function  Excluir: Boolean; override;
    function  Gravar: Boolean; override;
    procedure Pesquisar; override;
    procedure Cancelar; override;
  end;

implementation

uses
  PesquisaNegociacao, Ambiente, _ItemNegociacao, _Produto, _LimiteCreditoProdutor;

const
  cProduto_Id  = 0;
  cNome        = 1;
  cPreco       = 2;
  cQuantidade  = 3;
  cTotal       = 4;

{$R *.dfm}

procedure TFormCadastroNegociacao.BuscarLimites;
var
  limites: WebLimiteCreditoProdutor;
begin
  limites := _LimiteCreditoProdutor.BuscarLimiteCreditoTelaNegociacao(Ambiente.con_banco, frProdutor.GetCodigo, frDistribuidor.GetCodigo);
  stLimite.Caption := FormatoMilharStr(limites.limite_credito);
  stLimiteUtilizado.Caption := FormatoMilharStr(limites.limite_credito_utilizado);
  stLimiteDisponivel.Caption := FormatoMilharStr(limites.limite_credito_disponivel);
end;

procedure TFormCadastroNegociacao.Cancelar;
begin
  inherited;
  status := '';
end;

procedure TFormCadastroNegociacao.DefinicaoStatus;
begin
  if status = 'PEN' then
    stStatus.Caption := 'Pendente'
  else if status = 'APR' then
    stStatus.Caption := 'Aprovada'
  else if status = 'CON' then
    stStatus.Caption := 'Concluída'
  else if status = 'CAN' then
    stStatus.Caption := 'Cancelada'
  else
    stStatus.Caption := '-';

  CorStatus(stStatus);
end;

procedure TFormCadastroNegociacao.eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
  negoc: TArrayOfWebNegociacao;
  itens: TArrayOfWebItemNegociacao;
begin
  inherited;
  if Key <> VK_RETURN then
    Exit;

  novo_registro := ValorInt(eCodigo) = 0;
  if novo_registro then begin
    status := 'PEN';
    eCodigo.Text := '';
    ModoTela(True);
    Exit;
  end;

  negoc := _Negociacao.BuscarNegociacoes(Ambiente.con_banco, 'where NEGOCIACAO_ID = ' + eCodigo.Text);
  if negoc = nil then begin
    MessageDlg(
      'Não foi possível encontrar os dados!',
      mtWarning,
      [mbOK],
      0
    );
    Exit;
  end;

  status := negoc[0].status;

  novo_registro := False;
  ModoTela(True);

  frProdutor.InserirDireto(negoc[0].produtor_id);
  frDistribuidor.InserirDireto(negoc[0].distribuidor_id);

  stLimite.Caption := FormatoMilharStr(negoc[0].limite_credito);
  stLimiteUtilizado.Caption := FormatoMilharStr(negoc[0].limite_credito_utilizado);
  stLimiteDisponivel.Caption := FormatoMilharStr(negoc[0].limite_credito_disponivel);

  if negoc[0].data_cadastro > 0 then
    stDataCadastro.Caption := FormatDateTime('dd/mm/yyyy', negoc[0].data_cadastro);

  if negoc[0].data_aprovacao > 0 then
    stDataAprovacao.Caption := FormatDateTime('dd/mm/yyyy', negoc[0].data_aprovacao);

  if negoc[0].data_conclusao > 0 then
    stDataConclusao.Caption := FormatDateTime('dd/mm/yyyy', negoc[0].data_conclusao);

  if negoc[0].data_cancelamento > 0 then
    stDataCancelamento.Caption := FormatDateTime('dd/mm/yyyy', negoc[0].data_cancelamento);

  DefinicaoStatus;

  itens := _ItemNegociacao.BuscarItensNegociacoes(Ambiente.con_banco, 'where ITE.NEGOCIACAO_ID = ' + eCodigo.Text);
  for i := Low(itens) to High(itens) do begin
    InserirItem(
      itens[i].produto_id,
      itens[i].nome,
      itens[i].preco,
      itens[i].quantidade,
      itens[i].total
    );
  end;

  TotalizarNegociacao;

  negoc := nil;
end;

procedure TFormCadastroNegociacao.eQuantidadeChange(Sender: TObject);
begin
  inherited;
  eTotal.Text := FormatoMilharStr(Valor(ePreco.Text) * Valor(eQuantidade.Text));
end;

procedure TFormCadastroNegociacao.eQuantidadeClick(Sender: TObject);
begin
  inherited;
  eQuantidade.SelectAll;
end;

procedure TFormCadastroNegociacao.eQuantidadeEnter(Sender: TObject);
begin
  inherited;
  eQuantidade.SelectAll;
end;

procedure TFormCadastroNegociacao.eQuantidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  eTotal.Text := Valor(ePreco.Text) * Valor(eQuantidade.Text);
end;

procedure TFormCadastroNegociacao.eTotalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then begin
    if frProduto.EstaVazio then begin
      MessageDlg(
        'É necessário informar o produto!',
        mtWarning,
        [mbOK],
        0
      );

      frProduto.sgConsulta.SetFocus;
      Abort;
    end;

    if Valor(eQuantidade.Text) = 0 then begin
      MessageDlg(
        'É necessário informar a quantidade!',
        mtWarning,
        [mbOK],
        0
      );

      eQuantidade.SetFocus;
      Abort;
    end;

    InserirItem(
      frProduto.GetCodigo,
      frProduto.GetNome,
      Valor(ePreco.Text),
      Valor(eQuantidade.Text),
      Valor(eTotal.Text)
    );

    frProduto.Clear;
    frProduto.Clear;
    ePreco.Clear;
    eQuantidade.Clear;
    eTotal.Clear;

    TotalizarNegociacao;
    frProduto.sgConsulta.SetFocus;
  end;
end;

function TFormCadastroNegociacao.Excluir: Boolean;
var
  retorno: TRetornoComunicaoBanco;
begin
  ValidarCampo(
    status <> 'PEN',
    'Somente é possível excluir negociação pendente',
    stStatus
  );

  retorno := _Negociacao.DeletarNegociacao(Ambiente.con_banco, ValorInt(eCodigo));

  if not retorno.teve_erro then begin
    status := '';
    MensagemSucesso;
  end
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

procedure TFormCadastroNegociacao.FormCreate(Sender: TObject);
begin
  inherited;
  status := '';
  DefinicaoStatus;

  IniciarGrid(
    sgItens,
    [
      'Produto',
      'Nome',
      'Preço',
      'Quantidade',
      'Total'
    ]
  );

  frProdutor.SetarBaseFrame(
    'select ' +
    '  PESSOA_ID as CODIGO, ' +
    '  RAZAO_SOCIAL as NOME ' +
    'from ' +
    '  PESSOAS ',
    'where TIPO_PESSOA = ''PRO'' and RAZAO_SOCIAL',
    'PESSOA_ID'
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

  frProduto.SetarBaseFrame(
    'select ' +
    '  PRODUTO_ID as CODIGO, ' +
    '  NOME ' +
    'from ' +
    '  PRODUTOS ',
    'where NOME',
    'PRODUTO_ID'
  );
end;

procedure TFormCadastroNegociacao.frDistribuidorbtnPesquisarClick(
  Sender: TObject);
begin
  inherited;
  frDistribuidor.btnPesquisarClick(Sender);

  if not frProdutor.EstaVazio then
    BuscarLimites;
end;

procedure TFormCadastroNegociacao.frProdutobtnPesquisarClick(Sender: TObject);
var
  preco: Double;
begin
  inherited;
  frProduto.btnPesquisarClick(Sender);
  preco := _Produto.BuscarPrecoProduto(Ambiente.con_banco, frProduto.GetCodigo);
  ePreco.Text := FormatoMilharStr(preco);
end;

procedure TFormCadastroNegociacao.frProdutorbtnPesquisarClick(Sender: TObject);
begin
  inherited;
  frProdutor.btnPesquisarClick(Sender);
  if not frDistribuidor.EstaVazio then
    BuscarLimites;
end;

function TFormCadastroNegociacao.Gravar: Boolean;
var
  i: Integer;
  posic: Integer;
  retorno: TRetornoComunicaoBanco;
  itens: TArrayOfWebItemNegociacao;
begin
  itens := nil;
  for i := sgItens.FixedRows to sgItens.RowCount - 1 do begin
    SetLength(itens, Length(itens) + 1);

    posic := High(itens);
    itens[posic].negociacao_id := ValorInt(eCodigo.Text);
    itens[posic].produto_id := ValorInt(sgItens.Cells[cProduto_Id, i]);
    itens[posic].quantidade := Valor(sgItens.Cells[cQuantidade, i]);
    itens[posic].preco := Valor(sgItens.Cells[cPreco, i]);
    itens[posic].total := Valor(sgItens.Cells[cTotal, i]);
  end;

  retorno := _Negociacao.AtualizarNegociacao(
    Ambiente.con_banco,
    ValorInt(eCodigo.Text),
    frProdutor.GetCodigo,
    frDistribuidor.GetCodigo,
    Valor(stTotalNegociacao),
    itens
  );

  if not retorno.teve_erro then begin
    status := '';
    Exclamar(retorno.mensagem_retorno);
  end
  else
    MensagemErro(retorno.mensagem_retorno);

  Result := not retorno.teve_erro;
end;

procedure TFormCadastroNegociacao.InserirItem(
  produto_id: Integer;
  nome: string;
  preco: Double;
  quantidade: Double;
  total_produto: Double
);
var
  i: Integer;
  linha: Integer;
begin
  linha := -1;

  for i := sgItens.FixedRows to sgItens.RowCount - 1 do begin
    if ValorInt(sgItens.Cells[cProduto_Id, i]) <> produto_id then
      Continue;

    if not Questionar('O item já foi adicionado! Deseja Sobrescrever?') then begin
      sgItens.Row := i;
      Abort;
    end
    else begin
      linha := i;
      Break;
    end;
  end;

  if linha = -1 then begin
    if sgItens.Cells[cProduto_Id, sgItens.FixedRows] <> '' then
      sgItens.RowCount := sgItens.RowCount + 1;

    linha := sgItens.RowCount - 1;
  end;

  sgItens.Cells[cProduto_Id, linha] := FormatoMilharStr(produto_id, 0);
  sgItens.Cells[cNome, linha] := nome;
  sgItens.Cells[cPreco, linha] := FormatoMilharStr(preco);
  sgItens.Cells[cQuantidade, linha] := FormatoMilharStr(quantidade);
  sgItens.Cells[cTotal, linha] := FormatoMilharStr(total_produto);
end;

procedure TFormCadastroNegociacao.ModoTela(editando: Boolean);
  procedure LimparStatic;
  begin
    stStatus.Caption := '-';
    stLimite.Caption := '-';
    stLimiteUtilizado.Caption := '-';
    stLimiteDisponivel.Caption := '-';
    stTotalNegociacao.Caption := '-';
    stDataCadastro.Caption := '-';
    stDataAprovacao.Caption := '-';
    stDataConclusao.Caption := '-';
    stDataCancelamento.Caption := '-';
  end;
begin
  inherited;
  Habilitar([eCodigo], not editando, False);

	Habilitar(
    [
      frProdutor,
      frDistribuidor,
      frProduto,
      ePreco,
      eQuantidade,
      eTotal,
      sgItens
    ],
    editando,
    True
  );

  if editando then begin
    frProdutor.SetFocus;
    frProdutor.SomenteLeitura(status <> 'PEN');
    frDistribuidor.SomenteLeitura(status <> 'PEN');
    frProduto.SomenteLeitura(status <> 'PEN');

    if status <> 'PEN' then begin
      ePreco.Enabled := False;
      eQuantidade.Enabled := False;
      eTotal.Enabled := False;
      sgItens.Enabled := False;
      btnExcluir.Enabled := False;
      btnGravar.Enabled := False;
    end;
  end
  else begin
    eCodigo.Clear;
    eCodigo.SetFocus;
    LimparStatic;
  end;

  if novo_registro then
    LimparStatic;

  DefinicaoStatus;
end;

procedure TFormCadastroNegociacao.Pesquisar;
var
  codigo: Integer;
begin
  inherited;
  codigo := PesquisaNegociacao.PesquisarNegociacao;

  if codigo > 0 then begin
    eCodigo.SetFocus;
    eCodigo.Text := IntToStr(codigo);
    Keybd_Event(13, 0, 0, 0);
  end;
end;

procedure TFormCadastroNegociacao.sgItensDblClick(Sender: TObject);
begin
  inherited;
  if Trim(sgItens.Cells[cProduto_Id, sgItens.Row]) = '' then
    Exit;

  frProduto.sgConsulta.Cells[0, 0] := sgItens.Cells[cProduto_Id, sgItens.Row];
  frProduto.sgConsulta.Cells[1, 0] := sgItens.Cells[cNome, sgItens.Row];
  ePreco.Text := sgItens.Cells[cPreco, sgItens.Row];
  eQuantidade.Text := sgItens.Cells[cQuantidade, sgItens.Row];
  eTotal. Text := sgItens.Cells[cTotal, sgItens.Row];

  frProduto.sgConsulta.SetFocus;
end;

procedure TFormCadastroNegociacao.sgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vkDelete then begin
    if sgItens.FixedRows = sgItens.RowCount - 1 then
      LimparGrid(sgItens)
    else
      TAuxGrid(sgItens).DeleteRow(sgItens.Row);

    sgItens.Refresh;
  end;
end;

procedure TFormCadastroNegociacao.TotalizarNegociacao;
var
  i: Integer;
  total: Double;
begin
  total := 0;
  for i := sgItens.FixedRows to sgItens.RowCount - 1 do
    total := total + Valor(sgItens.Cells[cTotal, i]);

  if total > 0 then
    stTotalNegociacao.Caption := FormatoMilharStr(total)
  else
    stTotalNegociacao.Caption := '-';
end;

procedure TFormCadastroNegociacao.VerificarDados;
begin
  inherited;
  ValidarCampo(
    Trim(sgItens.Cells[sgItens.FixedRows, 0]) = '',
    'É necessário informar ao menos um produto!',
    sgItens
  );

  ValidarCampo(
    frProdutor.EstaVazio,
    'É necessário informar o produtor!',
    frProdutor.sgConsulta
  );

  ValidarCampo(
    frDistribuidor.EstaVazio,
    'É necessário informar o distribuidor!',
    frDistribuidor.sgConsulta
  );

  ValidarCampo(
    Valor(stTotalNegociacao) > Valor(stLimiteDisponivel),
    'O valor desta negociação supera o limite disponível!' + #13 +
    'Limite disponível: ' + stLimiteDisponivel.Caption + #13 +
    'Valor negociação: ' + stTotalNegociacao.Caption,
    sgItens
  );
end;

end.
