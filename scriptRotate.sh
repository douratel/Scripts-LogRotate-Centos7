#!/bin/bash

#Script para criacao de log diário
#Autor: Leandro Pereira de Souza - leandro.ti@hotmail.com
#Script para CentOs 7


#VARIAVEL UTILIZADA NO DATE
#QUANTIDADE DE DIAS RETROATIVOS QUE DESEJA GERAR O LOG
#SE i=-1 VAI GERAR UM ARQUIVO COM O LOG DO DIA ANTERIOR
i=-1

#NUMERO DO DIA RETROATIVO QUE VAI REMOVER O LOG.
#SE rmv=-730 VAI REMOVER APENAS O LOG GERADO HA 730 DIAS ATRÁS
rmv=-730

#####################################
#   VERIFICAR DATA DE GERAR LOG   #
#####################################
#-d '-1 day' SE REFERE AO DIA ANTERIOR DA DATA ATUAL
date=`date -d "$i day" +%d/%b/%Y`
#DIA SEM ESPAÇO
dia=`date -d "$i day" +%d`
#DIA COM ESPAÇO NO NUMERO
diaspace=`date -d "$i day" +%e`
mes=`date -d "$i day" +%b`
ano=`date -d "$i day" +%Y`

########################################
#VERIFICAR DATA PARA REMOVER LOG ANTIGO#
########################################
dateRmv=`date -d "$rmv day" +%d/%b/%Y`
#DIA SEM ESPAÇO
diaRmv=`date -d "$rmv day" +%d`
#DIA COM ESPAÇO NO NUMERO
diaspaceRmv=`date -d "$rmv day" +%e`
mesRmv=`date -d "$rmv day" +%b`
anoRmv=`date -d "$rmv day" +%Y`

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
#ARQUIVO PARA REMOVER
arqDateRemove=/var/log/mikrotik/$anoRmv/$mesRmv/$mesRmv-$diaRmv-$anoRmv-mikrotik.log

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

#REMOVER LOG ANTIGO
if [ -e $arqDateRemove ]
then
echo "Removendo arquivo antigo"
rm -rf $arqDateRemove
else
echo "Não existe arquivo antigo"
fi

###############################
###CONVERSÃO DE FORMATO DATA MES
### Devido ao formato da data do do Mikrotik ser diferente do Centos, utilizei essa estrutura CASE para
### filtrar corretamente o log do Mikrotik.
################################
  case $mes in
        Jan)
                mes=Jan
                ;;
        Fev)
                mes=Feb
                ;;
        Mar)
                mes=Mar
                ;;
        Abr)
                mes=Apr
                ;;
        Mai)
                mes=May
                ;;
        Jun)
                mes=Jun
                ;;
        Jul)
                mes=Jul
                ;;
        Ago)
                mes=Aug
                ;;
        Set)
                mes=Sep
                ;;
        Out)
                mes=Oct
                ;;
        Nov)
                mes=Nov
                ;;
        Dez)
                mes=Dec
                ;;
  esac
  
############GERAR LOG###################################################
grep -i "$mes $diaspace" /var/log/mikrotik/mikrotik.log >> $LocalNewLog

echo "
########
Log de $date finalizado!
########
"
