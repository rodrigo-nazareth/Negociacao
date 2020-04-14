unit _ConexaoBanco;

interface

uses
  Winapi.Windows, Vcl.Dialogs, inifiles, SysUtils, Forms, Classes, Data.SqlExpr, Data.DBXCommon, Data.DB, System.Variants;

type

  TColuna = (tpChave, tpCampo);

  TPesquisa = class(TSQLQuery)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AsColunaInt(coluna: string): Integer; overload;
    function AsColunaInt(indice: Integer): Integer; overload;
    function AsColunaString(coluna: string): string; overload;
    function AsColunaString(indice: Integer): string; overload;
    function AsColunaDouble(coluna: string): Double; overload;
    function AsColunaDouble(indice: Integer): Double; overload;
    function AsColunaDateTime(coluna: string): TDateTime; overload;
    function AsColunaDateTime(indice: Integer): TDateTime; overload;
    function AsColunaVariant(coluna: string): Variant; overload;
    function AsColunaVariant(indice: Integer): Variant; overload;
    function Pesquisar: Boolean; overload;
    function Pesquisar(valores: array of Variant): Boolean; overload;
  end;

  TConexaoBanco = class(TComponent)
  protected
    transacao: TDBXTransaction;
    conexao_banco: TSQLConnection;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function  Conectar(base: string): Boolean;
    procedure Desconectar;
    function  Conectado: Boolean;
    function  NovaPesquisa: TPesquisa;
    procedure AbrirTransacao;
    procedure FecharTransacao;
    procedure VoltarTransacao;
  end;

  TExecucao = class(TComponent)
  private
    sql: string;
    con_banco: TConexaoBanco;
  public
    constructor Create(c: TConexaoBanco); reintroduce; overload;
    destructor Destroy; override;

    procedure SetSql(_sql: string);
    procedure Executar; overload;
    procedure Executar(valores: array of variant); overload;
  end;

  Colunas = record
    nome: string;
    tipo: TColuna;
    valor: Variant;
  end;
  TArrayOfColunas = array of Colunas;

  TTabela = class(TComponent)
  private
    tabela: string;
    colunas: TArrayOfColunas;
    con_banco: TConexaoBanco;
  public
    constructor Create(c: TConexaoBanco; _tabela: string); reintroduce; overload;
    destructor Destroy; override;

    procedure AddColuna(coluna: string; valor: Variant; tipo_coluna: TColuna = tpCampo);
    function  GetValorColuna(coluna: string): Variant;
    procedure Inserir;
    procedure Alterar;
    procedure Deletar;
    procedure NovoRegistro;
  end;

implementation

procedure TConexaoBanco.AbrirTransacao;
begin
  transacao := conexao_banco.BeginTransaction;
end;

function TConexaoBanco.Conectado: Boolean;
begin
  Result := conexao_banco.Connected;
end;

function TConexaoBanco.Conectar(base: string): Boolean;
begin
  try
    conexao_banco.Params.Values['User_Name'] := 'SYSDBA';
    conexao_banco.Params.Values['Password'] := 'masterkey';
    conexao_banco.Params.Values['DataBase'] := 'localhost' + ':' + base;
    conexao_banco.Connected := True;

    Result := True;
  except
    Result := False;
  end;
end;

constructor TConexaoBanco.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  conexao_banco := TSQLConnection.Create(Application);
  conexao_banco.Connected := False;
  conexao_banco.LoginPrompt := False;
  conexao_banco.ConnectionName := 'FBConnection';
  conexao_banco.DriverName := 'Firebird';
  conexao_banco.LibraryName := 'dbxfb.dll';
  conexao_banco.VendorLib := 'fbclient.dll';
  conexao_banco.GetDriverFunc := 'getSQLDriverINTERBASE';
end;

procedure TConexaoBanco.Desconectar;
begin
  if conexao_banco.Connected then
    conexao_banco.Close;
end;

destructor TConexaoBanco.Destroy;
begin
  Desconectar;
  conexao_banco.Free;
  inherited Destroy;
