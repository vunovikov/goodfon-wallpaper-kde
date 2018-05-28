#!/usr/bin/env bash

#wget -O - http://www.reddit.com/r/wallpaper |\
#   grep -Eo 'http://i.imgur.com[^&]+jpg' |\
#   shuf -n 1 |\
#   xargs wget -O background.jpg
#feh --bg-fill background.jpg

url="https://www.goodfon.ru"
resolution=`xdpyinfo -display :0.0 | grep dimensions | egrep -o "[0-9]+x[0-9]+ pixels" | egrep -o "[0-9]+x[0-9]+"`

# Вариант №1
cd /home/novikov-vyu/111
image_orig_res=`curl -sL $url/catalog/space/ |\
grep "$url/wallpaper/" |\
cut -d '"' -f 2 |\
shuf -n 1 |\
xargs curl -sL |\
grep "<a href=\"/download/" |\
cut -d '"' -f 2 |\
head -n1`
image_my_res=`echo $url$image_orig_res | sed -E 's/[0-9]{3,}x[0-9]{3,}/'"$resolution"'/'`
image_name=`echo $image_my_res | sed -E 's/https:\/\/www.goodfon.ru\/download\///;s/\/[0-9]{3,}x[0-9]{3,}\///'`
echo $image_my_res | xargs curl -sL | grep "a href=.https://img4.goodfon.ru" | cut -d '"' -f 2 | xargs curl -O

# Вариант №2
cd /home/novikov-vyu/111
image_orig_res=`curl -sL $url/catalog/space/ |\
grep "$url/wallpaper/" |\
cut -d '"' -f 2 |\
shuf -n 1 |\
sed 's/wallpaper/download/;s/\.html//'`
echo $image_orig_res"/"$resolution"/"| xargs curl -sL | grep "a href=.https://img4.goodfon.ru" | cut -d '"' -f 2 | xargs curl -O

# Вариант №3. Если нужен оригинальный размер
cd /home/novikov-vyu/111
image_orig_res=`curl -sL $url/catalog/space/ |\
grep "$url/wallpaper/" |\
cut -d '"' -f 2 |\
shuf -n 1 |\
xargs curl -sL |\
grep "<a href=\"/download/" |\
cut -d '"' -f 2 |\
head -n1`
echo $url$image_orig_res | xargs curl -sL | grep "a href=.https://img4.goodfon.ru" | cut -d '"' -f 2 | xargs curl -O

#dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
#var Desktops = desktops();                                                                                                                       
#for (i=0;i<Desktops.length;i++) {
#        d = Desktops[i];
#        d.wallpaperPlugin = "org.kde.image";
#        d.currentConfigGroup = Array("Wallpaper",
#                                   "org.kde.image",
#                                    "General");
#        d.writeConfig("Image", "file:///PATH/TO/IMAGE.png");
#}'
