#!/usr/bin/perl

use strict;

my @x;

while (my $l=<>) {
  push @x,$l;
}

@x = sort {
  my ($a_bk,$a_ch,$a_num,$a_name) = split(/,/,$a);
  my ($b_bk,$b_ch,$b_num,$b_name) = split(/,/,$b);
  $a_ch = $a_ch+0;
  $b_ch = $b_ch+0;
  return $a_ch <=> $b_ch if $a_ch!=$b_ch;
  $a_num = $a_num+0;
  $b_num = $b_num+0;
  return $a_num <=> $b_num if $a_num!=$b_num;
  return $a_name <=> $b_name;
} @x;

foreach my $l(@x) {
  print $l;
}
