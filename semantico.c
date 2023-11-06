#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantic_analyzer.h"

// Declaración de estructuras de datos y variables globales
typedef struct {
    char* token_type;
    char* value;
} Token;

Token* tokens = NULL;
int num_tokens = 0;

// Declaración de la tabla de símbolos para almacenar información de variables
typedef struct {
    char* name;
    char* type;
} SymbolTableEntry;

SymbolTableEntry* symbol_table = NULL;
int symbol_table_size = 0;

void add_symbol(const char* name, const char* type) {
    symbol_table_size++;
    symbol_table = (SymbolTableEntry*)realloc(symbol_table, symbol_table_size * sizeof(SymbolTableEntry));
    symbol_table[symbol_table_size - 1].name = strdup(name);
    symbol_table[symbol_table_size - 1].type = strdup(type);
}


int find_symbol(const char* name) {
    for (int i = 0; i < symbol_table_size; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return i;  // La variable se encuentra en la tabla de símbolos
        }
    }
    return -1; 
}

int is_valid_operation(const char* left_type, const char* right_type, const char operator) {
    if (strcmp(left_type, right_type) == 0) {
        return 1;
    }

    if ((operator == '+' || operator == '-') && (
        (strcmp(left_type, "int") == 0 && strcmp(right_type, "int") == 0) ||
        (strcmp(left_type, "float") == 0 && strcmp(right_type, "float") == 0))) {
        return 1;
    }

    if ((operator == '*' || operator == '/') && (
        (strcmp(left_type, "int") == 0 && strcmp(right_type, "int") == 0) ||
        (strcmp(left_type, "float") == 0 && strcmp(right_type, "float") == 0))) {
        return 1;
    }

    if (operator == '+' && (
        (strcmp(left_type, "string") == 0 && strcmp(right_type, "string") == 0))) {
        return 1;
    }

    if (operator == '=' && (
        (strcmp(left_type, "int") == 0 && (strcmp(right_type, "int") == 0 || strcmp(right_type, "float") == 0)) ||
        (strcmp(left_type, "float") == 0 && (strcmp(right_type, "int") == 0 || strcmp(right_type, "float") == 0)) ||
        (strcmp(left_type, "string") == 0 && strcmp(right_type, "string") == 0))) {
        return 1;
    }

    return 0; 
}

// Función principal del analizador semántico
void semantic_analysis() {
    for (int i = 0; i < num_tokens; i++) {
        if (strcmp(tokens[i].token_type, "IDENTIFICADOR") == 0) {
            const char* variable_name = tokens[i].value;
            int symbol_index = find_symbol(variable_name);
            if (symbol_index == -1) {
                printf("Error semántico: Variable no declarada - %s\n", variable_name);
            }
        }

        if (strcmp(tokens[i].token_type, "DECLARACION") == 0) {
            const char* variable_type = tokens[i - 1].value;
            const char* variable_name = tokens[i].value;
            int symbol_index = find_symbol(variable_name);
            if (symbol_index != -1) {
                printf("Error semántico: Variable ya declarada - %s\n", variable_name);
            } else {
                add_symbol(variable_name, variable_type);
            }
        }

        if (strcmp(tokens[i].token_type, "SUMA") == 0 || strcmp(tokens[i].token_type, "RESTA") == 0) {
            char* left_type = NULL;
            char* right_type = NULL;
            int j = i - 1;
            while (j >= 0 && (strcmp(tokens[j].token_type, "IDENTIFICADOR") == 0 || strcmp(tokens[j].token_type, "NUMERO") == 0)) {
                j--;
            }
            if (j >= 0) {
                const char* left_variable_name = tokens[j].value;
                int left_symbol_index = find_symbol(left_variable_name);
                if (left_symbol_index != -1) {
                    left_type = symbol_table[left_symbol_index].type;
                }
            }
            j = i + 1;
            while (j < num_tokens && (strcmp(tokens[j].token_type, "IDENTIFICADOR") == 0 || strcmp(tokens[j].token_type, "NUMERO") == 0)) {
                j++;
            }
            if (j < num_tokens) {
                const char* right_variable_name = tokens[j].value;
                int right_symbol_index = find_symbol(right_variable_name);
                if (right_symbol_index != -1) {
                    right_type = symbol_table[right_symbol_index].type;
                }
            }
            if (!is_valid_operation(left_type, right_type, tokens[i].value[0])) {
                printf("Error semántico: Incompatibilidad de tipos en la operación - %s %s %s\n", left_type, tokens[i].value, right_type);
            }
        }

    }
}

