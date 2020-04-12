unit _Pessoa;

interface

uses
  _ConexaoBanco, Biblioteca, System.SysUtils;

type
  WebPessoa = record
    pessoa_id: Integer;
    razao_social: string;
    nome_fantasia: string;
    cpf_cnpj: string;
    tipo_pessoa: string;
  end;
  TArrayOfWebPessoa = array of WebPessoa;

  TDadosPessoaPesq = record
    pessoa_id: Integer;
    nome: string;
  end;
  TArrayOfTDadosPessoaPesq = array of TDadosPessoaPesq;

  TPessoa = class(TTabela)
  private
    function  GetPessoaId: Integer;
    procedure SetPessoaId(x: Integer);
    function  GetRazaoSocial: string;
    procedure SetRazaoSocial(x: string);
    function  GetNomeFantasia: string;
    procedure SetNomeFantasia(x: string);
    function  GetCpfCnpj: string;
    procedure SetCpfCnpj(x: string);
    function  GetTipoPessoa: string;
    procedure SetTipoPessoa(x: string);
  public
    constructor Create(c: TConexaoBanco);
  published
    property PESSOA_ID: Integer read GetPessoaId write SetPessoaId;
    property RAZAO_SOCIAL: string read GetRazaoSocial write SetRazaoSocial;
    property NOME_FANTASIA: string read GetNomeFantasia write SetNomeFantasia;
    property CPF_CNPJ: string read GetCpfCnpj write SetCpfCnpj;
    property TIPO_PESSOA: string read GetTipoPessoa write SetTipoPessoa;
  end;

function AtualizarPessoa(
  con: TConexaoBanco;
  pessoa_id: Integer;
  razao_social: string;
  nome_fantasia: string;
  cpf_cnpj: string;
  tipo_pessoa: string
): TRetornoComunicaoBanco;

function DeletarPessoa(con: TConexaoBanco; pessoa_id: Integer): TRetornoComunicaoBanco;
function BuscarPessoa(con: TConexaoBanco; filtros: string): TArrayOfWebPessoa;
function BuscaPessoaTelaPesquisa(con: TConexaoBanco; filtro: string): TArrayOfTDadosPessoaPesq;

implementation

{ TPessoa }

constructor TPessoa.Create(c: TConexaoBanco);
begin
  inherited Create('PESSOAS', c);
end;

function TPessoa.GetCpfCnpj: string;
begin
  Result := GetValorColuna('CPF_CNPJ');
end;

function TPessoa.GetNomeFantasia: string;
begin
  Result := GetValorColuna('NOME_FANTASIA');
end;

function TPessoa.GetPessoaId: Integer;
begin
  Result := GetValorColuna('PESSOA_ID');
end;

function TPessoa.GetRazaoSocial: string;
begin
  Result := GetValorColuna('RAZAO_SOCIAL');
end;

function TPessoa.GetTipoPessoa: string;
begin
  Result := GetValorColuna('TIPO_PESSOA');
end;

procedure TPessoa.SetCpfCnpj(x: string);
begin
  AddColuna('CPF_CNPJ', x, tpCampo);
end;

procedure TPessoa.SetNomeFantasia(x: string);
begin
  AddColuna('NOME_FANTASIA', x, tpCampo);
end;

procedure TPessoa.SetPessoaId(x: Integer);
begin
  AddColuna('PESSOA_ID', x, tpChave);
end;

procedure TPessoa.SetRazaoSocial(x: string);
begin
  AddColuna('RAZAO_SOCIAL', x, tpCampo);
end;

procedure TPessoa.SetTipoPessoa(x: string);
begin
   AddColuna('TIPO_PESSOA', x, tpCampo);
end;

function AtualizarPessoa(
  con: TConexaoBanco;
  pessoa_id: Integer;
  razao_social: string;
  nome_fantasia: string;
  cpf_cnpj: string;
  tipo_pessoa: string
): TRetornoComunicaoBanco;
var
 pessoa: TPessoa;
begin
  Result.teve_erro := False;
  pessoa := TPessoa.Create(con);

  try
    con.AbrirTransacao;

    pessoa.PESSOA_ID := pessoa_id;
    pessoa.RAZAO_SOCIAL := razao_social;
    pessoa.NOME_FANTASIA := nome_fantasia;
    pessoa.CPF_CNPJ := cpf_cnpj;
    pessoa.TIPO_PESSOA := tipo_pessoa;

    if pessoa_id > 0 then
      pessoa.Alterar
    else
      pessoa.Inserir;

    con.FecharTransacao;
  except on E: Exception do
    begin
      Result.teve_erro := True;
      Result.mensagem_erro := e.message;
      con.VoltarTransacao;
    end;
  end;

  FreeAndNil(pessoa);
end;

function DeletarPessoa(con: TConexaoBanco; pessoa_id: Integer): TRetornoComunicaoBanco;
var
  pessoa: TPessoa;
begin
  Result.teve_erro := False;
  pessoa := TPessoa.Create(con);

  try
    con.AbrirTransacao;

    pessoa.PESSOA_ID := pessoa_id;
    pessoa.Deletar;

    con.FecharTransacao;
  except on E: Exception do
    begin
      Result.teve_erro := True;
      Result.mensagem_erro := e.message;
      con.VoltarTransacao;
    end
  end;

  FreeAndNil(pessoa);
end;

function BuscarPessoa(con: TConexaoBanco; filtros: string): TArrayOfWebPessoa;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  PESSOA_ID,');
  pesq.SQL.Add('  RAZAO_SOCIAL,');
  pesq.SQL.Add('  NOME_FANTASIA,');
  pesq.SQL.Add('  CPF_CNPJ,');
  pesq.SQL.Add('  TIPO_PESSOA');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  PESSOAS');
  pesq.SQL.Add(filtros);

  if pesq.Pesquisar then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].pessoa_id := pesq.AsColunaInt('PESSOA_ID');
      Result[i].razao_social := pesq.AsColunaString('RAZAO_SOCIAL');
      Result[i].nome_fantasia := pesq.AsColunaString('NOME_FANTASIA');
      Result[i].cpf_cnpj := pesq.AsColunaString('CPF_CNPJ');
      Result[i].tipo_pessoa := pesq.AsColunaString('TIPO_PESSOA');

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

function BuscaPessoaTelaPesquisa(con: TConexaoBanco; filtro: string): TArrayOfTDadosPessoaPesq;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add('select ');
  pesq.SQL.Add('  PESSOA_ID,');
  pesq.SQL.Add('  RAZAO_SOCIAL');
  pesq.SQL.Add('from');
  pesq.SQL.Add('  PESSOAS');
  pesq.SQL.Add(filtro);

  if pesq.Pesquisar then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].pessoa_id := pesq.AsColunaInt('PESSOA_ID');
      Result[i].nome := pesq.AsColunaString('RAZAO_SOCIAL');

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

end.
