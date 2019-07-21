#!/usr/bin/python
# -*- coding: utf8 -*-
 
'''
VectorFieldPlot - plots electric and magnetic fieldlines in svg
http://commons.wikimedia.org/wiki/User:Geek3/VectorFieldPlot
 
Copyright (C) 2010 Geek3
 
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation;
either version 3 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.
 
You should have received a copy of the GNU General Public License
along with this program; if not, see http://www.gnu.org/licenses/
'''
 
version = '1.3'
 
 
from math import *
from lxml import etree
import scipy as sc
import scipy.optimize as op
import scipy.integrate as ig
import bisect
 
 
 
# some helper functions
def vabs(x):
    '''
    euclidian vector norm for any kind of vector
    '''
    return sqrt(sum([i**2 for i in x]))
 
def vnorm(x):
    '''
    vector normalisation
    '''
    d = vabs(x)
    if d != 0.: return sc.array(x) / vabs(x)
    return sc.array(x)
 
def rot(xy, phi):
    '''
    2D vector rotation
    '''
    s = sin(phi); c = cos(phi)
    return sc.array([c * xy[0] - s * xy[1], c * xy[1] + s * xy[0]])
 
def cosv(v1, v2):
    '''
    find the cosine of the angle between two vectors
    '''
    d1 = sum(v1**2); d2 = sum(v2**2)
    if d1 != 1.: d1 = sqrt(d1)
    if d2 != 1.: d2 = sqrt(d2)
    if d1 * d2 == 0.: return 1.
    return sc.dot(v1, v2) / (d1 * d2)
 
def sinv(v1, v2):
    '''
    find the sine of the angle between two vectors
    '''
    d1 = sum(v1**2); d2 = sum(v2**2)
    if d1 != 1.: d1 = sqrt(d1)
    if d2 != 1.: d2 = sqrt(d2)
    if d1 * d2 == 0.: return 0.
    return (v1[0] * v2[1] - v1[1] * v2[0]) / (d1 * d2)
 
def angle_dif(a1, a2):
    return ((a2 - a1 + pi) % (2. * pi)) - pi
 
def list_interpolate(l, t):
    n = max(0, bisect.bisect_right(l, t) - 1)
    s = None
    if t < l[0]:
        if l[1] - l[0] == 0.:
            s = 0.
        else:
            s = (t - l[0]) / float(l[1] - l[0])
    elif t >= l[-1]:
        n = len(l) - 2
        if l[-1] - l[-2] == 0.:
            s = 1.
        else:
            s = (t - l[-2]) / float(l[-1] - l[-2])
    else:
        s = (t - l[n]) / (l[n+1] - l[n])
    return n, s
 
def pretty_vec(p):
    return '{0:> 9.5f},{1:> 9.5f}'.format(p[0], p[1])
 
 
