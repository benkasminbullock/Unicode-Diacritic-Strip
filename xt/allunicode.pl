#!/home/ben/software/install/bin/perl
use Z;
use lib "$Bin/lib";
use Unicode::Diacritic::Strip ':all';
for my $i (0..0x20000) {
    my $k = Unicode::Diacritic::Strip::decompose (chr ($i));
}
