package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment;

use Moose;

use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::BaseCount;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::Comments;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::Filename;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::FragmentSize;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::LibraryName;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::MateFilename;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::ReadCount;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::SampleAccession;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::SampleName;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::TaxonID;
# extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

__PACKAGE__->meta->make_immutable;

no Moose;

1;