class FieldplotDocument:
    '''
    creates a svg document structure using lxml.etree
    '''
    def __init__ (self, name, width=800, height=600, digits=3.5, unit=100,
        center=None, licence='GFDL-cc', commons=False):
        self.name = name
        self.width = float(width)
        self.height = float(height)
        self.digits = float(digits)
        self.unit = float(unit)
        self.licence = licence
        self.commons = commons
        if center == None: self.center = [width / 2., height / 2.]
        else: self.center = [float(i) for i in center]
 
        # create document structure
        self.svg = etree.Element('svg',
            nsmap={None: 'http://www.w3.org/2000/svg',
            'xlink': 'http://www.w3.org/1999/xlink'})
        self.svg.set('version', '1.1')
        self.svg.set('baseProfile', 'full')
        self.svg.set('width', str(int(width)))
        self.svg.set('height', str(int(height)))
 
        # title
        self.title = etree.SubElement(self.svg, 'title')
        self.title.text = self.name
 
        # description
        self.desc = etree.SubElement(self.svg, 'desc')
        self.desc.text = ''
        self.desc.text += self.name + '\n'
        self.desc.text += 'created with VectorFieldPlot ' + version + '\n'
        self.desc.text += 'http://commons.wikimedia.org/wiki/User:Geek3/VectorFieldPlot\n'
        if commons:
            self.desc.text += """
about: http://commons.wikimedia.org/wiki/File:{0}.svg
""".format(self.name)
        if self.licence == 'GFDL-cc':
            self.desc.text += """rights: GNU Free Documentation license,
        Creative Commons Attribution ShareAlike license\n"""
        self.desc.text += '  '
 
        # background
        self.background = etree.SubElement(self.svg, 'rect')
        self.background.set('id', 'background')
        self.background.set('x', '0')
        self.background.set('y', '0')
        self.background.set('width', str(width))
        self.background.set('height', str(height))
        self.background.set('fill', '#ffffff')
 
        # image elements
        self.content = etree.SubElement(self.svg, 'g')
        self.content.set('id', 'image')
        self.content.set('transform',
            'translate({0},{1}) scale({2},-{2})'.format(
            self.center[0], self.center[1], self.unit))
 
        self.arrow_geo = {'x_nock':0.3,'x_head':3.8,'x_tail':-2.2,'width':4.5}
 
    def __get_defs(self):
        if 'defs' not in dir(self):
            self.defs = etree.Element('defs')
            self.desc.addnext(self.defs)
        return self.defs
 
    def __check_fieldlines(self, linecolor='#000000', linewidth=1.):
        if 'fieldlines' not in dir(self):
            self.fieldlines = etree.SubElement(self.content, 'g')
            self.fieldlines.set('id', 'fieldlines')
            self.fieldlines.set('fill', 'none')
            self.fieldlines.set('stroke', linecolor)
            self.fieldlines.set('stroke-width',
                str(linewidth / self.unit))
            self.fieldlines.set('stroke-linejoin', 'round')
            self.fieldlines.set('stroke-linecap', 'round')
        if 'count_fieldlines' not in dir(self): self.count_fieldlines = 0
 
    def __check_symbols(self):
        if 'symbols' not in dir(self):
            self.symbols = etree.SubElement(self.content, 'g')
            self.symbols.set('id', 'symbols')
        if 'count_symbols' not in dir(self): self.count_symbols = 0
 
    def __check_whitespot(self):
        if 'whitespot' not in dir(self):
            self.whitespot = etree.SubElement(
                self.__get_defs(), 'radialGradient')
            self.whitespot.set('id', 'white_spot')
            for attr, val in [['cx', '0.65'], ['cy', '0.7'], ['r', '0.75']]:
                self.whitespot.set(attr, val)
            for col, of, op in [['#ffffff', '0', '0.7'],
                ['#ffffff', '0.1', '0.5'], ['#ffffff', '0.6', '0'],
                ['#000000', '0.6', '0'], ['#000000', '0.75', '0.05'],
                ['#000000', '0.85', '0.15'], ['#000000', '1', '0.5']]:
                stop = etree.SubElement(self.whitespot, 'stop')
                stop.set('stop-color', col)
                stop.set('offset', of)
                stop.set('stop-opacity', op)
 
    def __get_arrowname(self, fillcolor='#000000'):
        if 'arrows' not in dir(self):
            self.arrows = {}
        if fillcolor not in self.arrows.iterkeys():
            arrow = etree.SubElement(self.__get_defs(), 'path')
            self.arrows[fillcolor] = arrow
            arrow.set('id', 'arrow' + str(len(self.arrows)))
            arrow.set('stroke', 'none')
            arrow.set('fill', fillcolor)
            arrow.set('transform', 'scale({0})'.format(1. / self.unit))
            arrow.set('d',
                'M {0},0 L {1},{3} L {2},0 L {1},-{3} L {0},0 Z'.format(
                self.arrow_geo['x_nock'], self.arrow_geo['x_tail'],
                self.arrow_geo['x_head'], self.arrow_geo['width'] / 2.))
        return self.arrows[fillcolor].get('id')
 
    def draw_charges(self, field, scale=1.):
        if 'monopoles' not in field.elements: return
        charges = field.elements['monopoles']
        self.__check_symbols()
        self.__check_whitespot()
 
        for charge in charges:
            c_group = etree.SubElement(self.symbols, 'g')
            self.count_symbols += 1
            c_group.set('id', 'charge{0}'.format(self.count_symbols))
            c_group.set('transform',
                'translate({0},{1}) scale({2},{2})'.format(
                charge[0], charge[1], float(scale) / self.unit))
 
            #### charge drawing ####
            c_bg = etree.SubElement(c_group, 'circle')
            c_shade = etree.SubElement(c_group, 'circle')
            c_symb = etree.SubElement(c_group, 'path')
            if charge[2] >= 0.: c_bg.set('style', 'fill:#ff0000; stroke:none')
            else: c_bg.set('style', 'fill:#0000ff; stroke:none')
            for attr, val in [['cx', '0'], ['cy', '0'], ['r', '14']]:
                c_bg.set(attr, val)
                c_shade.set(attr, val)
            c_shade.set('style',
                'fill:url(#white_spot); stroke:#000000; stroke-width:2')
            # plus sign
            if charge[2] >= 0.:
                c_symb.set('d', 'M 2,2 V 8 H -2 V 2 H -8 V -2'
                    + ' H -2 V -8 H 2 V -2 H 8 V 2 H 2 Z')
            # minus sign
            else: c_symb.set('d', 'M 8,2 H -8 V -2 H 8 V 2 Z')
            c_symb.set('style', 'fill:#000000; stroke:none')
 
    def draw_currents(self, field, scale=1.):
        if ('wires' not in field.elements
            and 'ringcurrents' not in field.elements):
            return
        self.__check_symbols()
        self.__check_whitespot()
        currents = []
        if 'wires' in field.elements:
            for i in field.elements['wires']:
                currents.append(i)
        if 'ringcurrents' in field.elements:
            for i in field.elements['ringcurrents']:
                currents.append(list(i[:2] + rot([0., i[3]], i[2])) + [i[-1]])
                currents.append(list(i[:2] - rot([0., i[3]], i[2])) + [-i[-1]])
 
        for cur in currents:
            c_group = etree.SubElement(self.symbols, 'g')
            self.count_symbols += 1
            if cur[-1] >= 0.: direction = 'out'
            else: direction = 'in'
            c_group.set('id',
                'current_{0}{1}'.format(direction, self.count_symbols))
            c_group.set('transform',
                'translate({0},{1}) scale({2},{2})'.format(
                cur[0], cur[1], float(scale) / self.unit))
 
            #### current drawing ####
            c_bg = etree.SubElement(c_group, 'circle')
            c_shade = etree.SubElement(c_group, 'circle')
            c_bg.set('style', 'fill:#b0b0b0; stroke:none')
            for attr, val in [['cx', '0'], ['cy', '0'], ['r', '14']]:
                c_bg.set(attr, val)
                c_shade.set(attr, val)
            c_shade.set('style',
                'fill:url(#white_spot); stroke:#000000; stroke-width:2')
            if cur[-1] >= 0.: # dot
                c_symb = etree.SubElement(c_group, 'circle')
                c_symb.set('cx', '0')
                c_symb.set('cy', '0')
                c_symb.set('r', '4')
            else: # cross
                c_symb = etree.SubElement(c_group, 'path')
                c_symb.set('d', 'M {1},-{0} L {0},-{1} L {2},{3} L {0},{1} \
L {1},{0} {3},{2} L -{1},{0} L -{0},{1} L -{2},{3} L -{0},-{1} L -{1},-{0} \
L {3},-{2} L {1},-{0} Z'.format(11.1, 8.5, 2.6, 0))
                c_symb.set('style', 'fill:#000000; stroke:none')
 
    def draw_magnets(self, field):
        if 'coils' not in field.elements: return
        coils = field.elements['coils']
        self.__check_symbols()
 
        for coil in coils:
            m_group = etree.SubElement(self.symbols, 'g')
            self.count_symbols += 1
            m_group.set('id', 'magnet{0}'.format(self.count_symbols))
            m_group.set('transform',
                'translate({0},{1}) rotate({2})'.format(
                coil[0], coil[1], degrees(coil[2])))
 
            #### magnet drawing ####
            r = coil[3]; l = coil[4]
            colors = ['#00cc00', '#ff0000']
            SN = ['S', 'N']
            if coil[5] < 0.:
                colors.reverse()
                SN.reverse()
            m_defs = etree.SubElement(m_group, 'defs')
            m_gradient = etree.SubElement(m_defs, 'linearGradient')
            m_gradient.set('id', 'magnetGrad{0}'.format(self.count_symbols))
            for attr, val in [['x1', '0'], ['x2', '0'], ['y1', str(coil[3])],
                ['y2', str(-coil[3])], ['gradientUnits', 'userSpaceOnUse']]:
                m_gradient.set(attr, val)
            for col, of, opa in [['#000000', '0', '0.125'],
                ['#ffffff', '0.07', '0.125'], ['#ffffff', '0.25', '0.5'],
                ['#ffffff', '0.6', '0.2'], ['#000000', '1', '0.33']]:
                stop = etree.SubElement(m_gradient, 'stop')
                stop.set('stop-color', col)
                stop.set('offset', of)
                stop.set('stop-opacity', opa)
            for i in [0, 1]:
                rect = etree.SubElement(m_group, 'rect')
                for attr, val in [['x', [-l, 0][i]], ['y', -r],
                    ['width', [2*l, l][i]], ['height', 2 * r],
                    ['style', 'fill:{0}; stroke:none'.format(colors[i])]]:
                    rect.set(attr, str(val))
            rect = etree.SubElement(m_group, 'rect')
            for attr, val in [['x', -l], ['y', -r],
                ['width', 2 * l], ['height', 2 * r],
                ['style', 'fill:url(#magnetGrad{0}); stroke-width:{1}; stroke-linejoin:miter; stroke:#000000'.format(self.count_symbols, 4. / self.unit)]]:
                rect.set(attr, str(val))
            for i in [0, 1]:
                text = etree.SubElement(m_group, 'text')
                for attr, val in [['text-anchor', 'middle'], ['y', -r],
                    ['transform', 'translate({0},{1}) scale({2},-{2})'.format(
                    [-0.65, 0.65][i] * l, -0.44 * r, r / 100.)],
                    ['style', 'fill:#000000; stroke:none; ' +
                    'font-size:120px; font-family:Bitstream Vera Sans']]:
                    text.set(attr, str(val))
                    text.text = SN[i]
 
    def draw_line(self, fieldline, maxdist=10., linewidth=2.,
        linecolor='#000000', attributes=[], arrows_style=None):
        '''
        draws a calculated fieldline from a FieldLine object
        to the FieldplotDocument svg image
        '''
        self.__check_fieldlines(linecolor, linewidth)
        self.count_fieldlines += 1
 
        bounds = {}
        bounds['x0'] = -(self.center[0] + 0.5 * linewidth) / self.unit
        bounds['y0'] = -(self.height - self.center[1] +
            0.5 * linewidth) / self.unit
        bounds['x1'] = (self.width - self.center[0] +
            0.5 * linewidth) / self.unit
        bounds['y1'] = (self.center[1] + 0.5 * linewidth) / self.unit
 
        # fetch the polyline from the fieldline object
        polylines = fieldline.get_polylines(self.digits, maxdist, bounds)
        if len(polylines) == 0: return
 
        line = etree.Element('path')
        if self.fieldlines.get('stroke') != linecolor:
            line.set('stroke', linecolor)
        if self.fieldlines.get('stroke-width') != str(linewidth / self.unit):
            line.set('stroke-width', str(linewidth / self.unit))
        for attr, val in attributes:
            line.set(attr, val)
 
        #### line drawing ####
        path_data = []
        for polyline in polylines:
            line_points = polyline['path']
            for i, p in enumerate(line_points):
                # go through all points, draw them if line segment is visible
                ptext = '{1:.{0}f},{2:.{0}f}'.format(
                    int(ceil(self.digits)), p[0], p[1])
                if i == 0: path_data.append('M ' + ptext)
                else: path_data.append('L ' + ptext)
        # close path if possible
        if (vabs(polylines[0]['path'][0] - polylines[-1]['path'][-1])
            < .1**self.digits):
            closed = True
            if len(polylines) == 1:
                path_data.append('Z')
            elif len(polylines) > 1:
                # rearrange array cyclic
                path_data.pop(0)
                while path_data[0][0] != 'M':
                    path_data.append(path_data.pop(0))
        else: closed = False
 
        path = ' '.join(path_data)
        line.set('d', path)
 
        if arrows_style == None:
            # include path directly into document structure
            line.set('id', 'fieldline{0}'.format(self.count_fieldlines))
            self.fieldlines.append(line)
        else:
            line_and_arrows = etree.SubElement(self.fieldlines, 'g')
            line_and_arrows.set('id', 'fieldline' + str(self.count_fieldlines))
            line_and_arrows.append(line)
            line_and_arrows.append(self.__draw_arrows(
                arrows_style, linewidth, polylines, linecolor, closed))
 
    def __draw_arrows(self, arrows_style, linewidth, polylines,
        linecolor='#000000', closed=False):
        '''
        draws arrows on polylines.
        options in "arrows_style":
        min_arrows: minimum number of arrows per segment
        max_arrows: maximum number of arrows per segment (None: no limit)
        dist: optimum distance between arrows
        scale: relative size of arrows to linewidth
        offsets [start_offset, mid_end, mid_start, end_offset]
        fixed_ends [True, False, False, True]:
        	make first/last arrow distance invariable
        '''
        min_arrows = 1; max_arrows = None; arrows_dist = 1.; scale = linewidth
        offsets = 4 * [0.5]; fixed_ends = 4 * [False]
        if 'min_arrows' in arrows_style:
            min_arrows = arrows_style['min_arrows']
        if 'max_arrows' in arrows_style:
            max_arrows = arrows_style['max_arrows']
        if 'dist' in arrows_style:
            arrows_dist = arrows_style['dist']
        if 'scale' in arrows_style:
            scale *= arrows_style['scale']
        if 'offsets' in arrows_style:
            offsets = arrows_style['offsets']
        if 'fixed_ends' in arrows_style:
            fixed_ends = arrows_style['fixed_ends']
        if scale == 1.: scaletext = ''
        else: scaletext = ' scale({0})'.format(scale)
 
        arrows = etree.Element('g')
        arrows.set('id', 'arrows' + str(self.count_fieldlines))
        for j, polyline in enumerate(polylines):
            line_points = polyline['path']
            mina = min_arrows
            maxa = max_arrows
            # measure drawn path length
            lines_dist = [0.]
            for i in range(1, len(line_points)):
                lines_dist.append(lines_dist[-1]
                    + vabs(line_points[i] - line_points[i-1]))
 
            offs = [offsets[2], offsets[1]]
            fixed = [fixed_ends[2], fixed_ends[1]]
            if polyline['start']:
                offs[0] = offsets[0]
                fixed[0] = fixed_ends[0]
            if polyline['end']:
                offs[1] = offsets[3]
                fixed[1] = fixed_ends[3]
 
            d01 = [0., lines_dist[-1]]
            for i in [0, 1]:
                if fixed[i]:
                    d01[i] += offs[i] * arrows_dist * [1., -1.][i]
                    mina -= 1
                    if maxa != None: maxa -= 1
            if d01[1] - d01[0] < 0.: break
            elif d01[1] - d01[0] == 0.: d_list = [d01[0]]
            else:
                d_list = []
                if fixed[0]: d_list.append(d01[0])
                if maxa > 0 or maxa == None:
                    number_intervals = (d01[1] - d01[0]) / arrows_dist
                    number_offsets = 0.
                    for i in [0, 1]:
                        if fixed[i]: number_offsets += .5
                        else: number_offsets += offs[i] - .5
                    n = int(number_intervals - number_offsets + 0.5)
                    n = max(n, mina)
                    if maxa != None: n = min(n, maxa)
                    if n > 0:
                        d = (d01[1] - d01[0]) / float(n + number_offsets)
                        if fixed[0]: d_start = d01[0] + d
                        else: d_start = offs[0] * d
                        for i in range(n):
                            d_list.append(d_start + i * d)
                if fixed[1]: d_list.append(d01[1])
 
            geo = self.arrow_geo # shortcut
            #### arrow drawing ####
            for d1 in d_list:
                # calculate arrow position and direction
                if d1 < 0. or d1 > lines_dist[-1]: continue
                d0 = d1 + (geo['x_nock'] * scale + 2.5*linewidth *
                    (geo['x_tail'] - geo['x_nock']) / geo['width']) / self.unit
                if closed and d0 < 0.: d0 = lines_dist[-1] + d0
                d2 = d1 + (geo['x_head'] * scale + linewidth *
                    (geo['x_tail'] - geo['x_head']) / geo['width']) / self.unit
                if closed and d2 > lines_dist[-1]: d1 -= lines_dist[-1]
                i0, s0 = list_interpolate(lines_dist, d0)
                i1, s1 = list_interpolate(lines_dist, d1)
                i2, s2 = list_interpolate(lines_dist, d2)
                p0 = line_points[i0] + s0 * (line_points[i0+1]-line_points[i0])
                p1 = line_points[i1] + s1 * (line_points[i1+1]-line_points[i1])
                p2 = line_points[i2] + s2 * (line_points[i2+1]-line_points[i2])
                p = None; angle = None
                if vabs(p2-p1) <= .1**self.digits or (d2 <= d0 and not closed):
                    v = line_points[i1+1] - line_points[i1]
                    p = p1
                    angle = atan2(v[1], v[0])
                else:
                    v = p2 - p0
                    p = p0 + sc.dot(p1 - p0, v) * v / vabs(v)**2
                    angle = atan2(v[1], v[0])
 
                arrow = etree.SubElement(arrows, 'use')
                arrow.set('{http://www.w3.org/1999/xlink}href',
                    '#' + self.__get_arrowname(linecolor))
                arrow.set('transform', ('translate({0:.'
                    + str(int(ceil(self.digits))) + 'f},{1:.'
                    + str(int(ceil(self.digits)))
                    + 'f}) rotate({2:.2f})').format(p[0], p[1],
                    degrees(angle)) + scaletext)
        return arrows
 
    def draw_object(self, name, params, group=None):
        '''
        Draw arbitraty svg object.
        Params must be a dictionary of valid svg parameters.
        '''
        self.__check_symbols()
        if group == None:
            obj = etree.SubElement(self.symbols, name)
        else:
            obj = etree.SubElement(group, name)
        for i, j in params.iteritems():
            obj.set(str(i), str(j))
        return obj
 
    def write(self, filename=None):
        # put symbols on top
        if 'content' in dir(self):
            for element in self.content:
                if element.get('id').startswith('symbols'):
                    self.content.append(element)
 
        # write content to file
        if filename == None: filename = self.name
        outfile = open(filename + '.svg', 'w')
        outfile.write(etree.tostring(self.svg, xml_declaration=True,
            pretty_print=True, encoding='utf-8'))
        outfile.close()
        print 'image written to', filename + '.svg'
 
 
 
