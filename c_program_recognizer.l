%{
int isMainOk = 0;
int isVariableDeclared = 0;
%}


word [_A-Za-z]+
digit [0-9]
digits [0-9]*
variableName (_{digits}|{word})({word}|{digits})*
dataType (int|float)
variableDeclare ({dataType}|(char)|(bool))[ ]+{variableName}([ ]*[=][ ]*{digit}{digits})?[;]([\n]|[ ])*
multiVariable {dataType}[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=]{digit}{digits})*[;]([\n]|[ ])*
multiChar (char)[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=][ ]*["][a-zA-Z0-9][ ]*["][ ]*)*[;]([\n]|[ ])*
multiBool (bool)[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=][ ]*(true|false)[ ]*)*[;]([\n]|[ ])*

mainStart {dataType}[ ]*(main)[ ]*[(][ ]*[)][\n]*[{]([ ]|[\n])*
bakiSobRules ({variableDeclare}|{multiVariable}|{multiChar}|{multiBool})*
mainEnd ([ ]|[\n])*(return[ ]+[-]?[0-9]*;)([ ]|[\n])*[}]

program {mainStart}{bakiSobRules}{mainEnd}

%%
{program}   {
                printf("Your source code is OK :)");
            }
%%


int a,b=30,c=99,d;

int yywrap()
{

}

int main()
{
    yyin=fopen("input.txt","r");
    yylex();
}
