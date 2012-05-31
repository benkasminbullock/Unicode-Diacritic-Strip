#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use Perl::Build;

perl_build (
    pod => [
        'lib/Unicode/Diacritic/Strip.pod',
    ],
);
