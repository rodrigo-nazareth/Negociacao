unit Ambiente;

interface

uses
  _ConexaoBanco, Vcl.Forms, System.SysUtils, Vcl.Dialogs, System.IniFiles, System.UITypes;

var
  con_banco: TConexaoBanco;

procedure IniciarAplicacao;

implementation

uses
  BuscarCaminhoBanco, Biblioteca;

function ConectarBancoDados: Boolean;
var
  caminho_banco: string;
  caminho_banco_projeto: string;
  arquivo_ini: string;

  tem_banco_projeto: Boolean;
  tem_arquivo_ini: Boolean;

  configuracoes: TIniFile;

  function BuscarBanco: string;
  var
    ini: TIniFile;
  begin
    Result := BuscarCaminhoBanco.BuscaCaminhoBanco;
    if BuscarCaminhoBanco._cancelou then begin
      MensagemCanceladoUsuario;
      Exit;
    end;

    arquivo_ini := ExtractFilePath(Application.ExeName) + 'CONFIG.INI';
    try
      ini := TIniFile.Create(arquivo_ini);
      ini.WriteString('CONEXAO', 'caminho_caminho', Result);
    finally
      FreeAndNil(ini);
    end;
  end;
begin
  Result := False;

  caminho_banco_projeto := ExtractFilePath(Application.ExeName) + 'data\DADOS.FDB';
  tem_banco_projeto := FileExists(caminho_banco_projeto);

  arquivo_ini := ExtractFilePath(Application.ExeName) + 'config.ini';
  tem_arquivo_ini := FileExists(arquivo_ini);

  caminho_banco := '';

  if tem_banco_projeto then
    caminho_banco := ExtractFilePath(Application.ExeName) + 'data\DADOS.FDB'
  else if tem_arquivo_ini then begin
    // carregando as informações do arquivo de configurações
    configuracoes := TIniFile.Create(arquivo_ini);
    Try
      caminho_banco := configuracoes.ReadString('CONEXAO', 'caminho_caminho', '');
    finally
      FreeAndNil(configuracoes);
    end;

    if not FileExists(caminho_banco) then
      caminho_banco := BuscarBanco;
  end
  else
    caminho_banco := BuscarBanco;

  if Trim(caminho_banco) = '' then begin
    MessageDlg(
      'Não foi encontrado o banco de dados da aplicação!',
      mtInformation,
      [mbOK],
      0
    );
    Exit;
  end;

  if not con_banco.Conectar(caminho_banco) then begin
    MessageDlg(
      'Não foi possível conectar ao banco de dados!',
      mtInformation,
      [mbOK],
      0
    );
    Exit;
  end;

  Result := True;
end;

procedure IniciarAplicacao;
begin
  con_banco := TConexaoBanco.Create(Application);

  if not ConectarBancoDados then
    Halt;
end;

end.
