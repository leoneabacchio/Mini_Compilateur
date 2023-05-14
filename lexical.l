%{
#include <string.h>
#include "syntaxique.tab.h"

int ligne=1;
char Entite_Lexicale []="";
int nb_err_lex=-5;
%}
Mc_Calcul #CALCUL
Mc_Boucle #BOUCLE 
Mc_Tab #TAB 
Mc_Int INT
Mc_Double DOUBLE
Mc_Char CHAR
Mc_String STRING
Mc_Const CONST
Mc_Table TAB
Mc_Print PRINT
Mc_Read READ 
Mc_For FOR
Mc_While WHILE
Mc_If IF 
Mc_Program Program 
STR ["].*["]
CHAR ['].[']
IDF [A-Z][a-zA-Z0-9_]*
Any [a-zA-Z0-9#$^'"@!~`&]*
Affect =
PV ;
VG ,
DPT :
Par_Ouv \(
Par_Fer \)
Deb \{
Fin \}
Brack_Ouv \[
Brack_Fer \]
CST_Int [1-9][0-9]*|0
CST_Double [1-9][0-9]*\.[0-9]*|0
Opr_Arith [+]|[-]|[*]|[/]
Opr_Log [<]|[<][=]|[>]|[>][=]|[=][=]|[!][=]
Cmntr [/][/]
%%
{Mc_Int} return Mc_Int;
{Mc_Double} return Mc_Double;
{Mc_Char} return Mc_Char;
{Mc_If} return Mc_If;
{Mc_Print} return Mc_Print;
{Mc_Read} return Mc_Read;
{Mc_For} return Mc_For;
{Mc_While} return Mc_While;
{Mc_String} return Mc_String;
{Mc_Program} return Mc_Program;
{Mc_Calcul} return Mc_Calcul;
{Mc_Boucle} return Mc_Boucle;
{Mc_Tab} return Mc_Tab;
{Mc_Const} return Mc_Const;
{STR} return STR;
{CHAR} return CHAR;
{IDF}  {if(yyleng>12){
     return -1;
     }
        else return IDF;};
{Affect} return Affect;
{PV} return PV;
{DPT} return DPT;
{Par_Ouv} return Par_Ouv;
{Par_Fer} return Par_Fer ;
{Cmntr} return Cmntr;
{CST_Int} {
    if (atoi(yytext)<32767 && atoi(yytext)>-32768) return CST_Int ;
    else return -1; 
}
{VG} return VG; 
{Opr_Arith} return Opr_Arith;
{Opr_Log} return Opr_Log;
{Brack_Ouv} return Brack_Ouv;
{Brack_Fer} return Brack_Fer;
{Deb} return Deb;
{Fin} return Fin;
[\n] {ligne++;return SautLigne;};
[ \t]
{Any} return Any;
. {
    nb_err_lex++;
    printf("erreur lexicale a la ligne %d genere par %s \n",ligne,yytext);
    }
%%
int yywrap(){}

