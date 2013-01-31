use v6;

sub reciprocal-recurring-cycle-len ( $d is copy ) {
	my %h;
	loop ( my $n = 1, my $i =0; ; $n *= 10 ) {
		given $n %= $d {
			when 0	{ return 0 }
			when %h	{ return $i - %h{$n} + 1 };		# r:
			# when %h.exists: $_      { return $i - %h{$n} + 1 };	# n:
			default	{ %h{$n} = ++$i }
		}
	}
}

my $max = 0;
my $idx;
$max = $_, $idx = $_ if $max < reciprocal-recurring-cycle-len $_ for 1..999;
say $idx;
