/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 12/03/24

  Descrição: Relatório de acessos que imprime os tipos de registro de acesso (entrada ou saída)

------------------------------------------------------------------------------------------------------------------ */


SELECT M.MATR_MATRICULA "MATRÍCULA", P.PESS_NOME "NOME", EMP.EMPR_NOME "EMPRESA",
CONVERT(VARCHAR, E.EVEN_MOMENTO, 103) "DATA",  CONVERT(VARCHAR, E.EVEN_MOMENTO, 108) "HORA", 
CASE WHEN E.EVEN_DIRECAO = '1' THEN 'ENTRADA'
     WHEN E.EVEN_DIRECAO = '2' THEN 'SAÍDA' END AS "REGISTRO DE ACESSO", LA.LOCA_NOME
FROM foracesso.EVENTO E
INNER JOIN foracesso.MATRICULADO M ON M.PESS_ID = E.PESS_ID AND M.MATR_ID = E.MATR_ID
INNER JOIN foracesso.PESSOA P ON P.PESS_ID = M.PESS_ID AND P.PESS_ID = E.PESS_ID
INNER JOIN foracesso.MATRICULADO_ALOCACAO MA ON MA.MATR_ID = M.MATR_ID AND MA.MAAL_TERMINO IS NULL
INNER JOIN foracesso.EMPRESA EMP ON EMP.EMPR_ID = MA.EMPR_ID
INNER JOIN foracesso.LOCAL_ACESSO LA ON LA.LOCA_ID = E.LOCA_ID
WHERE E.EVEN_TIPO IN ('17001','17003', '17004') AND CAST(E.EVEN_MOMENTO AS DATE) BETWEEN :DATA1 AND :DATA2
ORDER BY 2

