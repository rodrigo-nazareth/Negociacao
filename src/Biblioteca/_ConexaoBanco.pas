unit _ConexaoBanco;

interface

uses
	SqlExpr, inifiles, SysUtils, Forms, Classes;

type
  TPesquisa = class(TSQLQuery)
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

	TConexaoBanco = class(TComponent)
  protected
    conexao_banco: TSQLConnection;
  public
		constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;

    function  Conectar(base: string): Boolean;
    procedure Desconectar;

    function  Conectado: Boolean;
    function  NovaPesquisa: TPesquisa;
	end;

implementation

uses
  Winapi.Windows, Vcl.Dialogs, Data.DB;

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
  inherited
  Create(AOwner);

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

function TConexaoBanco.NovaPesquisa: TPesquisa;
begin
  Result := TPesquisa.Create(Self);
  Result.SQLConnection := conexao_banco;
  Result.DisableControls;
  Result.SQL.Clear;
end;

constructor TPesquisa.Create(AOwner: TComponent);
begin
  inherited;
  Create(AOwner);
end;

destructor TPesquisa.Destroy;
begin
  Active := False;
  inherited;
end;

end.
