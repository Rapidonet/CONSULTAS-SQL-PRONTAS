/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 26/09/2023
					   

  Descrição: Imprime os dados dos visitantes que ainda estão com o crachá em uso.

------------------------------------------------------------------------------------------------------------------ */

SELECT * FROM FORACESSO.VISITANTE
WHERE VISI_COD_CRACHA IS NULL AND VISI_DAT_VALIDADE > GETDATE() AND VISI_DAT_BAIXA IS NULL