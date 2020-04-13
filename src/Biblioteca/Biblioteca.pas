unit Biblioteca;

interface

uses
  System.SysUtils, Vcl.Forms, Vcl.Grids, Vcl.Dialogs, System.UITypes, Vcl.StdCtrls,
  VCLTee.Chart, Vcl.ExtCtrls, Vcl.CheckLst, Vcl.Controls, Vcl.Mask, Vcl.ComCtrls, Vcl.Graphics;

type
  TColunasCabecalho = record
    nome: string;
    tamanho: Integer;
  end;
  TArrayOfTColunasCabecalho = array of TColunasCabecalho;

  TRetornoComunicaoBanco = record
    teve_erro: Boolean;
    mensagem_retorno: string;
  end;

var
  _tela_princial: TForm;

function  AbrirForm(classe: TFormClass): TForm;

function  SomenteNumeros(valor: string): string;

procedure LimparGrid(var grid: TStringGrid);
procedure IniciarGrid(var grid: TStringGrid; colunas: array of string); overload;
procedure IniciarGrid(var grid: TStringGrid; colunas: TArrayOfTColunasCabecalho); overload;
procedure IniciarGrid(var grid: TStringGrid; colunas: array of variant); overload;

procedure MensagemCanceladoUsuario;
procedure MensagemSucesso;
procedure MensagemErro(msg_adicional: string);
procedure Exclamar(msg: string);
function  Questionar(mensagem: string): Boolean;

function RetirarCaracter(s: string; c: char):string;
function RetirarPontos(s: string): string;

function  ValorInt(str: string): Integer; overload;
function  ValorInt(edit: TEdit): Integer; overload;
function  Valor(str: string): variant; overload;
function  Valor(st: TStaticText): variant; overload;
function  Valor(e: TCustomEdit): variant; overload;
function  ValorIntStr(str: string): string; overload;

procedure LimparObjetos(objs:array of TControl);
procedure Habilitar(objs: array of TControl; ativar: Boolean; limpar: Boolean);
function  FormatoMilharStr(numero: Double; decimais: Integer = 2): string;

procedure ValidarCampo(
  abrotar: Boolean;
  mensagem: string;
  campo: TWinControl
);

procedure CorStatus(var stStatus: TStaticText);

implementation

uses
  FrameBasePesquisa;

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

  for i := 0 to Length(colunas) - 1 do
    grid.Cells[i, 0] := colunas[i];
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

function ValorInt(str: string): Integer;
begin
  str := RetirarPontos(Trim(str));
  try
    Result := StrToInt(str);
  except
    Result := 0;
  end;
end;

function  ValorInt(edit: TEdit): Integer;
begin
  edit.Text := RetirarPontos(Trim(edit.Text));
  try
    Result := StrToInt(edit.Text);
  except
    Result := 0;
  end;
end;

function  Valor(str: string): variant; overload;
begin
  str := RetirarPontos(Trim(str));
  try
    Result := StrToFloat(str);
  except
    Result := 0;
  end;
end;

function  Valor(st: TStaticText): variant; overload;
var
  str: string;
begin
  str := RetirarPontos(Trim(st.Caption));
  try
    Result := StrToFloat(str);
  except
    Result := 0;
  end;
end;

function Valor(e: TCustomEdit): variant; overload;
var
  str: string;
begin
  str := RetirarPontos(Trim(e.Text));

  try
    Result := StrToFloat(str);
  except
    Result := 0;
  end;
end;

function ValorIntStr(str: string): string; overload;
var
  valor: Integer;
begin
  str := RetirarPontos(Trim(str));
  try
    valor := ValorInt(str);
    Result := IntToStr(valor);
  except
    Result := '';
  end;
end;

procedure LimparObjetos(objs:array of TControl);
var
  i: Integer;
  j: Integer;
