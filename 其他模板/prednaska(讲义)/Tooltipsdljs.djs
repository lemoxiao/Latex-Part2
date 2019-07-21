\begingroup
\obeyspaces\obeylines\global\let^^M=\jsR%
\catcode`\"=12%
\gdef\dljsTooltipsdljsiii{%
  var animace;
  var fancyTooltipsLoaded = true;

  function CloseTooltips()
  {
    try {this.getField("ikona").hidden=true;}catch (e) {}
    try {app.clearInterval(animace);}catch (e) {}
  }

  function nastav(cislo,strana)
  {
    var f=this.getField("ikona."+(strana));
    var g=this.getField("animtiph."+cislo);
    var sourf=f.rect;
    var sourg=g.rect;
    if ((mouseX+sourg[2]-sourg[0])<sourf[2])
    var percX=100*(mouseX-sourf[0])/((sourf[2]-sourf[0])-(sourg[2]-sourg[0]));
    else
    var percX=100*(mouseX-sourf[0]-(sourg[2]-sourg[0]))/((sourf[2]-sourf[0])-(sourg[2]-sourg[0]));
    var percY=100*(mouseY-sourf[3])/((sourf[1]-sourf[3])-(sourg[1]-sourg[3]));
    if (percX>100) percX=100;
    if (percY>100) percY=100;
    if (percX<0) percX=0;
    if (percY<0) percY=0;
    f.buttonAlignX=percX;
    f.buttonAlignY=percY;
  }

  function zobraz(cislo,strana)
  {
    var f=this.getField("ikona."+(strana));
    var g=this.getField("animtiph."+cislo);
    f.hidden=false;
    f.buttonSetIcon(g.buttonGetIcon());
  }
}%
\endgroup
\begingroup 
\ccpdftex%
\input{dljscc.def}%
\immediate\pdfobj{ << /S /JavaScript /JS (\dljsTooltipsdljsiii) >> }
\xdef\objTooltipsdljsiii{\the\pdflastobj\space0 R}
\endgroup 
\endinput
