THE_URL:file://localhost/Users/hubery/Public/ucar/Document/Functions/Built-in/charactertointeger.shtml
THE_TITLE:charactertointeger
   NCL Home > Documentation > Functions > Type converters

charactertointeger

   Coerces values of type character to values of type integer (deprecated; use tointeger).

Prototype

        function charactertointeger (
                char_val  : character
        )

        return_val [dimsizes(char_val)] :  integer

Arguments

   char_val

   A character variable of any dimension.

Return value

   The returned value has the same dimensionality as the input variable char_val.

Description

   This function converts an ASCII character (or characters) to its decimal equivalent and returns that as an integer value.
   For example, conversion of the ASCII character 'a' yields the integer 97 as a return value.

   Note: this function and other xxxtointeger functions have been superceded by tointeger.

   This function performs coercion that is not automatically available through the NCL grammar. See the section on coercion
   of types for details on NCL's automatic type conversions.

   The functions chartointeger and chartoint are identical to this function, and can be used if you don't want to use the
   full charactertointeger name. These alias names are included just for people who don't like to type (or like the shorter
   names).

   Attributes, with the exception of _FillValue, are not propagated by the conversion functions. See Example 2 below.

   Special considerations apply to how missing values are handled in the conversion functions. See Example 2.

See Also

   totype, tointeger, touint, toint64

Examples

   Example 1

   Converts an array of ASCII characters to their decimal equivalents returned as integers.
begin
  cc = new((/2,3/),character)
  cc(0,0) = integertocharacter (65)  ; 'A'
  cc(0,1) = integertocharacter (66)  ; 'B'
  cc(0,2) = integertocharacter (67)  ; 'C'
  cc(1,0) = integertocharacter (68)  ; 'D'
  cc(1,1) = integertocharacter (69)  ; 'E'
  cc(1,2) = integertocharacter (70)  ; 'F'
  print(cc)  ; Prints the character array cc.
  ff = charactertointeger(cc)
  print(ff)  ; Prints the decimal equivalents.
end

   Example 2

   Shows how missing values are handled.

begin
;
;  Conversion does not preserve attributes, except missing value.
;  A character missing value is converted to its ASCII equivalent
;  and that converted to a integer when a character missing value
;  is propagated to a integer variable.
;
  a = new(3,character)
  a = (/integertocharacter(66), integertocharacter(67), integertocharacter(68)/)
  a@T = "string"
  a@_FillValue = integertocharacter(65)
  b = charactertointeger(a)
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
  a = new(3,character)
  a = (/integertocharacter(66), integertocharacter(67), integertocharacter(65)/)
  a@_FillValue = integertocharacter(65)
  b = charactertointeger(a)
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
  a = new(3,character)
  a = (/integertocharacter(66), integertocharacter(67), integertocharacter(65)/)
  a@_FillValue = integertocharacter(65)
  b = new(3,integer,80)
  b = charactertointeger(a)
  print (b)
  delete(a)
  delete(b)
end


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
