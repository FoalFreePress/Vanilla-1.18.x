#!/usr/bin/env sh
# Forge requires a configured set of both JVM and program arguments.
# Add custom JVM arguments to the user_jvm_args.txt
# Add custom program arguments {such as nogui} to this file in the next line before the "$@" or
#  pass them to this script directly


export LOCKFILE=minecraft.pid

if [ -f $LOCKFILE ]
then
echo 'it looks like minecraft is already running'
echo 'if you think that is wrong and theres a stale lockfile, here is the process:'
ps `cat $LOCKFILE`
echo '====='
echo "if there is no process, delete $LOCKFILE and run this script again"
exit
fi

# remove the lock file if control-c
trap "rm -f $LOCKFILE; exit" INT TERM EXIT

echo $$ > $LOCKFILE


while true;
do

ulimit -a

java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.18.1-39.0.9-log-ips/unix_args.txt nogui

~/bin/backup-minecraft-full.sh

git add .
git commit -m "Sync from Server."
git push

echo restarting in 5 seconds...
sleep 1
echo restarting in 4 seconds...
sleep 1
echo restarting in 3 seconds...
sleep 1
echo restarting in 2 seconds...
sleep 1
echo restarting in 1 second...
sleep 1

done

rm -f $LOCKFILE
