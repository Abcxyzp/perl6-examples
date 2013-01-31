use v6;

my $max = 0;
my $result;
for 3, 5 ... 999 -> $b {
	next unless $b.is-prime;
	for 3 - $b - 1, 3 - $b - 1 + 2 ... 999 -> $a {
		my $i = 0;
		$i++ while ( $i**2 + $i*$a + $b ).is-prime;
		$max = $i, $result = $a*$b if $i > $max;
	}
}
say $result;
