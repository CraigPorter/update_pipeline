#!/usr/bin/env perl
use strict;
use warnings;

BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator::Report');
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error');
}

# create header errors
my @header_errors = ( 
    UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error->new( 
        location    => 'Sanger Contact',
        type        => 'warning',
        description => 'Invalid sanger contact',
        message     => 'No entry for sanger contact.',
        user_action => 'Add sanger contact' ),
    UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error->new( 
        location    => 'Study Name',
        type        => 'error',
        description => 'Invalid study name',
        message     => '"My pet goat" is not a valid study name',
        user_action => 'Add valid study name' )
);

# create experiment error
my @expt_errors = ( 
    UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error->new( 
        location    => 'ecoli_01',
        type        => 'warning',
        description => 'No entry for read count',
        message     => 'No entry for read count.',
        user_action => 'None required - read count is set during import.' ),
    UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error->new( 
        location    => 'ecoli_02',
        type        => 'error',
        description => 'Invalid taxon ID',
        message     => '"E.coli" is not an integer',
        user_action => 'Add valid taxon id' )
);

# valid object 
my $report_output;
open(my $filehandle, '>', \$report_output);

ok my $error_report = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Report->new(
    header_error     => \@header_errors,
    experiment_error => \@expt_errors,
    filehandle       => $filehandle ), 'populate valid error report';

ok $error_report->summary_report(), 'summary report created';

print $report_output,"\n";
$report_output = '';

ok $error_report->full_report(), 'full report created';
print $report_output,"\n";


close $filehandle;

done_testing();
