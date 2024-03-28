/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Thierry Santos | thierry@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 27/03/24

  Descrição: Imprime as matrículas que tem acessos em um intervalo menor de 30 segundos de uma para outra.

------------------------------------------------------------------------------------------------------------------ */

SELECT * FROM 
(SELECT  MAT.MATR_MATRICULA MATRICULA ,
	PES.PESS_NOME NOME,
	CONVERT(VARCHAR,EVEN_MOMENTO,103) DATA_EVENTO,
	SUBSTRING(CONVERT(VARCHAR, EVEN_MOMENTO,108),1,5) HORA_EVENTO,
	DATEDIFF(SECOND, LAG(EVEN_MOMENTO) OVER (PARTITION BY MAT.MATR_MATRICULA ORDER BY EVEN_MOMENTO), EVEN_MOMENTO) AS DiferencaMinutos
	FROM FORACESSO.EVENTO EVE
INNER JOIN FORACESSO.MATRICULADO MAT ON
	EVE.MATR_ID = MAT.MATR_ID
INNER JOIN FORACESSO.PESSOA PES ON 
	PES.PESS_ID = MAT.PESS_ID
WHERE EVEN_CATEGORIA = 7 AND CONVERT(DATE,EVEN_MOMENTO) = :DATADOEVENTO) TOTAL
WHERE DiferencaMinutos <= 30