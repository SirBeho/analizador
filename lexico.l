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
    // Leer tokens de tu analizador léxico (modifica esta parte según tu implementación)
    // Asume que has llenado el arreglo "tokens" correctamente.
    yyparse();

    // Realizar el análisis semántico
    semantic_analysis();

    // Imprimir los tokens (para fines de depuración)
    for (int i = 0; i < num_tokens; i++) {
        printf("Token Type: %s, Value: %s\n", tokens[i].token_type, tokens[i].value);
    }

    // Liberar memoria (asegúrate de liberar adecuadamente la memoria asignada a los tokens y valores)
    for (int i = 0; i < num_tokens; i++) {
        free(tokens[i].token_type);
        free(tokens[i].value);
    }
    free(tokens);

    return 0;
}