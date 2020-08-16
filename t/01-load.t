use v6;
use lib 'lib';
use Test;

plan 2;

use System::Stats::CPUsage;
ok 1, "use System::Stats::CPUsage worked!";
use-ok 'System::Stats::CPUsage';