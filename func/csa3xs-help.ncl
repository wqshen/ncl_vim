THE_URL:file://localhost/Users/hubery/Public/ucar/Document/Functions/Built-in/csa3xs.shtml
THE_TITLE:csa3xs
   NCL Home > Documentation > Functions > Interpolation, Ngmath routines

csa3xs

   Calculates an approximating cubic spline for three-dimensional input data.

Prototype

        function csa3xs (
                xi     [*] : float,
                yi     [*] : float,
                zi     [*] : float,
                ui         : float,
                wts        : float,
                knots  [3] : integer,
                smth   [1] : float,
                nderiv [3] : integer,
                xo     [*] : float,
                yo     [*] : float,
                zo     [*] : float
        )

        return_val  :  float

Arguments

   xi

   A 1-dimensional array of length nxi containing the X coordinates of the input data points.
   yi

   A 1-dimensional array of length nxi containing the Y coordinates of the input data points.
   zi

   A 1-dimensional array of length nxi containing the Z coordinates of the input data points.
   ui

   An array of any dimensionality (last dimension must be nxi) containing the functional values at the input data
   coordinates given by xi, yi, and zi. That is, ui(...,k) is the input function value at (xi(k),yi(k),zi(k)) for k = 0 to
   nxi-1.
   wts

   A scalar or an array of length nxi containing weights for the ui values at the input xi values. If wts is an array, then
   wts(k) is a weight for the value of ui(...,k) for k=0,nxi-1. If you do not desire to weight the input ui values, then set
   wts equal to -1. The weights in the wts array are relative and may be set to any non-negative value. When csa3xs is
   called, the weights are summed and the individual weights are normalized so that the weight sum is unity.
   knots

   The number of knots to be used in constructing the approximating surface. knots(0), knots(1), and knots(2) must all be at
   least 4. The larger the value for knots, the closer the approximated surface will come to passing through the input
   function values.
   smth

   A parameter that controls extrapolation into sparse data regions. If smth is zero, then nothing special is done in sparse
   data regions. A good first choice for smth is 1.
   nderiv

   Specifies whether you want functional values (nderiv=0), first derivative values (nderiv=1), or second derivative values
   (nderiv=2) in each of the three coordinate directions.
   xo

   A one-dimensional array of length nxo containing the X coordinates of the approximating spline.
   yo

   A one-dimensional array of length nyo containing the Y coordinates of the approximating spline.
   zo

   A one-dimensional array of length nzo containing the Z coordinates of the approximating spline.

Return value

   An array containing the calculated functional values. The array will be dimensioned N x nxo x nyo x nzo, where N
   represents all but the last dimension of ui. If uo is the returned value, then uo(...,i,j,k) contains the functional
   value at coordinate (xo(i),yo(j),zo(k)).

Description

   This function is part of the Csagrid package - a software package that implements a cubic spline approximation algorithm
   to fit a function to input data. The input for the approximation is a set of randomly-spaced data, which may be
   one-dimensional, two-dimensional, or three-dimensional. The general documentation for Csagrid contains several complete
   examples.

   The following three three-dimensional functions all do the same thing, differing only in the type of the input and output
   arrays: csa3 (generic input/output); csa3s (single input/output); csa3d (double input/output).

   If you want to weight the input data values, calculate derivatives, or handle sparse data areas specially, you should
   instead use one of these "expanded" functions (note the "x" following the "3" in the name): csa3x (generic input/output);
   csa3xs (single input/output); csa3xd (double input/output).

   If you want to compute function values at a specified list of coordinate positions, rather than at coordinate positions
   forming a grid, you should use one of these six "list form" functions (note the "l" following the "3" in the name):
   csa3l; csa3ls; csa3ld; csa3lx; csa3lxs; csa3lxd.

Examples

begin

;
;  Create the input arrays.
;
  xmin = -2.
  xmax =  2.
  ymin = -2.
  ymax =  2.
  zmin = -2.
  zmax =  2.

  nx = 21
  ny = 21
  nz = 21

  ndata = 1000
  xi = new(ndata,float)
  yi = new(ndata,float)
  zi = new(ndata,float)
  ui = new(ndata,float)

  do i=0,ndata-1
      xi(i) = xmin + (xmax-xmin)*rand()/32767.
      yi(i) = ymin + (ymax-ymin)*rand()/32767.
      zi(i) = zmin + (zmax-zmin)*rand()/32767.
      ui(i) = xi(i)*xi(i) + yi(i)*yi(i) + zi(i)*zi(i)
  end do

;
;  Set up the output grid.
;
  xo = fspan(xmin,xmax,nx)
  yo = fspan(ymin,ymax,ny)
  zo = fspan(zmin,zmax,nz)

;
;  Calculate the values for the approximating cubic spline for the
;  first partial derivative with respect to Y.
;
  knots = (/4,4,4/)
  wts = -1.
  smth = 0.
  nderiv = (/0,1,0/)
  uo = csa3xs(xi,yi,zi,ui,wts,knots,smth,nderiv,xo,yo,zo)

end


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
