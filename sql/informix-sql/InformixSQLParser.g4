/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2023 by 455741807@qq.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
 * associated documentation files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge, publish, distribute,
 * sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
 * NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Project : InformixSQLParser; an ANTLR4 grammar for Informix database SQL language,
 * see as https://www.ibm.com/docs/en/informix-servers/14.10?topic=programming-guide-sql-syntax
 */

parser grammar InformixSQLParser;

options {
    tokenVocab = InformixSQLLexer;
}

sqlScript
    : unitStatement* EOF
    ;

unitStatement
    : (createRole
    | dropAccessMethod
    | dropAggregate
    | dropDatabase
    | dropIndex
    | dropRole
    | dropSynonym
    | dropTable
    | dropTrigger
    | dropTrustedContext
    | dropType
    | dropUser
    | dropView
    | dropXadatasource
    | dropXadataTypeSource
    | databaseStmt
    | closeStmt
    | closeDatabaseStmt
    | commitWorkStmt
    ) SCOL
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-create-role-statement
createRole
    : CREATE ROLE (IF NOT EXISTS)? roleName=anyName
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-role-statement
dropRole
    : DROP ROLE (IF EXISTS)? roleName=anyName
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-synonym-statement
dropSynonym
    : DROP SYNONYM (IF EXISTS)? synonymName=identifier
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-table-statement
dropTable
    : DROP TABLE (IF EXISTS)? tableName=identifier (CASCADE | RESTRICT)?
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-trigger-statement
dropTrigger
    : DROP TRIGGER (IF EXISTS)? triggerName=identifier
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-trusted-context-statement
dropTrustedContext
    : DROP TRUSTED CONTEXT contextName=anyName
    ;
//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-type-statement
dropType
    : DROP TYPE (IF EXISTS)? dataTypeName=identifier RESTRICT
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-user-statement-unix-linux
dropUser
    : DROP USER userName=anyName
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-view-statement
dropView
    : DROP VIEW (IF EXISTS)? viewName=identifier (CASCADE | RESTRICT)?
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-xadatasource-statement
dropXadatasource
    : DROP XADATASOURCE (IF EXISTS)? xaSourceName=identifier RESTRICT
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-xadatasource-type-statement
dropXadataTypeSource
    : DROP XADATASOURCE TYPE (IF EXISTS)? xaSourceName=identifier RESTRICT
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-access-method-statement
dropAccessMethod
    : DROP ACCESS_METHOD (IF EXISTS)? accessMethodName=identifier RESTRICT
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-aggregate-statement
dropAggregate
    : DROP AGGREGATE (IF EXISTS)? aggregateName=identifier
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-database-statement
dropDatabase
    : DROP DATABASE (IF EXISTS)? databaseName=identifier
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-drop-index-statement
dropIndex
    : DROP INDEX (IF EXISTS)? indexName=identifier ONLINE?
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-close-statement
closeStmt
    : CLOSE cursorId=identifier
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-close-database-statement
closeDatabaseStmt
    : CLOSE DATABASE
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-database-statement
databaseStmt
    : DATABASE databaseName=anyName EXCLUSIVE?
    ;

//https://www.ibm.com/docs/en/informix-servers/14.10?topic=statements-commit-work-statement
commitWorkStmt
    : COMMIT WORK?
    ;

anyName
    : IDENTIFIER
    | keyword
    | STRING_LITERAL
    | OPEN_PAR anyName CLOSE_PAR
    ;

identifier
    : anyName ('.' anyName)*
    ;

keyword
    : ABORT
    | ACTION
    | ACCESS_METHOD
    | ADD
    | AFTER
    | AGGREGATE
    | ALL
    | ALTER
    | ANALYZE
    | AND
    | AS
    | ASC
    | ATTACH
    | AUTOINCREMENT
    | BEFORE
    | BEGIN
    | BETWEEN
    | BY
    | CASCADE
    | CASE
    | CAST
    | CHECK
    | CLOSE
    | COLLATE
    | COLUMN
    | COMMIT
    | CONFLICT
    | CONSTRAINT
    | CONTEXT
    | CREATE
    | CROSS
    | CURRENT_DATE
    | CURRENT_TIME
    | CURRENT_TIMESTAMP
    | DATABASE
    | DEFAULT
    | DEFERRABLE
    | DEFERRED
    | DELETE
    | DESC
    | DETACH
    | DISTINCT
    | DROP
    | EACH
    | ELSE
    | END
    | ESCAPE
    | EXCEPT
    | EXCLUSIVE
    | EXISTS
    | EXPLAIN
    | FAIL
    | FOR
    | FOREIGN
    | FROM
    | FULL
    | GLOB
    | GROUP
    | HAVING
    | IF
    | IGNORE
    | IMMEDIATE
    | IN
    | INDEX
    | INDEXED
    | INITIALLY
    | INNER
    | INSERT
    | INSTEAD
    | INTERSECT
    | INTO
    | IS
    | ISNULL
    | JOIN
    | KEY
    | LEFT
    | LIKE
    | LIMIT
    | MATCH
    | NATURAL
    | NO
    | NOT
    | NOTNULL
    | NULL
    | OF
    | OFFSET
    | ON
    | ONLINE
    | OR
    | ORDER
    | OUTER
    | PLAN
    | PRAGMA
    | PRIMARY
    | QUERY
    | RAISE
    | RECURSIVE
    | REFERENCES
    | REGEXP
    | REINDEX
    | RELEASE
    | RENAME
    | REPLACE
    | RESTRICT
    | RIGHT
    | ROLLBACK
    | ROW
    | ROWS
    | SAVEPOINT
    | SELECT
    | SET
    | SYNONYM
    | TABLE
    | TEMP
    | TEMPORARY
    | THEN
    | TO
    | TRANSACTION
    | TRIGGER
    | TRUSTED
    | TYPE
    | UNION
    | UNIQUE
    | UPDATE
    | USER
    | USING
    | VACUUM
    | VALUES
    | VIEW
    | VIRTUAL
    | WHEN
    | WHERE
    | WITH
    | WITHOUT
    | WORK
    | XADATASOURCE
    | FIRST_VALUE
    | OVER
    | PARTITION
    | RANGE
    | PRECEDING
    | UNBOUNDED
    | CURRENT
    | FOLLOWING
    | CUME_DIST
    | DENSE_RANK
    | LAG
    | LAST_VALUE
    | LEAD
    | NTH_VALUE
    | NTILE
    | PERCENT_RANK
    | RANK
    | ROW_NUMBER
    | GENERATED
    | ALWAYS
    | STORED
    | TRUE
    | FALSE
    | WINDOW
    | NULLS
    | FIRST
    | LAST
    | FILTER
    | GROUPS
    | EXCLUDE
;