unit RelacaoNegociacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, _FormBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids, FrameBasePesquisa, frxClass, frxPreview,
  Data.FMTBcd, Data.DB, Data.SqlExpr, Datasnap.DBClient, Data.DBXFirebird,
  frxDBSet, Vcl.DBGrids, frxExportPDF;

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
    query: TSQLDataSet;
    frxDataSetRelatorio: TfrxDBDataset;
    queryNEGOCIACAO_ID: TIntegerField;
    infTOTAL: TFMTBCDField;
    infDATA_CADASTRO: TDateField;
    infDATA_APROVACAO: TDateField;
    infDATA_CONCLUSAO: TDateField;
    infDATA_CANCELAMENTO: TDateField;
    infNOME_PRODUTOR: TStringField;
    infNOME_DISTRIBUIDOR: TStringField;
    stfSTATUS_ANALITICO: TStringField;
    frxPDFExport1: TfrxPDFExport;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure sbImprimirClick(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure frProdutorsgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frDistribuidorsgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    filtro_sql: string;
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
  total_negociacoes: Double;
  negociacoes: TArrayOfWebNegociacao;
  form_msg: TFormProcessamento;
begin
  inherited;
  LimparGrid(sgResultado);
  pcRelacaoNegociacao.ActivePage := tsFiltros;
  filtro_sql := '';

  if cbFiltros.ItemIndex <> 4 then begin
    filtro_sql := filtro_sql + ' and NEG.STATUS = ';
    if cbFiltros.ItemIndex = 0 then
      filtro_sql := filtro_sql + QuotedStr('PEN')
    else if cbFiltros.ItemIndex = 1 then
      filtro_sql := filtro_sql + QuotedStr('APR')
    else if cbFiltros.ItemIndex = 3 then
      filtro_sql := filtro_sql + QuotedStr('CON')
    else if cbFiltros.ItemIndex = 4 then
      filtro_sql := filtro_sql + QuotedStr('CAN');
  end;

  if not frProdutor.EstaVazio then
    filtro_sql := filtro_sql + ' and NEG.PRODUTOR_ID = ' + IntToStr(frProdutor.GetCodigo);

  if not frDistribuidor.EstaVazio then
    filtro_sql := filtro_sql + ' and NEG.DISTRIBUIDOR_ID = ' + IntToStr(frDistribuidor.GetCodigo);

  form_msg := TFormProcessamento.Create(Application);
  form_msg.Show;
  form_msg.Update;
  try
    negociacoes := _Negociacao.BuscarNegociacoesRelatorio(Ambiente.con_banco, filtro_sql);
    if negociacoes = nil then
      Exclamar('Nenhum dado encontrado!')
    else begin
      linha := sgResultado.FixedRows;
      total_negociacoes := 0;
      for i := Low(negociacoes) to High(negociacoes) do begin
        sgResultado.Cells[cNegociacao, linha] := FormatoMilharStr(negociacoes[i].negociacao_id, 0);
        sgResultado.Cells[cStatus, linha] := negociacoes[i].status_analitico;
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
      sgResultado.Cells[cProdutor, linha] := 'Total negociações';
      sgResultado.Cells[cTotal_Negociacao, linha] := FormatoMilharStr(total_negociacoes);

      Inc(linha);

      if linha > sgResultado.RowCount then
        sgResultado.RowCount := linha;

      pcRelacaoNegociacao.ActivePage := tsResultado;
      sgResultado.SetFocus;
    end;
  finally
    FreeAndNil(form_msg);
  end;
end;

procedure TFormRelacaoNegociacoes.FormCreate(Sender: TObject);
begin
  inherited;
  pcRelacaoNegociacao.ActivePage := tsFiltros;
  filtro_sql := '';

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

procedure TFormRelacaoNegociacoes.frDistribuidorsgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    frDistribuidor.Clear;
end;

procedure TFormRelacaoNegociacoes.frProdutorsgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    frProdutor.Clear;
end;

procedure TFormRelacaoNegociacoes.sbImprimirClick(Sender: TObject);
begin
  inherited;
  if sgResultado.Cells[cNegociacao, sgResultado.FixedRows] = '' then begin
    Exclamar('Não há dados para impressão!');
    Abort;
  end;

  if not FileExists(ExtractFilePath(Application.ExeName) + 'RelatorioNegociacoes.fr3') then begin
    Exclamar(
      'Não foi possível encontrar o arquivo de configuração do relatório!' + #13 +
      'Arquivo: ' + ExtractFilePath(Application.ExeName) + 'RelatorioNegociacoes.fr3'
    );
    Abort;
  end;

  query.Active := False;
  query.Close;
  query.SQLConnection := Ambiente.con_banco.GetConexao;
  query.CommandText :=
    'select ' +
    '  NEG.NEGOCIACAO_ID, ' +
    '  case ' +
    '    NEG.STATUS ' +
    '    when ''PEN'' then ''Pendente'' ' +
    '    when ''APR'' then ''Aprovada'' ' +
    '    when ''CON'' then ''Concluída'' ' +
    '    when ''CAN'' then ''Cancelada'' ' +
    '    else ''-'' ' +
    '  end as STATUS_ANALITICO, ' +
    '  PRO.RAZAO_SOCIAL as NOME_PRODUTOR, ' +
    '  DIS.RAZAO_SOCIAL as NOME_DISTRIBUIDOR, ' +
    '  NEG.TOTAL, ' +
    '  NEG.DATA_CADASTRO, ' +
    '  NEG.DATA_APROVACAO, ' +
    '  NEG.DATA_CONCLUSAO, ' +
    '  NEG.DATA_CANCELAMENTO ' +
    'from ' +
    '  NEGOCIACOES NEG ' +

    'inner join PESSOAS PRO ' +
    'on NEG.PRODUTOR_ID = PRO.PESSOA_ID ' +

    'inner join PESSOAS DIS ' +
    'on NEG.DISTRIBUIDOR_ID = DIS.PESSOA_ID ' +

    'where 1=1 ' +
    filtro_sql;

  query.Open;

  frxDataSetRelatorio.DataSet := nil;

  frxDataSetRelatorio.DataSet := query;
  frxRelatorio.LoadFromFile(ExtractFilePath(Application.ExeName) + 'RelatorioNegociacoes.fr3');
  frxRelatorio.PrepareReport(True);
  frxRelatorio.ShowReport;

  query.Active := False;
end;

end.
