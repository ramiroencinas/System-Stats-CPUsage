# System::Stats::CPUsage
[![Build Status](https://travis-ci.com/ramiroencinas/System-Stats-CPUsage.svg?branch=master)](https://travis-ci.com/github/ramiroencinas/System-Stats-CPUsage)

Raku module - Provides Statistics CPU Usage in percentage.

## OS Supported: ##
* GNU/Linux by /proc/stat
* Win32 by wmic

## Installing the module ##

    zef update
    zef install System::Stats::CPUsage

## Example Usage: ##

```raku 
use v6;
use System::Stats::CPUsage;    

say "CPUsage%: CPU_Percentage()"
```