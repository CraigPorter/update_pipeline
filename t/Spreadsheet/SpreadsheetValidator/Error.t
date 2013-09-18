#!/usr/bin/env perl
use strict;
use warnings;

BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error');
}

# populate error
ok my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error->new( 
    location    => 'Study Name',
    type        => 'error',
    description => 'Invalid study name',
    message     => '"My pet goat" is not a valid study name',
    user_action => 'Add valid study name' ), 'populate valid error';

done_testing();
