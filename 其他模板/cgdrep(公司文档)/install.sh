#!/bin/bash

# USAGE:
# 1. install to user's local directories
#
#   $ ./install
#
# 2. install to global directories
#
#   $ sudo -sH
#   $ ./install --global
#

reconfig_lyx() {
    echo -n "Refreshing Lyx configuration               ... "
    lyx -batch -x reconfigure examples/report_lyx/main_en.lyx
    echo "Done"
}

if [[ $1 == '--global' ]];
then
    TEXMF=$(kpsewhich -var-value TEXMFLOCAL)
    LYXDIR=$(cd $(dirname $(which lyx)) && cd .. && pwd)/share/lyx
    FONTDIR=/usr/share/fonts
else
    reconfig_lyx
    TEXMF=$(kpsewhich -var-value TEXMFHOME)
    LYXDIR=
    for lyxdir in .lyx2.2 .lyx2.1 .lyx
    do
        if [[ -d  "$HOME/$lyxdir" ]]
        then
            LYXDIR="$HOME/$lyxdir"
        fi
    done
    FONTDIR="$HOME/.local/share/fonts"
fi

##################### Part 1 : Latex class  #########################
echo -n "User LaTeX templates are to be installed to $TEXMF        ... "
DSTDIR=$TEXMF/tex/latex
[[ -d $DSTDIR ]] || mkdir -p $DSTDIR
cp -r src/tex/latex/cgdrep $DSTDIR
texhash
echo "Done"

##################### Part 2 : Lyx layout   #########################
if [[ -d $LYXDIR ]]
then
    echo -n "Lyx user dir found in $LYXDIR, installing Lyx layouts       ... "
    cp src/lyx/layouts/* $LYXDIR/layouts/
    reconfig_lyx
    echo "Done"
fi

##################### Part 3 : Install fonts #########################

FONTS=(
    "NotoSansSC,Noto Sans SC,https://noto-website.storage.googleapis.com/pkgs/NotoSansSC.zip,httpfff://"
    "NotoSerifSC,Noto Serif SC,https://noto-website.storage.googleapis.com/pkgs/NotoSerifSC.zip"
    "XITS,XITS,https://cloud.github.com/downloads/khaledhosny/xits-math/xits-1.106.zip"
    "STIX,STIXGeneral,https://jaist.dl.sourceforge.net/project/stixfonts/Past%20Releases/STIXv1.1.0.zip"
    "mplus,M+ 1m,https://www.fontsquirrel.com/fonts/download/M-1m"
    "SourceSerifPro,Source Serif Pro,https://github.com/adobe-fonts/source-serif-pro/archive/2.000R.zip"
)
install_one_font() {
    fname="$1"
    url1="$2"
    url2="$3"

    FTMP=$(mktemp)
    for url in "$url1" "$url2"
    do
        curl -L -o $FTMP "$url1"
        if [[ $? -eq 0 ]]
        then
            fdir="$FONTDIR/$fname"
            [[ -d "$fdir" ]] || mkdir -p "$fdir"
            (cd "$fdir" && unzip -o $FTMP)
	    break
        fi
    done
    rm $FTMP
}

install_fonts() {
    for ln in "${FONTS[@]}"
    do
        OLDIFS=$IFS
        IFS=','
        set -- $ln
        fname="$1"
        query="$2"
        url1="$3"
        url2="$4"
        IFS=$OLDIFS

        # check if the font is already installed
        fc-list -q "$query"
        if [[ $? -eq 0 ]]
        then
            echo "... font \"$query\" found"
        else
            echo "... download and install font \"$query\""
            install_one_font "$fname" "$url1" "$url2"
            fc-cache
            fc-list "$query"
            if [[ $? -ne 0 ]]
            then
                echo "... failed to install font \"$query\""
                exit -1
            fi
        fi
    done
}

install_fonts

echo "install completed"

