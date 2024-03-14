use strict;
use warnings;

use Term::ANSIColor qw(:constants);
use Text::Diff;

require "./main.pl";
our ($expanded, $collapsed);

# remove the wrappings from qr//
my $pattern = $expanded =~ s/(^\(\?\^x\:\n+|\n+\)$)//rg;

# remove any whole single line comments (at ANY indent)
$pattern =~ s/\n([ \t]*[#][^\n]+\n)+/\n/g;

# remove any indents
$pattern =~ s/^[ \t]*//gm;

# remove rest of newlines
$pattern =~ s/\n//g;

my %options = (
  STYLE => "Unified",
  OUTPUT => \*STDOUT,
  FILENAME_A => 'Existing',
  FILENAME_B => 'New'
);

# get existing collapsed pattern to compare against
my $expected = $collapsed =~ s/(^\(\?\^x\:\n+|\n+\)$)//rg;

if ($expected eq $pattern) {
  print BRIGHT_GREEN ON_BLACK "No changes detected!\n", RESET;
} else {
  print BRIGHT_RED ON_BLACK "Differences detected:\n", RESET;
  diff \$expected, \$pattern, \%options;
}

print "\nCompiled pattern:\n\n$pattern\n\n";