#!/bin/bash

#VARIAVEL UTILIZADA NO DATE
i=-1

#VERIFICAR DATA
#-d '-1 day' SE REFERE AO DIA ANTERIOR DA DATA ATUAL
date=`date -d "$i day" +%d/%b/%Y`
#echo $date

#DIA SEM ESPAÇO
dia=`date -d "$i day" +%d`
#echo $dia

#DIA COM ESPAÇO NO NUMERO
diaspace=`date -d "$i day" +%e`
#echo $diaspace

mes=`date -d "$i day" +%b`
#echo "Mes no formato Centos7: " $mes

ano=`date -d "$i day" +%Y`
#echo $ano

###############################
###CONVERSÃO DE FORMATO DATA MES
### Devido ao formato da data do do Mikrotik ser diferente do Centos, utilizei essa estrutura CASE para
### filtrar corretamente o log do Mikrotik.
################################

  case $mes in


        Jan)
                mes=Jan
                echo $mes
                ;;
        Fev)
                mes=Feb
                echo $mes
                ;;
        Mar)
                mes=Mar
                echo $mes
                ;;

        Abr)
                mes=Apr
                echo $mes
                ;;
        Mai)
                mes=May
                echo $mes
                ;;
        Jun)
                mes=Jun
                echo $mes
                ;;
        Jul)
                mes=Jul
                echo $mes
                ;;
        Ago)
                mes=Aug
                echo $mes
                ;;
        Set)
                mes=Sep
                echo $mes
                ;;
        Out)
                mes=Oct
                echo $mes
                ;;
        Nov)
                mes=Nov
                echo $mes
                ;;
        Dez)
                mes=Dec
                echo $mes
                ;;

  esac

echo "Mes no formato Mikrotik: " $mes

################################
################################


#DIRETORIO DE LOGs RECEBIDOS DO MIKROTIK
DiretorioLogsOriginais=/var/log/mikrotik

#DIRETORIO ANUAL DE LOGs
DiretorioLogsAnual=/var/log/mikrotik/$ano

#DIRETORIO MENSAL DE LOGs
DiretorioLogsMensal=$DiretorioLogsAnual/$mes

#ARQUIVO DIARIO DE LOGS
LocalNewLog=$DiretorioLogsMensal/$mes-$dia-$ano-mikrotik.log

#VERIFICA SE DIRETORIO ANUAL DE EXISTE. AQUI É CRIADO CASO NÃO EXISTA
if [ ! -d $DiretorioLogsAnual ]
then
mkdir -m 755 -p $DiretorioLogsAnual
echo "Criando diretorio $DiretorioLogsAnual"
else
echo "Diretorio ja exite"
fi

#CRIAR DIRETORIO MENSAL DE LOGS CASO NÃO EXISTA
if [ ! -d $DiretorioLogsMensal ]
then
mkdir -m 755 -p $DiretorioLogsMensal
echo "Criando diretorio $DiretorioLogsMensal"
else
echo "Diretorio ja exite"
fi

grep -i "$mes $diaspace" /var/log/mikrotik/mikrotik.log >> $LocalNewLog

echo "
########
Log de $date finalizado!
########
"
