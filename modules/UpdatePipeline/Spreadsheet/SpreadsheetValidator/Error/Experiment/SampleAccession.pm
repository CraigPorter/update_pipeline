package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::SampleAccession;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Sample Acccession');

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'string')
    {
        # valid sample accession
        $self->type('ok');
        $self->description('Valid sample accession');
        $self->message('"'.$self->cell_contents.'" is a valid sample accession');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'undefined' || $self->cell_format eq 'empty') 
    {
        # no sample accession
        $self->type('ok');
        $self->description('Valid sample accession');
        $self->message('No sample accession supplied');
        $self->user_action('No action required');
        $pass = 1;
    }
    else
    {
        # expected string but got something else
        $self->type('error');
        $self->description('Invalid sample accession');
        $self->message('"'.$self->cell_contents.'" is not a valid sample accession');
        $self->user_action('Supply valid sample accession');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;