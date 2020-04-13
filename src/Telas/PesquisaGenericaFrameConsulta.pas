unit PesquisaGenericaFrameConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PesquisaBase, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Buttons, Vcl.ExtCtrls, Biblioteca, _PesquisaGenericaFrame;

type
  TFormPesquisaGenericaFrame = class(TFormPesquisaBase)
    stAtalhos2: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure sgPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgPesquisaEnter(Sender: TObject);
  private
    sql: string;
    selecionado_todos: Boolean;

    procedure SelecionarTodos(marcar: Boolean);
    procedure SelecionarRegistro(linha: Integer);
  end;

var
  _cancelou: Boolean;

function PesquisarUnicoRegistro(consulta: string): TRetornoFrameConsulta;
function PesquisarVariosRegistros(consulta: string): TArrayOfTRetornoFrameConsulta;

implementation

uses
  Ambiente;

const
  cSelecionado       = 0;
  cCodigo            = 1;
  cNome              = 2;

{$R *.dfm}

procedure TFormPesquisaGenericaFrame.FormCreate(Sender: TObject);
begin
  inherited;
  IniciarGrid(sgPesquisa, ['Sel?', 'Código', 'Nome']);
end;

procedure TFormPesquisaGenericaFrame.sgPesquisaEnter(Sender: TObject);
var
  i: Integer;
  linha: Integer;
  dados: TArrayOfTRetornoFrameConsulta;
begin
  inherited;
  dados := _PesquisaGenericaFrame.BuscarDadosFrame(
    Ambiente.con_banco,
    sql + ' like ''%' + eChave.Text + '%'''
  );

  linha := sgPesquisa.FixedRows;
  for i := Low(dados) to High(dados) do begin
    sgPesquisa.Cells[cCodigo, linha] := FormatoMilharStr(dados[i].codigo, 0);
    sgPesquisa.Cells[cNome, linha] := dados[i].nome;

    Inc(linha);
  end;

  if linha > sgPesquisa.RowCount then
    sgPesquisa.RowCount := linha;
end;

procedure TFormPesquisaGenericaFrame.sgPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and (UpperCase(Char(Key)) = 'T') then begin
    SelecionarTodos(not selecionado_todos);
    selecionado_todos := not selecionado_todos;
  end
  else if key = 32  then
    SelecionarRegistro(sgPesquisa.Row);
end;

procedure TFormPesquisaGenericaFrame.SelecionarRegistro(linha: Integer);
begin
  if sgPesquisa.Cells[cSelecionado, linha] = 'Não' then
    sgPesquisa.Cells[cSelecionado, linha] := 'Sim'
  else
    sgPesquisa.Cells[cSelecionado, linha] := 'Não';
end;

procedure TFormPesquisaGenericaFrame.SelecionarTodos(marcar: Boolean);
var
  i: Integer;
begin
  for i := sgPesquisa.FixedRows to sgPesquisa.RowCount - 1  do begin
    if marcar then
      sgPesquisa.Cells[cSelecionado, i] := 'Sim'
    else
      sgPesquisa.Cells[cSelecionado, i] := 'Não';
  end;
end;

function PesquisarUnicoRegistro(consulta: string): TRetornoFrameConsulta;
var
  retorno: TRetornoFrameConsulta;
  form: TFormPesquisaGenericaFrame;
begin
  retorno := Default(TRetornoFrameConsulta);
  Result := retorno;
  form := TFormPesquisaGenericaFrame.Create(Application);

  form.sgPesquisa.ColWidths[cSelecionado] := -1;
  form.sql := consulta;
  _cancelou := False;

  if form.ShowModal = mrOk then begin
    Result.codigo := ValorInt(form.sgPesquisa.Cells[cCodigo, form.sgPesquisa.Row]);
    Result.nome := form.sgPesquisa.Cells[cNome, form.sgPesquisa.Row];
  end
  else
    _cancelou := True;

  form.Free;
end;

function PesquisarVariosRegistros(consulta: string): TArrayOfTRetornoFrameConsulta;
var
  i: Integer;
  form: TFormPesquisaGenericaFrame;
begin
  Result := nil;
  form := TFormPesquisaGenericaFrame.Create(Application);

  with form do begin

    form.sql := consulta;
    _cancelou := False;

    if form.ShowModal = mrOk then begin
      for i := sgPesquisa.FixedRows to sgPesquisa.RowCount - 1 do begin
        if sgPesquisa.Cells[cSelecionado, i] <> 'Sim' then
          Continue;

        SetLength(Result, Length(Result) + 1);
        Result[High(Result)].codigo := ValorInt(sgPesquisa.Cells[cCodigo, i]);
        Result[High(Result)].nome := sgPesquisa.Cells[cNome, i];
      end;
    end
    else
      _cancelou := True;
  end;

  form.Free;
end;

end.
