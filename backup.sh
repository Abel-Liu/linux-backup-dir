#!/bin/bash
#Auto backup

############## Config ##################
DATE=`date +"%Y-%m-%d"`
SourceDir=/home/abeltest/somefiles  #the dir need backup
BakDir=/home/abeltest/backup
LogFile=/home/abeltest/backup/log/$DATE.log
RetainDay=7  #delete backup xx days ago
############## Begin ##################
mkdir -p $BakDir/
mkdir -p `dirname $LogFile`

echo "-------------" >> $LogFile
echo "$(date +"%Y-%m-%d %H:%M:%S") backup start" >> $LogFile

SrcName=`basename $SourceDir`
PackFile=$SrcName-$DATE.tar.gz

cd `dirname $SourceDir`

tar -zcvf $BakDir/$PackFile $SrcName
echo "$(date +"%Y-%m-%d %H:%M:%S") $SourceDir backup to $BakDir/$PackFile" >> $LogFile

OldFile=$BakDir/$SrcName-$(date --date="$RetainDay days ago" +"%Y-%m-%d").tar.gz

if [ -f $OldFile ]
	then
  	rm -rf $OldFile > /dev/null
  	echo "$(date +"%Y-%m-%d %H:%M:%S") $OldFile was deleted" >> $LogFile
fi

echo "$(date +"%Y-%m-%d %H:%M:%S") backup completed" >> $LogFile
exit 0