#!/bin/bash

log="${HOME}/bin/mic_debug.log"

echo "Writing to $log"

echo "==========================================================" &> $log
echo "pacmd list-sinks" >> $log
pacmd list-sinks &>> $log
echo "" &>> $log
echo "==========================================================" &>> $log
echo "pacmd list-sink-inputs" >> $log
pacmd list-sink-inputs &>> $log
echo "" &>> $log
echo "==========================================================" &>> $log
echo "pacmd list-sources" >> $log
pacmd list-sources &>> $log
echo "" &>> $log
echo "==========================================================" &>> $log
echo "pacmd list-source-outputs" >> $log
pacmd list-source-outputs &>> $log
echo "" &>> $log
echo "==========================================================" &>> $log
echo "sudo fuser -v /dev/snd/*" >> $log
sudo fuser -v /dev/snd/* &>> $log

less $log
