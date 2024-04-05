#!/bin/sh
POST_PATH=../_posts
FONT_NAME=FZSKBXKJW
BASE_FILE=./index/index.html.base

letters=`grep -rnI "style: letter" $POST_PATH | awk -F ":" '{print $1}'`

echo '<div class="test">' >| $BASE_FILE

for l in $letters
do
     cat $l >> $BASE_FILE
done

echo "
</div>
<style>
  @font-face {
    font-family: 'font';
    src: url('../fonts/\$font.eot');
    src:
      url('../fonts/\$font.eot?#font-spider') format('embedded-opentype'),
      url('../fonts/\$font.woff2') format('woff2'),
      url('../fonts/\$font.woff') format('woff'),
      url('../fonts/\$font.ttf') format('truetype'),
      url('../fonts/\$font.svg') format('svg');
    font-weight: normal;
    font-style: normal;
  }
    .test{
        font-family: 'font';
    }
</style>
" >> $BASE_FILE

sed "s/\$font/$FONT_NAME/g" $BASE_FILE > ./index/index.html

node /usr/local/bin/fsp local index/index.html

# eot=$(cat fonts/$FONT_NAME.eot|base64|tr -d '\n')
# woff=$(cat fonts/$FONT_NAME.woff|base64|tr -d '\n')
woff2=$(cat fonts/$FONT_NAME.woff2|base64|tr -d '\n')
# ttf=$(cat fonts/$FONT_NAME.ttf|base64|tr -d '\n')
# svg=$(cat fonts/$FONT_NAME.svg|base64|tr -d '\n')

cat > fonts-zh.css <<EOF
@font-face {
    font-family: '$FONT_NAME';
    src: url(data:application/font-woff2;charset=utf-8;base64,$woff2) format('woff2');
    font-weight: normal;
    font-style: normal;
    font-display: swap;
}
EOF

mv fonts-zh.css ../media/css
