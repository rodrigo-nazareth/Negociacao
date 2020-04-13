unit PesquisaBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, _FormBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.StdCtrls, System.UITypes;

type
  TFormPesquisaBase = class(TFormBase)
    LbFiltros: TLabel;
    LbChave: TLabel;
    cbFiltros: TComboBox;
    eChave: TEdit;
    sgPesquisa: TStringGrid;
    stAtalhos: TStaticText;
    btnOk: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure sgPesquisaDblClick(Sender: TObject);
    procedure sgPesquisaEnter(Sender: TObject);
    procedure sgPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure Ok(Sender: TObject);
  end;

implementation

uses
  Biblioteca;

{$R *.dfm}

procedure TFormPesquisaBase.FormCreate(Sender: TObject);
begin
  inherited;
  ActiveControl := eChave;
  btnOk.OnClick := Ok;
end;

procedure TFormPesquisaBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then begin
    if btnSair.Enabled then
      btnSair.Click;
  end;
end;

procedure TFormPesquisaBase.Ok(Sender: TObject);
begin
  if (sgPesquisa.Cells[0, 1] = '') and (sgPesquisa.Cells[1, 1] = '') then
    Exclamar('Nenhum dado foi selecionado!')
  else
    ModalResult := mrOk;
end;

procedure TFormPesquisaBase.sgPesquisaDblClick(Sender: TObject);
begin
  inherited;
  btnOk.Click;
end;

procedure TFormPesquisaBase.sgPesquisaEnter(Sender: TObject);
begin
  inherited;
  if Trim(eChave.Text) = '' then begin
    MessageDlg('É necessário informar valor para pesquisa!', mtWarning, [mbOK], 0);
    eChave.SetFocus;
    Abort;
  end;

  LimparGrid(sgPesquisa);
end;

procedure TFormPesquisaBase.sgPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    btnOk.Click
  else if Key = 27 then
    btnSair.Click;
end;

end.
