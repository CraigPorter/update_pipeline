package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Report;

use Moose;
use Text::CSV;
use UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error;

#has 'header_error'     => ( is => 'ro', isa => 'ArrayRef[UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error]', required => 1 ); # header errors
#has 'experiment_error' => ( is => 'ro', isa => 'ArrayRef[UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error]', required => 1 ); # experiment errors
has 'header_error'     => ( is => 'ro', isa => 'ArrayRef',   required   => 1 ); # header errors
has 'experiment_error' => ( is => 'ro', isa => 'ArrayRef',   required   => 1 ); # experiment errors
has 'filehandle'       => ( is => 'ro', isa => 'FileHandle', required   => 1 ); # output filehandle
has '_csv_out'         => ( is => 'ro', isa => 'Text::CSV',  lazy_build => 1 ); # output CSV
has '_column_header'   => ( is => 'ro', isa => 'ArrayRef',   lazy_build => 1 ); # column header

sub _build__csv_out
{
    my ($self) = @_;
    my $csv = Text::CSV->new( { binary => 1 } );
    $csv->eol("\r\n");
    return $csv;
}

sub _build__column_header
{
    my ($self) = @_;
    my @header = ('location','type','description','message','user_action');
    return \@header;
}

sub _get_all_header
{
    my ($self) = @_;
    my @error = ();
    for my $err (@{$self->header_error})
    {
        push @error, [ $err->location, $err->type, $err->description, $err->message, $err->user_action ];
    }    
    return \@error;
}

sub _get_all_experiment
{
    my ($self) = @_;
    my @error = ();
    for my $err (@{$self->experiment_error})
    {
        push @error, [ $err->location, $err->type, $err->description, $err->message, $err->user_action ];
    }    
    return \@error;
}

sub _get_header_error
{
    my ($self) = @_;
    my @error = ();
    for my $err (@{$self->header_error})
    {
        push @error, [ $err->location, $err->type, $err->description, $err->message, $err->user_action ] if $err->type eq 'error';
    }    
    return \@error;
}

sub _get_header_warning
{
    my ($self) = @_;
    my @error = ();
    for my $err (@{$self->header_error})
    {
        push @error, [ $err->location, $err->type, $err->description, $err->message, $err->user_action ] if $err->type eq 'warning';
    }    
    return \@error;
}

sub _get_experiment_error
{
    my ($self) = @_;
    my @error = ();
    for my $err (@{$self->experiment_error})
    {
        push @error, [ $err->location, $err->type, $err->description, $err->message, $err->user_action ] if $err->type eq 'error';
    }    
    return \@error;        
}

sub _get_experiment_warning
{
    my ($self) = @_;
    my @error = ();
    for my $err (@{$self->experiment_error})
    {
        push @error, [ $err->location, $err->type, $err->description, $err->message, $err->user_action ] if $err->type eq 'warning';
    }    
    return \@error;        
}

sub _get_summary
{
    my ($self) = @_;
    my @summary;
    push @summary, ['header errors',scalar @{$self->_get_header_error}];
    push @summary, ['header warnings',scalar @{$self->_get_header_warning}];
    push @summary, ['experiment errors',scalar @{$self->_get_experiment_error}]; 
    push @summary, ['experiment warnings',scalar @{$self->_get_experiment_warning}]; 
    return \@summary;
}

sub full_report
{
    my ($self) = @_;
    my @output_rows;
    # Title 
    push @output_rows, $self->_column_header;
    # Header Errors and Warnings
    push @output_rows, @{$self->_get_all_header};
    # Experiment Errors and Warnings
    push @output_rows, @{$self->_get_all_experiment};
    # Summary
    push @output_rows, @{$self->_get_summary};

    # Output CSV
    for my $row (@output_rows)
    {
        $self->_csv_out->print($self->filehandle,$row)
    }
    return 1;    
}

sub summary_report
{
    my ($self) = @_;
    # Summary
    for my $row (@{$self->_get_summary})
    {
        $self->_csv_out->print($self->filehandle,$row)
    }
    return 1;
}


__PACKAGE__->meta->make_immutable;

no Moose;

1;
