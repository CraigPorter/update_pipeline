package NCBI::Exceptions;

use Exception::Class (
    NCBI::Exceptions::TaxonLookupFailed   => { description => 'Couldnt lookup the scientific name from a taxon id' },
);  

1;
