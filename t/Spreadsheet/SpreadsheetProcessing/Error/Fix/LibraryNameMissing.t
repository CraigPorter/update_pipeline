#!/usr/bin/env perl
use strict;
use warnings;
BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetProcessing::ErrorsAndWarnings::Error::LibraryNameMissing');
}

# instantiate
ok my $error = UpdatePipeline::Spreadsheet::SpreadsheetProcessing::ErrorsAndWarnings::Error::LibraryNameMissing->new(), 'instantiate error';

# autofix
is $error->autofix('invalid'), 'invalid', 'no fix for fatal error';

done_testing();