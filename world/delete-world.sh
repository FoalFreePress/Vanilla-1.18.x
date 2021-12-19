read -r -p "You are about to delete the data for this world. Are you sure? [Y/n] " response
if [[ "$response" =~ ^([Y])$ ]]
then
    cd /home/sweetie/servers/minecraft/118_vanillaplus/world
    rm -rv advancements/ data/ datapacks/ DIM-1/ DIM1/ entities/ playerdata/ poi/ region/ stats/ level.dat level.dat_old session.lock
else
    echo "Aborting"
fi
