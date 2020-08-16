use v6;
use lib 'lib';
use Test;

plan 1;

use System::Stats::CPUsage;

ok ( CPU_Percentage() >= 0 && CPU_Percentage() <= 100 ), "CPUsage% >= 0 and <= 100";