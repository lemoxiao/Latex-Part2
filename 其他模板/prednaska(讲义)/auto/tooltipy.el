(TeX-add-style-hook "tooltipy"
 (lambda ()
    (LaTeX-add-environments
     "nopreview")
    (TeX-add-symbols
     '("stranka" ["argument"] 2)
     "overbar"
     "R"
     "strankaB"
     "setpars"
     "oldtextbf"
     "textit"
     "obrazek"
     "definice"
     "vypocet"
     "vyuziti"
     "item"
     "textbf")
    (TeX-run-style-hooks
     "a4wide"
     "graphicx"
     "color"
     "geometry"
     "fancybox"
     "fancytooltips"
     "createtips"
     "amsfonts"
     "amsmath"
     "multido"
     "marvosym"
     "bm"
     "calc"
     "babel"
     "czech"
     "hvmaths"
     "fontenc"
     "T1"
     "inputenc"
     "latin2"
     "latex2e"
     "art10"
     "article")))

