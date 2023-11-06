#ifndef SEMANTIC_ANALYZER_H
#define SEMANTIC_ANALYZER_H


typedef struct {
    char* token_type;
    char* value;
} Token;

extern Token* tokens;
extern int num_tokens;



void add_token(const char* type);
void semantic_analysis();

#endif