unit _Negociacao;

interface

uses
  _ConexaoBanco, Biblioteca, System.SysUtils, _ItemNegociacao, Data.SqlExpr;

Type
  WebNegociacao = record
    negociacao_id: Integer;
    produtor_id: Integer;
    distribuidor_id: Integer;
    status_sintetico: string;
    status_analitico: string;
    total: Double;
    data_cadastro: TDateTime;
    data_aprovacao: TDateTime;
    data_conclusao: TDateTime;
    data_cancelamento: TDateTime;
    limite_credito: Double;
    limite_credito_utilizado: Double;
    limite_credito_disponivel: Double;
    nome_produtor: string;
    nome_distribuidor: string;
  end;
  TArrayOfWebNegociacao = array of WebNegociacao;

  TDadosNegociacaoPesq = record
    negociacao_id: Integer;
    nome_produtor: string;
    nome_distribuidor: string;
    status: string;
  end;
  TArrayOfTDadosNegociacaoPesq = array of TDadosNegociacaoPesq;

  TNegociacao = class(TTabela)
  private
    function  GetNegociacao_Id: Integer;
    procedure SetNegociacao_Id(x: Integer);
    function  GetPRODUTOR_ID: Integer;
    procedure SetPRODUTOR_ID(x: Integer);
    function  GetDISTRIBUIDOR_ID: Integer;
    procedure SetDISTRIBUIDOR_ID(x: Integer);
    function  GetTOTAL: Double;
    procedure SetTOTAL(x: Double);
  public
    constructor Create(c: TConexaoBanco);
  published
    property NEGOCIACAO_ID: Integer read GetNegociacao_Id write SetNegociacao_Id;
    property PRODUTOR_ID: Integer read GetPRODUTOR_ID write SetPRODUTOR_ID;
    property DISTRIBUIDOR_ID: Integer read GetDISTRIBUIDOR_ID write SetDISTRIBUIDOR_ID;
    property TOTAL: Double read GetTOTAL write SetTOTAL;
  end;


function AtualizarNegociacao(
  con: TConexaoBanco;
  negociacao_id: Integer;
  produtor_id: Integer;
  distribuidor_id: Integer;
  total: Double;
  itens: TArrayOfWebItemNegociacao
): TRetornoComunicaoBanco;

function DeletarNegociacao(con: TConexaoBanco; negociacao_id: Integer): TRetornoComunicaoBanco;
function BuscarNegociacoes(con: TConexaoBanco; filtros: string): TArrayOfWebNegociacao;
function BuscaNegociacaoTelaPesquisa(con: TConexaoBanco; filtro: string): TArrayOfTDadosNegociacaoPesq;
function AlterarStatusNegociacao(con: TConexaoBanco; negociacao_id: Integer; novo_status: string): TRetornoComunicaoBanco;
function BuscarNegociacoesRelatorio(con: TConexaoBanco; sql_texto: string): TArrayOfWebNegociacao;

implementation

{ TNegociacao }

constructor TNegociacao.Create(c: TConexaoBanco);
begin
  inherited Create(c, 'NEGOCIACOES');
end;

function TNegociacao.GetDISTRIBUIDOR_ID: Integer;
begin
  Result := GetValorColuna('DISTRIBUIDOR_ID');
end;

function TNegociacao.GetNegociacao_Id: Integer;
begin
  Result := GetValorColuna('NEGOCIACAO_ID');
end;

function TNegociacao.GetPRODUTOR_ID: Integer;
begin
  Result := GetValorColuna('PRODUTOR_ID');
end;

function TNegociacao.GetTOTAL: Double;
begin
  Result := GetValorColuna('TOTAL');
end;

procedure TNegociacao.SetDISTRIBUIDOR_ID(x: Integer);
begin
  AddColuna('DISTRIBUIDOR_ID', x, tpCampo);
end;

procedure TNegociacao.SetNegociacao_Id(x: Integer);
begin
  AddColuna('NEGOCIACAO_ID', x, tpChave);
end;

procedure TNegociacao.SetPRODUTOR_ID(x: Integer);
begin
  AddColuna('PRODUTOR_ID', x, tpChave);
end;

procedure TNegociacao.SetTOTAL(x: Double);
begin
  AddColuna('TOTAL', x, tpCampo);
end;

function DeletarNegociacao(con: TConexaoBanco; negociacao_id: Integer): TRetornoComunicaoBanco;
var
  negoc: TNegociacao;
