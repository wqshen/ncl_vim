THE_URL:file://localhost/Users/hubery/Public/ucar/Document/Functions/Built-in/floattochar.shtml
THE_TITLE:floattochar
   NCL Home > Documentation > Functions > Type converters

floattochar

   Coerces values of type float to values of type character.

Prototype

        function floattochar (
                float_val  : float
        )

        return_val [dimsizes(float_val)] :  character

Arguments

   float_val

   A float variable of any dimension.

Return value

   The return variable is of the same dimensionality as the input.

   For any float value in the range [0,127] (the ASCII decimal equivalent range for ASCII characters) the return value is
   the ASCII character having that decimal equivalent. A value between 128 and 255, inclusive, is returned as that value. A
   value out of the range [0,255] is returned as a missing value.

Description

   This function converts float values to character values.

   For any float value in the range 0 to 127 (the ASCII decimal equivalent range for ASCII characters) the return value is
   the ASCII character having that decimal equivalent. A value between 128 and 255 is returned as that value. Any fractional
   part of an input value is truncated.

   This function performs coercion that is not automatically available through the NCL grammar. See the section on coercion
   of types for details on NCL's automatic type conversions.

   This function is an alias for the function floattocharacter. It is identical to that function and is included just for
   people who don't like to type (or like the shorter names). Attributes, with the exception of _FillValue, are not
   propagated by the conversion functions. See Example 2 below.

   Special considerations apply to how missing values and out-of-range values are handled in the conversion functions. For
   this function an out-of-range value is a valid float that is not in the valid range [0,255], or a numeric value that is
   outside the range of a valid float. An out-of-range value is converted to a missing value, but what that missing value is
   depends on the circumstances of the particular conversion being performed. For example, determination has to be made
   whether a missing value for a variable to be converted is in the range of the type of the target variable. Example 2
   below illustrates most of the many possibilities; its output should provide convincing evidence that care must be taken
   when making assumptions about the results returned from a conversion function when the original variable has missing or
   out-of-range values.

See Also

   floattocharacter

Examples

   Example 1

   Converts an array of floats to an array of characters.

begin
;
;  65 is the ASCII decimal equivalent for the character A.
;  97 is the ASCII decimal equivalent for the character a.
;  33 is the ASCII decimal equivalent for the character !.
;  -1 is not a legal ASCII decimal equivalent.
; 150 is returned as that value.
;
  a = (/ 65, 97, 33.33, -1, 150 /)
  print(floattochar(a))
end


   Example 2

   Shows how missing values and out-of-range values are handled.

begin
;
;  Conversion does not preserve attributes, except missing value.
;
  a = (/ 66., 67., 68.6/)
  a@T = "string"
  a@_FillValue = 65.
  b = floattochar(a)
  print (b)
  delete(a)
  delete(b)
;
;  The missing value of the target variable is retained if
;  the missing value of the original variable is out of
;  the range of the target variable.  Note that this can
;  turn a value that is not a missing value in the original
;  variable into a missing value in the target variable if
;  a value in the original variable equals the missing value
;  in the target variable.
;
  a = (/ 66., 67., 68.6/)
  a@_FillValue = 1.e40
  b = new(3,character,integertocharacter(65))
  b = floattochar(a)
  print (b)
  delete(a)
  delete(b)
;
;  Values to be converted that are out of the range
;  of the target variable are converted to the default missing value
;  of the target variable if neither the original variable nor
;  the target variable has a missing value specified.
;
  a = (/ 66., 67., 268.6/)
  b = floattochar(a)
  print (b)
  delete(a)
  delete(b)
;
;  Values to be converted that are out of the range
;  of the target variable are converted to the missing value
;  of the original variable, if that missing value is in
;  the range of the target variable and the target variable
;  has no missing value specified.
;
  a = (/ 66., 67., 268.6/)
  a@_FillValue = 65.
  b = floattochar(a)
  print (b)
  delete(a)
  delete(b)
;
;  Values to be converted that are out of the range
;  of the target variable are converted to the default missing value
;  of the target variable if the missing value of the
;  original variable is out of the range of the target variable
;  and the target variable has no missing value specified.
;
  a = (/ 66., 67., 268.6/)
  a@_FillValue = 1.e50
  b = floattochar(a)
  print (b)
  delete(a)
  delete(b)
;
;  If the target variable has no missing value
;  specified and the original variable does, the missing
;  value of the target variable inherits the missing value of the
;  original variable and the missing values
;  of the original variable are retained in
;  the target variable.
;
  a = (/ 66., 67., 65.5/)
  a@_FillValue = 65.
  b = floattochar(a)
  print (b)
  delete(a)
  delete(b)
;
;  If the target variable has a missing
;  value specified and the original variable
;  has a missing value specified, the missing
;  value of the target variable is retained
;  even when the missing value of the original
;  variable is in the range of the type of the
;  target variable.  Missing values in the
;  original variable are converted to the
;  missing value of the target variable.
;
  a = (/ 66., 67., 65.5/)
  a@_FillValue = 65.
  b = new(3,character,integertocharacter(68))
  b = floattochar(a)
  print (b)
  delete(a)
  delete(b)
end



   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
