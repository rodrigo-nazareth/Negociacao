unit _LimiteCreditoProdutor;

interface

uses
  _ConexaoBanco, Biblioteca, System.SysUtils;

type
  WebLimiteCreditoProdutor = record
    produtor_id: Integer;
    distribuidor_id: Integer;
    limite_credito: Double;
    limite_credito_utilizado: Double;
    limite_credito_disponivel: Double;
    nome_distribuidor: string;
  end;
  TArrayOfWebLimiteCreditoProdutor = array of WebLimiteCreditoProdutor;

  TLimiteCreditoProdutor = class(TTabela)
  private
    function  GetPRODUTOR_ID: Integer;
    procedure SetPRODUTOR_ID(const Value: Integer);
    function  GetDISTRIBUIDOR_ID: Integer;
    procedure SetDISTRIBUIDOR_ID(const Value: Integer);
    function  GetLIMITE_CREDITO: Double;
    procedure SetLIMITE_CREDITO(const Value: Double);
  public
    constructor Create(c: TConexaoBanco);
  published
    property PRODUTOR_ID: Integer read GetPRODUTOR_ID write SetPRODUTOR_ID;
    property DISTRIBUIDOR_ID: Integer read GetDISTRIBUIDOR_ID write SetDISTRIBUIDOR_ID;
    property LIMITE_CREDITO: Double read GetLIMITE_CREDITO write SetLIMITE_CREDITO;
  end;

function BuscarLimitesProdutor(con: TConexaoBanco; produtor_id: Integer): TArrayOfWebLimiteCreditoProdutor;
function BuscarLimiteCreditoTelaNegociacao(con: TConexaoBanco; produtor_id: Integer; distribuidor_id: Integer): WebLimiteCreditoProdutor;

implementation

function BuscarLimitesProdutor(con: TConexaoBanco; produtor_id: Integer): TArrayOfWebLimiteCreditoProdutor;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  LIM.PRODUTOR_ID,');
  pesq.SQL.Add('  LIM.DISTRIBUIDOR_ID,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO_UTILIZADO,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO_DISPONIVEL,');
  pesq.SQL.Add('  DIS.RAZAO_SOCIAL');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  LIMITES_CREDITO_PRODUTOR LIM');

  pesq.SQL.Add('inner join PESSOAS DIS');
  pesq.SQL.Add('on LIM.DISTRIBUIDOR_ID = DIS.PESSOA_ID');

  pesq.SQL.Add('where PRODUTOR_ID = :P1');

  pesq.SQL.Add('order by');
  pesq.SQL.Add('  LIM.DISTRIBUIDOR_ID');

  if pesq.Pesquisar([produtor_id]) then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].produtor_id := pesq.AsColunaInt('PRODUTOR_ID');
      Result[i].distribuidor_id := pesq.AsColunaInt('DISTRIBUIDOR_ID');
      Result[i].limite_credito := pesq.AsColunaDouble('LIMITE_CREDITO');
      Result[i].limite_credito_utilizado := pesq.AsColunaDouble('LIMITE_CREDITO_UTILIZADO');
      Result[i].limite_credito_disponivel := pesq.AsColunaDouble('LIMITE_CREDITO_DISPONIVEL');
      Result[i].nome_distribuidor := pesq.AsColunaString('RAZAO_SOCIAL');

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

{ TLimiteCreditoProdutor }

constructor TLimiteCreditoProdutor.Create(c: TConexaoBanco);
begin
  inherited Create(c, 'LIMITES_CREDITO_PRODUTOR');
end;

function TLimiteCreditoProdutor.GetDISTRIBUIDOR_ID: Integer;
begin
  Result := GetValorColuna('DISTRIBUIDOR_ID');
end;

function TLimiteCreditoProdutor.GetLIMITE_CREDITO: Double;
begin
  Result := GetValorColuna('LIMITE_CREDITO');
end;

function TLimiteCreditoProdutor.GetPRODUTOR_ID: Integer;
begin
  Result := GetValorColuna('PRODUTOR_ID');
end;

procedure TLimiteCreditoProdutor.SetDISTRIBUIDOR_ID(const Value: Integer);
begin
  AddColuna('DISTRIBUIDOR_ID', Value, tpChave);
end;

procedure TLimiteCreditoProdutor.SetLIMITE_CREDITO(const Value: Double);
begin
  AddColuna('LIMITE_CREDITO', Value, tpCampo);
end;

procedure TLimiteCreditoProdutor.SetPRODUTOR_ID(const Value: Integer);
begin
  AddColuna('PRODUTOR_ID', Value, tpChave);
end;

function BuscarLimiteCreditoTelaNegociacao(con: TConexaoBanco; produtor_id: Integer; distribuidor_id: Integer): WebLimiteCreditoProdutor;
var
  pesq: TPesquisa;
begin
  Result := default(WebLimiteCreditoProdutor);
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  LIM.PRODUTOR_ID,');
  pesq.SQL.Add('  LIM.DISTRIBUIDOR_ID,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO_UTILIZADO,');
  pesq.SQL.Add('  LIM.LIMITE_CREDITO_DISPONIVEL');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  LIMITES_CREDITO_PRODUTOR LIM');

  pesq.SQL.Add('where LIM.PRODUTOR_ID = :P1');
  pesq.SQL.Add('and LIM.DISTRIBUIDOR_ID = :P2');

  if pesq.Pesquisar([produtor_id, distribuidor_id]) then begin
    Result.produtor_id := pesq.AsColunaInt('PRODUTOR_ID');
    Result.distribuidor_id := pesq.AsColunaInt('DISTRIBUIDOR_ID');
    Result.limite_credito := pesq.AsColunaDouble('LIMITE_CREDITO');
    Result.limite_credito_utilizado := pesq.AsColunaDouble('LIMITE_CREDITO_UTILIZADO');
    Result.limite_credito_disponivel := pesq.AsColunaDouble('LIMITE_CREDITO_DISPONIVEL');
  end;

  pesq.Active := False;
  pesq.Free;
end;

end.
