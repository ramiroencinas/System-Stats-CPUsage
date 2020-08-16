use v6;

unit module System::Stats::CPUsage;

sub CPU_Percentage ( ) is export {

  my $ret;  
  
  given $*KERNEL {
    when /linux/  { $ret = linux() }
    when /win32/  { $ret = win32() }    
  }

  return $ret;

}

sub win32 ( ) {

  my $cpu-percent;

  repeat until $cpu-percent >= 0 {

    $cpu-percent = ((shell "wmic cpu get loadpercentage", :out).out.slurp-rest).lines[2];    

    sleep 1;

  }

  return $cpu-percent;

}

sub linux ( ) {

  my %s1 = shot_cpu_stat_linux();
  sleep 1;
  my %s2 = shot_cpu_stat_linux();

  # say qq:to/END/; 
  #    User: %s1<user> - %s2<user>
  #    Nice: %s1<nice> - %s2<nice>
  #  System: %s1<system> - %s2<system>
  #    Idle: %s1<idle> - %s2<idle>
  #  iowait: %s1<iowait> - %s2<iowait>
  #     irq: %s1<irq> - %s2<irq>
  # softirq: %s1<softirq> - %s2<softirq>
  #   steal: %s1<steal> - %s2<steal>
  # END

  # https://stackoverflow.com/a/23376195/1875221

  my $PrevIdle = %s1<idle> + %s1<iowait>;
  my $Idle = %s2<idle> + %s2<iowait>;

  my $PrevNonIdle = %s1<user> + %s1<nice> + %s1<system> + %s1<irq> + %s1<softirq> + %s1<steal>;
  my $NonIdle = %s2<user> + %s2<nice> + %s2<system> + %s2<irq> + %s2<softirq> + %s2<steal>;

  my $PrevTotal = $PrevIdle + $PrevNonIdle;
  my $Total = $Idle + $NonIdle;

  my $totald = $Total - $PrevTotal;
  my $idled = $Idle - $PrevIdle;

  my $CPU_Percentage = (($totald - $idled) / $totald) * 100;

  return $CPU_Percentage.Int;

}

sub shot_cpu_stat_linux() {
  
  my $sourcefile = '/proc/stat';
  
  my @data = $sourcefile.IO.open.lines[0].words;

  return {
    'user'    => @data[1].Int,
    'nice'    => @data[2].Int,
    'system'  => @data[3].Int,
    'idle'    => @data[4].Int,
    'iowait'  => @data[5].Int,
    'irq'     => @data[6].Int,
    'softirq' => @data[7].Int,
    'steal'   => @data[8].Int
  };
}
