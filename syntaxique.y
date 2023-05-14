%{
extern int ligne;
int nb_err_syn=0;
extern yytext;

%}
%token Mc_Int Mc_For Mc_Print Mc_Boucle Mc_Calcul Mc_Double
IDF STR CHAR Mc_Char Cmntr Affect PV VG DPT Par_Ouv Par_Fer CST_Int CST_Double Opr_Inf Opr_Plus 
Mc_Const Mc_If Mc_Read SautLigne Mc_Tab  Mc_While Mc_Program
Mc_String Deb Fin Opr_Arith Opr_Log Brack_Ouv Brack_Fer err Any

%%
S:Include MonPrgrm |
;
/*Declaration de Bibliotheque*/
Include:Bib Include|
;
Bib:Mc_Calcul SautLigne|Mc_Boucle SautLigne|Mc_Tab SautLigne|SautLigne
;
/*Debut de programme*/
MonPrgrm:Mc_Program IDF SautLigne Deb SautLigne PRGRM Fin SautLigne |
;
PRGRM:Declaration PRGRM |Instructions PRGRM |Commentaire PRGRM |
;
/*Declaration*/
Declaration:TYPE IDF SPRT|TYPE Tabl SPRTTab|TYPE DecConst SPRT
;
SPRT:VG IDF SPRT|PV
;
SPRTTab:VG IDF Brack_Ouv InTabl Brack_Fer SPRTTab|PV 
;
TYPE:Mc_Int|Mc_Double|Mc_String|Mc_Char
;
Tabl:IDF Brack_Ouv InTabl Brack_Fer
;
DecConst:Mc_Const IDF
;
InTabl:CST_Int|IDF|Arith
;
Var:Tabl|IDF
;
/*Instructions*/
Instructions:InstAffect Instructions | InstCond Instructions | InstBoucle Instructions | InstLec Instructions | InstAffich Instructions  | Commentaire Instructions | Declaration Instructions | SautLigne Instructions | /*InstArith Instructions |*/
;
InstAffect:Var Affect CST_Int PV | Var Affect CST_Double PV | Var Affect STR PV | Var Affect CHAR PV | Var Affect Var | Var Affect InstArith
;
InstLec:Mc_Read Par_Ouv Var Par_Fer PV
;
InstAffich:Mc_Print Par_Ouv Var Par_Fer PV | Mc_Print Par_Ouv STR Par_Fer PV | Mc_Print Par_Ouv CHAR Par_Fer PV
;
InstBoucle:Mc_While Par_Ouv Cond Par_Fer SautLigne Deb Instructions Fin |Mc_For Par_Ouv Affectation DPT ValeurFinal DPT ValeurFinal Par_Fer SautLigne Deb Instructions Fin|Mc_For Par_Ouv Affectation DPT ValeurFinal Par_Fer SautLigne Deb Instructions Fin
;
Affectation:Var Affect CST_Int | Var Affect CST_Double | Var Affect STR | Var Affect CHAR | Var Affect Var 
;
ValeurFinal:IDF | CST_Int | Arith
;
Arith:Var Opr_Arith CST_Int | Var Opr_Arith Var
;
InstArith:Var ListOp 
;
ListOp:Opr_Arith CST_Int ListOp | Opr_Arith Var ListOp | PV
;
InstCond:Mc_If Par_Ouv Var Opr_Log Var Par_Fer SautLigne Deb Instructions Fin | Mc_If Par_Ouv Var Opr_Log CST_Int Par_Fer SautLigne Deb Instructions Fin | Mc_If Par_Ouv Var Opr_Log CST_Double Par_Fer SautLigne Deb Instructions Fin | Mc_If Par_Ouv IDF Opr_Log STR Par_Fer SautLigne Deb Instructions Fin | Mc_If Par_Ouv IDF Opr_Log CHAR Par_Fer SautLigne Deb Instructions Fin
;
Cond:Var Opr_Log Var | Var Opr_Log CST_Int | Var Opr_Log CST_Double | Var Opr_Log STR | Var Opr_Log CHAR 
;
/*Commentaires*/
Commentaire:Cmntr ContenuCmntr Cmntr
; 
ContenuCmntr:ALL ContenuCmntr|
;
ALL:Any|IDF|CST_Int|CST_Double|STR|CHAR|SautLigne
;
%%
yyerror()
{
nb_err_syn++;
printf("erreur syntaxique a la ligne %d genere par %s\n",ligne,yytext);
return 1;
}
int main()
{
yyparse();
if (nb_err_syn==0)
printf("Syntaxe correcte");
else
printf("Syntaxe incorrecte");
return 1;
}