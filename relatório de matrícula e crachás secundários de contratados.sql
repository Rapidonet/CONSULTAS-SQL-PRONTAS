/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 02/10/2023

  Descrição: Imprime a matrícula e os crachás secundários dos contratados.

------------------------------------------------------------------------------------------------------------------ */

SELECT DISTINCT C.CONT_COD_MATRICULA, C.CONT_NOM_NOME, E.ESTA_NOM_EMPRESA
FROM FORACESSO.CONTRATADO C
INNER JOIN FORACESSO.MARCACAO M ON M.MARC_COD_MATRICULA = C.CONT_COD_MATRICULA
INNER JOIN FORACESSO.EMPRESA E ON E.ESTA_COD_EMPRESA = C.ESTA_COD_EMPRESA
WHERE M.MARC_DAT_MARCACAO >= DATEADD(DAY, -30, GETDATE())