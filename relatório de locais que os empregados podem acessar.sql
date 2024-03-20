/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 27/10/2023

  Descrição: Imprime os locais que os empregados podem acessar.

------------------------------------------------------------------------------------------------------------------ */

SELECT  E.DFFUNCRACHA "CRACHÁ", E.DFFUNNOME "NOME", LP.LOCA_COD_LOCAL, L.LOCA_TXT_DESCRICAO FROM FORACESSO.CRACHA C
INNER JOIN FORACESSO.EMPREGADO E ON C.CRAC_COD_CRACHA = SUBSTRING(E.DFFUNCRACHA, 4, 15)
INNER JOIN FORACESSO.GRUPO G ON C.CRAC_COD_GRUPO = G.GRUP_COD_GRUPO
INNER JOIN FORACESSO.ACESSO_LOCAL AL ON G.GRUP_COD_GRUPO = AL.ACLO_COD_GRUPO
INNER JOIN FORACESSO.LOCAL_PONTO LP ON AL.ACLO_COD_LOCAL = LP.LOCA_COD_LOCAL AND C.CRAC_COD_CRACHA = LP.CRAC_COD_CRACHA 
INNER JOIN FORACESSO.LOCAL L ON L.LOCA_COD_LOCAL = LP.LOCA_COD_LOCAL