THE_URL:file://localhost/Users/hubery/Public/ucar/Document/Functions/User_contributed/cd_string.shtml
THE_TITLE:cd_string
   NCL Home > Documentation > Functions > Date routines

cd_string

   Converts time values into nicely formatted strings.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"

        function cd_string (
                time      : numeric,
                inFormat  : string
        )

Arguments

   time

   An array containing the values of time. This variable must have an attribute named "units".
   inFormat

   A string specifying the format of the tick labels. See the description section below for more details.

Return value

   A string array representing the time(s) in the specified format.

Description

   This function converts time values to nicely formatted strings, based on the inFormat format string.

   This function behaves the same as ut_string, except it uses cd_calendar to initially convert the time format. cd_calendar
   supports more calendars, so it may be better to use this function.

   The '%' acts as an escape character. The single character after every '%' is formatted according to the rules:
   Y => 4-digit year (e.g., 2007).
   y => 2-digit year (e.g., 07).
   C => CAPITAL month abbreviation (e.g., JUN).
   c => Small month abbreviation (e.g., Jun).
   F => CAPITAL full month (e.g., JUNE).
   f => Small full month (e.g., June).
   N => 2-digit month (e.g., 06).
   n => 1 or 2 digit month (e.g., 6 for June, 12 for December).
   D => 2-digit day (e.g., 04).
   d => 1 or 2 digit day (e.g., 4)
   H => 2-digit hour (e.g., 09).
   h => 1 or 2 digit hour (e.g., 9 or 11).
   M => 2 digit minute (e.g., 08).
   m => 1 or 2 digit minute (e.g., 07 or 56).
   S => 2 digit second (e.g., 02).
   s => 1 or 2 digit second (e.g., 2 or 23).
   J => 3-digit day-of-year (e.g., 091) (added in v6.0.0)
   j => 1, 2, or 3 digit day-of-year (e.g., 4, 91, or 181) (added in v6.0.0)

   Any character at any other place in the format string is drawn as is.

   NOTE: a '%' can be drawn using "%%".

   If inFormat is set to an empty string (""), it will default to "%H%M UTC %d %c %Y" (e.g. "1800 UTC 4 Jul 1776").

   Note: there is a potential rounding bug in cd_calendar which causes a problem in this routine if you have a units of
   "minutes since" or "seconds since". It sometimes causes the minutes/seconds to be returned as something like "0/60" (0
   minutes/60 seconds) rather than "1/0" (1 minute/0 seconds). If you are affected by this bug, then you may be able to use
   ut_string as a work-around, if you are using a "standard" calendar.

   Acknowledgements:

   This function is based on the time_axis_labels procedure, written by Arindam Chakraborty, Centre for Atmospheric and
   Oceanic Sciences (Indian Institute of Science). It was adapted by:

     Carl J. Schreck, III
     PhD Student
     Department of Atmospheric and Environmental Sciences
     University at Albany

See Also

   time_axis_labels, cd_convert

Examples

   For all the following examples, assume that time is an array of time values.

   Example 1

   Using the default format string of "" will result in "HHMM UTC D Mon YYYY" (e.g., 1800 UTC 4 Jul 1776):

  format = ""
  stime  = cd_string(time,format)

   Example 2

   To format the time values as "CccYy" (Apr98, May98, etc):

  format = "%c%y"
  stime  = cd_string(time,format)

   Example 3

   To format the time values as "NN/YYYY" (04/1998, 05/1998, etc):

  format = "%N/%Y"
  stime  = cd_string(time,format)

   Example 4

   To format the time values as "HH:MM:SS":
  format = "%H:%M:%S"
  stime  = cd_string(time,format)

   To specify month/day as well, use:
  format = "%N/%D %H:%M:%S"

   Example 5

   To format the hour values as "HH:00 Hours" use:

  format = "%H:00 Hours"
  stime  = cd_string(time,format)

   Example 6

   To format the time values as "29 Jun", "4 Jul", etc:

 format = "%d %c"
 stime  = cd_string( time, format)

   For using these labels in a plot, see the documentation for time_axis_labels.


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
