use strict;
use warnings;
use ExtUtils::MakeMaker;

my $pm = 'lib/Unicode/Diacritic/Strip.pm';

WriteMakefile (
    NAME => 'Unicode::Diacritic::Strip',
    VERSION_FROM => $pm,
    ABSTRACT_FROM => $pm,
    AUTHOR => 'Ben Bullock <bkb@cpan.org>',
    LICENSE => 'perl',
    PREREQ_PM => {
    },
);
