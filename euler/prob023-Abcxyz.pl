use v6;

sub sum-of-divisors ( $n is copy ) {	# This could be opted faster by sieving to get a list of results directly, but not necessary here, since the slowest section is on the later loop instead.
	my $sum = 1;
	my $tmp;
	loop ( my $p = 2; $p**2 <= $n; $p += $p==2 ?? 1 !! 2 ) {
		next unless $n %% $p;
		$tmp = $p;
		while $n %% $p {
			$n div= $p;
			$tmp *= $p;
		}
		$sum = $sum * ($tmp - 1) div ($p - 1);
	}
	$sum *= ($n + 1) if $n > 1;
	return $sum;
}

my @abundant-ns = grep { $_ + $_ < sum-of-divisors $_ }, 12..28123 - 12;
my @result = 0, 1 xx 28123;

for @abundant-ns.kv -> $i, $n {
	# last if $n > 28123 div 2;	# This line is not necessary, since the inner loop directly quits anyway.
	my $limit = 28123 - $i;
	# for $i..^@abundant-ns -> $j {			# 13/15 min, (n:. r: takes 41 min with > 4GB mem)
	loop ( my $j = $i; $j < @abundant-ns; $j++ ) {	# 36/41 sec, (n:. r: takes 49 min with 250MB mem)
		last if @abundant-ns[$j] > $limit;
		@result[ @abundant-ns[$j] + $n ] = 0;
	}
}

say [+] grep { @result[$_] }, ^@result;
