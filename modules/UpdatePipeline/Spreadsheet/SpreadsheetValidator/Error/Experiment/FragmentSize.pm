package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::FragmentSize;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Fragment Size');

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'integer')
    {
        # valid taxon id
        $self->type('ok');
        $self->description('Valid fragment size');
        $self->message('"'.$self->cell_contents.'" is a valid fragment size');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'empty') 
    {
        # no taxon id
        $self->type('warning');
        $self->description('Fragment size set to default');
        $self->message('No fragment size supplied');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'zero') 
    {
        # taxon id is zero
        $self->type('warning');
        $self->description('Fragment size set to zero');
        $self->message('Fragment size set to zero');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank') 
    {
        # whitespace
        $self->type('error');
        $self->description('Invalid fragment size');
        $self->message('Fragment size is whitespace');
        $self->user_action('Supply valid fragment size');
    }
    else
    {
        # other error
        $self->type('error');
        $self->description('Invalid fragment size');
        $self->message('"'.$self->cell_contents.'" is not a valid fragment size');
        $self->user_action('Supply valid fragment size');        
    }
    
    return $pass;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;