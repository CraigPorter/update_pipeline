#!/usr/bin/env perl
use strict;
use warnings;

BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator');
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator::Header');
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator::Experiment');
    use_ok('UpdatePipeline::Spreadsheet::SpreadsheetValidator::Report');
}

# check validator
ok my $validator = UpdatePipeline::Spreadsheet::SpreadsheetValidator->new(filename => 't/data/external_data_example.xls'), 'open example spreadsheet';
ok $validator->validate(), 'example spreadsheet is valid';

# write report
ok $validator->write_full_report, 'writes report';

# write summary
ok $validator->write_summary_report, 'writes summary report';

done_testing();
