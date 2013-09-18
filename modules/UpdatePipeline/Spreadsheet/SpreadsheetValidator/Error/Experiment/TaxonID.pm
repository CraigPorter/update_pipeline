package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::TaxonID;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Taxon ID');

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'integer')
    {
        # valid taxon id
        $self->type('ok');
        $self->description('Valid taxon id');
        $self->message('"'.$self->cell_contents.'" is a valid taxon id');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'empty' || $self->cell_format eq 'blank' || $self->cell_format eq 'zero') 
    {
        # no taxon id
        $self->type('error');
        $self->description('Invalid taxon id');
        $self->message('No taxon id supplied');
        $self->user_action('Supply valid taxon id');
    }
    else
    {
        # other error
        $self->type('error');
        $self->description('Invalid taxon id');
        $self->message('"'.$self->cell_contents.'" is not a valid taxon id');
        $self->user_action('Supply valid taxon id');        
    }
    
    return $pass;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;