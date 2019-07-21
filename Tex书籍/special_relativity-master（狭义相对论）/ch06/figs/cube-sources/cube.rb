#!/usr/bin/ruby

include Math

#-----------------------------------------------------------------------------------
def main

v = 0.99 # observer's velocity/c, along x axis
n = 100 # break each curve up into n segments
$global_scale = 12.0*gamma_function(v) # compensate for aberration somewhat by rescaling, or else high-v
                                  # drawings are too small to see
$xo = 1 # x of observer; nonrelativistically, this has to be negative or else parts of it are behind him
$xs = -2.0 # x of screen

$smallest_theta_p = 999.0
$biggest_theta_p = 0.0
$smallest_theta = 999.0
$biggest_theta = 0.0

paths = ''
paths = paths + draw_cube(n,v) + draw_reticle([50.0],n)
print svg_template(paths)

$stderr.print "range of theta in lab frame        = #{$smallest_theta*180.0/PI} to #{$biggest_theta*180.0/PI}\n"
$stderr.print "range of theta in observer's frame = #{$smallest_theta_p*180.0/PI} to #{$biggest_theta_p*180.0/PI}\n"

end # main

def draw_reticle(angles,n)
  path = ''
  angles.each {|theta|
    r = $global_scale * $xs * tan(theta*PI/180.0) # SVG distance between center of screen and point lying at this angle
    dphi = (2.0*PI)/(2.0*n.to_f)
    0.upto(n-1) { |i|
      phi = 2*i*dphi
      path = path + path_template_two_points(r*cos(phi),r*sin(phi),r*cos(phi+dphi),r*sin(phi+dphi))
    }
  }
  return path
end

def draw_cube(n,v)

paths = ''

0.upto(1) {|x|
  0.upto(1) {|y|
    0.upto(1) {|z|
      0.upto(1) {|xx|
        0.upto(1) {|yy|
          0.upto(1) {|zz|
            d = pythag_sq(x-xx,y-yy,z-zz)
            if d<1.01 and "#{x},#{y},#{z}"<"#{xx},#{yy},#{zz}" then
              #$stderr.print "#{x},#{y},#{z},#{xx},#{yy},#{zz}\n"
              0.upto(n-1) { |i|
                paths = paths + segment(x-0.5-$xo,y-0.5,z-0.5,xx-0.5-$xo,yy-0.5,zz-0.5,i,n,v)
              }
            end
          }
        }
      }
    }
  }
}
return paths
end

def segment(x1,y1,z1,x2,y2,z2,i,n,v)
  x = interp(x1,x2,i,n)
  xx = interp(x1,x2,i+1,n)
  y = interp(y1,y2,i,n)
  yy = interp(y1,y2,i+1,n)
  z = interp(z1,z2,i,n)
  zz = interp(z1,z2,i+1,n)
  xv,yv = viewport(x,y,z,v)
  xxv,yyv = viewport(xx,yy,zz,v)
  if xv.nan? or xxv.nan? then return '' end
  return path_template_two_points(xv,yv,xxv,yyv)
end

def path_template_two_points(x1,y1,x2,y2)
  return path_template(x1,y1,x2-x1,y2-y1)
end

def interp(a,b,i,n)
  return a+(i.to_f/n.to_f)*(b-a)
end

#-----------------------------------------------------------------------------------
def pythag_sq(x,y,z)
  return x**2+y**2+z**2
end

def pythag(x,y,z)
  return sqrt(pythag_sq(x,y,z))
end

def viewport(x,y,z,v)
  ry,rz = viewport_low_level(x,y,z,$xs,v) # ray appears to have come from point (xs,ry,rz) on screen
  return [$global_scale*ry,$global_scale*rz]
end

def viewport_low_level(x,y,z,xs,v)
  # returns the (y,z) coordinates of the point (xs,y,z) on the screen from which the ray appears to have come
  # observer is at origin; inputs are *present* positions in lab frame
  # screen is at xs

  if false then
  # time lag since ray was emitted
  # t^2=y^2+z^2+(x+vt)^2 -- propagated at c from the position where the point used to be
  t1,t2 = quadratic(1.0-v**2,-2.0*x*v,-x**2-y**2-z**2)
  t = t1
  if t2>t then t=t2 end # pick longer time lag -- could shorter one also be valid?
  #if t2<t then t=t2 end # ???

  # angle in lab frame
  theta = acos((x+v*t)/t)
  end

  # angle in lab frame
  theta = atan2(pythag(y,z,0.0),x) # returns 0 to pi because top is positive
  if theta>$biggest_theta then $biggest_theta = theta end
  if theta<$smallest_theta then $smallest_theta = theta end

  # aberration
  gamma = gamma_function(v)
  tan_theta_p = sin(theta)/(gamma*(cos(theta)+v))
  theta_p = atan(tan_theta_p)
  if theta_p<0 then theta_p = theta_p + 2.0*PI end
  if theta_p>$biggest_theta_p then $biggest_theta_p = theta_p end
  if theta_p<$smallest_theta_p then $smallest_theta_p = theta_p end
  if tan_theta_p>0.5*PI then return [0.0/0.0,0.0/0.0] end # NaN
  #s = (xs/(x+v*t))*(tan_theta_p/tan(theta))
  s = (xs/x)*(tan_theta_p/tan(theta))
  return [y*s,z*s]
end

def gamma_function(v)
  return 1/sqrt(1-v**2)
end

def quadratic(a,b,c)
  d = sqrt(b**2-4.0*a*c)
  x1 = (-b+d)/(2.0*a)
  x2 = (-b-d)/(2.0*a)
  return [x1,x2]
end

#-----------------------------------------------------------------------------------

def path_template(x,y,dx,dy)
return <<-"PATH"
    <path
       style="color:#000000;fill:none;stroke:#000000;stroke-width:0.35768592;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;stroke-dashoffset:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
       d="m #{x},#{y} #{dx},#{dy}"
       id="path3004"
       inkscape:connector-curvature="0" />
  PATH
end

def svg_template(x)
return <<-"TEMPLATE"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="744.09448819"
   height="1052.3622047"
   id="svg2"
   version="1.1"
   inkscape:version="0.48.4 r9939"
   sodipodi:docname="empty.svg">
  <defs
     id="defs4" />
  <sodipodi:namedview
     id="base"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="0.0"
     inkscape:pageshadow="2"
     inkscape:zoom="0.35"
     inkscape:cx="375"
     inkscape:cy="520"
     inkscape:document-units="px"
     inkscape:current-layer="layer1"
     showgrid="false"
     inkscape:window-width="1280"
     inkscape:window-height="996"
     inkscape:window-x="0"
     inkscape:window-y="0"
     inkscape:window-maximized="1" />
  <metadata
     id="metadata7">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:label="Layer 1"
     inkscape:groupmode="layer"
     id="layer1">
     #{x}
  </g>
</svg>
TEMPLATE
end
#------------------------------------------------------------------------------------------
main
