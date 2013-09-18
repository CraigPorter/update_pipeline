package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Experiment;

use Moose;

use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Common';

has 'experiment_row'           => ( is => 'ro', isa => 'HashRef',    required => 1);
has 'valid_experiment_row'     => ( is => 'ro', isa => 'HashRef',    lazy_build => 1);
has '_filename'                => ( is => 'ro', isa => 'Maybe[Str]', lazy_build => 1);
has '_mate_filename'           => ( is => 'ro', isa => 'Maybe[Str]', lazy_build => 1);
has '_sample_name'             => ( is => 'ro', isa => 'Maybe[Str]', lazy_build => 1);
has '_sample_accession_number' => ( is => 'ro', isa => 'Maybe[Str]', lazy_build => 1);
has '_taxon_id'                => ( is => 'ro', isa => 'Maybe[Int]', lazy_build => 1);
has '_library_name'            => ( is => 'ro', isa => 'Maybe[Str]', lazy_build => 1);
has '_fragment_size'           => ( is => 'ro', isa => 'Maybe[Int]', lazy_build => 1);
has '_raw_read_count'          => ( is => 'ro', isa => 'Maybe[Int]', lazy_build => 1);
has '_raw_base_count'          => ( is => 'ro', isa => 'Maybe[Int]', lazy_build => 1);
has '_comments'                => ( is => 'ro', isa => 'Maybe[Str]', lazy_build => 1);

sub _build_valid_experiment_row
{
    my ($self) = @_;
    my %experiment_row = ( 'filename'                => $self->_filename,
                           'mate_filename'           => $self->_mate_filename,
                           'sample_name'             => $self->_sample_name,
                           'sample_accession_number' => $self->_sample_accession_number,
                           'taxon_id'                => $self->_taxon_id,
                           'library_name'            => $self->_library_name,
                           'fragment_size'           => $self->_fragment_size,
                           'raw_read_count'          => $self->_raw_read_count,
                           'raw_base_count'          => $self->_raw_base_count,
                           'comments'                => $self->_comments );
    return \%experiment_row;
}

sub _build__cell_data
{
    my ($self) = @_;
    return $self->experiment_row;
}

sub _build__filename
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::Filename->new( cell_contents => $self->_cell_data->{'filename'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'filename'};
}

sub _build__mate_filename
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::MateFilename->new( cell_contents => $self->_cell_data->{'mate_filename'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'mate_filename'};
}

sub _build__sample_name
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::SampleName->new( cell_contents => $self->_cell_data->{'sample_name'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'sample_name'};
}

sub _build__sample_accession_number
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::SampleAccession->new( cell_contents => $self->_cell_data->{'sample_accession_number'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'sample_accession_number'};
}

sub _build__taxon_id
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::TaxonID->new( cell_contents => $self->_cell_data->{'taxon_id'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'taxon_id'};
}

sub _build__library_name
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::LibraryName->new( cell_contents => $self->_cell_data->{'library_name'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'library_name'};
}

sub _build__fragment_size
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::FragmentSize->new( cell_contents => $self->_cell_data->{'fragment_size'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'fragment_size'};
}

sub _build__raw_read_count
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::ReadCount->new( cell_contents => $self->_cell_data->{'raw_read_count'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'raw_read_count'};
}

sub _build__raw_base_count
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::BaseCount->new( cell_contents => $self->_cell_data->{'raw_base_count'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'raw_base_count'};
}

sub _build__comments
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::Comments->new( cell_contents => $self->_cell_data->{'comments'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'comments'};
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;