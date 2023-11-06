%{
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "sintactico.tab.h"
#include "semantic_analyzer.h"
%}

%option case-insensitive
%option noyywrap

%%

[\t \n \r] ;

(int|char|float|double|bool|void) {
    yylval.str = strdup(yytext);
    return TIPO_DE_DATO;
}

"if" {
    yylval.str = strdup(yytext);
    return PALABRA_RESERVADA;
}

[a-zA-Z][a-zA-Z0-9_]* {
    yylval.str = strdup(yytext);
    return IDENTIFICADOR;
}

[0-9]+(\.[0-9]+)? {
    yylval.str = strdup(yytext);
    return NUMERO;
}

"=" {
   yylval.str = strdup(yytext);
    return SIMBOLO_ASIGNACION;
}

("=="|"<"|">"|"<="|">=") {
    yylval.str = strdup(yytext);
    return COMPARACION;
}

";" {
    return FIN;
}

[\{\}\[\]\(\)] {
    yylval.str = strdup(yytext);
    return *yytext;
}

[-+*/] {
    return *yytext;
}

. {
    fprintf(stderr, "Caracter no reconocido: %s\n", yytext);
}

void print_tokens();

int yyparse(void);

int main() {
 
    yyparse();

   
    semantic_analysis();

    print_tokens()

   
    for (int i = 0; i < num_tokens; i++) {
        free(tokens[i].token_type);
        free(tokens[i].value);
    }
    free(tokens);

    

    return 0;
}