%{
#include <stdio.h>
%}

DIGITO   [0-9]
LETRA    [a-zA-Z]
NUMERO   {DIGITO}+
OPERADOR [+*-/]
IDENTIFICADOR {LETRA}(({LETRA}|{DIGITO}|_)*)

%%

(int|char|float|double|bool|void) {
    printf("%-10s Palabra reservada: Tipo de dato: %s \n", yytext, yytext);
}

(for|while|do) {
    printf("%-10s Palabra reservada: ciclo %s \n", yytext, yytext);
}

(return|break|continue|switch|case|default) {
    printf("%-10s Palabra reservada: %s \n", yytext, yytext);
}

(if|else|elseif) {
    printf("%-10s Palabra reservada: condicional %s \n", yytext, yytext);
}


main {
    printf("%-10s Función principal: main \n", yytext);
}

{IDENTIFICADOR} {
    printf("%-10s Identificador\n", yytext);
}

{NUMERO} {
    printf("%-10s Número\n", yytext, yytext);
}

{NUMERO}\.{NUMERO} {
    printf("%-10s Número decimal\n", yytext, yytext);
}

-?{NUMERO} {
    printf("%-10s Número negativo\n", yytext, yytext);
}

-?{NUMERO}\.{NUMERO} {
    printf("%-10s Número decimal negativo\n", yytext, yytext);
}

\+ {
    printf("%-10s Operador suma\n", yytext);
}

\++ {
    printf("%-10s Operador incremento\n", yytext);
}

\- {
    printf("%-10s Operador resta\n", yytext);
}


\-- {
    printf("%-10s Operador decremento\n", yytext);
}

\* {
    printf("%-10s Operador multiplicacion\n", yytext);
}

\/ {
   printf("%-10s Operador division\n", yytext);
}


\% {
    printf("%-10s Operador modulo\n", yytext);
}

! {
    printf("%-10s Operador lógico: NOT\n", yytext);
}

\{ {
    printf("%-10s Símbolo de apertura de llave: \n", yytext);
}

\} {
    printf("%-10s Símbolo de cierre de llave:\n", yytext);
}

\[ {
    printf("%-10s Símbolo de apertura de corchete\n", yytext);
}

\] {
    printf("%-10s Símbolo de cierre de corchete \n", yytext);
}

\( {
    printf("%-10s Símbolo de apertura de paréntesis\n", yytext);
}

\) {
    printf("%-10s Símbolo de cierre de paréntesis \n", yytext);
}

= {
    printf("%-10s Operador de asignacion \n", yytext);
}

== {
    printf("%-10s Operador de comparación: \n", yytext);
}

!= {
    printf("%-10s Operador de comparación: \n", yytext);
}

[ \t\n] {
    // Ignorar espacios en blanco y saltos de línea
}

. {
    printf("%-10s Carácter no reconocido\n", yytext);
}

%%

int main() {
    yylex();
    return 0;
}