class FieldLine:
    '''
    calculates field lines
    '''
    def __init__(self, field, start_p, start_v=None, start_d=None,
        directions='forward', maxn=1000, maxr=300.0, hmax=1.0,
        pass_dipoles=0, path_close_tol=5e-3, bounds_func=None,
        stop_funcs=[None, None]):
        '''
        field: a field in which the line exists
        start_p: [x0, y0]: where the line starts
        start_v: [vx0, vy0]: optional start direction
        start_d: [dx0, dy0]: optional dipole start direction (slope to x=1)
        directions: forward, backward, both: bidirectional
        unit: estimation for the scale of the scene
        maxn: maximum number of steps
        maxr: maximum number of units to depart from start
        hmax: maximum number of units for stepsize
        pass_dipoles: number of dipoles to be passed through (-1 = infinite)
        '''
        self.field = field
        self.p_start = sc.array(start_p)
        self.first_point = self.p_start
        self.bounds_func = bounds_func
        self.stop_funcs = stop_funcs
        if start_v == None: self.v_start = None
        else: self.v_start = sc.array(start_v)
        if start_d == None: self.d_start = None
        else: self.d_start = sc.array(start_d)
        self.__create_nodes(directions, maxn, maxr, hmax,
            pass_dipoles, path_close_tol)
 
    def __get_nearest_pole(self, p, v=None):
        '''
        returns distance to nearest pole
        '''
        p_near = self.first_point
        d_near = vabs(self.first_point - p)
        if v != None: d_near *= 1.3 - cosv(v, self.first_point - p)
        type_near = 'start'
        mon = []
        for ptype, poles in self.field.elements.iteritems():
            if ptype not in ['monopoles', 'dipoles'] or len(poles) == 0:
                continue
            for pole in poles:
                d = vabs(pole[:2] - p)
                if v != None: d *= 1.3 - cosv(v, pole[:2] - p)
                if d < d_near:
                    d_near = d
                    p_near = pole
                    type_near = ptype
        return sc.array(p_near), type_near
 
    def __rkstep(self, p, v, f, h):
        '''
        fourth order Runge Kutta step
        '''
        k1 = h * v
        k2 = h * f(p + k1 / 2.)
        k3 = h * f(p + k2 / 2.)
        k4 = h * f(p + k3)
        p1 = p + (k1 + 2. * (k2 + k3) + k4) / 6.
        return p1
 
    def __create_nodes_part(self, sign, maxn, maxr, hmax,
        pass_dipoles, path_close_tol):
        '''
        executes integration from startpoint to one end
        '''
        # p is always the latest position
        # v is always the latest normalized velocity
        # h is always the latest step size
        # l is always the summarized length
        err = 5e-8 # error tolerance for integration
        f = None
        if sign >= 0.: f = self.field.Fn
        else: f = lambda r: -self.field.Fn(r)
        # first point
        p = self.p_start
        if self.v_start != None:
            v = vnorm(self.v_start) * sign
        else:
            v = f(p)
        nodes = [{'p':p.copy(), 'v_in':None}]
        xtol = 20. * err; ytol = path_close_tol
        # initialize loop
        h = (sqrt(5) - 1.) / 10.; h_old = h
        l = 0.; i = 0
        while i < maxn and l < maxr:
            i += 1
            if len(nodes) == 1 and self.d_start != None:
                # check for start from a dipole
                h = vabs(self.d_start)
                p = p + self.d_start
                v = f(p)
                nodes[-1]['v_out'] = h * vnorm(2.0 * vnorm(self.d_start) - v)
                nodes.append({'p':p.copy(), 'v_in':h * v})
            elif len(nodes) > 1:
                # check for special cases
                nearest_pole, pole_type = self.__get_nearest_pole(p, v)
                vpole = nearest_pole[:2] - p
                dpole = vabs(vpole)
                vpole /= dpole
 
                cv = cosv(v, vpole); sv = sinv(v, vpole)
                if ((dpole < 0.1 or h >= dpole)
                    and (cv > 0.9 or dpole < ytol)):
                    # heading for some known special point
                    if pole_type == 'start':
                        # is the fieldline about to be closed?
                        if ((dpole * abs(sv) < ytol) and
                            (dpole * abs(cv) < xtol) and (l > 1e-3)):
                            # path is closed
                            nodes[-1]['v_out'] = None
                            print 'closed at', pretty_vec(p)
                            break
                        elif (h > 0.99 * dpole and (cv > 0.9 or
                            (cv > 0. and dpole * abs(sv) < ytol))):
                            # slow down
                            h = max(4.*err, dpole*cv * max(.9, 1-.1*dpole*cv))
 
                    if (pole_type == 'monopoles' and
                        dpole < 0.01 and cv > .996):
                        # approaching a monopole: end line with x**3 curve
                        nodes[-1]['v_out'] = vnorm(v) * dpole
                        v = vnorm(1.5 * vnorm(vpole) -
                            .5 * vnorm(nodes[-1]['v_out']))
                        nodes.append({'p':nearest_pole[:2].copy(),
                            'v_in':v * dpole, 'v_out':None})
                        l += h
                        break
 
                    if (pole_type == 'dipoles' and
                        dpole < 0.01 and cv > .996):
                        # approaching a dipole
                        m = sign * vnorm(nearest_pole[2:4])
                        p = nodes[-1]['p'] + 2. * sc.dot(m, vpole) * m * dpole
                        # approximation by a y=x**1.5 curve
                        nodes[-1]['v_out'] = 2. * vnorm(v) * dpole
                        nodes.append({'p':nearest_pole[:2].copy(),
                            'v_in':sc.zeros(2), 'v_out':sc.zeros(2)})
                        l += h
                        # check if the path is being closed
                        v_end = self.first_point - p
                        if ((dpole * abs(sinv(v, v_end)) < ytol) and
                            (dpole * abs(cosv(v, v_end)) < xtol) and l > 1e-3):
                            # path is closed
                            nodes[-1]['v_out'] = None
                            break
                        if pass_dipoles == 0:
                            nodes[-1]['v_out'] = None
                            break
                        if pass_dipoles > 0:
                            pass_dipoles -= 1
                        v = f(p)
                        nodes.append({'p':p.copy(), 'v_in':2.*vnorm(v)*dpole})
                        l += h
                        continue
 
                # buckle detection at unknown places
                elif h < 0.01:
                    # check change rate of curvature
                    hh = h * 3.
                    v0 = f(p + hh / 2. * v)
                    v1 = f(p + hh * v)
                    angle0 = atan2(v[1], v[0])
                    angle1 = atan2(v0[1], v0[0])
                    angle2 = atan2(v1[1], v1[0])
                    a0 = angle_dif(angle1, angle0)
                    a1 = angle_dif(angle2, angle1)
                    adif = angle_dif(a1, a0)
                    corner_limit = 1e4
                    if abs(adif) / hh**2 > corner_limit:
                        # assume a corner here
                        if abs(a0) >= abs(a1):
                            h0 = 0.; h1 = hh / 2.
                            vm = vnorm(vnorm(v) + vnorm(v0))
                        else:
                            h0 = hh / 2.; h1 = hh
                            vm = vnorm(vnorm(v0) + vnorm(v1))
                        if vabs(vm)==0.: vm = vnorm(sc.array([v0[1], -v0[0]]))
                        hc = op.brentq(lambda hc: sinv(f(p+hc*v), vm), h0, h1)
                        v2 = f(p + hc / 2. * v)
                        if sinv(f(p), vm) * sinv(f(p + 2.*hc*v2), vm) <= 0.:
                            hc = op.brentq(lambda hc: sinv(f(p + hc * v2),
                                vm), 0., 2. * hc)
                        nodes[-1]['v_out'] = vnorm(nodes[-1]['v_in']) * hc
                        # create a corner
                        # use second-order formulas instead of runge-kutta
                        p += hc * v2
                        print 'corner at', pretty_vec(p)
                        v = vnorm(2. * v2 - v)
                        nodes.append({'p':p.copy(),'v_in':v*hc,'corner':True})
                        l += h
                        # check if the path is being closed
                        v_end = self.first_point - p
                        if ((dpole * abs(sinv(v, v_end)) < ytol) and
                            (dpole * abs(cosv(v, v_end)) < xtol) and l > 1e-3):
                            # path is closed
                            nodes[-1]['v_out'] = None
                            break
                        # check area after the corner
                        # lengths are chosen to ensure corner detection
                        p0 = p + hh * .2 * f(p + hh * .2 * v1); va0 = f(p0)
                        p1 = p0 + hh * .4 * va0; va1 = f(p1)
                        p2 = p1 + hh * .4 * va1; va2 = f(p2)
                        angle0 = atan2(va0[1], va0[0])
                        angle1 = atan2(va1[1], va1[0])
                        angle2 = atan2(va2[1], va2[0])
                        a0 = angle_dif(angle1, angle0)
                        a1 = angle_dif(angle2, angle1)
                        adif = angle_dif(a1, a0)
                        if (abs(adif) / (.8*hh)**2 > corner_limit or
                            abs(a0) + abs(a1) >= pi / 2.):
                            print 'end edge at', pretty_vec(p)
                            # direction after corner changes again -> end line
                            nodes[-1]['v_out'] = None
                            break
                        vm = vnorm(1.25 * va1 - 0.25 * va2)
                        v = f(p + hh * vm)
                        nodes[-1]['v_out'] = vnorm(2. * vm - v) * hh
                        p += vm * hh
                        nodes.append({'p':p.copy(), 'v_in':v * hh})
                        l += h
 
            # make single and double runge-kutta step
            p11 = self.__rkstep(p, vnorm(v), f, h)
            p21 = self.__rkstep(p, vnorm(v), f, h / 2.)
            p22 = self.__rkstep(p21, f(p21), f, h / 2.)
            diff = vabs(p22 - p11)
            if diff < 2. * err:
                # accept step
                p = (16. * p22 - p11) / 15.
                nodes[-1]['v_out'] = vnorm(v) * h
                v = f(p)
                if vabs(v) == 0.:
                    # field is zero, line is stuck -> end line
                    nodes[-1]['v_out'] = None
                    break
                if (len(nodes) >= 2
                    and vabs(nodes[-1]['p'] - nodes[-2]['p']) == 0.):
                    if h > 2. * err: h /= 7.
                    else:
                        # point doesn_t move, line is stuck -> end line
                        nodes = nodes[:-1]
                        nodes[-1]['v_out'] = None
                        break
                nodes.append({'p':p.copy(), 'v_in':v * h})
                l += h
 
            # stop at the prohibited area
            if self.stop_funcs != None and self.stop_funcs != [None, None]:
                stop_fct = self.stop_funcs[{-1.0:0, 1.0:1}[sign]]
                if stop_fct(nodes[-1]['p']) > 0.0:
                    while len(nodes) > 1 and stop_fct(nodes[-2]['p']) > 0.0:
                        nodes = nodes[:-1]
                    if len(nodes) > 1:
                        p, p1 = nodes[-2]['p'], nodes[-1]['p']
                        t = op.brentq(lambda t: stop_fct(p + t * (p1 - p)),
                            0.0, 1.0)
                        nodes[-1]['p'] = p + t * (p1 - p)
                        h = vabs(nodes[-1]['p'] - p)
                        nodes[-2]['v_out'] = f(nodes[-2]['p']) * h
                        nodes[-1]['v_in'] = f(nodes[-1]['p']) * h
                    print 'stopped at', pretty_vec(nodes[-1]['p'])
                    break 
 
            # adapt step carefully
            if diff > 0.:
                factor = (err / diff) ** .25
                if h < h_old: h_new = min((h + h_old) / 2., h * factor)
                else: h_new = h * max(0.5, factor)
                h_old = h
                h = h_new
            else:
                h_old = h
                h *= 2.
            h = min(hmax, max(err, h))
 
        nodes[-1]['v_out'] = None
        if i == maxn:
            print maxn, 'integration steps exceeded at', pretty_vec(p)
        if l >= maxr:
            print 'integration boundary',str(maxr),'exceeded at',pretty_vec(p)
        return nodes
 
    def __is_loop(self, nodes, path_close_tol):
        if vabs(nodes[0]['p'] - nodes[-1]['p']) >  max(5e-4, path_close_tol):
            return False
        length = 0.
        for i in range(1, len(nodes)):
            length += vabs(nodes[i]['p'] - nodes[i-1]['p'])
            if length > 5e-3:
                return True
        return False
 
    def __create_nodes(self, directions,
        maxn, maxr, hmax, pass_dipoles, path_close_tol):
        '''
        creates self.nodes from one or two parts
        wrapper for __self.create_nodes_part
        '''
        closed = False
        if (directions == 'forward'):
            self.nodes = self.__create_nodes_part(
                1., maxn, maxr, hmax, pass_dipoles, path_close_tol)
        else:
            nodes1 = self.__create_nodes_part(
                -1., maxn, maxr, hmax, pass_dipoles, path_close_tol)
            # reverse nodes1
            nodes1.reverse()
            for node in nodes1:
                v_out = node['v_out']
                if node['v_in'] == None: node['v_out'] = None
                else: node['v_out'] = -node['v_in']
                if v_out == None: node['v_in'] = None
                else: node['v_in'] = -v_out
            self.nodes = nodes1
            if len(self.nodes) > 0: self.first_point = self.nodes[0]['p']
            if directions != 'backward':
                # is it already a closed loop?
                if not self.__is_loop(self.nodes, path_close_tol):
                    nodes2 = self.__create_nodes_part(
                        1., maxn, maxr, hmax, pass_dipoles, path_close_tol)
                    self.nodes[-1]['v_out'] = nodes2[0]['v_out']
                    self.nodes += nodes2[1:]
 
        # append accumulated normalized sum
        self.nodes[0]['t'] = 0.
        for i in range(1, len(self.nodes)):
            self.nodes[i]['t'] = (self.nodes[i-1]['t']
                + vabs(self.nodes[i-1]['p'] - self.nodes[i]['p']))
        length = self.nodes[-1]['t']
        if length != 0.:
            for i in range(1, len(self.nodes)):
                self.nodes[i]['t'] /= length
        # add corner tag to all nodes
        for i, node in enumerate(self.nodes):
            if not node.has_key('corner'):
                self.nodes[i]['corner'] = False
 
    def get_position(self, t):
        '''
        dense output routine
        t: parameter, 0 <= t <= 1
        '''
        nodes = self.nodes
        if len(nodes) == 1:
            return nodes[0]['p']
        if len(nodes) <= 0:
            return sc.zeros(2)
        if t != 1.: t = t % 1.
        n, p = list_interpolate([i['t'] for i in nodes], t)
        p0, v0 = nodes[n]['p'], nodes[n]['v_out']
        p1, v1 = nodes[n+1]['p'], nodes[n+1]['v_in']
        # cubic bezier interpolation (hermite interpolation)
        q = 1. - p
        xy = q*p0 + p*p1 + p * q * ((p - q) * (p1 - p0) + (q*v0 - p*v1))
        return xy
 
    def __bending(self, p0, p3, t0, t3):
        # calculate two extra points on intervall
        p1 = self.get_position((2.*t0 + t3) / 3.)
        p2 = self.get_position((t0 + 2.*t3) / 3.)
        # d1, d2: point distances from straight line
        d1 = (p1 - p0)[0] * (p3 - p0)[1] - (p1 - p0)[1] * (p3 - p0)[0]
        d1 /= vabs(p3 - p0)
        d2 = (p2 - p0)[0] * (p3 - p0)[1] - (p2 - p0)[1] * (p3 - p0)[0]
        d2 /= vabs(p3 - p0)
        dsum, ddif = d1 + d2, d1 - d2
        d = 0.
        if abs(ddif) < 1e-5:
            d = 10. / 9. * (abs(d1) + abs(d2)) / 2.
        else:
            # calculate line bending as max distance of a deg-3 polynomial:
            y = lambda x: 13.5 * x * (1.-x) * (d1 * (2./3.-x) + d2 * (x-1./3.))
            # all the factors come from the quadratic formula
            xm = .5 + dsum / (18. * ddif)
            xd = sqrt(27. * ddif**2 + dsum**2) / (18. * ddif)
            x1, x2 = min(xm + xd, xm - xd), max(xm + xd, xm - xd)
            if x1 > 0.:
                d = max(d, abs(y(x1)))
            if x2 < 1.:
                d = max(d, abs(y(x2)))
        return d
 
    def __get_polyline(self, t0, t1, digits=3.5, maxdist=10., mindist=4e-4):
        '''
        returns points of an adapted polyline,
        representing the fieldline to an accuracy of digits.
        no corner should be between t0 and t1.
        '''
        f = self.get_position
        t_list = sc.linspace(t0, t1, 10)
        value_list = [f(t) for t in t_list]
 
        # adapt t_list
        num = 0; num_success = 0
        while len(t_list) > 2:
            ratios = []; delta_t = []
            N_old = len(t_list) - 1
            success = True
            # get bending
            for i in range(N_old):
                bend = self.__bending(value_list[i], value_list[i+1],
                    t_list[i], t_list[i + 1])
                d = vabs(value_list[i+1] - value_list[i])
                # keep point distance smaller than maxdist
                ratio = d / maxdist
                if num > 10: exponent = 1. / (num - 8.)
                else: exponent = 0.5
                # find best ratio, assuming bending is proportional to d**2
                if bend != 0.:
                    ratio = max(ratio, (bend / 0.1 ** digits)**exponent)
                ratio = min(ratio, d / mindist)
                if ratio > 1.1: # 1 + 0.1 for termination safety
                    success = False
                ratio = min(max(.25, ratio), 4.) # prevent too big changes
                ratios.append(ratio)
                delta_t.append(t_list[i + 1] - t_list[i])
 
            n = sum(ratios)
            N = max(1, ceil(n)) # new intervall number must be an integer
            num += 1
            # check if we all intervalls are good enough and we are finished
            if success == True: num_success += 1
            else: num_success = 0
            if num_success > 2 and N < N_old: num_success = 2
            if num_success >= 3: break
            if num >= 25:
                print 'polyline creation did not converge after', num, 'tries!'
                break
            ratios = [ratio * N / n for ratio in ratios]
 
            # rearrange t_list
            t_list = [t0] # initialize again
            N0 = 0; Nt = 0.; N1 = 0.; t = t0
            for i in range(N_old):
                N1 += ratios[i]
                while N1 - N0 >= 1.:
                    N0 += 1
                    t += delta_t[i] * (N0 - Nt) / ratios[i]
                    Nt = N0
                    if len(t_list) == N:
                        break
                    t_list.append(t)
                t += delta_t[i] * (N1 - Nt) / ratios[i]
                Nt = N1
            t_list.append(t1)
            value_list = [f(t) for t in t_list]
        return value_list, t_list
 
    def __out_of_bounds(self, p, bounds):
        '''
        returns a points distance to the drawing area
        >0: outside;    <=0: inside
        '''
        if self.bounds_func != None:
            s = self.bounds_func(p)
            if s > 0.: return s
        if bounds == None: return -1.
        if (p[0] < bounds['x0'] or p[1] < bounds['y0']
            or p[0] > bounds['x1'] or p[1] > bounds['y1']):
            return sqrt((p[0] - bounds['x0'])**2 + (p[1] - bounds['y0'])**2
                + (bounds['x1'] - p[0])**2 + (bounds['y1'] - p[1])**2)
        else:
            return max(bounds['x0'] - p[0], bounds['y0'] - p[1],
                p[0] - bounds['x1'], p[1] - bounds['y1'])
 
    def get_polylines(self, digits=3.5, maxdist=10., bounds=None):
        '''
        returns polyline segments that are inside of bounds.
        the path is represented as a set of adapted line segments
        which are cut at the image bounds and at edges.
        '''
        if len(self.nodes) <= 1: return []
 
        # search for all corners
        corners = []
        for node in self.nodes:
            if node['corner']: corners.append(node['t'])
        if len(corners) == 0 or corners[0] != 0.: corners.insert(0, 0.)
        if corners[-1] != 1.: corners.append(1.)
 
        # search for points where line intersects bounds
        edges = []; parts_outside = False; inside1 = False; t1 = 0.
        if self.__out_of_bounds(self.nodes[0]['p'], bounds) <= 0.:
            inside1 = True
            edges.append({'t0':0.})
        for i in range(1, len(self.nodes)):
            t0 = t1; t1 = self.nodes[i]['t']
            p1 = self.nodes[i]['p']
            inside0 = inside1
            inside1 = (self.__out_of_bounds(p1, bounds) <= 0.)
            if inside1:
                if not inside0:
                    edges.append({'t0':op.brentq(lambda t: 
                        self.__out_of_bounds(self.get_position(t),
                        bounds), t0, t1)})
                if i == len(self.nodes) - 1:
                    edges[-1]['t1'] = 1.
            else:
                parts_outside = True
                if inside0:
                    edges[-1]['t1'] = (op.brentq(lambda t:
                        self.__out_of_bounds(self.get_position(t),
                        bounds), t0, t1))
 
        # all points are outside the drawing area
        if len(edges) == 0: return []
 
        # join first and last segment
        if (len(edges) > 1 and
            edges[0]['t0'] == 0. and edges[-1]['t1'] == 1. and
            vabs(self.get_position(1.) - self.get_position(0.)) <= 1e-5):
            edges[0]['t0'] = edges[-1]['t0'] - 1.
            edges = edges[:-1]
 
        # insert corners to all segments
        for edge in edges:
            edge['corners'] = []
            for c in corners:
                if edge['t0'] < c and c < edge['t1']:
                    edge['corners'].append(c)
 
        # create final polylines
        polyline = []
        for interval in edges:
            line = []
            t_list = [interval['t0']] + interval['corners'] + [interval['t1']]
            for i in range(1, len(t_list)):
                pl = self.__get_polyline(t_list[i-1], t_list[i],
                    digits, maxdist)[0]
                if i == 1: line += pl
                else: line += pl[1:]
            if len(line) >= 2:
                polyline.append({'path':line,
                    'start':(interval['t0']==0.), 'end':(interval['t1']==1.)})
        return polyline
 
 
 
