# System::Stats::CPUsage

Provides Statistics CPU Usage in percentage.

## OS Supported: ##
* GNU/Linux by /proc/stat
* Win32 by wmic

## Installing the module ##

    zef update
    zef install System::Stats::CPUsage

## Example Usage: ##
    use v6;
    use System::Stats::CPUsage;    

    say "CPUsage%: CPU_Percentage()"