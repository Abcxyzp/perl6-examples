use v6;

sub sum-of-proper-divisors ( $n is copy ) {
	my $sum = 1 - $n;
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

my @abundant-ns = grep { $_ < sum-of-proper-divisors $_ }, 12..28123 - 12;
my @result = 0, 1 xx 28123;

for @abundant-ns.kv -> $i, $n {
	last if $n > 28123 div 2;	# This line is not necessary, since the inner loop directly quits anyway.
	my $limit = 28123 - $i;
	# for $i..^@abundant-ns {			# 13 min, LAZY list == SLOW list... Optimizing it into loop is a better choice, I guess the compiler could do something similar to this by default.
	loop ( $_ = $i; $_ < @abundant-ns; $_++ ) {	# 36 sec, completely equivalent to the line above, but much faster.
		last if @abundant-ns[$_] > $limit;
		@result[ @abundant-ns[$_] + $n ] = 0;
	}
}

say [+] grep { @result[$_] }, ^@result;
