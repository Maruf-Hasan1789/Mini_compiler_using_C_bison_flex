%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include<math.h>
	#include "f.tab.h"
	extern FILE *yyin;
	extern FILE *yyout;
%}

ID [a-zA-Z]
digit [0-9]
main   "root()"

%%

{main}       { return MAIN_FUNC; }
"int"        { return INT; }
"float"      { return FLOAT; }
{ID}         { yylval= *yytext - 'a'; return VAR; }
"read"       { return READ; }
"write"      { return WRITE; }
"+"          { return ADD; }
"-"          { return SUB; }
"*"          { return MUL; }
"/"          { return DIV; }
"^"          { return EXPONEN; }
"="          { return EQUALS; }
"<"			 { return LT; }
">"         { return GT; }
"<="         { return LE; }
">="         { return GE; }
"!="         { return NE; }
","          { return COMA; }
";"          { return SEMI; }
":"          { return COLON; }
"("          { return LPAR; }
")"          { return RPAR; }
"{"          { return SLPAR; }
"}"          { return SRPAR; }
"if"         { return IF; }
"else"       { return ELSE; }
"loop"        { return FOR; }
"from"		 { return FROM; }
"upto" 		  { return UPTO; }
"step"		{ return STEP; }
"while"      { return WHILE; }
"%"			 { return MOD;  }
"square"	{ return SQR;}
"cube"		{ return CUBE;}
"sqrt"		{ return SQRT; }
"isprime"	{ return ISPRIME; }
"-"?{digit}+ { yylval= atoi(yytext); return NUM ; }
"-"?{digit}*[.][0-9]+ { yylval= atof(yytext); return NUM ; }
[ \t\n]

%%

int main(void)
{	
	yyin=fopen("input.txt","r");
	yyout = fopen("OUTPUT.txt","w");
	yyparse();
	return 0;
}
