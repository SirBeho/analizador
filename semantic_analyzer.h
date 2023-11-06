#ifndef SEMANTIC_ANALYZER_H
#define SEMANTIC_ANALYZER_H

// Declaración de estructuras de datos y variables globales
typedef struct {
    char* token_type;
    char* value;
} Token;

extern Token* tokens;
extern int num_tokens;

// Funciones del analizador semántico

void add_token(const char* type);
void semantic_analysis();

#endif