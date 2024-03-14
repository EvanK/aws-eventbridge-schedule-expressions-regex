use strict;
use warnings;

use Test::More;

require './main.pl';
our ($expanded, $collapsed);

my $tests_planned = 0;

# tests organized into groups of positive and negative matches
my %cases = (
    'positives' => [],
    'negatives' => [],
);

# loads all test cases from their respective files
foreach my $group ( keys %cases ) {
    open my $fh, "tests/$group.txt" or die "Couldn't open $group: $!";
    while ( my $line = <$fh> ) {
        chomp($line);
        (my $test, my $name) = split /\t/, $line;
        push @{ $cases{$group} }, { test => $test, name => $name };
        # counting planned tests as we go
        $tests_planned += 2;
    }
    close $fh;
}

# set up how many we expect to run
plan tests => $tests_planned;

# iterate each group...
foreach my $group ( keys %cases ) {
    # determine what sort of case group this is
    my $state = $group eq 'positives' ? 'match' : 'mismatch';
    my $action = $group eq 'positives' ? 'like' : 'unlike';

    # and then each test case...
    foreach my $test ( @{ $cases{$group} } ) {
        # tolerate any missing test names
        my $test_name = defined $test->{'name'} ? $test->{'name'} : '';

        note("Expecting $state for $test_name -- $test->{'test'}");

        {
            no strict 'refs';
            &{$action}($test->{'test'}, $expanded, $test_name);
            &{$action}($test->{'test'}, $collapsed, $test_name);
        }
    }
}
