unit _Produto;

interface

uses
  _ConexaoBanco, Biblioteca, System.SysUtils;

type
  WebProduto = record
    produto_id: Integer;
    nome: string;
    preco: Double;
  end;
  TArrayOfWebProduto = array of WebProduto;

  TProduto = class(TTabela)
  private
    function  GetProduto_Id: Integer;
    procedure SetProduto_Id(x: Integer);
    function  GetNome: string;
    procedure SetNome(x: string);
    function  GetPreco: Double;
    procedure SetPreco(x: Double);
  public
    constructor Create(c: TConexaoBanco);
  published
    property PRODUTO_ID: Integer read GetProduto_Id write SetProduto_Id;
    property NOME: string read GetNome write SetNome;
    property PRECO: Double read GetPreco write SetPreco;
  end;

function AtualizarProduto(
  con: TConexaoBanco;
  produto_id: Integer;
  nome: string;
  preco: Double
): TRetornoComunicaoBanco;

function DeletarProduto(con: TConexaoBanco; produto_id: Integer): TRetornoComunicaoBanco;
function BuscarProdutos(con: TConexaoBanco; filtros: string): TArrayOfWebProduto;
function BuscarPrecoProduto(con: TConexaoBanco; produto_id: Integer): Double;

implementation

{ TProduto }

constructor TProduto.Create(c: TConexaoBanco);
begin
  inherited Create(c, 'PRODUTOS');
end;

function TProduto.GetNome: string;
begin
  Result := GetValorColuna('NOME');
end;

function TProduto.GetPreco: Double;
begin
  Result := GetValorColuna('PRECO');
end;

function TProduto.GetProduto_Id: Integer;
begin
  Result := GetValorColuna('PRODUTO_ID');
end;

procedure TProduto.SetNome(x: string);
begin
  AddColuna('NOME', x, tpCampo);
end;

procedure TProduto.SetPreco(x: Double);
begin
  AddColuna('PRECO', x, tpCampo);
end;

procedure TProduto.SetProduto_Id(x: Integer);
begin
  AddColuna('PRODUTO_ID', x, tpChave);
end;

function AtualizarProduto(
  con: TConexaoBanco;
  produto_id: Integer;
  nome: string;
  preco: Double
): TRetornoComunicaoBanco;
var
  produto: TProduto;
  novo_registro: Boolean;
  pesq: TPesquisa;
begin
  Result.teve_erro := False;
  produto := TProduto.Create(con);
  pesq := con.NovaPesquisa;

  try
    con.AbrirTransacao;

    novo_registro := produto_id = 0;
    if novo_registro then begin
      pesq.SQL.Add('select gen_id(GEN_PRODUTOS_ID,1) as CODIGO from rdb$database');
      pesq.Pesquisar;
      produto_id := pesq.AsColunaInt('CODIGO');
    end;

    produto.PRODUTO_ID := produto_id;
    produto.NOME := nome;
    produto.PRECO := preco;

    if novo_registro then
      produto.Inserir
    else
      produto.Alterar;

    Result.mensagem_retorno := 'Operação realizada com sucesso!';
    if novo_registro then
      Result.mensagem_retorno := Result.mensagem_retorno + #13 + 'Novo código: ' + FormatoMilharStr(produto_id, 0);

    con.FecharTransacao;
  except on E: Exception do
    begin
      Result.teve_erro := True;
      Result.mensagem_retorno := e.message;
      con.VoltarTransacao;
    end;
  end;

  FreeAndNil(produto);
  pesq.Active := False;
  pesq.Free;
end;

function DeletarProduto(con: TConexaoBanco; produto_id: Integer): TRetornoComunicaoBanco;
var
  produto: TProduto;
begin
  Result.teve_erro := False;
  produto := TProduto.Create(con);

  try
    con.AbrirTransacao;

    produto.PRODUTO_ID := produto_id;
    produto.Deletar;

    con.FecharTransacao;
  except on E: Exception do
    begin
      Result.teve_erro := True;
      Result.mensagem_retorno := e.message;
      con.VoltarTransacao;
    end
  end;

  FreeAndNil(produto);
end;

function BuscarProdutos(con: TConexaoBanco; filtros: string): TArrayOfWebProduto;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  PRODUTO_ID,');
  pesq.SQL.Add('  NOME,');
  pesq.SQL.Add('  PRECO');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  PRODUTOS');
  pesq.SQL.Add(filtros);

  if pesq.Pesquisar then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].produto_id := pesq.AsColunaInt('PRODUTO_ID');
      Result[i].nome:= pesq.AsColunaString('NOME');
      Result[i].preco := pesq.AsColunaDouble('PRECO');

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

function BuscarPrecoProduto(con: TConexaoBanco; produto_id: Integer): Double;
var
  pesq: TPesquisa;
begin
  Result := 0;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  PRECO');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  PRODUTOS');
  pesq.SQL.Add('where PRODUTO_ID = :P1');

  if pesq.Pesquisar([produto_id]) then
    Result := pesq.AsColunaDouble('PRECO');

  pesq.Active := False;
  pesq.Free;
end;

end.
