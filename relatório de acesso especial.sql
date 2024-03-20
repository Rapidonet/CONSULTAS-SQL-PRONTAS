/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORACESSO
                       Data da �ltima modifica��o: 05/09/2023

  Descri��o: Imprime informa��es do acesso especial: matr�cula, nome, perfil de acesso, empresa, data in�cio e fim
             do acesso, bem como quem liberou e a justificativa da permiss�o.

------------------------------------------------------------------------------------------------------------------ */

SELECT M.MATR_MATRICULA "MATR�CULA", 
	   P.PESS_NOME "NOME",
	   PA.PEAC_DESCRICAO "PERFIL_ACESSO",
	   ISNULL(C.CNTR_DESCRICAO, '1 - MINERA��O MARAC� IND.COM. S/A') "EMPRESA",
	   CONVERT(varchar, AE.ACES_INICIO, 103) "DATA IN�CIO",
	   CONVERT(varchar, AE.ACES_INICIO, 108) "HORA",
	   CONVERT(varchar, AE.ACES_TERMINO, 103) "DATA FIM",
	   CONVERT(varchar, AE.ACES_TERMINO, 108) "HORA",
	   LA.LOCA_NOME "LOCAL",
	   RMD.REMD_USUARIO "USU�RIO",
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

