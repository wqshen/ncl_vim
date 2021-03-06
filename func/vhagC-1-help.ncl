THE_URL:file://localhost/Users/hubery/Public/ucar/Document/Functions/Built-in/vhagC-1.shtml
THE_TITLE:vhagC
   NCL Home > Documentation > Functions > Spherical harmonic routines

vhagC

   Computes vector spherical harmonic analysis of vector fields on a gaussian grid via spherical harmonics.

Prototype

        function vhagC (
                u  : numeric,
                v  : numeric
        )

        return_val  :  float or double

Arguments

   u
   v

   vector function to be analyzed (input, array with two or more dimensions). The two rightmost dimensions must be nlat x
   nlon.
     * input values must be in ascending latitude order
     * input arrays must be on a global grid

Return value

   bc will contain the vector spherical harmonic coefficients. The user need not preallocate this array since the function
   will do so.

   If the rightmost two dimensions of u and v are nlat x nlon then the second-to-the-rightmost dimension of bc is nlat and
   the rightmost dimension (N) is a function of the comparative size of nlat and nlon. It may be determined as follows:

     N = minimum[nlat, (nlon )/2] if nlon is even
     N = minimum[nlat, (nlon+1)/2] if nlon is odd

   An additional dimension of length 4 is added to address the real and imaginary parts associated with the u and v
   components.

   If u and v are two dimensional arrays (nlat,nlon), then bc(0,nlat,N) will contain the "real" coefficients [u].

     bc(1,nlat,N) would contain the "imaginary" coefficients [u]
     bc(2,nlat,N) would contain the "real" coefficients [v]
     bc(3,nlat,N) would contain the "imaginary" coefficients [v]

   If u and v are three dimensional arrays (nt,nlat,nlon), then:

     bc(0,nt,nlat,N) would contain the "real" coefficients [u]
     bc(1,nt,nlat,N) would contain the "imaginary" coefficients [u]
     bc(2,nt,nlat,N) would contain the "real" coefficients [v]
     bc(3,nt,nlat,N) would contain the "imaginary" coefficients [v]

   If u and v are four dimensional arrays (nt,nlvl,nlat,nlon), then:

     bc(0,nt,nlvl,nlat,N) will contain the "real" coefficients [u]
     bc(1,nt,nlvl,nlat,N) will contain the "imaginary" coefficients [u]
     bc(2,nt,nlvl,nlat,N) will contain the "real" coefficients [v]
     bc(3,nt,nlvl,nlat,N) will contain the "imaginary" coefficients [v]

   etc.

   The return array will be double if the input is double, and float otherwise.

   Note: The coefficients contained in bc are in mathematical coordinates. Please read the documentation at:

     http://www.scd.ucar.edu/css/software/spherepack/vhagc.txt

   This is tricky and care must be taken to handle the coefficients correctly.

Description

   vhagC performs the vector spherical harmonic analysis on the arrays u and v. In general, vhagC (performs vector spherical
   harmonic analysis) is used in conjunction with vhsgC (performs vector spherical harmonic synthesis). Note that both vhagC
   and vhsgC operate on a gaussian grid.

   NOTE: This function does not allow for missing data (defined by the _FillValue attribute) to be present. The input arrays
   should not include the cyclic (wraparound) points, as this function uses spherical harmonics. (NCL procedures/functions
   that use spherical harmonics should never be passed input arrays that include cyclic points.)

   If the input arrays u and v are on a fixed grid, vhaeC should be used. Also, note that vhagC is the function version of
   vhagc.

See Also

   vhagc, vhsgC, vhsgc, vhaeC, vhaec, vhsec, vhseC

Examples

   In the examples below, u and v are on a gaussian grid.

   Example 1

   u(nlat,nlon), v(nlat,nlon)

bc = vhagC (u,v)
     [do something with the coefficients]
UV = vhsgC (bc,nlon)      ; or vhsgc (bc(0,:,:),bc(1,:,:),bc(2,:,:),bc(3,:,:),u,v)

   Example 2

   u(nt,nlat,nlon), v(nt,nlat,nlon)

bc = vhagC (u,v)
     [do something with the coefficients]
UV = vhsgC (bc,nlon)      ; or vhsgc (bc(0,:,:,:),bc(1,:,:,:),bc(2,:,:,:),bc(3,:,:,:),u,v)

   Example 3

   u(nt,nlvl,nlat,nlon), v(nt,nlvl,nlat,nlon)

bc = vhagC (u,v)
     [do something with the coefficients]
UV = vhsgC (bc,nlon)      ; or vhsgc (bc(0,:,:,:,:),bc(1,:,:,:,:),bc(2,:,:,:,:),bc(3,:,:,:,:),u,v)


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