end;

procedure TConexaoBanco.FecharTransacao;
begin
  conexao_banco.CommitFreeAndNil(transacao);
end;

function TConexaoBanco.NovaPesquisa: TPesquisa;
begin
  Result := TPesquisa.Create(Self);
  Result.SQLConnection := conexao_banco;
  Result.DisableControls;
  Result.SQL.Clear;
  Result.Active := False;
end;

procedure TConexaoBanco.VoltarTransacao;
begin
  conexao_banco.RollbackIncompleteFreeAndNil(transacao);
end;

function TPesquisa.AsColunaInt(coluna: string): Integer;
begin
  Result := FieldByName(coluna).AsInteger;
end;

function TPesquisa.AsColunaDateTime(indice: Integer): TDateTime;
begin
  Result := FieldByNumber(indice).AsDateTime;
end;

function TPesquisa.AsColunaDateTime(coluna: string): TDateTime;
begin
  Result := FieldByName(coluna).AsDateTime;
end;

function TPesquisa.AsColunaDouble(indice: Integer): Double;
begin
  Result := FieldByNumber(indice).AsFloat;
end;

function TPesquisa.AsColunaDouble(coluna: string): Double;
begin
  Result := FieldByName(coluna).AsFloat;
end;

function TPesquisa.AsColunaInt(indice: Integer): Integer;
begin
  Result := FieldByNumber(indice).AsInteger;
end;

function TPesquisa.AsColunaString(indice: Integer): string;
begin
  Result := FieldByNumber(indice).AsString;
end;

function TPesquisa.AsColunaString(coluna: string): string;
begin
  Result := FieldByName(coluna).AsString;
end;

function TPesquisa.AsColunaVariant(indice: Integer): Variant;
begin
  Result := FieldByNumber(indice).AsVariant;
end;

constructor TPesquisa.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TPesquisa.Destroy;
begin
  Active := False;
  inherited;
end;

function TPesquisa.Pesquisar: Boolean;
begin
  Result := Pesquisar([]);
end;

function TPesquisa.Pesquisar(valores: array of Variant): Boolean;
var
  i: integer;
begin
  Active := False;

  for i := Low(valores) to High(valores) do
    ParamByName('P' + IntToStr(i + 1)).Value := valores[i];

  Active := True;
  Result := not IsEmpty;
end;

{ TExecucao }

constructor TExecucao.Create(c: TConexaoBanco);
begin
  inherited Create(c);
  con_banco := c;
end;

destructor TExecucao.Destroy;
begin
  inherited Destroy;
end;

procedure TExecucao.Executar;
var
  sql_query: TSQLQuery;
begin
  sql_query := con_banco.NovaPesquisa;
  sql_query.SQL.Add(sql);
  sql_query.ExecSQL;
  sql_query.Free;
end;

procedure TExecucao.Executar(valores: array of variant);
var
  i: integer;
  query: TSQLQuery;
begin
  query := con_banco.NovaPesquisa;
  query.SQL.Add(sql);

  for i := Low(valores) to High(valores) do begin
    if valores[i] = null then
      query.ParamByName('P' + IntToStr(i + 1)).AsString := ''
    else
      query.ParamByName('P' + IntToStr(i + 1)).Value := valores[i];
  end;

  query.ExecSql;

  query.Active := False;
  query.Free;
end;

procedure TExecucao.SetSql(_sql: string);
begin
  sql := _sql;
end;

{ TTabela }

procedure TTabela.AddColuna(coluna: string; valor: Variant; tipo_coluna: TColuna = tpCampo);
begin
  SetLength(colunas, Length(colunas) + 1);
  colunas[High(colunas)].nome := coluna;
  colunas[High(colunas)].valor := valor;
  colunas[High(colunas)].tipo := tipo_coluna;
end;

procedure TTabela.Alterar;
var
  i: Integer;
  par: Integer;
  sql: string;
  valores: array of Variant;
  exec: TExecucao;
