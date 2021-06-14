%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	int symbol[60];
	int val_table[1000];
	extern FILE *yyin;
	extern FILE *yyout;
%}



%token  MAIN_FUNC INT FLOAT READ WRITE ADD SUB MUL DIV EXPONEN LN EQUALS LT GT LE GE NE COMA SEMI COLON LPAR RPAR SLPAR SRPAR IF ELSE FOR WHILE MOD UPTO FROM STEP NUM SQR SQRT CUBE VAR ISPRIME
%nonassoc IFX
%nonassoc ELSE
%left LT GT LE GE
%left MOD
%left ADD SUB
%left MUL DIV

%%

program:
    | MAIN_FUNC SLPAR STATEMENTS SRPAR { printf("Execution Done!\n"); }
    ;
STATEMENTS:
	| STATEMENTS LINE
	;
LINE:
	 DECLARATION SEMI	{ printf("Declaration\n"); }
	| EXPRESSION SEMI	{   printf("\nvalue of expression: %d\n", $1); $$=$1;}
	| VAR EQUALS EXPRESSION SEMI { 
							val_table[$1] = $3; 
							printf("Value of the variable: %d\t\n",$3);
							$$=$3;
						     }
	| READ VAR SEMI			{
								printf("User Input for %c\n",$2+97);
                                if(symbol[$2] == 1) 
                                {
                                    printf("Value taken from user for %c\n",$2+97);
                                    int a;
                                    scanf("%d",&a);
                                    val_table[$2] = a;
								}
								else
                                    printf("%c not declared\n",$2+97);
							}
	| WRITE VAR SEMI		{
							if(symbol[$2] == 1) 
                                {
									printf("%d\n",val_table[$2]);
								}
								else
                                    printf("%c not declared\n",$2+97);
							
							}
	| WRITE VAR EQUALS EXPRESSION SEMI
						{
						       if(symbol[$2] == 1) 
                                {
                                   val_table[$2]=$4;
								   printf("\n%d\n",$4);
								}
								else
                                    printf("%c not declared\n",$2+97);
						
						}
	| IF EXPRESSION SLPAR STATEMENTS SRPAR {
								if($2){
									printf("\nvalue of expression in IF: %d\n",$4);
								}
								else{
									printf("condition value zero in IF block\n");
								}
							}
	
	| IF EXPRESSION SLPAR STATEMENTS SRPAR ELSE SLPAR STATEMENTS SRPAR {
								if($2){
									printf("value of expression in IF: %d\n",$4);
								}
								else{
									printf("value of expression in ELSE: %d\n",$8);
								}
							}
	| FOR FROM NUM UPTO NUM STEP EQUALS NUM COLON SLPAR STATEMENTS SRPAR	{
													int i;
													int cnt=$8;
													int lmt=$5;
													int val=$11;
													
													if($3<=lmt)
													{
												
													for(i=$3;i<lmt;i+=cnt)
													{
														printf("%d \n",i);
													}
													
													}
													else
													{
													   printf("Reverse Loop\n");
													   for(i=$3;i>=lmt;i-=cnt)
													   {
													       printf("%d\n",i);
													   }
													}
													$$=1;
													}
													 
	
	| SQR EXPRESSION	SEMI			{
									printf("%d\n",$2*$2);
								    }
	| CUBE EXPRESSION	SEMI			{
									printf("%d\n",$2*$2*$2);
								}
	| SQRT EXPRESSION SEMI		{
									int val=$2;
									printf("square root of %d is %f\n",val,sqrt(val));
									$$=1;
								}
								
								
	| ISPRIME LPAR NUM RPAR SEMI	{
											int n=$3;
											int flag=0;
											printf("%d",n);
											for(int i=2;i*i<=$3;i++)
											{
												if(n%i==0)
												{
													flag=1;
													break;
												}
											}
											if(flag)
											{
												printf("\nThe number is not Prime\n");
												$$=1;
											}
											else
											{
												printf("\nThe number is Prime\n");
												$$=0;
											}
										}
							
	
    ;

DECLARATION: TYPE ID
			;
TYPE: INT
	| FLOAT
	;
ID : ID COMA VAR  {
					if(symbol[$3]==0)
					 {
					  symbol[$3]=1;
					 }
					 else
					 {
						printf("Variable already declared\n");
					 }
					}
    |VAR           {
					if(symbol[$1]==0)
					 {
					  symbol[$1]=1;
					 }
					 else
					 {
						printf("Variable already declared\n");
						
					 }
					}
    ;
EXPRESSION: NUM					{ $$ = $1; 	}
	| VAR						{ if(symbol[$1]==1)
									$$=val_table[$1];
								}
	
	| EXPRESSION ADD EXPRESSION	{ $$ = $1 + $3; 
								   printf("%d\n",$1+$3);
								}

	| EXPRESSION SUB EXPRESSION	{ $$ = $1 - $3; 
								printf("%d\n",$$);
								}

	| EXPRESSION MUL EXPRESSION	{ $$ = $1 * $3; 
								printf("%d\n",$$);
								}

	| EXPRESSION DIV EXPRESSION	{ if($3){
				     					$$ = $1 / $3;
										printf("%d\n",$$);
				  					}
				  					else{
										$$ = 0;
										printf("\ndivision by zero\t");
				  					} 	
				    			}
								
	| EXPRESSION MOD EXPRESSION { if($3){
				     					$$ = $1 % $3;
										printf("%d\n",$$);
				  					}
				  					else{
										$$ = 0;
										printf("\nMOD by zero\t");
				  					} 	
				    			}
								
	| EXPRESSION GT EXPRESSION { $$ = $1 > $3; 
								printf("Greater\n");
								}
	
	|  EXPRESSION LT EXPRESSION { $$ = $1 < $3; 
								printf("LESS\n");
								}
								
	|  EXPRESSION GE EXPRESSION { int a=$1;
								 int b=$3;
								 if(a>=b){
								     printf("Greater equals\n");
									 $$=1;
									 }
								else{
									printf("Not greater equal\n");
									$$=0;
								}
								
								}
	| EXPRESSION LE EXPRESSION {
								int a=$1;
								 int b=$3;
								 if(a<=b){
								     printf("Less equals\n");
									 $$=1;
									 }
								else{
									printf("Not less equal\n");
									$$=0;
								}
								}	
	| LPAR EXPRESSION RPAR		{ $$ = $2;	}
	 
	| VAR NE VAR               {
								if($1 != $3)
								 {
									printf("Not Equal\n");
									$$=1;
								}
								else
								{
								  printf("Equal\n");
								  $$=0;
								}
							  }
	
	
	;
	
%%


int yywrap()
{
	return 1;
}
int yyerror(char *s){
	printf( "%s\n", s);
	return 0;
}
