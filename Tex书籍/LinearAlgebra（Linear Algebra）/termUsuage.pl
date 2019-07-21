#!/usr/bin/perl
# AJR 20 Mar 2015
$term="homogeneous";
$terms=`grep '$term' */*.tex|awk -F: '{print $1}'|sort -u|wc -l`;
print "$term= $terms\n";