class Field:
    '''
    represents an electromagnetic field together with
    charges, potential, setup etc.
    '''
    def __init__ (self, elements={}):
        self.elements = {}
        for name, params in elements.iteritems():
            self.add_element(name, params)
 
    '''
    possible types:
    'homogeneous': [Fx, Fy]
    'monopoles': [x, y, charge]
    'dipoles': [x, y, phi, q]
    'quadrupoles': [x, y, phi, q]
    'wires': [x, y, I]
    'charged_planes': [x0, y0, x1, y1, charge]
    'ringcurrents': [x0, y0, phi, R, I]
    'coils': [x0, y0, phi, R, Lhalf, I]
    'custom': user defined function
    '''
 
    def add_element(self, name, params):
        if len(params) >= 1 and str(type(params[0])) == "<type 'function'>":
            if name in self.elements: self.elements[name] += params
            else: self.elements[name] = params
        else:
            el = [sc.array(param, dtype='float') for param in params]
            if name in self.elements: self.elements[name] += el
            else: self.elements[name] = el
 
    def get_elements(self, name):
        if name in self.elements: return self.elements[name]
        else: return []
 
    def F(self, xy):
        '''
        returns the field force as a vector
        '''
        Fxy = sc.zeros(2)
 
        # homogeneous: homogeneus field in a given direction
        for hom in self.get_elements('homogeneous'):
            Fxy += hom
 
        # monopoles: electric charges and magnetic monopoles
        for mon in self.get_elements('monopoles'):
            r = xy - sc.array(mon[:2])
            d = vabs(r)
            if d != 0.:
                Fxy += mon[-1] * r / d**3
 
        # dipoles: pointlike electric or magnetic dipole
        for dip in self.get_elements('dipoles'):
            r = xy - sc.array(dip[:2])
            d = vabs(r)
            if d != 0.:
                p = sc.array(dip[2:4])
                Fxy += (3. * sc.dot(p, r) * r - sc.dot(r, r) * p) / (4.*pi*d**5)
            else:
                # the sign of this is unphysical, but more useful
                return dip[2:4]
 
        # quadrupoles: pointlike electric or magnetic quadrupoles
        for quad in self.get_elements('quadrupoles'):
            r = xy - sc.array(quad[:2])
            d = vabs(r)
            r /= d
            if d != 0.:
                p = rot([0,1], quad[2])
                pr = sc.dot(p, r)
                Fxy += (((5.*pr**2 - 1.) * r - 2.*pr * p) *
                    3.*quad[3] / (4.*pi * d**4))
            else:
                return quad[2:4]
 
        # wires: infinite straight wire perpendicular to image plane
        for wire in self.get_elements('wires'):
            r = xy - sc.array(wire[:2])
            Fxy += wire[-1]/(2*pi) * sc.array([-r[1], r[0]]) / (r[0]**2 + r[1]**2)
 
        # charged_planes: rectangular plane with edges [x0,y0] and [x1,y1]
        # perpendicular to image plane and infinite in z-direction
        for plane in self.get_elements('charged_planes'):
            r = xy - .5 * (plane[2:4] + plane[0:2])
            p = .5 * (plane[2:4] - plane[0:2])
            rsq = r[0]**2 + r[1]**2
            psq = p[0]**2 + p[1]**2
            X = r[0] * p[1] - p[0] * r[1]
            Y = r[1] * p[1] + p[0] * r[0]
            if X == 0.: Fa = 0.
            else: Fa = atan((psq - Y) / X) + atan((psq + Y) / X) 
            Fb = atanh(2. * Y / (rsq + psq))
            Fxy += (plane[4] / (4*pi*psq)
                * sc.array([Fa*p[1]+Fb*p[0], Fb*p[1]-Fa*p[0]]))
 
        # ringcurrents: round currentloop perpendicular to image plane
        # caution: slow because of numerical integration
        for ring in self.get_elements('ringcurrents'):
            r = xy - sc.array(ring[:2])
            # change into a relative coordinate system with a and b
            a, b = rot(r, -ring[2]) / ring[3]
            c = 1. + a**2 + b**2
            def fa(t): h=cos(t); return (1.-b*h) / sqrt((c-2.*b*h)**3)
            def fb(t): h=cos(t); return (a * h) / sqrt((c-2.*b*h)**3)
            Fa = ig.quad(fa, 0., pi, epsrel=0., full_output=True)[0]
            Fb = ig.quad(fb, 0., pi, epsrel=0., full_output=True)[0]
            # backtransform
            Fxy += rot([Fa, Fb], ring[2]) * (ring[-1] / ring[3])
 
        # coil: dense cylinder coil or cylinder magnet
        # caution: slow because of numerical integration
        for coil in self.get_elements('coils'):
            r = xy - sc.array(coil[:2])
            # change into a relative coordinate system with a and b
            a, b = rot(r, -coil[2]) / coil[3]
            c = 1. + b**2
            l = coil[4] / coil[3]
            am = a - l; am2 = am ** 2
            ap = a + l; ap2 = ap ** 2
            def fa(t):
                h = cos(t);
                d = c - 2. * b * h
                return (1. - b*h) / d * (ap / sqrt(d + ap2)
                    - am / sqrt(d + am2))
            def fb(t):
                h = cos(t);
                d = c - 2. * b * h
                return h / sqrt(d + am2) - h / sqrt(d + ap2)
            Fa = ig.quad(fa, 0., pi, full_output=True)[0]
            Fb = ig.quad(fb, 0., pi, full_output=True)[0]
            # backtransform
            Fxy += rot([Fa, Fb], coil[2]) * (coil[-1] / (2. * coil[4]))
 
        # custom: user defined function
        for cust in self.get_elements('custom'):
            Fxy += cust(xy)
 
        return Fxy
 
    def Fn(self, xy):
        '''
        returns the normalized field force, i.e. direction of field lines
        '''
        force = self.F(xy)
        d = vabs(force)
        if (d != 0.): return force / d
        return sc.array([0., 0.])
 
### append your specific field creation here ###

print "generating files u.svg, like charges"

# paste this code at the end of VectorFieldPlot 1.0
doc = FieldplotDocument('u', width=800, height=800)
field = Field({'monopoles':[[-1,0,-1], [1,0,-1]]})
doc.draw_charges(field)
for x in [-1, 1]:
    line = FieldLine(field, [x,0], start_v=[x, 0],
        directions='backward')
    doc.draw_line(line)
n = 32
for i in range(n):
    a = 2.0 * pi * (0.5 + i) / n
    line = FieldLine(field, [10.*cos(a), 10.*sin(a)],
        directions='forward')
    doc.draw_line(line)
doc.write()

print "generating files v.svg, opposite charges"

# paste this code at the end of VectorFieldPlot 1.0
doc = FieldplotDocument('v', width=800, height=800)
field = Field({'monopoles':[[-1,0,1], [1,0,-1]]})
doc.draw_charges(field)
n = 16
for i in range(n):
    a = (0.5 + i) / n
    a = 2.0 * pi * a
    line = FieldLine(field, [-1,0], start_v=[cos(a), sin(a)],
        directions='forward')
    doc.draw_line(line)
doc.write()
