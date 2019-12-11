MERGE INTO TRIPPIN.PEOPLE T
USING TRIPPIN.PEOPLE_STAGE S
ON
(
    T.USERNAME = S.USERNAME
)
WHEN NOT MATCHED THEN INSERT
(
     USERNAME
    ,FIRSTNAME
    ,LASTNAME
    ,MIDDLENAME
    ,AGE
    ,META_CREATED_AT
    ,META_UPDATED_AT
)
VALUES
(
     S.USERNAME
    ,S.FIRSTNAME
    ,S.LASTNAME
    ,S.MIDDLENAME
    ,S.AGE
    ,TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())
    ,TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())
)
WHEN MATCHED THEN UPDATE
SET
     T.FIRSTNAME = S.FIRSTNAME
    ,T.LASTNAME = S.LASTNAME
    ,T.MIDDLENAME = S.MIDDLENAME
    ,T.AGE = S.AGE
    ,T.META_UPDATED_AT = TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())
;

SELECT "number of rows inserted" AS ROWS_INSERTED, "number of rows updated" AS ROWS_UPDATED FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));