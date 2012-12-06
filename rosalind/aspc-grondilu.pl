use v6;

sub postfix:<!> { [*] 1 .. $^n }
sub C($n, $k) { $n! div ($k! * ($n-$k)!) }
my ($n, $m) = $*IN.get.split(' ')».Int;

my $sum = my $C = C $n, $m;
for $m+1 .. $n -> $k {
    $sum += $C = $C * ($n - $k + 1) div $k;
}
say $sum % 1_000_000;

# vim: ft=perl6
