import math

l = 0    # affine parameter lambda
dl = .001  # change in l with each iteration
l_max = 100.

# initial position:
r=1
phi=0
# initial derivatives of coordinates w.r.t. lambda
vr = 0
vphi = 1

k = 0 # keep track of how often to print out updates
while l<l_max:
  l = l+dl
  # Christoffel symbols:
  Grphiphi = -r
  Gphirphi = 1/r
  # second derivatives:
  ar   = -Grphiphi*vphi*vphi
  aphi = -2.*Gphirphi*vr*vphi
      # ... factor of 2 because G^a_{bc}=G^a_{cb} and b
      #     is not the same as c
  # update velocity:
  vr = vr + dl*ar
  vphi = vphi + dl*aphi
  # update position:
  r = r + vr*dl
  phi = phi + vphi*dl
  if k%10000==0: # k is divisible by 10000
    phi_deg = phi*180./math.pi
    print "lambda=%6.2f   r=%6.2f   phi=%6.2f deg." % (l,r,phi_deg)
  k = k+1
