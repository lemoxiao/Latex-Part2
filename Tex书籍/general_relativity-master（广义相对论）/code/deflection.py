import math

# constants, in SI units:
G = 6.67e-11         # gravitational constant
c = 3.00e8           # speed of light
m_kg = 1.99e30       # mass of sun
r_m = 6.96e8         # radius of sun

# From now on, all calculations are in units of the
# radius of the sun.

# mass of sun, in units of the radius of the sun:
m_sun = (G/c**2)*(m_kg/r_m)
m = 1000.*m_sun

# Start at point of closest approach.
# initial position:
t=0
r=1 # closest approach, grazing the sun's surface
phi=-math.pi/2
# initial derivatives of coordinates w.r.t. lambda
vr = 0
vt = 1
vphi = math.sqrt((1.-2.*m/r)/r**2)*vt # gives ds=0, lightlike

l = 0    # affine parameter lambda
l_max = 20000.
epsilon = 1e-6 # controls how fast lambda varies
while l<l_max:
  dl = epsilon*(1.+r**2) # giant steps when farther out
  l = l+dl
  # Christoffel symbols:
  Gttr = m/(r**2-2*m*r)
  Grtt = m/r**2-2*m**2/r**3
  Grrr = -m/(r**2-2*m*r)
  Grphiphi = -r+2*m
  Gphirphi = 1/r
  # second derivatives:
  #  The factors of 2 are because we have, e.g., G^a_{bc}=G^a_{cb}
  at   = -2.*Gttr*vt*vr
  ar   = -(Grtt*vt*vt + Grrr*vr*vr + Grphiphi*vphi*vphi)
  aphi = -2.*Gphirphi*vr*vphi
  # update velocity:
  vt = vt + dl*at
  vr = vr + dl*ar
  vphi = vphi + dl*aphi
  # update position:
  r = r + vr*dl
  t = t + vt*dl
  phi = phi + vphi*dl

# Direction of propagation, approximated in asymptotically flat coords.
# First, differentiate (x,y)=(r cos phi,r sin phi) to get vx and vy:
vx = vr*math.cos(phi)-r*math.sin(phi)*vphi
vy = vr*math.sin(phi)+r*math.cos(phi)*vphi
prop = math.atan2(vy,vx) # inverse tan of vy/vx, in the proper quadrant
prop_sec = prop*180.*3600/math.pi
print "final direction of propagation = %6.2f arc-seconds" % prop_sec
