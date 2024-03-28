/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 05/09/2023

  Descrição: Imprime informações do acesso especial: matrícula, nome, perfil de acesso, empresa, data início e fim
             do acesso, bem como quem liberou e a justificativa da permissão.

  Obs.: Gentileza prestar atenção onde irá rodar a consulta sql, veja que tem o campo:
        ISNULL(C.CNTR_DESCRICAO, '1 - MINERAÇÃO MARACÁ IND.COM. S/A') "EMPRESA", que substitui
	os campos nulos pelo nome da empresa escolhida na hora da criação do script.

------------------------------------------------------------------------------------------------------------------ */

SELECT M.MATR_MATRICULA "MATRÍCULA", 
	   P.PESS_NOME "NOME",
	   PA.PEAC_DESCRICAO "PERFIL_ACESSO",
	   ISNULL(C.CNTR_DESCRICAO, '1 - MINERAÇÃO MARACÁ IND.COM. S/A') "EMPRESA",
	   CONVERT(varchar, AE.ACES_INICIO, 103) "DATA INÍCIO",
	   CONVERT(varchar, AE.ACES_INICIO, 108) "HORA",
	   CONVERT(varchar, AE.ACES_TERMINO, 103) "DATA FIM",
	   CONVERT(varchar, AE.ACES_TERMINO, 108) "HORA",
	   LA.LOCA_NOME "LOCAL",
	   RMD.REMD_USUARIO "USUÁRIO",
	   MPE.MPES_JUSTIFICATIVA "JUSTIFICATIVA"
FROM FORACESSO.EVENTO E
INNER JOIN FORACESSO.MATRICULADO M ON M.PESS_ID = E.PESS_ID 
INNER JOIN FORACESSO.PESSOA P ON P.PESS_ID = E.PESS_ID 
INNER JOIN FORACESSO.MATRICULADO_PERFIL_ACESSO MPA ON M.MATR_ID = MPA.MATR_ID AND MPA.MAPA_TERMINO IS NULL
INNER JOIN FORACESSO.PERFIL_ACESSO PA ON MPA.PEAC_ID = PA.PEAC_ID
LEFT JOIN FORACESSO.CONTRATO C ON C.CNTR_ID = M.CNTR_ID 
INNER JOIN FORACESSO.ACESSO_ESPECIAL AE ON AE.MATR_ID = M.MATR_ID
INNER JOIN FORACESSO.LOCAL_ACESSO LA ON LA.LOCA_ID = E.LOCA_ID
LEFT JOIN FORACESSO.MATRICULADO_PERMISSAO_ESPECIAL MPE ON MPE.MATR_ID = M.MATR_ID AND E.MPES_ID = MPE.MPES_ID
LEFT JOIN FORACESSO.REGISTRO_MOV_DADOS RMD ON SUBSTRING(RMD.REMD_CHAVE, 3, 50) = M.MATR_MATRICULA 
AND REMD_ATRIBUTO = 'PermissoesEspeciais' AND REMD_OPERACAO = 'Inclusao'
WHERE E.EVEN_TIPO IN ('17001', '17004') AND LA.LOCA_NOME = :LOCALNOME AND E.EVEN_MOMENTO BETWEEN :1DATAINI AND :2DATAFIM

