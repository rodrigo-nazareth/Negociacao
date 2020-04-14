unit ManutencaoNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, _FormBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, FrameBasePesquisa, System.UITypes;

type
  TFormManutencaoNegociacao = class(TFormBase)
    lbCodigo: TLabel;
    eCodigo: TEdit;
    StaticText1: TStaticText;
    stStatus: TStaticText;
    frProdutor: TFramePesquisa;
    frDistribuidor: TFramePesquisa;
    GridPanel1: TGridPanel;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    StaticText7: TStaticText;
    stDataCadastro: TStaticText;
    stDataAprovacao: TStaticText;
    stDataConclusao: TStaticText;
    StaticText11: TStaticText;
    stDataCancelamento: TStaticText;
    StaticText6: TStaticText;
    stTotalNegociacao: TStaticText;
    btnAprovar: TBitBtn;
    btnConcluir: TBitBtn;
    btnCancelar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnCancelarEdicao: TBitBtn;
    procedure eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnAprovarClick(Sender: TObject);
    procedure btnConcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCancelarEdicaoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    status: string;

    procedure ModoTela(editando: Boolean);
    procedure DefinicaoStatus;
    procedure AlterarStatus(novo_status: string);
  end;

implementation

{$R *.dfm}

uses _Negociacao, Ambiente, Biblioteca, PesquisaNegociacao;

procedure TFormManutencaoNegociacao.AlterarStatus(novo_status: string);
var
  retorno: TRetornoComunicaoBanco;
begin
  retorno := _Negociacao.AlterarStatusNegociacao(Ambiente.con_banco, ValorInt(eCodigo.Text), novo_status);

  if retorno.teve_erro then
    Exclamar(retorno.mensagem_retorno)
  else begin
    status := novo_status;
    DefinicaoStatus;
    Exclamar(retorno.mensagem_retorno);
  end;
end;

procedure TFormManutencaoNegociacao.btnAprovarClick(Sender: TObject);
begin
  inherited;
  AlterarStatus('APR');
end;

procedure TFormManutencaoNegociacao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  AlterarStatus('CAN');
end;

procedure TFormManutencaoNegociacao.btnCancelarEdicaoClick(Sender: TObject);
begin
  inherited;
  status := '';
  ModoTela(False);
end;

procedure TFormManutencaoNegociacao.btnConcluirClick(Sender: TObject);
begin
  inherited;
  AlterarStatus('CON');
end;

procedure TFormManutencaoNegociacao.btnPesquisarClick(Sender: TObject);
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

procedure TFormManutencaoNegociacao.DefinicaoStatus;
begin
  if status = 'PEN' then begin
    stStatus.Caption := 'Pendente';
    btnAprovar.Enabled := True;
    btnConcluir.Enabled := False;
    btnCancelar.Enabled := True;
  end
  else if status = 'APR' then begin
    stStatus.Caption := 'Aprovada';
    btnAprovar.Enabled := False;
    btnConcluir.Enabled := True;
    btnCancelar.Enabled := True;
  end
  else if status = 'CON' then begin
    stStatus.Caption := 'Concluída';
    btnAprovar.Enabled := False;
    btnConcluir.Enabled := False;
    btnCancelar.Enabled := False;
  end
  else if status = 'CAN' then begin
    stStatus.Caption := 'Cancelada';
    btnAprovar.Enabled := False;
    btnConcluir.Enabled := False;
    btnCancelar.Enabled := False;
  end
  else
    stStatus.Caption := '-';

  CorStatus(stStatus);
end;

procedure TFormManutencaoNegociacao.eCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  negoc: TArrayOfWebNegociacao;
begin
  inherited;
  if Key <> VK_RETURN then
    Exit;

  if ValorInt(eCodigo) = 0 then begin
    MessageDlg(
      'É necessário informar um código valido!',
      mtWarning,
      [mbOK],
      0
    );
    eCodigo.SetFocus;
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

  ModoTela(True);

  frProdutor.InserirDireto(negoc[0].produtor_id);
  frDistribuidor.InserirDireto(negoc[0].distribuidor_id);

  if negoc[0].data_cadastro > 0 then
    stDataCadastro.Caption := FormatDateTime('dd/mm/yyyy', negoc[0].data_cadastro);

  if negoc[0].data_aprovacao > 0 then
    stDataAprovacao.Caption := FormatDateTime('dd/mm/yyyy', negoc[0].data_aprovacao);

  if negoc[0].data_conclusao > 0 then
    stDataConclusao.Caption := FormatDateTime('dd/mm/yyyy', negoc[0].data_conclusao);

  if negoc[0].data_cancelamento > 0 then
    stDataCancelamento.Caption := FormatDateTime('dd/mm/yyyy', negoc[0].data_cancelamento);

  stTotalNegociacao.Caption := FormatoMilharStr(negoc[0].total);

  status := negoc[0].status;
  DefinicaoStatus;

  negoc := nil;
end;

procedure TFormManutencaoNegociacao.FormCreate(Sender: TObject);
begin
  inherited;
  status := '';
  ActiveControl := eCodigo;

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
end;

procedure TFormManutencaoNegociacao.ModoTela(editando: Boolean);
  procedure LimparStatic;
  begin
    stStatus.Caption := '-';
    stTotalNegociacao.Caption := '-';
    stDataCadastro.Caption := '-';
    stDataAprovacao.Caption := '-';
    stDataConclusao.Caption := '-';
    stDataCancelamento.Caption := '-';
  end;
begin
  inherited;
  Habilitar([eCodigo, btnPesquisar], not editando, False);

	Habilitar(
    [
      frProdutor,
      frDistribuidor,
      btnAprovar,
      btnConcluir,
      btnCancelar
    ],
    editando,
    True
  );

  LimparStatic;

  if editando then begin
    frProdutor.SetFocus;
    btnCancelarEdicao.Enabled := True;
  end
  else begin
    eCodigo.Clear;
    eCodigo.SetFocus;
    btnCancelarEdicao.Enabled := False;
  end;

  DefinicaoStatus;
end;

end.
