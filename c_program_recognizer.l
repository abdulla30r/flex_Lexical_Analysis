%{
    int isMainStarted = 0;
    int error = 0;
    int isMainFinished = 0;
%}


word [_A-Za-z]+
digit [0-9]
digits [0-9]*
variableName (_{digits}|{word})({word}|{digits})*
multiVariable (int|float)[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=]{digit}{digits})*[;]([\n]|[ ])*
mainStart (int|float)[ ]+(main)[ ]*[(][ ]*[)][\n]*[{]([ ]|[\n])*
multiChar (char)[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=][ ]*["][a-zA-Z0-9][ ]*["][ ]*)*[;]([\n]|[ ])*
multiBool (bool)[ ]+{variableName}[ ]*(([,][ ]*{variableName})*[ ]*|[ ]*[=][ ]*(true|false)[ ]*)*[;]([\n]|[ ])*
mainEnd ([ ]|[\n])*(return[ ]+[-]?[0-9]*;)([ ]|[\n])*[}]([ ]|[\n])*


%%
{mainStart} {
    if(error!=0){
        return 0;
    }
    else{
        ++isMainStarted;
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
    if(error!=0 || isMainStarted==0){
        error++;
        printf("%s",yytext);
    }
    else{
        isMainStarted=0;
        ++isMainFinished;
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
        if(isMainFinished!=1 || isMainStarted==1){
            printf("Invalid Ending\n");
        }
        else{
            printf("Your source code is OK :)\n");
        }
    }
    else{
        printf("\nTry Again '( \n");
    }
}
