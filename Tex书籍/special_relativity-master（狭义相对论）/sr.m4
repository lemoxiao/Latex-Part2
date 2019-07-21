m4_changecom(`//%')m4_dnl
m4_changequote(`[:',`:]')m4_dnl
m4_ifelse(__web,1,[:
  m4_define([:__birdvec:],[:$\rightarrow $1$:])
  m4_define([:__birddualvec:],[:$$1 \rightarrow$:])
  m4_define([:__birdscalarproduct:],[:$$1 \rightarrow $2$:])
  m4_define([:__birdflipscalarproduct:],[:$$2 \leftarrow $1$:])
  m4_define([:__birdgrad:],[:$($1) \rightarrow$:])
:],[:
  m4_define([:__birdvec:],[:\birdvec{$1}:])
  m4_define([:__birddualvec:],[:\birddualvec{$1}:])
  m4_define([:__birdscalarproduct:],[:\birdscalarproduct{$1}{$2}:])
  m4_define([:__birdflipscalarproduct:],[:\birdflipscalarproduct{$1}{$2}:])
  m4_define([:__birdgrad:],[:\birdgrad{$1}:])
:])
