unit _FormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  TFormBase = class(TForm)
    pnBotoes: TPanel;
    btnSair: TBitBtn;
    procedure TeclaEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SoNumerosInt(Sender: TObject; var Key: Char);
    procedure SoNumerosDbl(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormatarCampoValorDbl(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBase: TFormBase;

implementation

uses
  Biblioteca;

{$R *.dfm}

{ TFormBase }

procedure TFormBase.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBase.SoNumerosDbl(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9',',','.']) then
    key := #0;
end;

procedure TFormBase.SoNumerosInt(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9']) then
    key := #0;
end;

procedure TFormBase.FormatarCampoValorDbl(Sender: TObject);
begin
  if Sender is TEdit then
    TEdit(Sender).Text := FormatoMilharStr(Valor(TEdit(Sender).Text));
end;

procedure TFormBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormBase.FormCreate(Sender: TObject);
begin
  btnSair.OnClick := btnSairClick;
end;

procedure TFormBase.TeclaEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    PerForm(40,0,0);
end;

end.
