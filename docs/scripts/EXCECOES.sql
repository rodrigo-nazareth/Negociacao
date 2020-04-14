CREATE EXCEPTION EXCLUSAO_DISTRIBUID_NEGOCI 'Este distribuidor não pode ser excluído pois está vinculado a uma negociação';
CREATE EXCEPTION EXCLUSAO_DISTRIB_LIMITE 'Este registro não pode ser excluído pois o distribuidor está vinculado ao limite de um produtro';
CREATE EXCEPTION EXCLUSAO_NEGOCIACAO_APROV 'Esta negociação não pode ser excluída pois já está aprovada';
CREATE EXCEPTION EXCLUSAO_NEGOCIACAO_CANC 'Esta negociação não pode ser excluída pois já está cancelada';
CREATE EXCEPTION EXCLUSAO_NEGOCIACAO_CONC 'Esta negociação não pode ser excluída pois já está concluída';
CREATE EXCEPTION EXCLUSAO_PRODUTO 'Este produto não pode ser excluído pois está vinculado a uma negociação';
CREATE EXCEPTION EXCLUSAO_PRODUTOR_LIMITE 'Este registro não pode ser excluído pois o produtor está vinculado ao limite de um distribuidor';
CREATE EXCEPTION EXCLUSAO_PRODUTOR_NEGOCI 'Este produtor não pode ser excluído pois está vinculado a uma negociação';
CREATE EXCEPTION EXCLU_NEGOC_APROVADA 'Somente é permitido excluir uma negociação pendente';