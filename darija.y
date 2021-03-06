%{
	
	#define TAILLE_MAX 1000 // Tableau de taille 1000
	#include <stdio.h>
	void yyerror (char *s);
	#include<string.h>
	#include <stdlib.h>
	char * trad="";
	 extern int yylex();
	 const char *str1;const char* str2;char* str3;
	char* traduction(char*arriver,int c);
	char* concatenationAvecEspace(char* str1, char* str2);
	
	
%}
%union {char * str ;  }
%token <str> damir ism hj fi3l point DEBUT DET N V P A AV
%type <str> Sism Sfi3l Shj Sdamir  phrase2  SN SV SA SP SDET phrase1 SAV
%start  S
%% 

 S : phrase2 
  |  S phrase2
  ;
phrase2: DEBUT phrase2   {  printf("%s",trad);trad=""; }
	|Sism
	|Sfi3l
	|Shj
	|Sdamir
	|Sism phrase2
	|Sfi3l  phrase2		
	|Shj  phrase2	
	|Sdamir   phrase2	
	|point           {printf("fin\n");}
      ;
    Sism : ism       {trad = concatenationAvecEspace(trad,traduction($1,2)); 
		}
		;
   Sfi3l : fi3l        {  trad = concatenationAvecEspace(trad,traduction($1,2));       
		}
      ;
   Shj : hj       {trad = concatenationAvecEspace(trad,traduction($1,2)); 
			
				}
     ;
   Sdamir :  damir        {trad = concatenationAvecEspace(trad,traduction($1,2)); 
		}
	;


S : phrase1
  | S phrase1
  ;
phrase1: DEBUT phrase1   { printf("%s",trad);trad=""; }
	|SN
	|SV
	|SP
	|SA
	|SAV
	|SAV phrase1
	|SDET
	|SDET phrase1
	|SN   phrase1		
	|SV   phrase1	
	|SP   phrase1	
	|SA   phrase1	
	|point           {printf("fin\n");}
      ;
  SDET : DET       {trad = concatenationAvecEspace(trad,traduction($1,1)); 
		}
		;
   SN :  N     {  trad = concatenationAvecEspace(trad,traduction($1,1));       
		}
      ;
   SV : V       {trad = concatenationAvecEspace(trad,traduction($1,1)); 
			
				}
     ;
   SP : P        {trad = concatenationAvecEspace(trad,traduction($1,1)); 
		}
	;
  
    SA : A      {trad = concatenationAvecEspace(trad,traduction($1,1));  }
    ;
  SAV : AV {trad = concatenationAvecEspace(trad,traduction($1,1)); }
%%
void yyerror (char *s)  {}

main()
{
//int c=  menu();
   yyparse();
}
char* traduction(char* arrive,int c)
{   FILE* fichier = NULL;
    char chaine[TAILLE_MAX] = ""; // Cha�ne vide de taille TAILLE_MAX
    char *motAp;
    char *motAv=(char*) malloc(20*sizeof(char*));
    int i;
    if(c==2)
    fichier = fopen("C:/Users/hp/Desktop/Ensak/compilateur/projet_compilation/darija/darija.txt", "r");
    else
    fichier = fopen("C:/Users/hp/Desktop/Ensak/compilateur/projet_compilation/darija/francais.txt", "r");
    int flag=0;
    int j;
    if (fichier != NULL)
    {
        while(fgets(chaine, TAILLE_MAX, fichier)!=NULL) // On lit maximum TAILLE_MAX caract�res du fichier, on stocke le tout dans "chaine"
	 {

			char *c;
			if ((c = strchr(chaine, '\n')) != NULL)
			    *c = '\0';
		        for(i=0;chaine[i]!='\0';i++)  
			{       if(chaine[i]==' ')
				{
				    motAp=chaine+i+1;
				    break;
				}
				motAv[i]=chaine[i];

			}
			motAv[i]='\0';
			if(strcmp(motAv,arrive)==0)
			{
					flag=1;				
				return strcat(motAp," "); 
				
				
			}
			
			
	 }
	 if(flag==0){
		//printf("not found");
		return NULL;
	 }
       
        fclose(fichier);
    }
    else{printf("error");}
}
char* concatenationAvecEspace(char* str1, char* str2){
	int l1 = strlen(str1);
	int l2 = strlen(str2);



	char* res = malloc((l1+l2+1)*sizeof(char));
	strcpy(res, str1);
	//strcat(res, " ");
	strcat(res, str2);

	return res;
}









