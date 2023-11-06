#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantic_analyzer.h"

// Función para verificar la compatibilidad de tipos en operaciones
int is_valid_operation(const char* left_type, const char* right_type, const char operator) {
    // Implementa la lógica de compatibilidad de tipos aquí
    return 1;  // Supongamos que todas las operaciones son válidas
}

// Función principal del analizador semántico
void semantic_analysis() {
    for (int i = 0; i < num_tokens; i++) {
        if (strcmp(tokens[i].token_type, "IDENTIFICADOR") == 0) {
            // Realiza aquí comprobaciones semánticas de variables no declaradas o fuera de ámbito
        }

        // Resto de tu lógica semántica...
    }
}


