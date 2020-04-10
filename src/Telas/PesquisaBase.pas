unit PesquisaBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, _FormBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.StdCtrls;

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
    procedure sgPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFormPesquisaBase.FormCreate(Sender: TObject);
begin
  inherited;
  ActiveControl := cbFiltros;
end;

procedure TFormPesquisaBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then begin
    if btnSair.Enabled then
      btnSair.Click;
  end;
end;

procedure TFormPesquisaBase.sgPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    btnOk.Click;
end;

end.
