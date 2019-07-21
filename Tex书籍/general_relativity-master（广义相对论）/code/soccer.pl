use Math::Trig;

use strict;

my $pi = 3.141592653589793;

my $p = (1+sqrt(5))/2.;

# http://en.wikipedia.org/wiki/Truncated_icosahedron
# before normalization with unit(), edge lengths are 2

# vuw is part of a hexagon
# vux is part of a pentagon

my @u = (3*$p,0,1);
my @v = (3*$p,0,-1);
my @w = (1+2*$p,-$p,2);
my @x = (1+2*$p,$p,2);

print_spherical_angles(\@u,\@v,\@w);
print_spherical_angles(\@u,\@w,\@x);

sub diff {
  my ($u,$v) = @_;
  my @u = @$u;
  my @v = @$v;

  return ($u[0]-$v[0],  $u[1]-$v[1],  $u[2]-$v[2]);
}

# computes the interior spherical angle at u of the triangle with vertices at u, v, and w
# http://en.wikipedia.org/wiki/Spherical_law_of_cosines
sub print_spherical_angles {
  my ($u,$v,$w) = @_;
  my @u = @$u;
  my @v = @$v;
  my @w = @$w;


print "distances uv, uw, and vw are (compared to edge length 2)\n  ",
  dist(@u,@v),"\n  ",
  dist(@u,@w),"\n  ",
  dist(@v,@w),"\n";

@u = unit(@u);
@v = unit(@v);
@w = unit(@w);


my $cosc = dot(@v,@w);
my $cosa = dot(@u,@w);
my $q = ($cosc-$cosa*$cosa)/(1-$cosa*$cosa);
print "cos a = $cosa\ncos c = $cosc\n";
print "C=",acos($q)*180./$pi,"\n";

}

sub vs {
  my $r = shift;
  return $r->[0].','.$r->[1].','.$r->[2];
}

sub dist {
  my ($a,$b,$c,$d,$e,$f) = @_;
  return pythag($a-$d,$b-$e,$c-$f);
}


sub pythag {
  my ($a,$b,$c) = @_;
  return sqrt($a*$a+$b*$b+$c*$c);
}

sub unit {
  my ($a,$b,$c) = @_;
  my $mag = pythag($a,$b,$c);
  return ($a/$mag,$b/$mag,$c/$mag);
}

sub dot {
  my ($a,$b,$c,$d,$e,$f) = @_;
  return $a*$d+$b*$e+$c*$f;
}
