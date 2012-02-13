for i in {1..11}
do
  for j in {0..1}
  do
    wget "http://us.media.blizzard.com/wow/icons/18/race_${i}_${j}.jpg"
  done
done

for i in {1..11}
do
  wget "http://us.media.blizzard.com/wow/icons/18/class_$i.jpg"
done

for i in {0..1}
do
  wget "http://us.media.blizzard.com/wow/icons/18/faction_$i.jpg"
done
