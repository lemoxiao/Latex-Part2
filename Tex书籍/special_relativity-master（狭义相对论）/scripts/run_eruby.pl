#!/usr/bin/perl

use strict;
use Cwd;
# This is a cut-down version of the version used for the Light and Matter books.

use XML::Parser;

# Run this script in the book's directory; it automatically runs eruby on all the chapters.
# Normally the eruby is executed with BOOK_OUTPUT_FORMAT='print', but
# with 'w' on the command line, it will produce web (html) output as well, running
# eruby a second time with BOOK_OUTPUT_FORMAT='web' and calling translate_to_html.rb.
# It also creates the table of contents (index.html), which is then filled in by
# translate_to_html.rb.
# Any command-line options in environment variable WOPT are passed on to translate_to_html.rb.
# Example:
#   WOPT='--no_write' make web

my $eruby = "fruby"; # use my reimplementation of eruby, for better error handling and better compatibility with TeX (see comments at top of fruby)

my $web = 0;
if (@ARGV) {
  my $a = $ARGV[0];
  $web = 1 if $a=~/w/;
}

my $wopt = '';
if (exists $ENV{WOPT}) {$wopt = $ENV{WOPT}}
my $no_write = 0;
if ($wopt=~/\-\-no_write/) {$no_write=1}
my $mathjax = 0;
if ($wopt=~/\-\-mathjax/) {$mathjax=1}
my $wiki = 0;
if ($wopt=~/\-\-wiki/) {$wiki=1}
my $xhtml = 0;
if ($wopt=~/\-\-modern/) {$xhtml=1}
my $html5 = 0;
if ($wopt=~/\-\-html5/) {$html5=1}

print "run_eruby.pl, no_write=$no_write, wiki=$wiki, xhtml=$xhtml\n";

# duplicated in translate_to_html.rb, but different number of ../'s
my $banner_html = <<BANNER;
  <div class="banner">
    <div class="banner_contents">
        <div class="banner_logo" id="logo_div"><img src="http://www.lightandmatter.com/logo.png" alt="Light and Matter logo" id="logo_img"></div>
        <div class="banner_text">
          <ul>
            <li> <a href="../../">home</a> </li>
            <li> <a href="../../books.html">books</a> </li>
            <li> <a href="../../software.html">software</a> </li>
            <li> <a href="../../courses.html">courses</a> </li>
            <li> <a href="../../area4author.html">contact</a> </li>

          </ul>
        </div>
    </div>
  </div>
BANNER

my $html_dir = $ENV{HOME} . '/Generated/html_books/sr';

#---------
#   Note:
#     The index is always html, even if we're generating xhtml.
#     Also, translate_to_html.rb generates links to chapter files named .html, not .xhtml,
#     even when we're generating xhtml output. This is because mod_rewrite is intended to
#     redirect users to the .xhtml only if they can handle it.
#---------
my $index = $ENV{HOME} . '/Generated/html_books/sr/index.html';
if ($web==1 && !$no_write && !$wiki) {
  open(FILE,">$index") or die "error opening $index";
  print FILE "<html><head><title>html version of book</title>    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.lightandmatter.com/banner.css\" media=\"all\"></head><body>\n";
  print FILE $banner_html;
  close FILE;
}

mkdir "temp" unless -d "temp";
foreach (<ch*/*.rbtex>) {
  my $file = $_;
  $file =~ m/ch(\d+)/;
  my $ch = $1;
  my $o = $file;
  $o =~ s/\.rbtex//;
  my $outfile_base = $o . "temp";
  my $postm4 = "$outfile_base.postm4";
  my $d = "ch$ch";
  my $web_flag = ($web==1 ? 1 : 0);
  my $cmd = "m4 -P -D __web='$web_flag' sr.m4 $file >$postm4";
  do_system($cmd,$file,'m4');
  my $cmd = "BOOK_OUTPUT_FORMAT='print' DIR='$d' $eruby $postm4 >$outfile_base.tex"; # is always executed by sh, not bash or whatever
  do_system($cmd,$file,'eruby (print)');
  if ($web==1) {
    my $cmd = "BOOK_OUTPUT_FORMAT='web' DIR='$d' $eruby $postm4 >$outfile_base.temp"; # is always executed by sh, not bash or whatever
    do_system($cmd,$file,'eruby (web)');
    my $html;
    if ($wiki) {
      $html = "$o";
    }
    else {
      $html = "$html_dir/$o";
    }
    if ($xhtml) {
      $html = $html . '.xhtml';
    }
    else {
      if ($wiki) {
        $html = $html . '.wiki';
      }
      else {
        if ($html5) {
          $html = $html . '.html5';
        }
        else {
          $html = $html . '.html';
        }
      }
    }
    if ($no_write) {$html = '/dev/null'}
    print STDERR "writing $html\n";
    $cmd = "mkdir -p $html_dir/ch$ch";
    do_system($cmd,'','') unless $wiki;
    my $cmd = "CHAPTER='$ch' scripts/translate_to_html.rb $wopt <$outfile_base.temp >$html";
    print $cmd,"\n";
    do_system($cmd,'stdin','translation');
    if ($xhtml) {
      local $/; open(F,"<$html"); my $x=<F>; close F;
      eval {XML::Parser->new->parse($x)};
      if ($@) {
        print "fatal error ===============> file $html output by /translate_to_html.rb is not well formed xml\n";
        XML::Parser->new->parse($x); # will print error message
        die;
      }
    }
  }
}

if ($web==1 && !$no_write) {
  open(FILE,">>$index") or die "error opening $index";
  print FILE "</body></html>\n";
  close FILE;
}

sub do_system {
  my $cmd = shift;
  my $file = shift;
  system($cmd)==0 or die "died on $file, $?, cmd=$cmd";
}
