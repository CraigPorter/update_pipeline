package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error;

use Moose;

has 'location'    => ( is => 'rw', isa => 'Str'); # header title or expt filename
has 'type'        => ( is => 'rw', isa => 'Str'); # error / warning
has 'description' => ( is => 'rw', isa => 'Str'); # error description (eg invalid filename)
has 'message'     => ( is => 'rw', isa => 'Str'); # error message (eg 'xxx' is not a valid filename)
has 'user_action' => ( is => 'rw', isa => 'Str'); # availible actions (eg include valid filename)

__PACKAGE__->meta->make_immutable;

# Add actions here. Actions to be overridden by error classes 
# eg Autofix minor errors
# fix warning (eg remove gb from size)
# fix error


no Moose;

1;