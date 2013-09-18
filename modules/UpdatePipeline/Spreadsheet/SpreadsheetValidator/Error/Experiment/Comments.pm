package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::Comments;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Comments');

sub check_format
{
    my ($self) = @_;
    
    # always return passed
    $self->type('ok');
    $self->description('Valid comments');
    $self->message('Comments always marked as valid');
    $self->user_action('No action required');

    return 1;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;