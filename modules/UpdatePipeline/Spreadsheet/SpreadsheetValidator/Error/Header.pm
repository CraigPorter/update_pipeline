package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header;

use Moose;

use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SupplierName;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SupplierOrganisation;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SangerContact;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SequencingTechnology;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::StudyName;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::StudyAccession;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::Size;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::Date;
# extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

__PACKAGE__->meta->make_immutable;

no Moose;

1;