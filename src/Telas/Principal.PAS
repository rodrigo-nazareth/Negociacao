unit Principal;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, System.ImageList, System.Actions, Data.FMTBcd, Data.DB,
  Data.SqlExpr, ADODB2000, _ConexaoBanco, Data.DBXFirebird, Ambiente, System.UITypes;

type
  TFormPrincipal = class(TForm)
    StatusBar: TStatusBar;
    mmPrincipal: TMainMenu;
    miCadastros: TMenuItem;
    miProdutor: TMenuItem;
    miDistribuidor: TMenuItem;
    miProduto: TMenuItem;
    miSair: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPprocedure TFormPrincipal.Button3Click(Sender: TObject);
begin

end;

rincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  for i := 0 to Screen.FormCount - 1 do begin
    if Screen.Forms[i].Name <> Self.Name then begin
      MessageDlg('Ainda existem telas abertas na aplicação!', mtWarning, [mbOK], 0);
      Screen.Forms[i].WindowState := wsNormal;
      Screen.Forms[i].BringToFront;
      Screen.Forms[i].SetFocus;
      Abort;
    end;
  end;

  if Application.MessageBox('Tem certeza que deseja encerrar a aplicação?', 'Questionamento', MB_YESNO + MB_ICONQUESTION) = mrYes then
    Application.Terminate
  else
    Abort;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := FormatDateTime('dd/mm/yyyy',Now);
end;

procedure TFormPrincipal.miSairClick(Sender: TObject);
begin
  Close;
end;

end.
