#!/usr/bin/env perl
use strict;
use warnings;

BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator::Experiment');
}

# check header
my $row_in = { filename                => 'file',
               mate_filename           => 'matefile',
               sample_name             => 'sample',
               sample_accession_number => 'ERP000001',
               taxon_id                => 12345,
               library_name            => 'library',
               fragment_size           => 100,
               raw_read_count          => 10000,
               raw_base_count          => 1000000,
               comments                => 'comments' };

ok my $expt_validator = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Experiment->new( experiment_row => $row_in ),'created object';
ok my $row_out = $expt_validator->valid_experiment_row(),'got row';

is_deeply $row_out, $row_in, 'valid expt data returned';
ok my $error_list_ref = $expt_validator->error_list, 'got error list';
is scalar @{$error_list_ref}, 0, 'no errors found';


# DEBUG
for my $error (@{$error_list_ref})
{
    print "\nerror:\n";
    print $error->location,"\n";
    print $error->type,"\n";
    print $error->description,"\n";
    print $error->message,"\n";
    print $error->user_action,"\n";
}





done_testing();
