find . -name '*.png' -printf '%p\n' -exec  magick convert {} -write mpr:input -background none -rotate 180 mpr:input -composite -set page %[@] -set option:bounds %[fx:u.page.width]x%[fx:u.page.height]-%[fx:u.page.x]-%[fx:u.page.y] -delete 0 mpr:input -set page %[bounds] -coalesce {} \;
read -rsp $'Press any key to continue...\n' -n1 key