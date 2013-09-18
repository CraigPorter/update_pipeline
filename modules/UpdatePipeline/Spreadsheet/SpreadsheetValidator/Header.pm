package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Header;

use Moose;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Common';

has 'header'       => ( is => 'ro', isa => 'HashRef', required => 1);
has 'valid_header' => ( is => 'ro', isa => 'HashRef', lazy_build => 1);

sub _build_valid_header
{
    my ($self) = @_;
    my %header = ( 'supplier_name'                 => $self->_supplier_name,
                   'supplier_organisation'         => $self->_supplier_organisation,
                   'internal_contact'              => $self->_internal_contact,
                   'sequencing_technology'         => $self->_sequencing_technology,
                   'study_name'                    => $self->_study_name,
                   'study_accession_number'        => $self->_study_accession_number,
                   'total_size_of_files_in_gbytes' => $self->_total_size_of_files_in_gbytes,
                   'data_to_be_kept_until'         => $self->_data_to_be_kept_until );

    return \%header;
}

sub _build__cell_data
{
    my ($self) = @_;
    return $self->header;
}

sub _supplier_name
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SupplierName->new( cell_contents => $self->_cell_data->{'supplier_name'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'supplier_name'};
}

sub _supplier_organisation
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SupplierOrganisation->new( cell_contents => $self->_cell_data->{'supplier_organisation'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'supplier_organisation'};
}

sub _internal_contact
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SangerContact->new( cell_contents => $self->_cell_data->{'internal_contact'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'internal_contact'};
}

sub _sequencing_technology
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SequencingTechnology->new( cell_contents => $self->_cell_data->{'sequencing_technology'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'sequencing_technology'};
}

sub _study_name
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::StudyName->new( cell_contents => $self->_cell_data->{'study_name'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'study_name'};
}

sub _study_accession_number
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::StudyAccession->new( cell_contents => $self->_cell_data->{'study_accession_number'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'study_accession_number'};
}

sub _total_size_of_files_in_gbytes
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::Size->new( cell_contents => $self->_cell_data->{'total_size_of_files_in_gbytes'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'total_size_of_files_in_gbytes'};
}

sub _data_to_be_kept_until
{
    my ($self) = @_;
    
    # Scan cell contents
    my $error = UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::Date->new( cell_contents => $self->_cell_data->{'data_to_be_kept_until'} );
    my $scan_ok = $error->check_format;

    # Push error to list
    push @{$self->error_list}, $error unless $scan_ok;
    
    return $self->_cell_data->{'data_to_be_kept_until'};
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;