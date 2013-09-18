package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::SampleName;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Sample Name');

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'string' || $self->cell_format eq 'integer')
    {
        # valid sample name
        $self->type('ok');
        $self->description('Valid sample name');
        $self->message('"'.$self->cell_contents.'" is a valid sample name');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank' || $self->cell_format eq 'empty') 
    {
        # no sample supplied
        $self->type('error');
        $self->description('Invalid sample name');
        $self->message('No sample name supplied');
        $self->user_action('Supply valid sample name');
    }
    else
    {
        # expected string but got number or date
        $self->type('error');
        $self->description('Invalid sample name');
        $self->message('"'.$self->cell_contents.'" is not a valid sample name');
        $self->user_action('Supply valid study name');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;