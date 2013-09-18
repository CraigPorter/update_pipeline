#!/usr/bin/env perl
use strict;
use warnings;

BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator::Header');
}

### START DEBUG ###
my %valid_header = ('study_name' => 'my pet goat'); # valid study name

ok my $header = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Header->new( header => \%valid_header ), 'valid header';
is $header->_study_name, 'my pet goat', 'title correct';

for my $error (@{$header->error_list})
{
    print "\nerror:\n";
    print $error->location,"\n";
    print $error->type,"\n";
    print $error->description,"\n";
    print $error->message,"\n";
    print $error->user_action,"\n";
}

my %invalid_header = ('study_name' => ''); # invalid study name

ok $header = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Header->new( header => \%invalid_header ), 'invalid header';
is $header->_study_name, '', 'title not supplied';

for my $error (@{$header->error_list})
{
    print "\nerror:\n";
    print $error->location,"\n";
    print $error->type,"\n";
    print $error->description,"\n";
    print $error->message,"\n";
    print $error->user_action,"\n";
}
### END DEBUG ###


# check header
my $header_in = { supplier_name                  => 'name',
		          supplier_organisation          => 'organisation',
		          internal_contact               => 'contact',
		          sequencing_technology          => 'Illumina',
		          study_name                     => 'study',
		          study_accession_number         => 'ERP000001',
		          total_size_of_files_in_gbytes  => '1.23',
		          data_to_be_kept_until          => '01.02.1234'};

ok my $header_validator = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Header->new( header => $header_in );
ok my $header_out = $header_validator->valid_header();

is_deeply $header_out, $header_in, 'valid header returned';
ok my $error_list_ref = $header_validator->error_list, 'got error list';
is scalar @{$error_list_ref}, 0, 'no errors found';


# MORE DEBUG
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
