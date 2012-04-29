use warnings;
use strict;
use Test::More tests => 2;
BEGIN { use_ok('Unicode::Diacritic::Strip') };
use Unicode::Diacritic::Strip 'strip_diacritics';
use utf8;
my $in = 'àÀâÂäçéÉèÈêÊëîïôùÙûüÜがぎぐげご';
my $out = 'aAaAaceEeEeEeiiouUuuUかきくけこ';
my $stripped = strip_diacritics ($in);
ok ($stripped eq $out, "Strip $in = $out");
# Local variables:
# mode: perl
# End:
