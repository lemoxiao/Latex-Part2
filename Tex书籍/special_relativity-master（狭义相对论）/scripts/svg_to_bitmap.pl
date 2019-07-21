#!/usr/bin/perl

use strict;

# usage:
#   svg_to_bitmap.pl foo.svg bar.png

# This is a cut-down version of render_one_figure.pl that only renders to png.
# Used for cover.

use FindBin;
use File::Glob;
use File::Copy;
use File::Temp qw(tempdir);

my $svg = $ARGV[0];
my $png = $ARGV[1];

my @temp_files = ();

my $pdf=$svg;
$pdf=~s/\.svg$/.pdf/;
# Inkscape normally expects preferences file to be in ~/.config/inkscape/preferences.xml .
# We need to override this, because otherwise it could contain inappropriate options for this purpose.
# There is an undocumented mechanism for overriding it using an environment variable:
#   https://bugs.launchpad.net/inkscape/+bug/382394
# Create dir for temporary prefs file. Other files will be created there.
my $temp_dir = tempdir( CLEANUP => 1 );
my $c="INKSCAPE_PORTABLE_PROFILE_DIR=$temp_dir inkscape --export-text-to-path --export-pdf=$pdf $svg  --export-area-drawing 1>/dev/null"; 
print "  $c\n"; 
my $good_prefs = "$FindBin::RealBin/inkscape_rendering_preferences.xml";
-r $good_prefs or die "file $good_prefs not found or not readable";
copy($good_prefs,"$temp_dir/preferences.xml") or die "error copying $good_prefs to $temp_dir, $!";
-e "$temp_dir/preferences.xml" or die "copied $good_prefs to $temp_dir, but it's not there?";
system($c)==0 or die "error in render_one_figure.pl, rendering figure using command $c";

# Don't use inkscape --export-png, because as of april 2013, it messes up on transparency.
# Can convert pdf directly to bitmap of the desired resolution using imagemagick, but it messes up on some files (e.g., huygens-1.pdf), so
# go through pdftoppm first.
my $ppm = 'z-1.ppm'; # only 1 page in pdf
push @temp_files,$ppm;
if (system("pdftoppm -r 300 $pdf z")!=0) {finit("Error in render_one_figure.pl, pdftoppm")}
push @temp_files,$pdf;
if (system("convert $ppm $png")!=0) {finit("Error in render_one_figure.pl, ImageMagick's convert")}

print "\n";
finit();


sub finit {
  my $message = shift;
  tidy();
  if ($message eq '') {
    exit(0);
  }
  else {
    die $message;
  }
}

sub tidy {
  foreach my $f(@temp_files) {
    unlink($f) or die "error deleting $f, $!";
  }
}
