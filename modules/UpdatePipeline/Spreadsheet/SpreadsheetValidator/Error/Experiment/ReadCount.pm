package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::ReadCount;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Read Count');

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'integer')
    {
        # valid read count
        $self->type('ok');
        $self->description('Valid read count');
        $self->message('"'.$self->cell_contents.'" is a valid read count');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'undefined' || $self->cell_format eq 'empty') 
    {
        # no read count
        $self->type('warning');
        $self->description('read count set to default');
        $self->message('No read count supplied');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'zero') 
    {
        # read count is zero
        $self->type('warning');
        $self->description('read count set to zero');
        $self->message('read count set to zero');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank') 
    {
        # whitespace
        $self->type('error');
        $self->description('Invalid read count');
        $self->message('read count is whitespace');
        $self->user_action('Supply valid read count');
    }
    else
    {
        # other error
        $self->type('error');
        $self->description('Invalid read count');
        $self->message('"'.$self->cell_contents.'" is not a valid read count');
        $self->user_action('Supply valid read count');        
    }
    
    return $pass;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;