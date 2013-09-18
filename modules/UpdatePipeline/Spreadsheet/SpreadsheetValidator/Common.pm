package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Common;
use Moose;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error;
use Scalar::Util qw(looks_like_number);

has '_cell_data' => ( is => 'ro', isa => 'HashRef',  lazy_build => 1);
has 'error_list' => ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

__PACKAGE__->meta->make_immutable;

no Moose;

1;