unit RelacaoNegociacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, _FormBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids, FrameBasePesquisa, frxClass, frxPreview,
  Data.FMTBcd, Data.DB, Data.SqlExpr, Datasnap.DBClient, Data.DBXFirebird,
  frxDBSet, Vcl.DBGrids;

type
  TFormRelacaoNegociacoes = class(TFormBase)
    pcRelacaoNegociacao: TPageControl;
    tsFiltros: TTabSheet;
    tsResultado: TTabSheet;
    sgResultado: TStringGrid;
    stAtalhos: TStaticText;
    frProdutor: TFramePesquisa;
    frDistribuidor: TFramePesquisa;
    cbFiltros: TComboBox;
    Label1: TLabel;
    sbImprimir: TSpeedButton;
    btnProcessar: TBitBtn;
    frxRelatorio: TfrxReport;
    scConexao: TSQLConnection;
    query: TSQLDataSet;
    frxDataSetRelatorio: TfrxDBDataset;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure sbImprimirClick(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  Biblioteca, _Negociacao, Ambiente, MensagemProcessamento, _ConexaoBanco;

const
  cNegociacao         = 0;
  cStatus             = 1;
  cProdutor           = 2;
  cDistribuidor       = 3;
  cTotal_Negociacao   = 4;
  cData_Cadastro      = 5;
  cData_Aprovacao     = 6;
  cData_Conclusao     = 7;
  cData_Cancelamento  = 8;
  // oculta
  cTipo_Linha         = 9; // D-Detalhe; E-Espaco; T-Total

{$R *.dfm}

procedure TFormRelacaoNegociacoes.btnProcessarClick(Sender: TObject);
var
  i: Integer;
  linha: Integer;
  filtros: string;
  total_negociacoes: Double;
  negociacoes: TArrayOfWebNegociacao;
  form_msg: TFormProcessamento;
begin
  inherited;
  LimparGrid(sgResultado);
  pcRelacaoNegociacao.ActivePage := tsFiltros;

  ValidarCampo(
    frProdutor.EstaVazio and frDistribuidor.EstaVazio,
    'É necessário informar ao menos um filtros (produtor ou distribuidor)!',
    frProdutor.sgConsulta
  );

  if cbFiltros.ItemIndex <> 4 then begin
    filtros := filtros + ' and NEG.STATUS = ';
    if cbFiltros.ItemIndex = 0 then
      filtros := filtros + QuotedStr('PEN')
    else if cbFiltros.ItemIndex = 1 then
      filtros := filtros + QuotedStr('APR')
    else if cbFiltros.ItemIndex = 3 then
      filtros := filtros + QuotedStr('CON')
    else if cbFiltros.ItemIndex = 4 then
      filtros := filtros + QuotedStr('CAN');
  end;

  if not frProdutor.EstaVazio then
    filtros := filtros + ' and NEG.PRODUTOR_ID = ' + IntToStr(frProdutor.GetCodigo);

  if not frDistribuidor.EstaVazio then
    filtros := filtros + ' and NEG.DISTRIBUIDOR_ID = ' + IntToStr(frDistribuidor.GetCodigo);


  form_msg := TFormProcessamento.Create(Application);
  form_msg.Show;
  form_msg.Update;
  try
    negociacoes := _Negociacao.BuscarNegociacoesRelatorio(Ambiente.con_banco, filtros);
    if negociacoes = nil then
      Exclamar('Nenhum dado encontrado!')
    else begin
      linha := sgResultado.FixedRows;
      total_negociacoes := 0;
      for i := Low(negociacoes) to High(negociacoes) do begin
        sgResultado.Cells[cNegociacao, linha] := FormatoMilharStr(negociacoes[i].negociacao_id, 0);

        if negociacoes[i].status = 'PEN' then
          sgResultado.Cells[cStatus, linha] := 'Pendente'
        else if negociacoes[i].status = 'APR' then
          sgResultado.Cells[cStatus, linha] := 'Aprovada'
        else if negociacoes[i].status = 'CON' then
          sgResultado.Cells[cStatus, linha] := 'Concluída'
        else if negociacoes[i].status = 'CAN' then
          sgResultado.Cells[cStatus, linha] := 'Cancelada'
        else
          sgResultado.Cells[cStatus, linha] := '-';

        sgResultado.Cells[cProdutor, linha] := negociacoes[i].nome_produtor;
        sgResultado.Cells[cDistribuidor, linha] := negociacoes[i].nome_distribuidor;
        sgResultado.Cells[cTotal_Negociacao, linha] := FormatoMilharStr(negociacoes[i].total);

        if negociacoes[i].data_cadastro > 0 then
          sgResultado.Cells[cData_Cadastro, linha] := FormatDateTime('dd/mm/yyyy', negociacoes[i].data_cadastro);

        if negociacoes[i].data_aprovacao > 0 then
          sgResultado.Cells[cData_Aprovacao, linha] := FormatDateTime('dd/mm/yyyy', negociacoes[i].data_aprovacao);

        if negociacoes[i].data_conclusao > 0 then
          sgResultado.Cells[cData_Conclusao, linha] := FormatDateTime('dd/mm/yyyy', negociacoes[i].data_conclusao);

        if negociacoes[i].data_cancelamento > 0 then
          sgResultado.Cells[cData_Cancelamento, linha] := FormatDateTime('dd/mm/yyyy', negociacoes[i].data_cancelamento);

        sgResultado.Cells[cTipo_Linha, linha] := 'D';

        total_negociacoes := total_negociacoes + negociacoes[i].total;

        form_msg.Update;
        Inc(linha);
      end;

      sgResultado.Cells[cTipo_Linha, linha] := 'E';
      Inc(linha);

      sgResultado.Cells[cTipo_Linha, linha] := 'T';
      sgResultado.Cells[cProdutor, linha] := 'Total geral';
      sgResultado.Cells[cTipo_Linha, linha] := FormatoMilharStr(total_negociacoes);

      pcRelacaoNegociacao.ActivePage := tsResultado;
      sgResultado.SetFocus;
    end;
  finally
    form_msg.Free;
  end;
end;

procedure TFormRelacaoNegociacoes.FormCreate(Sender: TObject);
begin
  inherited;
  pcRelacaoNegociacao.ActivePage := tsFiltros;

  IniciarGrid(
    sgResultado,
    [
      'Negociação',
      'Status',
      'Produtor',
      'Distribuidor',
      'Total negociação',
      'Dt. cadastro',
      'Dt. aprovação',
      'Dt. conclusão',
      'Dt. cancelamento'
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
end;

procedure TFormRelacaoNegociacoes.sbImprimirClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  query.FieldDefs.Clear;
  query

  for i := sgResultado.FixedRows to sgResultado.RowCount - 1 do begin
    query.FieldDefs.Add('NEGOCIACAO_ID', ftString, 12, False);
    query.FieldDefs.Add('STATUS', ftString, 3, False);
    query.FieldDefs.Add('TOTAL', ftString, 12, False);
    query.FieldDefs.Add('DATA_CADASTRO', ftString, 10, False);
    query.FieldDefs.Add('DATA_APROVACAO', ftString, 10, False);
    query.FieldDefs.Add('DATA_CONCLUSAO', ftString, 10, False);
    query.FieldDefs.Add('DATA_CANCELAMENTO', ftString, 10, False);
    query.FieldDefs.Add('NOME_PRODUTOR', ftString, 150, False);
    query.FieldDefs.Add('NOME_DISTRIBUIDOR', ftString, 150, False);

    query.FieldByName('NEGOCIACAO_ID').AsString := sgResultado.Cells[cNegociacao, i];
    query.FieldByName('STATUS').AsString := sgResultado.Cells[cStatus, i];
    query.FieldByName('TOTAL').AsString := sgResultado.Cells[cTotal_Negociacao, i];
    query.FieldByName('DATA_CADASTRO').AsString := sgResultado.Cells[cData_Cadastro, i];
    query.FieldByName('DATA_APROVACAO').AsString := sgResultado.Cells[cData_Aprovacao, i];
    query.FieldByName('DATA_CONCLUSAO').AsString := sgResultado.Cells[cData_Conclusao, i];
    query.FieldByName('DATA_CANCELAMENTO').AsString := sgResultado.Cells[cData_Cancelamento, i];
    query.FieldByName('NOME_PRODUTOR').AsString := sgResultado.Cells[cProdutor, i];
    query.FieldByName('NOME_DISTRIBUIDOR').AsString := sgResultado.Cells[cDistribuidor, i];
  end;


  frxDataSetRelatorio.DataSet := query;
  frxRelatorio.LoadFromFile(ExtractFilePath(Application.ExeName) + 'RelatorioNegociacoes.fr3');
  frxRelatorio.PrepareReport(True);
  frxRelatorio.ShowReport;
end;

end.
