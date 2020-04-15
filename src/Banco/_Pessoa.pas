unit _Pessoa;

interface

uses
  _ConexaoBanco, Biblioteca, System.SysUtils, _LimiteCreditoProdutor;

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
  tipo_pessoa: string;
  limites: TArrayOfWebLimiteCreditoProdutor
): TRetornoComunicaoBanco;

function DeletarPessoa(con: TConexaoBanco; pessoa_id: Integer): TRetornoComunicaoBanco;
function BuscarPessoas(con: TConexaoBanco; filtros: string): TArrayOfWebPessoa;
function BuscaPessoaTelaPesquisa(con: TConexaoBanco; filtro: string): TArrayOfTDadosPessoaPesq;

implementation

{ TPessoa }

constructor TPessoa.Create(c: TConexaoBanco);
begin
  inherited Create(c, 'PESSOAS');
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
  tipo_pessoa: string;
  limites: TArrayOfWebLimiteCreditoProdutor
): TRetornoComunicaoBanco;
var
  i: Integer;
  pessoa: TPessoa;
  lim: TLimiteCreditoProdutor;
  novo_registro: Boolean;
  novo_registro_lim: Boolean;
  pesq: TPesquisa;
begin
  Result.teve_erro := False;
  pessoa := TPessoa.Create(con);
  lim := TLimiteCreditoProdutor.Create(con);
  pesq := con.NovaPesquisa;

  try
    con.AbrirTransacao;

    novo_registro := pessoa_id = 0;
    if novo_registro then begin
      pesq.SQL.Add('select gen_id(gen_pessoas_id,1) as CODIGO from rdb$database');
      pesq.Pesquisar;
      pessoa_id := pesq.AsColunaInt('CODIGO');
    end;

    pessoa.PESSOA_ID := pessoa_id;
    pessoa.RAZAO_SOCIAL := razao_social;
    pessoa.NOME_FANTASIA := nome_fantasia;
    pessoa.CPF_CNPJ := cpf_cnpj;
    pessoa.TIPO_PESSOA := tipo_pessoa;

    if novo_registro then
      pessoa.Inserir
    else
      pessoa.Alterar;

    for i := Low(limites) to High(limites) do begin
      lim.NovoRegistro;
      lim.PRODUTOR_ID := pessoa_id;
      lim.DISTRIBUIDOR_ID := limites[i].distribuidor_id;
      lim.LIMITE_CREDITO := limites[i].limite_credito;

      pesq.SQL.Clear;
      pesq.SQL.Add('select count(*) as QTDE from LIMITES_CREDITO_PRODUTOR where PRODUTOR_ID = :P1 and DISTRIBUIDOR_ID = :P2');
      pesq.Pesquisar([pessoa_id, limites[i].distribuidor_id]);
      novo_registro_lim := pesq.AsColunaInt('QTDE') = 0;

      if novo_registro_lim then
        lim.Inserir
      else
        lim.Alterar;
    end;


    Result.mensagem_retorno := 'Operação realizada com sucesso!';
    if novo_registro then
      Result.mensagem_retorno := Result.mensagem_retorno + #13 + 'Novo código: ' + FormatoMilharStr(pessoa_id, 0);

    con.FecharTransacao;
  except on E: Exception do
    begin
      Result.teve_erro := True;
      Result.mensagem_retorno := e.message;
      con.VoltarTransacao;
    end;
  end;

  FreeAndNil(pessoa);
  FreeAndNil(lim);
  pesq.Active := False;
  pesq.Free;
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
      Result.mensagem_retorno := e.message;
      con.VoltarTransacao;
    end
  end;

  FreeAndNil(pessoa);
end;

function BuscarPessoas(con: TConexaoBanco; filtros: string): TArrayOfWebPessoa;
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
