%{
#include <y.tab.h>
%}

campo [A-Za-z0-9]+|"*"


%%

"SELECT" {return SELECT;}
"FROM"	{return FROM;}
"WHERE" {return WHERE;}
"*" {return *;}
{campo} {yylval.--- = yytext; return CAMPO;}



%%
