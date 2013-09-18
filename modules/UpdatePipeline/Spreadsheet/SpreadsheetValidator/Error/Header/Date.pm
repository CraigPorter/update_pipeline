package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::Date;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Date');

# note: think about moving this to default for each error type
sub _build__allowed_formats
{
    my ($self) = @_;
    my @allowed = ('integer','date');
    return \@allowed;
}

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'date')
    {
        # valid date
        $self->type('ok');
        $self->description('Valid date');
        $self->message('"'.$self->cell_contents.'" is a valid date');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_contents =~ m/^\d{4}$/ && $self->cell_contents > 2013 ) 
    {
        # only year supplied
        $self->type('ok');
        $self->description('Valid date');
        $self->message('"'.$self->cell_contents.'" is a valid date');
        $self->user_action('No action required');
    }
    elsif($self->cell_format eq 'empty') 
    {
        # empty
        $self->type('warning');
        $self->description('Invalid date');
        $self->message('No date supplied - expected date or year');
        $self->user_action('Supply valid date (dd.mm.yyyy or yyyy)');
    }
    else
    {
        # not valid or empty
        $self->type('warning');
        $self->description('Invalid date');
        $self->message('"'.$self->cell_contents.'" is not a valid date');
        $self->user_action('Supply valid date (dd.mm.yyyy or yyyy)');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;