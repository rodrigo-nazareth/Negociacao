unit RelacaoNegociacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, _FormBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids, FrameBasePesquisa;

type
  TFormRelacaoNegociacoes = class(TFormBase)
    pcRelacaoNegociacao: TPageControl;
    tsFiltros: TTabSheet;
    tsResultado: TTabSheet;
    sgResultado: TStringGrid;
    stAtalhos: TStaticText;
    frProdutor: TFramePesquisa;
    frDistribuidor: TFramePesquisa;
    cbFiltros: TComboBox;
    Label1: TLabel;
    sbImprimir: TSpeedButton;
    btnProcessar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure sbImprimirClick(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  Biblioteca, _Negociacao, Ambiente;

const
  cNegociacao         = 0;
  cProdutor           = 1;
  cDistribuidor       = 2;
  cDt_Cadastro        = 3;
  cDt_Aprovacao       = 4;
  cData_Conclusão     = 5;
  cData_Cancelamento  = 6;
  cTotal_Negociacao   = 7;

{$R *.dfm}

procedure TFormRelacaoNegociacoes.btnProcessarClick(Sender: TObject);
var
  filtros: string;
  negociacoes: TArrayOfWebNegociacao;
begin
  inherited;
  filtros := ' where 1=1 '

  if cbFiltros.ItemIndex <> 4 then begin
    filtros := filtros + ' and NEG.STATUS = ';
    if cbFiltros.ItemIndex = 0 then
      filtros := filtros + QuotedStr('PEN')
    else if cbFiltros.ItemIndex = 1 then
      filtros := filtros + QuotedStr('APR')
    else if cbFiltros.ItemIndex = 3 then
      filtros := filtros + QuotedStr('CON')
    else if cbFiltros.ItemIndex = 4 then
      filtros := filtros + QuotedStr('CAN');
  end;

  if not frProdutor.EstaVazio then
    filtros := filtros + ' and NEG.PRODUTOR_ID = ' + StrToInt(frProdutor.GetCodigo);

  if not frDistribuidor.EstaVazio then
    filtros := filtros + ' and NEG.PRODUTOR_ID = ' + StrToInt(frProdutor.GetCodigo);

  negociacoes := _Negociacao.BuscarNegociacoesRelatorio(Ambiente.con_banco, filtros);
//  cNegociacao         = 0;
//  cProdutor           = 1;
//  cDistribuidor       = 2;
//  cDt_Cadastro        = 3;
//  cDt_Aprovacao       = 4;
//  cData_Conclusão     = 5;
//  cData_Cancelamento  = 6;
//  cTotal_Negociacao   = 7;
end;

procedure TFormRelacaoNegociacoes.FormCreate(Sender: TObject);
begin
  inherited;
  pcRelacaoNegociacao.ActivePage := tsFiltros;
  IniciarGrid(
    sgResultado,
    [
      'Negociação',
      'Produtor',
      'Distribuidor',
      'Dt cadastro',
      'Dt aprovação',
      'Data conclusão',
      'Data cancelamento',
      'Total negociação'
    ]
  );
end;

procedure TFormRelacaoNegociacoes.sbImprimirClick(Sender: TObject);
begin
  inherited;
//  cNegociacao         = 0;
//  cProdutor           = 1;
//  cDistribuidor       = 2;
//  cDt_Cadastro        = 3;
//  cDt_Aprovacao       = 4;
//  cData_Conclusão     = 5;
//  cData_Cancelamento  = 6;
//  cTotal_Negociacao   = 7;
end;

end.