begin
  exec := TExecucao.Create(con_banco);
  valores := nil;

  sql := 'update ' + tabela + ' set ';

  par := 0;
  for i := Low(colunas) to High(colunas) do begin
    if colunas[i].tipo = tpChave then
      Continue;

    sql := sql + colunas[i].nome + ' = ' + ':P' + IntToStr(par + 1) + ', ';
    Inc(par);
  end;

  sql := Trim(sql);
  sql := Copy(sql, 0, Length(sql) - 1);

  sql := sql + ' where ';
  for i := Low(colunas) to High(colunas) do begin
    if colunas[i].tipo = tpCampo then
      Continue;

    sql := sql + colunas[i].nome + ' = :P' + IntToStr(par + 1) + ' and ';
    Inc(par);
  end;

  sql := Trim(sql);
  sql := Copy(sql, 0, Length(sql) - 3);

  for i := Low(colunas) to High(colunas) do begin
    if colunas[i].tipo = tpChave then
      Continue;

    SetLength(valores, Length(valores) + 1);
    valores[High(valores)] := colunas[i].valor;
  end;

  for i := Low(colunas) to High(colunas) do begin
    if colunas[i].tipo = tpCampo then
      Continue;

    SetLength(valores, Length(valores) + 1);
    valores[High(valores)] := colunas[i].valor;
  end;

  try
    exec.SetSql(sql);
    exec.Executar(valores);
  finally
    exec.Free;
  end;
end;

constructor TTabela.Create(c: TConexaoBanco; _tabela: string);
begin
  inherited Create(c);
  con_banco := c;
  tabela := _tabela;
  colunas := nil;
end;

procedure TTabela.Deletar;
var
  i: Integer;
  sql: string;
  valores: array of Variant;
  exec: TExecucao;
begin
  exec := TExecucao.Create(con_banco);
  valores := nil;

  sql := 'delete from ' + tabela + ' where ';

  for i := Low(colunas) to High(colunas) do
    sql := sql + colunas[i].nome + ' = :P' + IntToStr(i + 1) + ' and ';

  sql := Trim(sql);
  sql := Copy(sql, 0, Length(sql) - 4);

  SetLength(valores, Length(valores) + 1);
  for i := Low(colunas) to High(colunas) do
    valores[i] := colunas[i].valor;

  try
    exec.SetSql(sql);
    exec.Executar(valores);
  finally
    exec.Free;
  end;
end;

destructor TTabela.Destroy;
begin
  colunas := nil;
  inherited;
end;

function TTabela.GetValorColuna(coluna: string): Variant;
var
  i: Integer;
begin
  Result := Null;
  for i := Low(colunas) to High(colunas) do begin
    if colunas[i].nome <> coluna then
      Continue;

    Result := colunas[i].valor;
    Break;
  end;
end;

procedure TTabela.Inserir;
var
  i: Integer;
  par: Integer;
  sql: string;
  valores: array of Variant;
  exec: TExecucao;
begin
  exec := TExecucao.Create(con_banco);
  valores := nil;

  sql := 'insert into ' + tabela + '(';
  par := 0;
  for i := Low(colunas) to High(colunas) do
    sql := sql + colunas[i].nome + ', ';

  sql := Trim(sql);
  sql := Copy(sql, 0, Length(sql) - 1);
  sql := sql + ') values (';

  for i := Low(colunas) to High(colunas) do begin
    sql := sql + ':P' + IntToStr(par + 1) + ', ';
    Inc(par);
  end;

  sql := Trim(sql);
  sql := Copy(sql, 0, Length(sql) - 1);
  sql := sql + ')';

  for i := Low(colunas) to High(colunas) do begin
    SetLength(valores, Length(valores) + 1);
    valores[High(valores)] := colunas[i].valor;
  end;

  try
    exec.SetSql(sql);
    exec.Executar(valores);
  finally
    exec.Free;
  end;
end;

procedure TTabela.NovoRegistro;
begin
  colunas := nil;
end;

function TPesquisa.AsColunaVariant(coluna: string): Variant;
begin
  Result := FieldByName(coluna).AsVariant;
end;

end.

