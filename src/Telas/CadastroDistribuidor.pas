unit CadastroDistribuidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CadastroPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormCadastroDistribuidor = class(TFormCadastroPadrao)
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  PesquisaPessoa;

{$R *.dfm}

procedure TFormCadastroDistribuidor.btnPesquisarClick(Sender: TObject);
var
  codigo: Integer;
begin
  inherited;
  codigo := PesquisaPessoa.PesquisarPessoa('DIS');
end;

end.
