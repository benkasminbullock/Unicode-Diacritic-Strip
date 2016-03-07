package Unicode::Diacritic::Strip;
use warnings;
use strict;
require Exporter;
use base qw(Exporter);
our @EXPORT_OK = qw/strip_diacritics/;
our $VERSION = '0.06';
use Unicode::UCD 'charinfo';
use Encode 'decode_utf8';

sub strip_diacritics
{
    my ($diacritics_text) = @_;
    if ($diacritics_text !~ /[^\x{01}-\x{80}]/) {
        # All the characters in this text are ASCII, and so there are
        # no diacritics.
        return $diacritics_text;
    }
    my @characters = split //, $diacritics_text;
    for my $character (@characters) {
        # Leave non-word characters unaltered.
	if ($character =~ /\W/) {
	    next;
	}
        my $decomposed = decompose ($character);
        if ($character ne $decomposed) {
            $character = $decomposed;
        }
    }
    my $stripped_text = join '', @characters;
    return $stripped_text;
}

# Decompose one character. This is the core part of the program.

sub decompose
{
    my ($character) = @_;
    # Get the Unicode::UCD decomposition.
    my $charinfo = charinfo (ord $character);
    my $decomposition = $charinfo->{decomposition};
    # Give up if there is no decomposition for $character
    if (! $decomposition) {
	return $character;
    }
    # Get the first character of the decomposition
    my @decomposition_chars = split /\s+/, $decomposition;
    $character = chr hex $decomposition_chars[0];
    # A character may have multiple decompositions, so repeat this
    # process until there are none left.
    return decompose ($character);
}

1;
