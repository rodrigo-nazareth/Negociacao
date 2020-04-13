unit _ItemNegociacao;

interface

uses
  _ConexaoBanco, Biblioteca, System.SysUtils;

Type
  WebItemNegociacao = record
    negociacao_id: Integer;
    produto_id: Integer;
    quantidade: Double;
    preco: Double;
    total: Double;
    nome: string;
  end;
  TArrayOfWebItemNegociacao = array of WebItemNegociacao;

  TItemNegociacao = class(TTabela)
  private
    function  GetNEGOCIACAO_ID: Integer;
    procedure SetNEGOCIACAO_ID(const Value: Integer);
    function  GetPRODUTO_ID: Integer;
    procedure SetPRODUTO_ID(const Value: Integer);
    function  GetQUANTIDADE: Double;
    procedure SetQUANTIDADE(const Value: Double);
    function  GetPRECO: Double;
    procedure SetPRECO(const Value: Double);
    function  GetTOTAL: Double;
    procedure SetTOTAL(const Value: Double);
  public
    constructor Create(c: TConexaoBanco);
  published
    property NEGOCIACAO_ID: Integer read GetNEGOCIACAO_ID write SetNEGOCIACAO_ID;
    property PRODUTO_ID: Integer read GetPRODUTO_ID write SetPRODUTO_ID;
    property QUANTIDADE: Double read GetQUANTIDADE write SetQUANTIDADE;
    property PRECO: Double read GetPRECO write SetPRECO;
    property TOTAL: Double read GetTOTAL write SetTOTAL;
  end;

function BuscarItensNegociacoes(con: TConexaoBanco; filtros: string): TArrayOfWebItemNegociacao;

implementation

{ TItemNegociacao }

constructor TItemNegociacao.Create(c: TConexaoBanco);
begin
  inherited Create(c, 'ITENS_NEGOCIACAO');
end;

function TItemNegociacao.GetNEGOCIACAO_ID: Integer;
begin
  Result := GetValorColuna('NEGOCIACAO_ID');
end;

function TItemNegociacao.GetPRECO: Double;
begin
  Result := GetValorColuna('PRECO');
end;

function TItemNegociacao.GetPRODUTO_ID: Integer;
begin
  Result := GetValorColuna('PRODUTO_ID');
end;

function TItemNegociacao.GetQUANTIDADE: Double;
begin
  Result := GetValorColuna('QUANTIDADE');
end;

function TItemNegociacao.GetTOTAL: Double;
begin
  Result := GetValorColuna('TOTAL');
end;

procedure TItemNegociacao.SetNEGOCIACAO_ID(const Value: Integer);
begin
  AddColuna('NEGOCIACAO_ID', Value, tpCampo);
end;

procedure TItemNegociacao.SetPRECO(const Value: Double);
begin
  AddColuna('PRECO', Value, tpCampo);
end;

procedure TItemNegociacao.SetPRODUTO_ID(const Value: Integer);
begin
  AddColuna('PRODUTO_ID', Value, tpCampo);
end;

procedure TItemNegociacao.SetQUANTIDADE(const Value: Double);
begin
  AddColuna('QUANTIDADE', Value, tpCampo);
end;

procedure TItemNegociacao.SetTOTAL(const Value: Double);
begin
  AddColuna('TOTAL', Value, tpCampo);
end;

function BuscarItensNegociacoes(con: TConexaoBanco; filtros: string): TArrayOfWebItemNegociacao;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  ITE.NEGOCIACAO_ID,');
  pesq.SQL.Add('  ITE.PRODUTO_ID,');
  pesq.SQL.Add('  ITE.PRECO,');
  pesq.SQL.Add('  ITE.QUANTIDADE,');
  pesq.SQL.Add('  ITE.TOTAL,');
  pesq.SQL.Add('  PRO.NOME');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  ITENS_NEGOCIACAO ITE');
  pesq.SQL.Add('inner join PRODUTOS PRO');
  pesq.SQL.Add('on ITE.PRODUTO_ID = PRO.PRODUTO_ID');

  pesq.SQL.Add(filtros);

  if pesq.Pesquisar then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].negociacao_id := pesq.AsColunaInt('NEGOCIACAO_ID');
      Result[i].produto_id := pesq.AsColunaInt('PRODUTO_ID');
      Result[i].preco := pesq.AsColunaDouble('PRECO');
      Result[i].quantidade := pesq.AsColunaDouble('QUANTIDADE');
      Result[i].total := pesq.AsColunaDouble('TOTAL');
      Result[i].nome := pesq.AsColunaString('NOME');

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

end.