begin
  Result.teve_erro := False;
  negoc := TNegociacao.Create(con);

  try
    con.AbrirTransacao;

    negoc.NEGOCIACAO_ID := negociacao_id;
    negoc.Deletar;

    con.FecharTransacao;
  except on E: Exception do
    begin
      Result.teve_erro := True;
      Result.mensagem_retorno := e.message;
      con.VoltarTransacao;
    end
  end;

  FreeAndNil(negoc);
end;

function BuscaNegociacaoTelaPesquisa(con: TConexaoBanco; filtro: string): TArrayOfTDadosNegociacaoPesq;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  NEG.NEGOCIACAO_ID,');
  pesq.SQL.Add('  PRD.RAZAO_SOCIAL as NOME_PRODUTOR,');
  pesq.SQL.Add('  DIS.RAZAO_SOCIAL as NOME_DISTRIBUIDOR,');
  pesq.SQL.Add('  NEG.STATUS');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  NEGOCIACOES NEG');

  pesq.SQL.Add('inner join PESSOAS PRD');
  pesq.SQL.Add('on NEG.PRODUTOR_ID = PRD.PESSOA_ID');

  pesq.SQL.Add('inner join PESSOAS DIS');
  pesq.SQL.Add('on NEG.DISTRIBUIDOR_ID = DIS.PESSOA_ID');

  pesq.SQL.Add(filtro);
  pesq.SQL.Add('order by');
  pesq.SQL.Add('  NEG.NEGOCIACAO_ID');

  if pesq.Pesquisar then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].negociacao_id := pesq.AsColunaInt('NEGOCIACAO_ID');
      Result[i].nome_produtor := pesq.AsColunaString('NOME_PRODUTOR');
      Result[i].nome_distribuidor := pesq.AsColunaString('NOME_DISTRIBUIDOR');

      if pesq.AsColunaString('STATUS') = 'PEN' then
        Result[i].status := 'Pendente'
      else if pesq.AsColunaString('STATUS') = 'APR' then
        Result[i].status := 'Aprovada'
      else if pesq.AsColunaString('STATUS') = 'CON' then
        Result[i].status := 'Concluída'
      else if pesq.AsColunaString('STATUS') = 'CAN' then
        Result[i].status := 'Cancelada'
      else
        Result[i].status := '-';

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

function BuscarNegociacoes(con: TConexaoBanco; filtros: string): TArrayOfWebNegociacao;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  NEG.NEGOCIACAO_ID,');
  pesq.SQL.Add('  NEG.PRODUTOR_ID,');
  pesq.SQL.Add('  NEG.DISTRIBUIDOR_ID,');
  pesq.SQL.Add('  NEG.STATUS,');
  pesq.SQL.Add('  NEG.TOTAL,');
  pesq.SQL.Add('  NEG.DATA_CADASTRO,');
  pesq.SQL.Add('  NEG.DATA_APROVACAO,');
  pesq.SQL.Add('  NEG.DATA_CONCLUSAO,');
  pesq.SQL.Add('  NEG.DATA_CANCELAMENTO,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO_UTILIZADO,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO_DISPONIVEL');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  NEGOCIACOES NEG');

  pesq.SQL.Add('inner join LIMITES_CREDITO_PRODUTOR LIM');
  pesq.SQL.Add('on NEG.PRODUTOR_ID = LIM.PRODUTOR_ID');
  pesq.SQL.Add('and NEG.DISTRIBUIDOR_ID = LIM.DISTRIBUIDOR_ID');

  pesq.SQL.Add(filtros);

  if pesq.Pesquisar then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].negociacao_id := pesq.AsColunaInt('NEGOCIACAO_ID');
      Result[i].produtor_id := pesq.AsColunaInt('PRODUTOR_ID');
      Result[i].distribuidor_id := pesq.AsColunaInt('DISTRIBUIDOR_ID');
      Result[i].status_sintetico := pesq.AsColunaString('STATUS');
      Result[i].total := pesq.AsColunaDouble('TOTAL');
      Result[i].data_cadastro := pesq.AsColunaDateTime('DATA_CADASTRO');
      Result[i].data_aprovacao := pesq.AsColunaDateTime('DATA_APROVACAO');
      Result[i].data_conclusao := pesq.AsColunaDateTime('DATA_CONCLUSAO');
      Result[i].data_cancelamento := pesq.AsColunaDateTime('DATA_CANCELAMENTO');
      Result[i].limite_credito := pesq.AsColunaDouble('LIMITE_CREDITO');
      Result[i].limite_credito_utilizado := pesq.AsColunaDouble('LIMITE_CREDITO_UTILIZADO');
      Result[i].limite_credito_disponivel := pesq.AsColunaDouble('LIMITE_CREDITO_DISPONIVEL');

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

