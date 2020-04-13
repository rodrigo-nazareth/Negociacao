unit FrameBasePesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.ExtCtrls, Vcl.Menus, System.UITypes;

type
  TFramePesquisa = class(TFrame)
    pnPesquisar: TPanel;
    sgConsulta: TStringGrid;
    btnPesquisar: TBitBtn;
    PnTitulos: TPanel;
    lbCampo: TLabel;
    Panel2: TPanel;
    CkChaveUnica: TCheckBox;
    ckSomenteLeitura: TCheckBox;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    sql_base: string;
    filtro_pesquisa: string;
    coluna_filtro: string;
    chave_unica: Boolean;

    procedure AjustarUltimaColuna;
  public
    constructor Create(AOwner: TComponent); override;

    procedure SetarBaseFrame(
      _sql: string;
      _filtro_pesquisa: string;
      _coluna_filtro: string;
      _chave_unica: Boolean = True
    );

    procedure ModoFrame(editando: Boolean; limpar: Boolean = True);
    procedure Clear;
    function  GetCodigo(linha: Integer = 0): Integer;
    function  GetNome(linha: Integer = 0): string;
    function  GetFiltros: string;
    function  EstaVazio: Boolean;
    procedure InserirDireto(codigo: Integer);
    procedure SomenteLeitura(somente_leitura: Boolean);
  end;

implementation

uses
  Biblioteca, _PesquisaGenericaFrame, PesquisaGenericaFrameConsulta, Ambiente;

const
  cCodigo  = 0;
  cNome    = 1;

{$R *.dfm}

{ TFramePesquisa }

procedure TFramePesquisa.btnPesquisarClick(Sender: TObject);
var
  resultado: TRetornoFrameConsulta;
begin
  if sql_base = '' then begin
    MessageDlg(
      'É necessário passar o select do frame!',
      mtError,
      [mbOK],
      0
    );
    Abort;
  end;

  sgConsulta.SetFocus;

  resultado := PesquisaGenericaFrameConsulta.PesquisarUnicoRegistro(sql_base + filtro_pesquisa);
  if PesquisaGenericaFrameConsulta._cancelou then
    Abort;

  sgConsulta.Cells[cCodigo, 0] := FormatoMilharStr(resultado.codigo, 0);
  sgConsulta.Cells[cNome, 0] := resultado.nome;
end;

procedure TFramePesquisa.Clear;
begin
  LimparGrid(sgConsulta);
end;

constructor TFramePesquisa.Create(AOwner: TComponent);
begin
  inherited;
  if CkChaveUnica.Checked then
    sgConsulta.RowCount := 1
  else
    sgConsulta.RowCount := 2;

  SomenteLeitura(ckSomenteLeitura.Checked);
end;

function TFramePesquisa.EstaVazio: Boolean;
begin
  Result := Trim(sgConsulta.Cells[0, 0]) = '';
end;

procedure TFramePesquisa.FrameResize(Sender: TObject);
begin
  AjustarUltimaColuna;
end;

procedure TFramePesquisa.ModoFrame(editando, limpar: Boolean);
begin
  inherited;
  lbCampo.Enabled := Editando;
  btnPesquisar.Enabled := editando;
  sgConsulta.Enabled := Editando;

  SomenteLeitura(ckSomenteLeitura.Checked);

  if limpar then
  	Clear;
end;

procedure TFramePesquisa.SetarBaseFrame(
  _sql: string;
  _filtro_pesquisa: string;
  _coluna_filtro: string;
  _chave_unica: Boolean = True
);
begin
  inherited;
  sql_base := _sql;
  coluna_filtro := _coluna_filtro;
  filtro_pesquisa := _filtro_pesquisa;

  if chave_unica then
    sgConsulta.RowCount := 1;
end;

procedure TFramePesquisa.SomenteLeitura(somente_leitura: Boolean);
begin
  pnPesquisar.Visible := not somente_leitura;
  pnPesquisar.Enabled := not somente_leitura;
  sgConsulta.Enabled := not somente_leitura;
  AjustarUltimaColuna;
end;

procedure TFramePesquisa.AjustarUltimaColuna;
var
  i: Integer;
  soma: Integer;
begin
  soma := 0;
  for i := 0 to SgConsulta.ColCount - 2 do
    soma := soma + sgConsulta.ColWidths[i];

  sgConsulta.ColWidths[sgConsulta.ColCount - 1] := sgConsulta.Width - soma - 2;
end;

function TFramePesquisa.GetCodigo(linha: Integer = 0): Integer;
begin
  Result := ValorInt(sgConsulta.Cells[cCodigo, linha]);
end;

function TFramePesquisa.GetFiltros: string;
var
  i: Integer;
begin
  Result := coluna_filtro;

  if sgConsulta.RowCount > 1 then begin
    Result := '(' + coluna_filtro + 'in (';

    for i := 0 to sgConsulta.RowCount - 1 do
      Result := Result + ValorIntStr(sgConsulta.Cells[cCodigo, i]) + ', ';

    Result := Trim(Result);
    Result := Copy(Result, 0, Length(Result) - 1);
    Result := Result + '))'
  end
  else
    Result := coluna_filtro + ' = ' + ValorIntStr(sgConsulta.Cells[cCodigo, 0]);
end;

function TFramePesquisa.GetNome(linha: Integer = 0): string;
begin
  Result := sgConsulta.Cells[cNome, linha];
end;

procedure TFramePesquisa.InserirDireto(codigo: Integer);
var
  resultado: TRetornoFrameConsulta;
begin
  if sql_base = '' then begin
    MessageDlg(
      'É necessário passar o select do frame!',
      mtError,
      [mbOK],
      0
    );
    Abort;
  end;

 resultado := _PesquisaGenericaFrame.BuscarDadosFrame(Ambiente.con_banco, sql_base + ' where ' + coluna_filtro + ' =  ' + IntToStr(codigo))[0];

 sgConsulta.Cells[cCodigo, 0] := FormatoMilharStr(resultado.codigo, 0);
 sgConsulta.Cells[cNome, 0] := resultado.nome;
end;

end.
