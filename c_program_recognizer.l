%{
    int isMainStarted = 0;
    int error = 0;
%}


word [_A-Za-z]+
digit [0-9]
digits [0-9]*
variableName (_{digits}|{word})({word}|{digits})*
dataType (int|float)
multiVariable {dataType}[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=]{digit}{digits})*[;]([\n]|[ ])*
mainStart {dataType}[ ]+(main)[ ]*[(][ ]*[)][\n]*[{]([ ]|[\n])*
multiChar (char)[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=][ ]*["][a-zA-Z0-9][ ]*["][ ]*)*[;]([\n]|[ ])*
multiBool (bool)[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=][ ]*(true|false)[ ]*)*[;]([\n]|[ ])*
mainEnd ([ ]|[\n])*(return[ ]+[-]?[0-9]*;)([ ]|[\n])*[}]([ ]|[\n])*


%%
{mainStart} {
    if(error!=0){
        return 0;
    }
    else{
        isMainStarted = 1;
    }
}
{multiChar}|{multiVariable}|{multiBool} {
    if(error!=0){
        return 0;
    }
    else{
        if(isMainStarted!=1){
            error++;
            printf("%s",yytext);
        }
    }
}

{mainEnd} {
    if(error!=0){
        return 0;
    }
    else{
        isMainStarted=0;
    }
}

. {
    error++;
    printf("%s",yytext);
}
[\n]
%%

int yywrap()
{

}

int main()
{
    yyin=fopen("input.txt","r");
    yylex(); 
    if(error==0){
        printf("Your source code is OK :)\n");
    }
    else{
        printf("\nTry Again '( \n");
    }
}
