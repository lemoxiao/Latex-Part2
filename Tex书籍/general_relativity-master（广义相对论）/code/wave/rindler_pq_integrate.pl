#!/usr/bin/perl

use strict;

my $pi = 3.141592;

my $n = 10000;

my $a = .1;
my $n_cycles = 1/$a;
my $omega = 1.;
my $w0 = 0.0;

my $p = p_func(0.);
my $q = 2-$p+$w0;
my $q_init = $q;

my $q1 = 0;

my $u;
my $du = 2.*$pi/$n;
my $skip = $n/10; # lines to skip between outputs; use 10 for looking at printout, 100 for graphing
my $final_phase = 2.*$pi*$n_cycles;

my $d = $a/(2*square($a+1))+$a/(2*square(1-$a))-$a-1;
# A/(2*(A+1)^2)+A/(2*(1-A)^2)-A-1

my $k = 0;
for ($u=0; $u<$final_phase; $u+=$du) {
  $p = p_func($u);
  my $p2 = p2_func($u);
  my $q2 = -$q*$p2/$p;
  $q1 = $q1 + $q2*$du;
  $q = $q + $q1*$du;
  my $w = $q-(2-$p);
  if ($k%$skip==0 || $u+$du>=$final_phase) {
    my $cycles=$u/(2.*$pi);
    my $pred_q2;

    if (1) {
      $pred_q2 = -$p2*cos($u*$a)-2.*$a*$a*cos($u*$a);
      #print "$cycles,$p,$q2,$pred_q2\n";
    }

    if (1) {
    my $pred = $a*(-cos($u*($a+1))/(2*square($a+1))-cos($u*(1-$a))/(2*square(1-$a))) + 2*cos($u*$a) + $d + 2 - 2*square($a/(2.*$pi))*square($u);
    # A*(-cos(u*(A+1))/(2*(A+1)^2)-cos(u*(1-A))/(2*(1-A)^2))+2*cos(u*A)
    my $err = $pred-$q;
    my $err2 = $pred*$p2+$p*$pred_q2;
    print "$cycles,$p,$q,$pred,$err,$err2\n";
    }
  }
  ++$k;
}

# must have max at u=0
sub p_func {
  my $u = shift;
  return 1+$a*cos($u);
}

sub p2_func {
  my $u = shift;
  return -$a*cos($u);
}

sub square {
  my $x = shift;
  return $x*$x;
}
