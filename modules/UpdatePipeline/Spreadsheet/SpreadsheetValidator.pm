package UpdatePipeline::Spreadsheet::SpreadsheetValidator;

use Moose;
use Moose::Util::TypeConstraints;

use UpdatePipeline::Spreadsheet::Parser;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Header;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Experiment;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Report;
use UpdatePipeline::Spreadsheet::Validate::Header;
use UpdatePipeline::Spreadsheet::Validate::SequencingExperiments;

has 'filename'              => ( is => 'ro', isa => 'FileName', required   => 1 );
has 'valid_header_metadata' => ( is => 'ro', isa => 'HashRef',  lazy_build => 1 );
has 'valid_rows_metadata'   => ( is => 'ro', isa => 'ArrayRef', lazy_build => 1 );
has '_header_metadata'      => ( is => 'ro', isa => 'HashRef',  lazy_build => 1 );
has '_rows_metadata'        => ( is => 'ro', isa => 'ArrayRef', lazy_build => 1 );
has '_parser'               => ( is => 'ro', isa => 'UpdatePipeline::Spreadsheet::Parser', lazy_build => 1 );

# report
has 'report_filename'       => ( is => 'rw', isa => 'Maybe[Str]', default   => undef      ); # report file
has '_header_error'         => ( is => 'rw', isa => 'ArrayRef',   default   => sub { [] } ); # header errors
has '_experiment_error'     => ( is => 'rw', isa => 'ArrayRef',   default   => sub { [] } ); # experiment errors
has '_csv_filehandle'       => ( is => 'rw', isa => 'FileHandle', lazy_build => 1         ); # output filehandle

sub _build_valid_header_metadata
{
    my ($self) = @_;
    #return $self->_header_metadata; # return input data for now
    my $header_validator = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Header->new(header => $self->_header_metadata);
    my $valid_header_ref = $header_validator->valid_header();
    push @{$self->_header_error}, @{$header_validator->error_list};
    return $valid_header_ref;
}

sub _build_valid_rows_metadata
{
    my ($self) = @_;
    #return $self->_rows_metadata; # return input data for now
    
    my @valid_rows_metadata;
    for my $expt (@{$self->_rows_metadata})
    {
        my $row_validator = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Experiment->new( experiment_row => $expt );
        push @valid_rows_metadata, $row_validator->valid_experiment_row();
        push @{$self->_experiment_error}, @{$row_validator->error_list};
    }
    return \@valid_rows_metadata;
}

sub _build__header_metadata
{
    my ($self) = @_;
    return $self->_parser->header_metadata;
}

sub _build__rows_metadata
{
    my ($self) = @_;
    return $self->_parser->rows_metadata;
}

sub _build__parser
{
    my ($self) = @_;
    return UpdatePipeline::Spreadsheet::Parser->new(filename => $self->filename);
}

sub _build__csv_filehandle
{
    my ($self) = @_;
    my $fh;
    
    if( defined $self->report_filename)
    {
        open($fh,'>',$self->report_filename) or die "failed to open '".$self->report_filename."'";
    }
    else
    {
        open($fh, ">&", \*STDOUT);
    }
    
    return $fh;
}

# confirm valid
sub validate
{
    my ($self) = @_;
    
    my $valid_head = UpdatePipeline::Spreadsheet::Validate::Header->new(input_header => $self->valid_header_metadata);
    my $valid_expt = UpdatePipeline::Spreadsheet::Validate::SequencingExperiments->new(raw_rows => $self->valid_rows_metadata);

    my @complete_error_list = ();
    push @complete_error_list, @{$self->_header_error};
    push @complete_error_list, @{$self->_experiment_error};
    my $error_count = 0;
    
    for my $err (@complete_error_list)
    {
        $error_count++ if $err->type eq 'error';
    }

    return($valid_head->is_valid() && $valid_expt->is_valid() && !$error_count);
}

sub write_full_report
{
    my ($self) = @_;
    my $report = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Report->new( header_error     => $self->_header_error,
                                                                                 experiment_error => $self->_experiment_error,
                                                                                 filehandle       => $self->_csv_filehandle );
    return $report->full_report();
}

sub write_summary_report
{
    my ($self) = @_;
    my $report = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Report->new( header_error     => $self->_header_error,
                                                                                 experiment_error => $self->_experiment_error,
                                                                                 filehandle       => $self->_csv_filehandle );
    return $report->summary_report();
}


__PACKAGE__->meta->make_immutable;

no Moose;

1;
