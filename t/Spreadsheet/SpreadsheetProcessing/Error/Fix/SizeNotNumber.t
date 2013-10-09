#!/usr/bin/env perl
use strict;
use warnings;
BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetProcessing::ErrorsAndWarnings::Error::SizeNotNumber');
}

# instantiate
ok my $error = UpdatePipeline::Spreadsheet::SpreadsheetProcessing::ErrorsAndWarnings::Error::SizeNotNumber->new(), 'instantiate error';

# autofix
is $error->autofix('invalid'), undef, 'unset';

done_testing();