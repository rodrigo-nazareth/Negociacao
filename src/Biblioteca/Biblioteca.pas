unit Biblioteca;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Grids, Vcl.Dialogs, System.UITypes;

type
  TColunasCabecalho = record
    nome: string;
    tamanho: Integer;
  end;
  TArrayOfTColunasCabecalho = array of TColunasCabecalho;

var
  _tela_princial: TForm;

function AbrirForm(classe: TFormClass): TForm;
procedure LimparGrid(var grid: TStringGrid);
procedure IniciarGrid(var grid: TStringGrid; colunas: array of string); overload;
procedure IniciarGrid(var grid: TStringGrid; colunas: TArrayOfTColunasCabecalho); overload;
procedure IniciarGrid(var grid: TStringGrid; colunas: array of variant); overload;
procedure MensagemCanceladoUsuario;
procedure MensagemSucesso;

implementation

function AbrirForm(classe: TFormClass): TForm;
var
  i: Integer;
  form: TForm;
  existe_form: Boolean;
begin
  form := nil;

  existe_form := False;
  for i := 0 to _tela_princial.MDIChildCount - 1 do begin
    if _tela_princial.MDIChildren[i].ClassName <> classe.ClassName then
      Continue;

    form := _tela_princial.MDIChildren[i];
    existe_form := True;
    Break;
  end;

  if existe_form then begin
    form.WindowState := WsNormal;
    form.BringToFront;
    form.SetFocus;
  end
  else begin
    form := Classe.Create(Application);;
    form.Show;
  end;

  Result := form;
end;

procedure LimparGrid(var grid: TStringGrid);
var
  i: Integer;
begin
  for i := grid.FixedRows to grid.RowCount - 1 do
    grid.Rows[i].Clear;

  grid.RowCount := grid.FixedRows + 1;
end;

procedure IniciarGrid(var grid: TStringGrid; colunas: array of string);
var
  i: Integer;
begin
  LimparGrid(grid);
  grid.ColCount := Length(colunas);
  grid.DefaultRowHeight := 19;

  for i := 0 to Length(colunas) - 1 do begin
    grid.Cells[i, 0] := colunas[i];
    grid.ColWidths[i] := grid.Canvas.TextWidth(colunas[i]);
  end;
end;

procedure IniciarGrid(var grid: TStringGrid; colunas: TArrayOfTColunasCabecalho);
var
  i: Integer;
begin
  LimparGrid(grid);
  grid.ColCount := Length(colunas);
  grid.DefaultRowHeight := 19;

  for i := 0 to Length(colunas) do begin
    grid.Cells[i, 0] := colunas[i].nome;
    grid.ColWidths[i] := colunas[i].tamanho;
  end;
end;

procedure IniciarGrid(var grid: TStringGrid; colunas: array of variant); overload;
var
  i: Integer;
  metade_itens: Integer;
begin
  LimparGrid(grid);
  grid.DefaultRowHeight := 19;
  grid.DrawingStyle := gdsClassic;

  if (High(colunas) + 1) mod 2 > 0 then begin
    MessageDlg(
      'Quantidade de colunas não está correta!',
      mtError,
      [mbOK],
      0
    );
    Exit;
  end;

  metade_itens := (High(colunas) - 1) div 2;
  grid.ColCount := metade_itens + 1;

  for i := 0 to metade_itens do begin
    grid.Cells[i, 0] := colunas[i * 2];
    grid.ColWidths[i] := colunas[i * 2 + 1];
  end;
end;

procedure MensagemSucesso;
begin
  MessageDlg(
    'Operação realizada com sucesso!',
    mtInformation,
    [mbOK],
    0
  );
end;

procedure MensagemCanceladoUsuario;
begin
  MessageDlg(
    'Operação cancelada pelo usuário!',
    mtWarning,
    [mbOK],
    0
  );
end;

end.
