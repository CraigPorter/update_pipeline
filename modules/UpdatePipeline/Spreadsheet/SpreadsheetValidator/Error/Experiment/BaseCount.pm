package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::BaseCount;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Base Count');

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'integer')
    {
        # valid base count
        $self->type('ok');
        $self->description('Valid base count');
        $self->message('"'.$self->cell_contents.'" is a valid base count');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'undefined' || $self->cell_format eq 'empty') 
    {
        # no base count
        $self->type('warning');
        $self->description('Base count set to default');
        $self->message('No base count supplied');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'zero') 
    {
        # base count is zero
        $self->type('warning');
        $self->description('Base count set to zero');
        $self->message('Base count set to zero');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank') 
    {
        # whitespace
        $self->type('error');
        $self->description('Invalid base count');
        $self->message('Base count is whitespace');
        $self->user_action('Supply valid base count');
    }
    else
    {
        # other error
        $self->type('error');
        $self->description('Invalid base count');
        $self->message('"'.$self->cell_contents.'" is not a valid base count');
        $self->user_action('Supply valid base count');        
    }
    
    return $pass;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;