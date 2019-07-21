import graph;

pair project(triple P)
{
	return (P.y-P.x/sqrt(2), P.z-P.x/sqrt(2));
}

real angleBetween(triple O, triple A, triple B)
{
	triple u = A - O, v = B - O;
	return -acos(dot(u, v) / (length(u) * length(v)) );
}

guide angleMark(triple O, triple A, triple B, real r)
{
	return graph(
		new pair (real t)
		{
			triple u = unit(A - O);
			triple v = unit(cross(u, cross(u, B - O) ) );
			return project(O + r * (u * cos(t) + v * sin(t) ) );
		},
		0, angleBetween(O, A, B) );
}
