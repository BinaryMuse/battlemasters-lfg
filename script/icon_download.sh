for i in 1 2 3 4 5 6 7 8 9 10 11 22
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
