/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 20/03/24

  Descrição: Relatório de acessos que imprime as matrículas que não tem 38 nem 62 no início.

------------------------------------------------------------------------------------------------------------------ */

SELECT P.PESS_NOME, M.MATR_MATRICULA
FROM FORACESSO.MATRICULADO M
INNER JOIN FORACESSO.PESSOA P ON P.PESS_ID = M.MATR_ID
WHERE SUBSTRING(M.MATR_MATRICULA, 1, 2) NOT IN ('38', '62');
