unit RelacaoNegociacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, _FormBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids;

type
  TFormRelacaoNegociacoes = class(TFormBase)
    pcRelacaoNegociacao: TPageControl;
    tsFiltros: TTabSheet;
    tsResultado: TTabSheet;
    BitBtn1: TBitBtn;
    sgResultado: TStringGrid;
    stAtalhos: TStaticText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFormRelacaoNegociacoes.FormCreate(Sender: TObject);
begin
  inherited;
  pcRelacaoNegociacao.ActivePage := tsFiltros;
end;

end.
