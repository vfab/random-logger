#!/bin/sh
n=-1
c=0
if [ -n "$3" ]
then
   n=$3
fi

while [ $n -ne $c ]
do
   WAIT=$(shuf -i $1-$2 -n 1)
   sleep $(echo "scale=4; $WAIT/1000" | bc)
   I=$(shuf -i 1-4 -n 1)
   D=`date -Iseconds`
   MS=`date +%s%3N`
   case "$I" in
      "1") M="$D ERROR An error is usually an exception that has been caught and not handled."
      ;;
      "2") M="$D INFO This is less important than debug log and is often used to provide context in the current task."
      ;;
      "3") M="$D WARN A warning that should be ignored is usually at this level and should be actionable."
      ;;
      "4") M="$D DEBUG This is a debug log that shows a log that can be ignored."
      ;;
   esac

   echo "{ \"_applicationId\":\"7280125\", \"_application\":\"Baggage Platform\", \"_filters\":[\"SRE\", \"SECURITY\", \"ANALYTICS\"], \"_timestamp\":\"$D\", \"_timeMillisInUTC\"=\"$MS\", \"_classification\":\"PII\", \"msg\":\"$M\" }"

   c=$(( c+1 ))
done
