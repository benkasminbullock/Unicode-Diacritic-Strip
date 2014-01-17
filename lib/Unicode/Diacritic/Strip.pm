package Unicode::Diacritic::Strip;
require Exporter;
@ISA = qw(Exporter);
our @EXPORT_OK = qw/strip_diacritics/;
use warnings;
use strict;
our $VERSION = 0.04;
use Unicode::UCD 'charinfo';
use Encode 'decode_utf8';

sub strip_diacritics
{
    my ($diacritics_text) = @_;
    if ($diacritics_text !~ /[^\x{01}-\x{80}]/) {
        # There are no diacritics;
        return $diacritics_text;
    }
    my @characters = split '', $diacritics_text;
    for my $character (@characters) {
        # Reject non-word characters
        next unless $character =~ /\w/;
        my $decomposed = decompose ($character);
        if ($character ne $decomposed) {
            # If the character has been altered, highlight and add a
            # mouseover showing the original character.
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
    return $character unless $decomposition;
    # Get the first character of the decomposition
    my @decomposition_chars = split /\s+/, $decomposition;
    $character = chr hex $decomposition_chars[0];
    # A character may have multiple decompositions, so repeat this
    # process until there are none left.
    return decompose ($character);
}

1;
