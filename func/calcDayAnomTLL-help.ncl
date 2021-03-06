THE_URL:file://localhost/Users/hubery/Public/ucar/Document/Functions/Contributed/calcDayAnomTLL.shtml
THE_TITLE:calcDayAnomTLL
   NCL Home > Documentation > Functions > Climatology

calcDayAnomTLL

   Calculates daily anomalies from a daily data climatology.

   [new.gif] Available in version 4.2.0.a033 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function calcDayAnomTLL (
                x        [*][*][*] : float or double,
                yyyyddd        [*] : integer,
                clmDay [366][*][*] : float or double
        )

        return_val  :  dimsizes(x)

Arguments

   x

   A three-dimensional array (time, lat, lon) containing the raw daily data. The dimensions must be named.
   yyyyddd

   A one-dimensional array (same size as the "time" dimension of x) containing values of the form yyyy*1000 + Day_of_Year
   where yyyy is a year [eg: 1993] and ddd is the sequential day of the current year [eg: Jan01=>1, Jan31=>31, etc.
   clmDay

   A three-dimensional array (366, lat, lon) output by clmDayTLL.

Return value

   A daily time series containing anomalies.

Description

   Subtract the mean daily annual cycle from the raw daily data.

       x(time,lat,lon)  <==== input dimension order
       x!0 = "time"     <==== time is in days
       x!1 = "lat"
       x!2 = "lon"

non-Leap  yyyyddd
       1905001 =>  Jan  1, 1905
       1905032 =>  Feb  1, 1905
       1905059 =>  Feb 28, 1905
       1905060 =>  Mar  1, 1905
       1905365 =>  Dec 31, 1905

Leap      yyyyddd
       1908001 =>  Jan  1, 1908
       1908032 =>  Feb  1, 1908
       1908059 =>  Feb 28, 1908
       1908060 =>  Feb 29, 1908
       1908061 =>  Mar  1, 1908
       1908366 =>  Dec 31, 1908

See Also

   clmDayTLL, smthClmDayTLL, clmMonTLL, clmMonTLLL, clmMonLLLT, clmMonLLT

Examples

   Example 1

   Compute daily anomalies using a climatology created by clmDayTLL or smthClmDayTLL. The input is daily 500 hPa heights
   spanning 1990-1999. The values are packed as type short and the time is in units "hours since 1-1-1 00:00:0".
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
   :
   :
   diri    = "./"                             ; input directory
   fili    = "HGT.nc"                         ; input file
   f       = addfile (diri+fili , "r")
;***********************************************************
; Read time and create required yyyyddd
;***********************************************************
   time    = f->time                          ; time:units = "hours since 1-1-1 00:00:0.0"
   TIME    = cd_calendar(time, 0)          ; type float
   year    = toint( TIME(:,0) )
   month   = toint( TIME(:,1) )
   day     = toint( TIME(:,2) )
   ddd     = day_of_year(year, month, day)
   yyyyddd = year*1000 + ddd                                  ; needed for input
;***********************************************************
; Read data: short2flt
;***********************************************************
   hgt     =  short2flt( f->hgt(:,0,:,:) )    ; convert to float
   printVarSummary( hgt )
;***********************************************************
; Compute daily climatology: raw and then 'smoothed'
;***********************************************************
   hClmDay    = clmDayTLL(hgt, yyyyddd)     ; daily climatology at each grid point
   printVarSummary(hClmDay)
;***********************************************************
; Compute smoothed daily climatology using 2 harmonics
;***********************************************************
   hClmDay_sm = smthClmDayTLL(hClmDay, 2)
   printVarSummary(hClmDay_sm)

;***********************************************************
; Compute daily anomalies using raw and smoothed daily climatologies
;***********************************************************
    hAnom      = calcDayAnomTLL (hgt, yyyyddd, hClmDay)
    printVarSummary(hAnom_sm)
    printMinMax(hAnom, True)

    hAnom_sm   = calcDayAnomTLL (hgt, yyyyddd, hClmDay_sm)

    hAnom_sm@long_name = "Anomalies from Smooth Daily Climatology"
    printVarSummary(hAnom_sm)
    printMinMax(hAnom_sm, True)




   The (edited) output yields
Variable: hgt
Type: float
imensions and sizes:   [time | 3652] x [lat | 73] x [lon | 144]
Coordinates:
            time: [17435256..17522880]
            lat: [90..-90]
            lon: [ 0..357.5]
Number Of Attributes: 16
  _FillValue :  1e+20
  level :       500
  long_name :   mean Daily Geopotential height

   The raw daily climatology
Variable: hClmDay
Type: float
Total Size: 15389568 bytes
            3847392 values
Number of Dimensions: 3
Dimensions and sizes:   [year_day | 366] x [lat | 73] x [lon | 144]
Coordinates:
            year_day: [1..366]
            lat: [90..-90]
            lon: [ 0..357.5]
Number Of Attributes: 4
  long_name :   Daily Climatology: mean Daily Geopotential height
  units :       m
  information : Raw daily averages across all years
  smoothing :   None

   The smoothed daily climatology
Variable: hClmDay_sm
Type: float
Number of Dimensions: 3
Dimensions and sizes:   [year_day | 366] x [lat | 73] x [lon | 144]
Coordinates:
            year_day: [1..366]
            lat: [90..-90]
            lon: [ 0..357.5]
Number Of Attributes: 4
  smoothing :   FFT: 2 harmonics were retained.
  information : Smoothed daily climatological averages
  units :       m
  long_name :   Daily Climatology: mean Daily Geopotential height

   The daily anomalies from the unsmoothed daily climatology.
Variable: hAnom
Dimensions and sizes:   [time | 3652] x [lat | 73] x [lon | 144]
Coordinates:
            time: [17435256..17522880]
            lat: [90..-90]
            lon: [ 0..357.5]
Number Of Attributes: 3
  _FillValue :  1e+20
  long_name :   Anomalies: mean Daily Geopotential height
  units :       m
(0)
(0)     Anomalies: mean Daily Geopotential height: min=-563.6   max=608

   The daily anomalies from the smoothed daily climatology.
Variable: hAnom_sm
Dimensions and sizes:   [time | 3652] x [lat | 73] x [lon | 144]
Coordinates:
            time: [17435256..17522880]
            lat: [90..-90]
            lon: [ 0..357.5]
Number Of Attributes: 3
  _FillValue :  1e+20
  long_name :   Anomalies from Smooth Daily Climatology
  units :       m
(0)
(0)     Anomalies from Smooth Daily Climatology: min=-565.107   max=626.271


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
