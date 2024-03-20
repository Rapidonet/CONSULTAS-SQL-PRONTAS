/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORACESSO
                       Data da última modificação: 22/01/24
					   

  Descrição: Busca a última marcação de cada funcionário

------------------------------------------------------------------------------------------------------------------ */

WITH ULTIMO_ACESSO AS (
    SELECT
        M.MATR_MATRICULA "MATRÍCULA",
        P.PESS_NOME "NOME",
        P.PESS_DOCUMENTOUNICO "CPF",
        E.EMPR_NOME "CONTRATADA",
        E.EMPR_CNPJ "CNPJ",
        CASE WHEN M.MATR_ATIVO = '1' THEN 'ATIVO' WHEN M.MATR_ATIVO = '0' THEN 'INATIVO' END AS "SITUAÇÃO",
        CONVERT(varchar, EV.EVEN_MOMENTO, 103  ) AS "MARCAÇÃO",
        ROW_NUMBER() OVER (PARTITION BY M.MATR_MATRICULA ORDER BY EV.EVEN_MOMENTO DESC) AS LINHA
    FROM
        FORACESSO.MATRICULADO M
        INNER JOIN FORACESSO.PESSOA P ON P.PESS_ID = M.PESS_ID
        INNER JOIN FORACESSO.EMPRESA E ON E.EMPR_GRUPO = M.EMPR_GRUPO
        INNER JOIN FORACESSO.MATRICULADO_ALOCACAO MA ON M.MATR_ID = MA.MATR_ID AND E.EMPR_ID = MA.EMPR_ID
        INNER JOIN FORACESSO.EVENTO EV ON EV.MATR_ID = M.MATR_ID
)
SELECT
    "MATRÍCULA",
    "NOME",
    "CPF",
    "CONTRATADA",
    "CNPJ",
    "SITUAÇÃO",
    "MARCAÇÃO" AS "ÚLTIMA MARCAÇÃO"
FROM ULTIMO_ACESSO
WHERE LINHA = 1
ORDER BY 2 ASC;
