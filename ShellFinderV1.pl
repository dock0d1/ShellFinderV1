#!/usr/bin/perl

####################################################
#       ShellFinderV1.pl - C0d3r: dock0d1          #
#                                                  #
#    Ferramenta para Desenvolvedores de sites      #
#       encontrarem possiveis shells upadas        #
#                                                  #
#              Discord : dock0d1#8800              #
#                                                  #
#         https://dock0d1.blogspot.com/            #
####################################################




use 5.12.0;
use warnings;


my @shells; 
sub pegarquivo
{
    my $arquivo = shift;
    open my $ah, "<", $arquivo or die $!."\n";
    local $/;
    my $kw = <$ah>;
    close($ah);
    return $kw;    
}


sub procurar
{
        my $arquivo = shift;
        my @palavras = (
                            { 
                                id    => "c99 Shell (shell)", 
                                val  => "c99shell",
                             },{ 
                                id    => "c100 Shell (shell)", 
                                val  => "c100shell",
                             },{ 
                                id    => "FaTaLisTiCz_Fx Fx29SheLL (shell)", 
                                val  => "FaTaLisTiCz_Fx Fx29SheLL",
                             },{ 
                                id    => ".: No System is Perfectly Safe :. (suspeito)", 
                                val  => "FaTaLisTiCz_Fx Fx29SheLL",
                             },{ 
                                id    => "[ SpammerHc 1.0] (spammer)", 
                                val  => "[ SpammerHc 1.0]",
                             },{ 
                                id    => "ZoRBaCK Connect (backdoor)", 
                                val  => "FaTaLisTiCz_Fx Fx29SheLL",
                             },{
                                id    => "r57 Shell (shell)",
                                val  => "r57shell",
                             },{
                                id    => "base64_decode (suspeito)",
                                val  => "base64_decode",
                             },{
                                id    => "I-47 Shell (shell)",
                                val  => "I-47",
                             },{
                                id    => "[Cyber Anarchy Shell] (suspeito)",
                                val  => "[Cyber Anarchy Shell]",
                             },{
                                id    => "EgY_SpIdEr ShElL (suspeito)",
                                val  => "EgY_SpIdEr",
                             },{
                                id    => "b374k-Shell (suspeito)",
                                val  => "b374k",
                             }                             
                        );
    
        my $conteudo = pegarquivo($arquivo);                     
        foreach my $item(@palavras)
        {
              printf("Arquivos Encontrados -> %-29s %s\n",$item->{"id"},$arquivo) if($conteudo =~ /$item->{"val"}/ix);
        }                          
}


sub tipos
{
    my $diretorio = shift;
    for my $i(glob($diretorio // "/*"))
    {      
            tipos($i.'/*') if(-d $i);
            push(@shells, $i) if(-f $i && $i =~ /\.(php|txt)/ix);         
    }
}


sub iniciar
{
    my $dir = shift;
    tipos($dir);
    foreach my $item(@shells)  
    {
        procurar($item);    
    }
    say "\n [*] Finalizado - * ";
}


sub sistema
{
     system(($^O ge 'linux')?'reset':'cls');
     printf("
####################################################
#       ShellFinderV1.pl - C0d3r: dock0d1          #
#                                                  #
#    Ferramenta para Desenvolvedores de sites      #
#       encontrarem possiveis shells upadas        #
#                                                  #
#              Discord : dock0d1#8800              #
#                                                  #
#         https://dock0d1.blogspot.com/            #
####################################################\n\n
        ");
     my $arg = $ARGV[0] or die "[*] Usage: ShFinder.pl <PASTA>\n";
     die "[-] Erro:  O argumento passado nao e uma pasta.\n" unless(-d $arg);
     iniciar($arg);
}


sistema;