/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORACESSO
                       Data da �ltima modifica��o: 20/03/24

  Descri��o: Relat�rio de acessos que imprime as matr�culas que n�o tem 38 nem 62 no in�cio.

------------------------------------------------------------------------------------------------------------------ */

SELECT P.PESS_NOME, M.MATR_MATRICULA
FROM FORACESSO.MATRICULADO M
INNER JOIN FORACESSO.PESSOA P ON P.PESS_ID = M.MATR_ID
WHERE SUBSTRING(M.MATR_MATRICULA, 1, 2) NOT IN ('38', '62');