begin
  for i := Low(objs) to High(objs) do begin
    if objs[i] is TEdit then
      TEdit(objs[i]).Clear
    else if objs[i] is TCustomMaskEdit then
      TCustomMaskEdit(objs[i]).Clear
    else if objs[i] is TMemo then
      TMemo(objs[i]).Lines.Clear
    else if objs[i] is TCheckBox then
      TCheckBox(objs[i]).State := cbGrayed
    else if objs[i] is TStringGrid then
      LimparGrid(TStringGrid(objs[i]))
    else if objs[i] is TRadioGroup then
      TRadioGroup(objs[i]).ItemIndex := -1
    else if objs[i] is TListBox then
      TListBox(objs[i]).Items.Clear
    else if objs[i] is TCheckListBox then
      TCheckListBox(objs[i]).Items.Clear
    else if objs[i] is TPageControl then
      TPageControl(objs[i]).ActivePageIndex := 0
    else if objs[i] is TComboBox then
      TComboBox(objs[i]).ItemIndex := -1
    else if objs[i] is TStaticText then
      TStaticText(objs[i]).Caption := ''
    else if objs[i] is TImage then
      TImage(objs[i]).Picture := nil
    else if objs[i] is TLabel then
      TLabel(objs[i]).Caption := ''
    else if objs[i] is TChart then begin
      for j:= 1 to TChart(objs[i]).SeriesList.Count do begin
        TChart(objs[i]).Series[j-1].ShowInLegend := False;
        TChart(objs[i]).Series[j-1].Clear;
      end;
    end
    else if objs[i] is TColorBox then
      TColorBox(objs[i]).ItemIndex := -1
    else if objs[i] is TLabeledEdit then
      TLabeledEdit(objs[i]).Clear;
  end;
end;

// Procedimento para ativar/desativar controles da tela
procedure Habilitar(objs: array of TControl; ativar: Boolean; limpar: Boolean);
var
  i: Integer;
begin
  for i := Low(objs) to High(objs) do begin
    if objs[i] is TFramePesquisa then
      TFramePesquisa(objs[i]).ModoFrame(ativar, limpar)
    else if objs[i] is TTabSheet then
      TTabSheet(objs[i]).TabVisible := ativar
    else if objs[i] is TControl then
      TControl(objs[i]).Enabled := ativar;
  end;

  if limpar then
    LimparObjetos(objs);
end;

function SomenteNumeros(valor: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(valor) do begin
    if  CharInSet(valor[i], ['0'..'9']) then
      Result := Result + valor[i];
  end;
end;

procedure MensagemErro(msg_adicional: string);
var
  mensagem: string;
begin
  mensagem := 'Erro ao realizar a operação!';

  msg_adicional := Trim(msg_adicional);
  if msg_adicional <> '' then
    mensagem := mensagem + #13 +msg_adicional;

  MessageDlg(
    mensagem,
    mtError,
    [mbOK],
    0
  );
end;

function FormatoMilharStr(numero: Double; decimais: Integer = 2): string;
begin
  if Decimais = 0 then
    Result := FormatFloat('#,##0', numero)
  else if Decimais = 1 then
    Result := FormatFloat('#,##0.0', numero)
  else if Decimais = 2 then
    Result := FormatFloat('#,##0.00', numero)
  else if Decimais = 3 then
    Result := FormatFloat('#,##0.000', numero)
  else if Decimais = 4 then
    Result := FormatFloat('#,##0.0000', numero)
  else if Decimais = 5 then
    Result := FormatFloat('#,##0.00000', numero)
  else if Decimais = 6 then
    Result := FormatFloat('#,##0.000000', numero)
  else if Decimais = 7 then
    Result := FormatFloat('#,##0.0000000', numero)
  else if Decimais = 8 then
    Result := FormatFloat('#,##0.00000000', numero)
  else
    Result:=FormatFloat('#,##0.00',numero);
end;

procedure Exclamar(msg: string);
begin
  MessageDlg(msg, mtInformation, [mbOK], 0);
end;

procedure ValidarCampo(
  abrotar: Boolean;
  mensagem: string;
  campo: TWinControl
);
begin
  if abrotar then begin
    MessageDlg(mensagem, mtInformation, [mbOK], 0);
    campo.SetFocus;
    Abort;
  end;
end;

function RetirarCaracter(s: string; c: char):string;
var
  i: Integer;
begin
  Result := '';
  for i:=1 to Length(s) do begin
    if s[i] <> c then
      Result := Result + s[i];
  end;
end;

function Questionar(mensagem: string): Boolean;
begin
  Result := MessageDlg(mensagem, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

function RetirarPontos(s: string): string;
begin
  Result := RetirarCaracter(s, '.');
end;

procedure CorStatus(var stStatus: TStaticText);
begin
  if stStatus.Caption = 'Pendente' then
    stStatus.Font.Color := clMaroon
  else if stStatus.Caption = 'Aprovada' then
    stStatus.Font.Color := clGreen
  else if stStatus.Caption = 'Concluída' then
    stStatus.Font.Color := clBlue
  else if stStatus.Caption = 'Cancelada' then
    stStatus.Font.Color := clRed;
end;

end.
