/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 26/09/2023
					   

  Descrição: Imprime os terceiros que estão ativos

------------------------------------------------------------------------------------------------------------------ */

SELECT CONT_COD_MATRICULA, CONT_NOM_NOME FROM FORACESSO.CONTRATADO
WHERE CONT_DAT_FINAL > GETDATE()