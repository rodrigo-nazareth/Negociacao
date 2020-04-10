program Negociacao;

uses
  Forms,
  Principal in 'Telas\Principal.pas' {FormPrincipal},
  _ConexaoBanco in 'Biblioteca\_ConexaoBanco.pas',
  Ambiente in 'Biblioteca\Ambiente.pas',
  Biblioteca in 'Biblioteca\Biblioteca.pas',
  Cadastro in 'Telas\Cadastro.pas' {FormCadastro},
  CadastroProdutor in 'Telas\CadastroProdutor.pas' {FormCadastroProdutor},
  CadastroDistribuidor in 'Telas\CadastroDistribuidor.pas' {FormCadastroDistribuidor},
  CadastroNegociacao in 'Telas\CadastroNegociacao.pas' {FormCadastroNegociacao},
  CadastroProduto in 'Telas\CadastroProduto.pas' {FormCadastroProduto},
  PesquisaNegociacao in 'Telas\PesquisaNegociacao.pas' {FormPesquisaNegociacao},
  PesquisaProduto in 'Telas\PesquisaProduto.pas' {FormPesquisaProduto},
  PesquisaPessoa in 'Telas\PesquisaPessoa.pas' {FormPesquisaPessoa},
  RelacaoNegociacoes in 'Telas\RelacaoNegociacoes.pas' {FormRelacaoNegociacoes},
  ManutencaoNegociacao in 'Telas\ManutencaoNegociacao.pas' {FormManutencaoNegociacao};

{$R *.RES}

begin
//  Ambiente.IniciarAplicacao;

  Application.Initialize;
  Application.MainFormOnTaskBar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
