THE_URL:file://localhost/Users/hubery/Public/ucar/Document/Functions/Contributed/g2fsh_Wrap.shtml
THE_TITLE:g2fsh_Wrap
   NCL Home > Documentation > Functions > Regridding

g2fsh_Wrap

   Interpolates a scalar quantity from a Gaussian grid to a fixed grid (retains metadata).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function g2fsh_Wrap (
                grid        : numeric,
                outdims [2] : integer
        )

        return_val  :  float or double

Arguments

   grid

   An array of 2 or more dimensions whose rightmost two dimensions must be latitude x longitude. The values must be in
   ascending latitude order.
   outdims

   An array indicating the dimensions of the rightmost two dimensions of the output grid (outdims[0] = nlatb, outdims[1] =
   nlonb).

Return value

   The return array's dimensions are the same as grid's dimensions, except the rightmost two dimensions, nlata and nlona,
   are replaced by nlatb and nlonb. The type will be double if the input is double, and float otherwise.

Description

   g2fsh_Wrap interpolates a scalar quantity on a Gaussian grid to a fixed grid using spherical harmonics (via the
   Spherepack code). Values will be in ascending latitude order.

   If missing values are encountered in a 2D subsection of the input array, then no interpolation will be performed on that
   2D array, and the corresponding 2D subsection of the return array will be filled with missing values.

   Arrays which have dimensions [...] x nlata x nlona should not include the cyclic (wrap-around) points when invoking this
   function. For example, if an array x has dimensions nlata = 64 and nlona = 129, where the "129" represents the cyclic
   point, then the user should pass the data to g2fsh_Wrap via:
  z = g2fsh_Wrap ( x(...,0:nlona-2) )  ; does not include cyclic points

   This function can only be used on grids that span the globe. It cannot be used for limited area grids.

   Please read the caveats that you should be aware of when using spherical harmonic regridding.

   This function is identical to the built-in function g2fsh except it retains metadata.

See Also

   f2fosh_Wrap, f2fsh_Wrap, f2gsh_Wrap, fo2fsh_Wrap, g2fsh_Wrap, g2gsh_Wrap

Examples

   Assume x is dimensioned nt x nlat x nlon. The code below interpolates from a Gaussian T63 grid (nlat=96, nlon=192) to a
   fixed 2.5 x 5.0 degree grid (jlat=73,ilon=72):

  X = g2fsh_Wrap (x, (/jlat,ilon/))     ; ==> X(nt,jlat,ilon)

Errors

   ier is equal to:

     4 or 10 if nlona is less than 4
     5 or 10 if nlata is less than 3
     8 if nlonb is less than 4
     9 if nlatb is less than 3


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