function AtualizarNegociacao(
  con: TConexaoBanco;
  negociacao_id: Integer;
  produtor_id: Integer;
  distribuidor_id: Integer;
  total: Double;
  itens: TArrayOfWebItemNegociacao
): TRetornoComunicaoBanco;
var
  i: Integer;
  novo_registro: Boolean;
  pesq: TPesquisa;
  negoc: TNegociacao;
  ite: TItemNegociacao;
  exec: TExecucao;
begin
  Result.teve_erro := False;
  negoc := TNegociacao.Create(con);
  ite := TItemNegociacao.Create(con);
  exec := TExecucao.Create(con);
  pesq := con.NovaPesquisa;

  try
    con.AbrirTransacao;

    novo_registro := negociacao_id = 0;
    if novo_registro then begin
      pesq.SQL.Add('select gen_id(gen_negociacoes_id,1) as CODIGO from rdb$database');
      pesq.Pesquisar;
      negociacao_id := pesq.AsColunaInt('CODIGO');
    end;

    negoc.NEGOCIACAO_ID := negociacao_id;
    negoc.PRODUTOR_ID := produtor_id;
    negoc.DISTRIBUIDOR_ID := distribuidor_id;
    negoc.TOTAL := total;

    if novo_registro then
      negoc.Inserir
    else
      negoc.Alterar;

    exec.SetSql('delete from ITENS_NEGOCIACAO where NEGOCIACAO_ID = :P1');
    exec.Executar([negociacao_id]);

    for i := Low(itens) to High(itens) do begin
      ite.NovoRegistro;
      ite.NEGOCIACAO_ID := negociacao_id;
      ite.PRODUTO_ID := itens[i].produto_id;
      ite.QUANTIDADE := itens[i].quantidade;
      ite.PRECO := itens[i].preco;
      ite.TOTAL := itens[i].total;

      ite.Inserir;
    end;

    Result.mensagem_retorno := 'Operação realizada com sucesso!';
    if novo_registro then
      Result.mensagem_retorno := Result.mensagem_retorno + #13 + 'Novo código: ' + FormatoMilharStr(negociacao_id, 0);

    con.FecharTransacao;
  except on E: Exception do
    begin
      Result.teve_erro := True;
      Result.mensagem_retorno := e.message;
      con.VoltarTransacao;
    end;
  end;

  FreeAndNil(negoc);
  FreeAndNil(ite);
  FreeAndNil(exec);
  pesq.Active := False;
  pesq.Free;
end;

function AlterarStatusNegociacao(con: TConexaoBanco; negociacao_id: Integer; novo_status: string): TRetornoComunicaoBanco;
var
  exec: TExecucao;
begin
  Result.teve_erro := False;
  exec := TExecucao.Create(con);

  try
    con.AbrirTransacao;

    exec.SetSql('update NEGOCIACOES set STATUS = :P2 where NEGOCIACAO_ID = :P1');
    exec.Executar([negociacao_id, novo_status]);

    Result.mensagem_retorno := 'Operação realizada com sucesso!';
    con.FecharTransacao;
  except on E: Exception do
    begin
      Result.teve_erro := True;
      Result.mensagem_retorno := e.message;
      con.VoltarTransacao;
    end
  end;

  FreeAndNil(exec);
end;

function BuscarNegociacoesRelatorio(con: TConexaoBanco; sql_texto: string): TArrayOfWebNegociacao;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add(sql_texto);
  if pesq.Pesquisar then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].negociacao_id := pesq.AsColunaInt('NEGOCIACAO_ID');
      Result[i].total := pesq.AsColunaDouble('TOTAL');
      Result[i].data_cadastro := pesq.AsColunaDateTime('DATA_CADASTRO');
      Result[i].data_aprovacao := pesq.AsColunaDateTime('DATA_APROVACAO');
      Result[i].data_conclusao := pesq.AsColunaDateTime('DATA_CONCLUSAO');
      Result[i].data_cancelamento := pesq.AsColunaDateTime('DATA_CANCELAMENTO');
      Result[i].nome_produtor := pesq.AsColunaString('NOME_PRODUTOR');
      Result[i].nome_distribuidor := pesq.AsColunaString('NOME_DISTRIBUIDOR');
      Result[i].status_analitico := pesq.AsColunaString('STATUS_ANALITICO');

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

end.
